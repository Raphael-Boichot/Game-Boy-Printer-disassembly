"""Regression test: protocol behaviour of the real firmware, as documented in Printer_protocol.md.
Check the protocol claims of Printer_protocol.md against the real firmware running in gbprinter_emu."""
import copy, random, sys
from gbprinter_emu import *

rom = open(sys.argv[1] if len(sys.argv) > 1 else '../TMP87C840_Toshiba_printer_ROM.bin', 'rb').read()
BOOT = Printer(rom); BOOT.run_ms(1500)
random.seed(1)
IMG = [bytes(random.randrange(256) for _ in range(640)) for _ in range(10)]
RESULTS = []

def fresh():
    p = copy.deepcopy(BOOT); return p, Link(p)

def st(rx): return rx[-1]
def ok(rx): return rx[-2] == 0x81

def record(name, expected, observed, detail=''):
    verdict = 'MATCH' if expected == observed else 'DIFFERS'
    RESULTS.append((name, expected, observed, verdict, detail))
    print('%-58s expected %-14s observed %-14s %s %s' % (name, expected, observed, verdict, detail))

def hx(x): return '%02X' % x
def seq(*rxs): return ' '.join(hx(st(r)) for r in rxs)

def load(L, n=2, p=None):
    L.packet(0x01)
    for i in range(n): L.packet(0x04, IMG[i])

# 1 basic job sequence
p, L = fresh()
a = L.packet(0x01); b = L.packet(0x04, IMG[0]); c = L.packet(0x04, IMG[1]); d = L.packet(0x04)
e = L.packet(0x02, bytes([1, 0x13, 0xE4, 0x40])); p.run_ms(5); f = L.packet(0x0F); p.run_ms(100); g = L.packet(0x0F)
record('job: init,data,data,empty,print,status,status', '00 00 08 08 08 04 06', seq(a, b, c, d, e, f, g))

# 2 checksum flag lag
p, L = fresh()
a = L.packet(0x0F, bad_checksum=True); b = L.packet(0x0F); c = L.packet(0x0F)
record('bad-checksum status packet, then two good ones', '00 01 00', seq(a, b, c), '(bit 0x01 one packet late)')

# 3 print without empty data packet
p, L = fresh(); load(L)
a = L.packet(0x02, bytes([1, 0x13, 0xE4, 0x40])); p.run_ms(200); b = L.packet(0x0F)
record('print without end-of-data packet: reply, status 200ms later', '18 00', seq(a, b), '(packet error, no print; idle reset wiped it)')

# 4 print with 3-byte payload
p, L = fresh(); load(L); L.packet(0x04)
a = L.packet(0x02, bytes([1, 0x13, 0xE4])); p.run_ms(200); b = L.packet(0x0F)
record('print with only 3 argument bytes: reply, status 200ms later', '18 00', seq(a, b), '(packet error, no print)')

# 5 second empty data packet
p, L = fresh(); load(L); L.packet(0x04); L.packet(0x0F)
a = L.packet(0x04)
record('second empty data packet (after a status poll)', '14', seq(a), '(packet error + full)')

# 6 compression flag 2
p, L = fresh(); L.packet(0x01)
a = L.packet(0x04, IMG[0][:100], compress=2)
record('data with compression flag 2', '10', seq(a))

# 7 length >= 0x400 uncompressed / compressed
p, L = fresh(); L.packet(0x01)
a = L.packet(0x04, bytes(0x400)); b = L.packet(0x0F)
p, L = fresh(); L.packet(0x01)
c = L.packet(0x04, bytes(0x400), compress=1); d = L.packet(0x0F)
record('1024-byte data: uncompressed / compressed (+status after)', '10 10 / 00 00', '%s / %s' % (seq(a, b), seq(c, d)))

# 8 status poll clears UNPROC when idle
p, L = fresh(); load(L)
a = L.packet(0x0F); b = L.packet(0x0F)
record('two status polls after 2 data packets', '00 00', seq(a, b), '(0x0F clears 0x08 before replying)')

# 9 garbage first byte while idle -> init
p, L = fresh(); load(L)
L.xfer(0x55); p.run_ms(20)
a = L.packet(0x0F, ); 
p2, L2 = fresh(); load(L2); p2.run_ms(20); b = L2.packet(0x04)
c = L.packet(0x04)
record('junk byte while idle wipes data (next data reply)', '00 vs 08', '%s vs %s' % (seq(c), seq(b)), '(control: no junk)')

# 10 replies during sync loss
p, L = fresh()
rx = [L.xfer(x) for x in (0x55, 0x88, 0x33, 0x0F, 0, 0, 0, 0x0F, 0, 0, 0)]
record('bytes after a junk first byte (no gap)', 'FF FF FF FF FF FF FF FF FF FF', ' '.join(hx(x) for x in rx[1:]))
p.run_ms(10); d = L.packet(0x0F)
record('next packet after a >5.12 ms gap', '81 00', '%02X %02X' % (d[-2], d[-1]))

