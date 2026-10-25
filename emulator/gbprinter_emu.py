"""Game Boy Printer emulator: runs the real TMP87C840 firmware (TLCS-870 CPU) and talks to it
through an emulated SIO2 link.

Written for the Game-Boy-Printer-disassembly project. CPU semantics follow Toshiba's TLCS-870
instruction table (flags JF/ZF/CF/HF) as quoted in MAME's tlcs870 comments; peripherals follow
the TMP87C840 datasheet. fc = 8 MHz, 1 machine cycle = 4/fc = 0.5 us.

Only what the printer firmware uses is modelled:
  * timers TC2 (main tick, INTTC2) and TC4 (inter-byte timeout, INTTC4); TC1/TC3 optional
  * SIO2 in 8-bit transmit/receive mode, external clock, shared data buffer 0x0FF8-0x0FFF
  * ADC (channel 0 = head temperature, channel 1 = battery), instant conversion
  * external 8 KB SRAM on ports P3/P4/P7 with strobes P2.1 (WE), P2.2 (CE), P5.4 (OE)
  * IDLE mode (SYSCR2.4) = wait for the next interrupt
"""
import sys

MC_PER_S = 2_000_000          # machine cycles per second at fc = 8 MHz

# interrupt bit (EIR / IL) -> vector:  vector = 0xFFE0 + (15 - bit) * 2
IRQ_INT5, IRQ_TC2, IRQ_SIO2, IRQ_INT4, IRQ_INT3, IRQ_TC4, IRQ_SIO1, IRQ_TC3 = 15, 14, 13, 12, 11, 10, 9, 8
IRQ_INT2, IRQ_TBT, IRQ_INT1, IRQ_TC1, IRQ_INT0 = 7, 6, 5, 4, 3


def rev8(b):
    b = ((b & 0xF0) >> 4) | ((b & 0x0F) << 4)
    b = ((b & 0xCC) >> 2) | ((b & 0x33) << 2)
    return ((b & 0xAA) >> 1) | ((b & 0x55) << 1)


def s8(v):
    return v - 0x100 if v & 0x80 else v


class Halt(Exception):
    pass


