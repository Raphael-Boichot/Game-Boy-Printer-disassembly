"""Head strobe timing of the real firmware, to compare with a scope on a real printer.

Prints a full 9-band picture of solid black, dark grey and light grey (exposure 0x40, palette 0xE4)
and reports how long one strobe line (P0.0) stays on per burst, for two head-temperature readings.

Real printer (owner's scope, exposure 64): one pixel = 4 ms; black 1.56 ms, dark 1.20 ms, light 0.96 ms.
usage: python3 strobe_check.py [ROM]
"""
import copy, sys
from gbprinter_emu import Printer, Link

rom = open(sys.argv[1] if len(sys.argv) > 1 else '../TMP87C840_Toshiba_printer_ROM.bin', 'rb').read()
BOOT = Printer(rom); BOOT.run_ms(1500)


def tile(c):
    return bytes([0xFF if c & 1 else 0, 0xFF if c & 2 else 0] * 8)


def run(color, temp, bands=9, expo=0x40):
    p = copy.deepcopy(BOOT); p.temp_adc = temp; L = Link(p); log = []; orig = p.sfr_wr

    def hook(a, v):
        if a in (0x00, 0x14):
            log.append((p.cyc, a, v))
        orig(a, v)
    p.sfr_wr = hook
    L.packet(1)
    for _ in range(bands):
        L.packet(4, tile(color) * 40)
    L.packet(4); L.packet(2, bytes([1, 0, 0xE4, expo]))
    p.run_ms(100)
    while L.packet(0x0F)[-1] & 2:
        p.run_ms(50)
    pulses, bursts, cur, t = [], [], 0, None
    for c, a, v in log:
        if a == 0x14:
            if v == 0x18:
                bursts.append(c)
            continue
        if v & 1 and not cur & 1:
            t = c
        if cur & 1 and not v & 1 and t is not None:
            pulses.append((c - t) / 2000)
        cur = v
    pulses = [x for x in pulses if x > 0.3]      # drop the short pulses sent for white dots
    gaps = sorted((bursts[i + 1] - bursts[i]) / 2000 for i in range(len(bursts) - 1))
    return pulses, len(bursts), (gaps[len(gaps) // 2], (bursts[-1] - bursts[0]) / 2e6)


for temp in (0x40, 0x80):
    for col, name in ((3, 'black'), (2, 'dark'), (1, 'light')):
        s, nb, per = run(col, temp)
        n = len(s)
        print('temp ADC %02X %-5s %d bursts (median %.2f ms apart, %.1f s in all): strobe first %.2f, 10%% %.2f, 50%% %.2f, 90%% %.2f, last %.2f ms'
              % (temp, name, nb, per[0], per[1], s[0], s[n // 10], s[n // 2], s[9 * n // 10], s[-1]))
