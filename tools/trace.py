"""Trace the Game Boy Printer ROM (TMP87C840) from its interrupt vectors and write a listing.

usage: python3 trace.py ROM.bin OUT.asm [extra_root_hex ...]
The repository listing was made with:  python3 trace.py TMP87C840_Toshiba_printer_ROM.bin ../TMP87C840_printer_rom.asm ABA1
"""
import struct, sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from t870 import dis, SYM
import t870

d = open(sys.argv[1], 'rb').read()
assert len(d) == 0x8000, "expected the 32 KB printer ROM"
m = bytearray(0x8000) + d
VEC = {}
names = ["V_FFE0", "V_FFE2", "V_FFE4", "V_FFE6", "V_FFE8", "V_FFEA", "V_FFEC", "V_FFEE",
         "V_FFF0", "V_FFF2", "V_FFF4", "V_FFF6", "V_FFF8", "V_FFFA", "V_FFFC", "RESET"]
for i in range(16):
    v = struct.unpack('<H', m[0xFFE0 + 2 * i:0xFFE2 + 2 * i])[0]
    VEC.setdefault(v, []).append(names[i])

extra = [int(x, 16) for x in sys.argv[3:]]
code = {}
labels = {}
calls = set()
todo = list(VEC) + extra
for v in VEC: labels[v] = "/".join(VEC[v])
jptab = []
TAB = {}
while todo:
    a = todo.pop()
    while a not in code and 0x8000 <= a <= 0xFFFF:
        I = dis(m, a)
        code[a] = I
        for t in I.tg:
            labels.setdefault(t, "L%04X" % t); todo.append(t)
        for t in I.call:
            labels.setdefault(t, "S%04X" % t); todo.append(t); calls.add(t)
        if "(PC+A)" in I.t:
            jptab.append(a)
            base = a + I.n; k = base; lo = 0x10000
            while k < lo:
                tgt = m[k] | (m[k+1] << 8)
                if not (0x8000 <= tgt < 0xE071): break
                lo = min(lo, tgt); labels.setdefault(tgt, "J%04X" % tgt); todo.append(tgt); k += 2
            TAB[base] = k
        if I.end: break
        a += I.n

cov = set()
for a, I in code.items():
    for k in range(I.n): cov.add(a + k)
print("; code bytes", len(cov), "subroutines", len(calls), file=sys.stderr)
print("; indirect jumps at", [hex(x) for x in jptab], file=sys.stderr)

out = []
a = 0x8000
while a < 0x10000:
    if a in code:
        I = code[a]
        if a in labels: out.append("%s:" % labels[a])
        t = I.t
        for tg in I.tg + I.call:
            if tg in labels: t = t.replace("$%04X" % tg, labels[tg])
        out.append("  %04X  %-10s %s" % (a, m[a:a + I.n].hex(), t))
        a += I.n
    else:
        s = a
        if s in TAB:
            for k in range(s, TAB[s], 2):
                tg = m[k] | (m[k+1] << 8); out.append("  %04X  dw %s" % (k, labels.get(tg, "$%04X" % tg)))
            a = TAB[s]; continue
        while a < 0x10000 and a not in code and a not in TAB: a += 1
        blk = m[s:a]
        if all(x == 0xFF for x in blk):
            out.append("  %04X  ; FF fill x%d" % (s, len(blk)))
        else:
            for k in range(0, len(blk), 16):
                out.append("  %04X  db %s" % (s + k, " ".join("%02X" % x for x in blk[k:k + 16])))
open(sys.argv[2], 'w').write("\n".join(out) + "\n")