class Printer:
    def __init__(self, rom, temp_adc=0x80, batt_adc=0xC0, button=False, trace=None):
        assert len(rom) == 0x8000
        self.m = bytearray(0x10000)
        self.m[0x8000:] = rom
        self.sram = bytearray(0x2000)
        self.pc = self.m[0xFFFE] | (self.m[0xFFFF] << 8)
        self.sp = 0
        self.rbs = 0
        self.jf = self.zf = self.cf = self.hf = 0
        self.eir = 0
        self.il = 0
        self.cyc = 0
        self.idle = False
        self.temp_adc, self.batt_adc = temp_adc, batt_adc
        self.button = button              # True = front button held (P2.0 low)
        self.sensor_p51 = 1               # value read on P5.1 (INT4 pin; mechanism sensor, meaning unknown)
        self.enc_period_ms = 9.0          # paper-motor encoder pulse period while the motor runs (INT3)
        self.enc_next = None
        self.enc_pulses = 0
        self.motor_log = []               # (cycle, on/off)
        self.jam = False                  # True = encoder pulses stop even with the motor on
        self.cam_period = 40              # encoder pulses per revolution of the cam/home sensor (P5.1, INT4)
        self.cam_high = 8                 # pulses per revolution with the sensor active (P5.1 = 1)
        self.cam_pos = 7
        self.adc_ch = 0
        # port output latches
        self.port = [0] * 8
        # timers
        self.tc2cr = 0; self.treg2 = 0; self.tc2_next = None
        self.tc4cr = 0; self.treg4 = 0; self.tc4_next = None
        self.tc1cr = 0; self.treg1a = 0; self.tc1_next = None
        self.tc3cr = 0; self.treg3a = 0; self.tc3_next = None
        # SIO2
        self.sio_cr1 = 0; self.sio_cr2 = 0; self.sio_idx = 0
        self.trace = trace
        self.hl_c_signed_uses = 0
        self.unknown = set()
        self.instr = 0
        self.pc_hits = None               # optional dict addr -> count
        self.nf = 0

    # ------------------------------------------------------------------ registers
    def r8(self, i):
        return self.m[0x40 + self.rbs * 8 + i]

    def w8r(self, i, v):
        self.m[0x40 + self.rbs * 8 + i] = v & 0xFF

    def r16(self, i):
        b = 0x40 + self.rbs * 8 + i * 2
        return self.m[b] | (self.m[b + 1] << 8)

    def w16r(self, i, v):
        b = 0x40 + self.rbs * 8 + i * 2
        self.m[b] = v & 0xFF; self.m[b + 1] = (v >> 8) & 0xFF

    def psw(self):
        return (self.jf << 7) | (self.zf << 6) | (self.cf << 5) | (self.hf << 4) | (self.rbs & 0xF)

    def set_psw(self, v):
        self.jf = (v >> 7) & 1; self.zf = (v >> 6) & 1; self.cf = (v >> 5) & 1; self.hf = (v >> 4) & 1
        self.rbs = v & 0xF

    # ------------------------------------------------------------------ memory / SFR
    def rd(self, a):
        a &= 0xFFFF
        if a < 0x40:
            return self.sfr_rd(a)
        return self.m[a]

    def wr(self, a, v):
        a &= 0xFFFF; v &= 0xFF
        if a < 0x40:
            return self.sfr_wr(a, v)
        if a >= 0x8000:
            return  # ROM
        self.m[a] = v

    def rd16(self, a):
        return self.rd(a) | (self.rd(a + 1) << 8)

    def wr16(self, a, v):
        self.wr(a, v & 0xFF); self.wr(a + 1, v >> 8)

    def cam_level(self):
        return 1 if (self.cam_pos % self.cam_period) < self.cam_high else 0

    def sram_addr(self):
        return ((self.port[4] & 0x1F) << 8) | self.port[3]

    def sfr_rd(self, a):
        if a == 0x02:
            v = self.port[2] & 0xFE
            return v | (0 if self.button else 1)
        if a == 0x05:
            # P5.0 = INT3 pin (encoder, read low when sampled in the handler), P5.1 = INT4 pin
            return (self.port[5] & 0xFC) | (self.cam_level() << 1)
        if a == 0x07:
            if not (self.port[2] & 0x04) and not (self.port[5] & 0x10):
                return self.sram[self.sram_addr()]
            return self.port[7]
        if a < 0x08:
            return self.port[a]
        if a == 0x0E:
            return 0x80 | self.adc_ch          # conversion always finished
        if a == 0x0F:
            return self.temp_adc if self.adc_ch == 0 else self.batt_adc
        if a == 0x22:
            return 0x00                         # SIO2 status: not busy
        if a == 0x3A:
            return self.eir & 0xFF
        if a == 0x3B:
            return self.eir >> 8
        if a == 0x3C:
            return self.il & 0xFF
        if a == 0x3D:
            return self.il >> 8
        if a == 0x3F:
            return self.psw()
        return self.m[a]

    def sfr_wr(self, a, v):
        self.m[a] = v
        if a < 0x08:
            old = self.port[a]
            self.port[a] = v
            if a == 5 and ((old ^ v) & 0x04):
                self.motor_log.append((self.cyc, not (v & 0x04)))
                self.enc_next = (self.cyc + int(self.enc_period_ms * MC_PER_S / 1000)) if not (v & 0x04) else None
            if a == 2:
                # SRAM write: WE (P2.1) rising edge while CE (P2.2) low
                if (old & 0x02) == 0 and (v & 0x02) and not (v & 0x04):
                    self.sram[self.sram_addr()] = self.port[7]
            return
        if a == 0x0E:
            self.adc_ch = v & 0x0F
        elif a == 0x10:
            self.treg1a = (self.treg1a & 0xFF00) | v
        elif a == 0x11:
            self.treg1a = (self.treg1a & 0xFF) | (v << 8)
        elif a == 0x14:
            self.tc1cr = v
            self.tc1_next = self.cyc + self.tc1_period() if (v & 0x30) == 0x10 and self.tc1_period() else None
        elif a == 0x15:
            self.tc2cr = v
            self.tc2_next = self.cyc + self.tc2_period() if v & 0x20 else None
        elif a == 0x16:
            self.treg2 = (self.treg2 & 0xFF00) | v
        elif a == 0x17:
            self.treg2 = (self.treg2 & 0xFF) | (v << 8)
            if self.tc2cr & 0x20:
                self.tc2_next = self.cyc + self.tc2_period()
        elif a == 0x18:
            self.treg3a = v
        elif a == 0x1A:
            self.tc3cr = v
            self.tc3_next = self.cyc + max(1, self.treg3a) * 32 if v & 0x10 else None
        elif a == 0x1B:
            self.treg4 = v
        elif a == 0x1C:
            self.tc4cr = v
            self.tc4_next = self.cyc + self.tc4_period() if v & 0x10 else None
        elif a == 0x22:
            self.sio_cr1 = v
            if v & 0x40 or not (v & 0x80):
                self.sio_idx = 0               # abort / stop
            if v & 0x80:
                self.sio_idx = 0
        elif a == 0x23:
            self.sio_cr2 = v
        elif a == 0x39:
            if v & 0x10:
                self.idle = True               # IDLE: wait for an interrupt
        elif a == 0x3A:
            self.eir = (self.eir & 0xFF00) | v
        elif a == 0x3B:
            self.eir = (self.eir & 0x00FF) | (v << 8)
        elif a == 0x3C:
            self.il &= 0xFF00 | v
        elif a == 0x3D:
            self.il &= 0x00FF | (v << 8)
        elif a == 0x3F:
            self.rbs = v & 0xF

    # timer periods in machine cycles (1 mc = 4 fc)
    def tc2_period(self):
        ck = (self.tc2cr >> 2) & 7
        div = {0: 1 << 23, 1: 1 << 13, 2: 1 << 8, 3: 1 << 3, 4: 1}.get(ck, 1 << 13)
        return max(1, self.treg2) * div // 4

    def tc4_period(self):
        ck = (self.tc4cr >> 2) & 3
        div = {0: 1 << 11, 1: 1 << 7, 2: 1 << 3}.get(ck, 1 << 11)
        return max(1, self.treg4) * div // 4

    def tc1_period(self):
        ck = (self.tc1cr >> 2) & 3
        div = {0: 1 << 11, 1: 1 << 7, 2: 1 << 3}.get(ck, 1 << 11)
        return max(1, self.treg1a) * div // 4 if self.treg1a else 0

    # ------------------------------------------------------------------ time and interrupts
    def tick_peripherals(self):
        c = self.cyc
        if self.tc2_next is not None and c >= self.tc2_next:
            self.il |= 1 << IRQ_TC2
            self.tc2_next += self.tc2_period()
        if self.tc4_next is not None and c >= self.tc4_next:
            self.il |= 1 << IRQ_TC4
            self.tc4_next += self.tc4_period()
        if self.tc3_next is not None and c >= self.tc3_next:
            self.il |= 1 << IRQ_TC3
            self.tc3_next += max(1, self.treg3a) * 32
        if self.enc_next is not None and c >= self.enc_next:
            if not self.jam:
                before = self.cam_level()
                self.cam_pos += 1
                if self.cam_level() and not before:
                    self.il |= 1 << IRQ_INT4        # cam sensor rising edge
                self.il |= 1 << IRQ_INT3
                self.enc_pulses += 1
            self.enc_next += int(self.enc_period_ms * MC_PER_S / 1000)
        if self.tc1_next is not None and c >= self.tc1_next:
            self.il |= 1 << IRQ_TC1
            p = self.tc1_period()
            self.tc1_next = self.tc1_next + p if p else None

    def next_event(self):
        ev = [t for t in (self.tc2_next, self.tc4_next, self.tc1_next, self.tc3_next, self.enc_next) if t is not None]
        return min(ev) if ev else None

    def check_irq(self):
        if not (self.eir & 1):
            return False
        pend = self.il & self.eir & 0xFFFE
        if not pend:
            return False
        for bit in range(1, 16):              # lower bit = higher priority
            if pend & (1 << bit):
                self.il &= ~(1 << bit)
                self.eir &= ~1
                self.m[self.sp] = self.psw()
                self.m[(self.sp - 2) & 0xFFFF] = self.pc & 0xFF
                self.m[(self.sp - 1) & 0xFFFF] = self.pc >> 8
                self.sp = (self.sp - 3) & 0xFFFF
                self.pc = self.rd16(0xFFE0 + (15 - bit) * 2)
                self.idle = False
                self.cyc += 6
                return True
        return False

    def run_until(self, target):
        """Run until machine cycle `target`."""
        while self.cyc < target:
            self.tick_peripherals()
            self.check_irq()
            if self.idle:
                ne = self.next_event()
                if ne is None or ne > target:
                    self.cyc = target
                    return
                self.cyc = max(self.cyc + 1, ne)
                continue
            self.step()

    def run_ms(self, ms):
        self.run_until(self.cyc + int(ms * MC_PER_S / 1000))

    # ------------------------------------------------------------------ SIO2 (Game Boy link)
    def exchange(self, gb_byte):
        """One byte clocked by the Game Boy. Returns the byte the Game Boy reads."""
        if not (self.sio_cr1 & 0x80):
            return 0xFF                         # SIO not running: line idles high
        a = 0x0FF8 + self.sio_idx
        out = rev8(self.m[a])                   # printer shifts LSB first, Game Boy reads MSB first
        self.m[a] = rev8(gb_byte)
        self.sio_idx += 1
        if self.sio_idx > (self.sio_cr2 & 7):
            self.sio_idx = 0
            self.il |= 1 << IRQ_SIO2
        return out

    # ------------------------------------------------------------------ stack
    def push16(self, v):
        self.m[(self.sp - 1) & 0xFFFF] = v & 0xFF
        self.m[self.sp] = (v >> 8) & 0xFF
        self.sp = (self.sp - 2) & 0xFFFF

    def pop16(self):
        self.sp = (self.sp + 2) & 0xFFFF
        return self.m[(self.sp - 1) & 0xFFFF] | (self.m[self.sp] << 8)

    # ------------------------------------------------------------------ ALU
    def alu8(self, op, a, b):
        """op: 0 addc 1 add 2 subb 3 sub 4 and 5 xor 6 or 7 cmp. Returns result (None for cmp)."""
        if op in (0, 1):
            c = self.cf if op == 0 else 0
            r = a + b + c
            self.hf = 1 if (a & 0xF) + (b & 0xF) + c > 0xF else 0
            self.cf = 1 if r > 0xFF else 0
            r &= 0xFF; self.zf = int(r == 0); self.jf = self.cf
            return r
        if op in (2, 3, 7):
            c = self.cf if op == 2 else 0
            r = a - b - c
            self.hf = 1 if (a & 0xF) - (b & 0xF) - c < 0 else 0
            self.cf = 1 if r < 0 else 0
            r &= 0xFF; self.zf = int(r == 0)
            self.jf = self.zf if op == 7 else self.cf
            return None if op == 7 else r
        r = (a & b) if op == 4 else (a ^ b) if op == 5 else (a | b)
        self.zf = int(r == 0); self.jf = self.zf
        return r

    def alu16(self, op, a, b):
        if op in (0, 1):
            c = self.cf if op == 0 else 0
            r = a + b + c
            self.cf = 1 if r > 0xFFFF else 0
            r &= 0xFFFF; self.zf = int(r == 0); self.jf = self.cf
            return r
        if op in (2, 3, 7):
            c = self.cf if op == 2 else 0
            r = a - b - c
            self.cf = 1 if r < 0 else 0
            r &= 0xFFFF; self.zf = int(r == 0)
            self.jf = self.zf if op == 7 else self.cf
            return None if op == 7 else r
        r = (a & b) if op == 4 else (a ^ b) if op == 5 else (a | b)
        self.zf = int(r == 0); self.jf = self.zf
        return r

    def inc8(self, v):
        r = (v + 1) & 0xFF; self.zf = int(r == 0); self.jf = self.zf; return r

    def dec8(self, v):
        r = (v - 1) & 0xFF; self.jf = int(v == 0); self.zf = int(r == 0); return r

    def shift(self, kind, v):
        if kind == 0:   # shlc
            self.cf = v >> 7; r = (v << 1) & 0xFF
        elif kind == 1:  # shrc
            self.cf = v & 1; r = v >> 1
        elif kind == 2:  # rolc
            c = self.cf; self.cf = v >> 7; r = ((v << 1) | c) & 0xFF
        else:            # rorc
            c = self.cf; self.cf = v & 1; r = (v >> 1) | (c << 7)
        self.zf = int(r == 0); self.jf = self.cf
        return r

    def cond(self, cc):
        z, c, j = self.zf, self.cf, self.jf
        return [z == 1, z == 0, c == 1, c == 0, (c or z) == 1, (c or z) == 0, j == 1, j == 0][cc]

    def bit_set(self, v, b):    # returns new value, flags: ZF = JF = ~old bit
        old = (v >> b) & 1; self.zf = self.jf = old ^ 1; return v | (1 << b)

    def bit_clr(self, v, b):
        old = (v >> b) & 1; self.zf = self.jf = old ^ 1; return v & ~(1 << b) & 0xFF

    def bit_cpl(self, v, b):
        old = (v >> b) & 1; self.zf = self.jf = old ^ 1; return v ^ (1 << b)

    def bit_test(self, v, b):   # LD CF,bit: CF = bit, JF = ~CF
        self.cf = (v >> b) & 1; self.jf = self.cf ^ 1

    def daa(self, v):
        r = v
        if self.hf or (r & 0xF) > 9:
            r += 6
        if self.cf or r > 0x9F:
            r += 0x60; self.cf = 1
        r &= 0xFF; self.zf = int(r == 0); self.jf = self.cf; return r

    def das(self, v):
        r = v
        if self.hf or (r & 0xF) > 9:
            r -= 6
        if self.cf or r > 0x9F:
            r -= 0x60; self.cf = 1
        r &= 0xFF; self.zf = int(r == 0); self.jf = self.cf; return r

    # ------------------------------------------------------------------ execution
    def fetch(self):
        v = self.m[self.pc]; self.pc = (self.pc + 1) & 0xFFFF; self.nf += 1; return v

    def fetch16(self):
        lo = self.fetch(); return lo | (self.fetch() << 8)

    def ea(self, k, start, disp):
        """effective address for (src)/(dst) modes 0..7"""
        if k == 0: return disp
        if k == 1: return (start + 2 + self.r8(0)) & 0xFFFF
        if k == 2: return self.r16(2)
        if k == 3: return self.r16(3)
        if k == 4: return (self.r16(3) + s8(disp)) & 0xFFFF
        if k == 5:
            c = self.r8(2)
            if c & 0x80: self.hl_c_signed_uses += 1
            return (self.r16(3) + s8(c)) & 0xFFFF
        if k == 6:
            hl = self.r16(3); self.w16r(3, hl + 1); return hl
        if k == 7:
            hl = (self.r16(3) - 1) & 0xFFFF; self.w16r(3, hl); return hl
        raise ValueError(k)

    def step(self):
        start = self.pc
        if self.pc_hits is not None:
            self.pc_hits[start] = self.pc_hits.get(start, 0) + 1
        if self.trace:
            self.trace(self, start)
        if start < 0x8000:
            raise Halt("PC outside ROM: %04X" % start)
        self.instr += 1
        self.nf = 0
        b = self.fetch()
        self._exec(b, start)
        self.cyc += 1 + self.nf          # rough: ~1 machine cycle per byte fetched + 1

    def _exec(self, b, start):
        m = self
        if b == 0x00: return
        if b == 0x01:
            v = m.r8(0); m.w8r(0, ((v & 0xF) << 4) | (v >> 4)); m.jf = 1; return
        if b == 0x02:
            r = m.r8(1) * m.r8(0); m.w16r(0, r); m.zf = m.jf = int((r >> 8) == 0); return
        if b == 0x03:
            m.div16(0); return
        if b == 0x04:
            m.sp = (m.sp + 3) & 0xFFFF
            m.pc = m.m[(m.sp - 2) & 0xFFFF] | (m.m[(m.sp - 1) & 0xFFFF] << 8)
            m.set_psw(m.m[m.sp]); m.eir |= 1; return
        if b == 0x05:
            m.pc = m.pop16(); return
        if b == 0x06:
            m.sp = (m.sp + 1) & 0xFFFF; m.set_psw(m.m[m.sp]); return
        if b == 0x07:
            m.m[m.sp] = m.psw(); m.sp = (m.sp - 1) & 0xFFFF; return
        if b == 0x0A: m.w8r(0, m.daa(m.r8(0))); return
        if b == 0x0B: m.w8r(0, m.das(m.r8(0))); return
        if b == 0x0C: m.cf = 0; m.jf = 1; return
        if b == 0x0D: m.cf = 1; m.jf = 0; return
        if b == 0x0E: m.cf ^= 1; m.jf = m.cf ^ 1; return
        if b == 0x0F: m.rbs = m.fetch() & 0xF; m.jf = 1; return
        if 0x10 <= b <= 0x13:
            r = (m.r16(b & 3) + 1) & 0xFFFF; m.w16r(b & 3, r); m.zf = int(r == 0); m.jf = m.zf; return
        if 0x14 <= b <= 0x17:
            m.w16r(b & 3, m.fetch16()); m.jf = 1; return
        if 0x18 <= b <= 0x1B:
            v = m.r16(b & 3); r = (v - 1) & 0xFFFF; m.w16r(b & 3, r); m.zf = int(r == 0); m.jf = int(v == 0); return
        if 0x1C <= b <= 0x1F:
            m.w8r(0, m.shift(b - 0x1C, m.r8(0))); return
        if b == 0x20:
            x = m.fetch(); m.wr(x, m.inc8(m.rd(x))); return
        if b == 0x21:
            a = m.r16(3); m.wr(a, m.inc8(m.rd(a))); return
        if b == 0x22:
            v = m.rd(m.fetch()); m.w8r(0, v); m.jf = 1; m.zf = int(v == 0); return
        if b == 0x23:
            v = m.rd(m.r16(3)); m.w8r(0, v); m.jf = 1; m.zf = int(v == 0); return
        if b == 0x24:
            x = m.fetch(); m.wr16(x, m.fetch16()); m.jf = 1; return
        if b == 0x25:
            m.wr16(m.r16(3), m.fetch16()); m.jf = 1; return
        if b == 0x26:
            y = m.fetch(); x = m.fetch(); v = m.rd(y); m.wr(x, v); m.jf = 1; m.zf = int(v == 0); return
        if b == 0x28:
            x = m.fetch(); m.wr(x, m.dec8(m.rd(x))); return
        if b == 0x29:
            a = m.r16(3); m.wr(a, m.dec8(m.rd(a))); return
        if b == 0x2A:
            m.wr(m.fetch(), m.r8(0)); m.jf = 1; return
        if b == 0x2B:
            m.wr(m.r16(3), m.r8(0)); m.jf = 1; return
        if b == 0x2C:
            x = m.fetch(); m.wr(x, m.fetch()); m.jf = 1; return
        if b == 0x2D:
            m.wr(m.r16(3), m.fetch()); m.jf = 1; return
        if b == 0x2E:
            m.wr(m.fetch(), 0); m.jf = 1; return
        if b == 0x2F:
            m.wr(m.r16(3), 0); m.jf = 1; return
        if 0x30 <= b <= 0x37:
            m.w8r(b & 7, m.fetch()); m.jf = 1; return
        if 0x40 <= b <= 0x47:
            x = m.fetch(); m.wr(x, m.bit_set(m.rd(x), b & 7)); return
        if 0x48 <= b <= 0x4F:
            x = m.fetch(); m.wr(x, m.bit_clr(m.rd(x), b & 7)); return
        if 0x50 <= b <= 0x57:
            v = m.r8(b & 7); m.w8r(0, v); m.jf = 1; m.zf = int(v == 0); return
        if 0x58 <= b <= 0x5F:
            v = m.r8(0); m.w8r(b & 7, v); m.jf = 1; m.zf = int(v == 0); return
        if 0x60 <= b <= 0x67:
            m.w8r(b & 7, m.inc8(m.r8(b & 7))); return
        if 0x68 <= b <= 0x6F:
            m.w8r(b & 7, m.dec8(m.r8(b & 7))); return
        if 0x70 <= b <= 0x77:
            r = m.alu8(b & 7, m.r8(0), m.fetch())
            if r is not None: m.w8r(0, r)
            return
        if 0x78 <= b <= 0x7F:
            r = m.alu8(b & 7, m.r8(0), m.rd(m.fetch()))
            if r is not None: m.w8r(0, r)
            return
        if 0x80 <= b <= 0xBF:
            d = b & 0x1F; d = d - 0x20 if d & 0x10 else d
            take = (m.jf == 1) if b < 0xA0 else (m.jf == 0)
            if take: m.pc = (start + 2 + d) & 0xFFFF
            m.jf = 1
            return
        if 0xC0 <= b <= 0xCF:
            v = 0xFFC0 + (b & 0xF) * 2
            m.push16(m.pc); m.pc = m.rd16(v); return
        if 0xD0 <= b <= 0xD7:
            d = s8(m.fetch())
            if m.cond(b & 7): m.pc = (start + 2 + d) & 0xFFFF
            m.jf = 1
            return
        if 0xD8 <= b <= 0xDF:
            m.bit_test(m.rd(m.fetch()), b & 7); return
        if 0xE0 <= b <= 0xE7:
            return m.src(b & 7, start)
        if 0xE8 <= b <= 0xEF:
            return m.reg(b, start)
        if b in (0xF0, 0xF2, 0xF3, 0xF4, 0xF6, 0xF7):
            return m.dst(b & 7, start)
        if b == 0xFA:
            m.sp = m.fetch16(); m.jf = 1; return
        if b == 0xFB:
            d = s8(m.fetch()); m.pc = (start + 2 + d) & 0xFFFF; m.jf = 1; return
        if b == 0xFC:
            t = m.fetch16(); m.push16(m.pc); m.pc = t; return
        if b == 0xFD:
            t = 0xFF00 | m.fetch(); m.push16(m.pc); m.pc = t; return
        if b == 0xFE:
            m.pc = m.fetch16(); m.jf = 1; return
        if b == 0xFF:
            raise Halt("SWI at %04X" % start)
        raise Halt("undefined opcode %02X at %04X" % (b, start))

    def div16(self, i):
        v = self.r16(i); c = self.r8(2)
        if c == 0:
            self.cf = 1; return
        q, r = divmod(v, c)
        self.w16r(i, (r << 8) | (q & 0xFF))
        self.cf = 1 if q > 0xFF else 0
        self.zf = self.jf = int(r == 0)

    def src(self, k, start):
        m = self
        disp = m.fetch() if k in (0, 4) else 0
        bx = m.fetch()
        # 16-bit loads and jumps need the address before the side effect only once
        if bx == 0x08 or bx == 0x09:     # ROLD / RORD A,(src)
            a = m.ea(k, start, disp); v = m.rd(a); acc = m.r8(0)
            if bx == 0x08:
                nv = ((v << 4) | (acc & 0xF)) & 0xFF; na = (acc & 0xF0) | (v >> 4)
            else:
                nv = ((acc & 0xF) << 4) | (v >> 4); na = (acc & 0xF0) | (v & 0xF)
            m.wr(a, nv); m.w8r(0, na); m.jf = 1; m.zf = 0; m.cf = 0; m.hf = 0; return
        if 0x14 <= bx <= 0x17:
            a = m.ea(k, start, disp); m.w16r(bx & 3, m.rd16(a)); m.jf = 1; return
        if bx == 0x20:
            a = m.ea(k, start, disp); m.wr(a, m.inc8(m.rd(a))); return
        if bx == 0x26:
            a = m.ea(k, start, disp); x = m.fetch(); v = m.rd(a); m.wr(x, v); m.jf = 1; return
        if bx == 0x27:
            a = m.ea(k, start, disp); v = m.rd(a); m.wr(m.r16(3), v); m.jf = 1; m.zf = int(v == 0); return
        if bx == 0x28:
            a = m.ea(k, start, disp); m.wr(a, m.dec8(m.rd(a))); return
        if bx == 0x2F:
            a = m.ea(k, start, disp); n = m.fetch(); m.alu8(7, m.rd(a), n); return
        if 0x40 <= bx <= 0x47:
            a = m.ea(k, start, disp); m.wr(a, m.bit_set(m.rd(a), bx & 7)); return
        if 0x48 <= bx <= 0x4F:
            a = m.ea(k, start, disp); m.wr(a, m.bit_clr(m.rd(a), bx & 7)); return
        if 0x58 <= bx <= 0x5F:
            a = m.ea(k, start, disp); v = m.rd(a); m.w8r(bx & 7, v); m.jf = 1; m.zf = int(v == 0); return
        if 0x60 <= bx <= 0x67:
            a = m.ea(k, start, disp); r = m.alu8(bx & 7, m.rd(a), m.rd(m.r16(3)))
            if r is not None: m.wr(a, r)
            return
        if 0x70 <= bx <= 0x77:
            a = m.ea(k, start, disp); n = m.fetch(); r = m.alu8(bx & 7, m.rd(a), n)
            if r is not None: m.wr(a, r)
            return
        if 0x78 <= bx <= 0x7F:
            a = m.ea(k, start, disp); r = m.alu8(bx & 7, m.r8(0), m.rd(a))
            if r is not None: m.w8r(0, r)
            return
        if 0xA8 <= bx <= 0xAF:
            a = m.ea(k, start, disp); v = m.rd(a); m.wr(a, m.r8(bx & 7)); m.w8r(bx & 7, v)
            m.jf = 1; m.zf = int(v == 0); return
        if 0xC0 <= bx <= 0xC7:
            a = m.ea(k, start, disp); m.wr(a, m.bit_cpl(m.rd(a), bx & 7)); return
        if 0xC8 <= bx <= 0xCF:
            a = m.ea(k, start, disp); v = m.rd(a); b = bx & 7
            m.wr(a, (v | (1 << b)) if m.cf else (v & ~(1 << b) & 0xFF)); m.jf = 1; return
        if 0xD0 <= bx <= 0xD7:
            a = m.ea(k, start, disp); m.cf ^= (m.rd(a) >> (bx & 7)) & 1; m.jf = m.cf ^ 1; return
        if 0xD8 <= bx <= 0xDF:
            a = m.ea(k, start, disp); m.bit_test(m.rd(a), bx & 7); return
        if 0xF8 <= bx <= 0xFC:
            a = m.ea(k, start, disp); t = m.rd16(a); m.push16(m.pc); m.pc = t; return
        if bx == 0xFE:
            a = m.ea(k, start, disp); m.pc = m.rd16(a); m.jf = 1; return
        raise Halt("undefined src op E%X %02X at %04X" % (k, bx, start))

    def dst(self, k, start):
        m = self
        disp = m.fetch() if k in (0, 4) else 0
        bx = m.fetch()
        if 0x10 <= bx <= 0x13:
            a = m.ea(k, start, disp); m.wr16(a, m.r16(bx & 3)); m.jf = 1; return
        if bx == 0x2C:
            a = m.ea(k, start, disp); m.wr(a, m.fetch()); m.jf = 1; return
        if 0x50 <= bx <= 0x57:
            a = m.ea(k, start, disp); m.wr(a, m.r8(bx & 7)); m.jf = 1; return
        raise Halt("undefined dst op F%X %02X at %04X" % (k, bx, start))

    def reg(self, b0, start):
        m = self
        g = b0 & 7; gg = b0 & 3
        bx = m.fetch()
        if bx == 0x01:
            v = m.r8(g); m.w8r(g, ((v & 0xF) << 4) | (v >> 4)); m.jf = 1; return
        if bx == 0x02:
            v = m.r16(gg); r = (v & 0xFF) * (v >> 8); m.w16r(gg, r); m.zf = m.jf = int((r >> 8) == 0); return
        if bx == 0x03:
            m.div16(gg); return
        if bx == 0x04 and b0 == 0xE8:
            m.sp = (m.sp + 3) & 0xFFFF
            m.pc = m.m[(m.sp - 2) & 0xFFFF] | (m.m[(m.sp - 1) & 0xFFFF] << 8)
            m.set_psw(m.m[m.sp]); return
        if bx == 0x06:
            m.w16r(gg, m.pop16()); return
        if bx == 0x07:
            m.push16(m.r16(gg)); return
        if bx == 0x0A: m.w8r(g, m.daa(m.r8(g))); return
        if bx == 0x0B: m.w8r(g, m.das(m.r8(g))); return
        if 0x10 <= bx <= 0x13:
            a = m.r16(bx & 3); m.w16r(bx & 3, m.r16(gg)); m.w16r(gg, a); m.jf = 1; return
        if 0x14 <= bx <= 0x17:
            m.w16r(bx & 3, m.r16(gg)); m.jf = 1; return
        if 0x1C <= bx <= 0x1F:
            m.w8r(g, m.shift(bx - 0x1C, m.r8(g))); return
        if 0x30 <= bx <= 0x37:
            r = m.alu16(bx & 7, m.r16(0), m.r16(gg))
            if r is not None: m.w16r(0, r)
            return
        if 0x38 <= bx <= 0x3F:
            r = m.alu16(bx & 7, m.r16(gg), m.fetch16())
            if r is not None: m.w16r(gg, r)
            return
        if 0x40 <= bx <= 0x47:
            m.w8r(g, m.bit_set(m.r8(g), bx & 7)); return
        if 0x48 <= bx <= 0x4F:
            m.w8r(g, m.bit_clr(m.r8(g), bx & 7)); return
        if 0x58 <= bx <= 0x5F:
            v = m.r8(g); m.w8r(bx & 7, v); m.jf = 1; m.zf = int(v == 0); return
        if 0x60 <= bx <= 0x67:
            r = m.alu8(bx & 7, m.r8(0), m.r8(g))
            if r is not None: m.w8r(0, r)
            return
        if 0x68 <= bx <= 0x6F:
            r = m.alu8(bx & 7, m.r8(g), m.r8(0))
            if r is not None: m.w8r(g, r)
            return
        if 0x70 <= bx <= 0x77:
            r = m.alu8(bx & 7, m.r8(g), m.fetch())
            if r is not None: m.w8r(g, r)
            return
        if bx in (0x82, 0x83, 0x8A, 0x8B, 0x92, 0x93, 0x9A, 0x9B, 0x9E, 0x9F):
            a = m.r16(2 + (bx & 1)); v = m.rd(a); bit = m.r8(g) & 7
            kind = bx & 0xFE
            if kind == 0x82: m.wr(a, m.bit_set(v, bit))
            elif kind == 0x8A: m.wr(a, m.bit_clr(v, bit))
            elif kind == 0x92: m.wr(a, m.bit_cpl(v, bit))
            elif kind == 0x9A:
                m.wr(a, (v | (1 << bit)) if m.cf else (v & ~(1 << bit) & 0xFF)); m.jf = 1
            else: m.bit_test(v, bit)
            return
        if 0xA8 <= bx <= 0xAF:
            a = m.r8(bx & 7); m.w8r(bx & 7, m.r8(g)); m.w8r(g, a); m.jf = 1; m.zf = int(m.r8(bx & 7) == 0); return
        if 0xC0 <= bx <= 0xC7:
            m.w8r(g, m.bit_cpl(m.r8(g), bx & 7)); return
        if 0xC8 <= bx <= 0xCF:
            v = m.r8(g); b = bx & 7
            m.w8r(g, (v | (1 << b)) if m.cf else (v & ~(1 << b) & 0xFF)); m.jf = 1; return
        if 0xD0 <= bx <= 0xD7:
            m.cf ^= (m.r8(g) >> (bx & 7)) & 1; m.jf = m.cf ^ 1; return
        if 0xD8 <= bx <= 0xDF:
            m.bit_test(m.r8(g), bx & 7); return
        if bx == 0xFA:
            m.sp = m.r16(gg); m.jf = 1; return
        if bx == 0xFB:
            m.w16r(gg, m.sp); m.jf = 1; return
        if bx == 0xFC:
            t = m.r16(gg); m.push16(m.pc); m.pc = t; return
        if bx == 0xFE:
            m.pc = m.r16(gg); m.jf = 1; return
        raise Halt("undefined reg op %02X %02X at %04X" % (b0, bx, start))