# 11 bad second byte
p, L = fresh()
rx = [L.xfer(x) for x in (0x88, 0x00, 0x0F, 0x00)]
record('0x88 then bad second byte: replies to bytes 2-4', '00 FF FF', ' '.join(hx(x) for x in rx[1:]))

# 12 inter-byte gap timeout
def gap_test(gap_ms):
    p, L = fresh(); L.packet(0x01)
    body = [0x88, 0x33, 0x0F, 0, 0, 0]
    for i, x in enumerate(body):
        if i == 3: p.run_ms(gap_ms)
        L.xfer(x)
    rx = [L.xfer(x) for x in (0x0F, 0, 0, 0)]
    return rx
lo, hi = 1.0, 20.0
for _ in range(10):
    mid = (lo + hi) / 2
    r = gap_test(mid)
    if r[-2] == 0x81: lo = mid
    else: hi = mid
record('longest gap inside a packet that is still accepted', '3.91-3.93 ms', '%.2f-%.2f ms' % (lo, hi), '(+1.2 ms byte time = 5.12 ms)')

# 13 idle reset
def idle_test(ms):
    p, L = fresh(); load(L); L.packet(0x04)
    p.run_ms(ms); return st(L.packet(0x0F))
lo, hi = 20.0, 2000.0
for _ in range(12):
    mid = (lo + hi) / 2
    if idle_test(mid) & 0x04: lo = mid
    else: hi = mid
record('silence after end-of-data that wipes the job', '125-126 ms', '%.0f-%.0f ms' % (lo, hi), '(12-13 ticks of 10.24 ms)')

# 14 init while busy
p, L = fresh(); load(L); L.packet(0x04); L.packet(0x02, bytes([1, 0x13, 0xE4, 0x40])); p.run_ms(300)
a = L.packet(0x0F); b = L.packet(0x01); c = L.packet(0x0F)
record('init while printing: status, init reply, status', '06 0E 0E', seq(a, b, c), '(init ignored, 0x08 set)')

# 15 break while busy
p, L = fresh(); load(L); L.packet(0x04); L.packet(0x02, bytes([1, 0x13, 0xE4, 0x40])); p.run_ms(300)
a = L.packet(0x08); p.run_ms(50); b = L.packet(0x0F); b2 = L.packet(0x04, IMG[0])
while L.packet(0x0F)[-1] & 2: p.run_ms(5)
c = L.packet(0x04, IMG[0]); d = L.packet(0x01); e = L.packet(0x04, IMG[0])
record('break while printing: break, status, data (busy), then idle: data, init, data', '02 06 04 14 04 00', seq(a, b, b2, c, d, e), '(stops at the end of the band)')

# 16 ten data packets
p, L = fresh(); L.packet(0x01)
r = [L.packet(0x04, IMG[i]) for i in range(10)]
record('10 data packets: replies', '00 08 08 08 08 08 08 08 08 08', seq(*r))
record('  bytes stored after 10 packets (0x85)', '1680', '%04X' % (p.m[0x85] | p.m[0x86] << 8))

# 17 unknown command
p, L = fresh()
a = L.packet(0x03, b'\x01\x02'); b = L.packet(0x0F)
record('unknown command 0x03 with payload', '81 00', '%02X %02X' % (a[-2], a[-1]))

# 18 print with 0 sheets (feed only)
p, L = fresh(); load(L); L.packet(0x04)
a = L.packet(0x02, bytes([0, 0x03, 0xE4, 0x40])); p.run_ms(100); b = L.packet(0x0F)
record('print with 0 sheets, margin 3: status after 100ms', '06', seq(b), '(feed runs, busy)')

# 19 low battery
p = Printer(rom, batt_adc=0x70); p.run_ms(1500); L = Link(p)
a = L.packet(0x0F); b = L.packet(0x0F)
record('battery ADC 0x70 at power-on: two status replies', 'FF FF', seq(a, b), '(lockout never lifted)')
# 20 head temperature out of range
p = Printer(rom, temp_adc=0x20); p.run_ms(1500); L = Link(p); load(L); L.packet(0x04)
a = L.packet(0x02, bytes([1, 0x13, 0xE4, 0x40])); p.run_ms(100); b = L.packet(0x0F)
record('head temp ADC 0x20 at power-on: status', 'FF', seq(b), '(lockout never lifted)')
# 21 paper jam
p, L = fresh(); load(L); L.packet(0x04); L.packet(0x02, bytes([1, 0x13, 0xE4, 0x40])); p.run_ms(300); p.jam = True
p.run_ms(400); a = L.packet(0x0F); b = L.packet(0x01); c = L.packet(0x0F)
record('encoder stops mid-print: status, init, status', '28 28 28', seq(a, b, c))

print()
print('%d checks, %d match, %d differ' % (len(RESULTS), sum(r[3] == 'MATCH' for r in RESULTS), sum(r[3] != 'MATCH' for r in RESULTS)))