# ---------------------------------------------------------------------- Game Boy side helpers
class Link:
    """Clock bytes into the printer like a Game Boy. byte_us = time per byte incl. gap."""

    def __init__(self, prn, byte_us=1200):
        self.p = prn
        self.byte_us = byte_us

    def xfer(self, b):
        self.p.run_until(self.p.cyc + int(self.byte_us * MC_PER_S / 1_000_000))
        return self.p.exchange(b)

    def packet(self, cmd, data=b"", compress=0, bad_checksum=False, raw=None):
        if raw is not None:
            body = list(raw)
        else:
            n = len(data)
            hdr = [cmd, compress, n & 0xFF, n >> 8]
            chk = (sum(hdr) + sum(data)) & 0xFFFF
            if bad_checksum:
                chk ^= 0x0101
            body = [0x88, 0x33] + hdr + list(data) + [chk & 0xFF, chk >> 8, 0, 0]
        rx = [self.xfer(b) for b in body]
        return rx


def status_str(s):
    names = ["CHK", "BUSY", "FULL", "UNPROC", "PKTERR", "JAM", "OTHER", "LOWBAT"]
    return "%02X[%s]" % (s, " ".join(n for i, n in enumerate(names) if s >> i & 1))


if __name__ == "__main__":
    rom = open(sys.argv[1], "rb").read()
    p = Printer(rom)
    p.run_ms(500)
    print("booted: pc=%04X instr=%d cyc=%d idle=%s eir=%04X il=%04X" % (p.pc, p.instr, p.cyc, p.idle, p.eir, p.il))
    L = Link(p)
    r = L.packet(0x0F)
    print("status reply:", " ".join("%02X" % x for x in r))
