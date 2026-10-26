"""Editability test for src/: insert code, rebuild, and check that the firmware still behaves the same.

Copies src/ to a temporary folder, inserts a `nop` at the start of three routines in three modules
(so nearly all code and tables move), assembles it, and runs the same print job on the original ROM
and on the moved one in the emulator. Replies, status sequence, strobe bursts and SRAM must match.
usage: python3 emulator/relocation_test.py
"""
import os, random, shutil, subprocess, sys, tempfile
HERE = os.path.dirname(os.path.abspath(__file__)); ROOT = os.path.dirname(HERE)
sys.path.insert(0, HERE); sys.path.insert(0, os.path.join(ROOT, 'tools'))
from gbprinter_emu import Printer, Link
import t870asm

tmp = tempfile.mkdtemp()
shutil.copytree(os.path.join(ROOT, 'src'), os.path.join(tmp, 'src'))
for f, lab in (('main_loop.asm', 'Main_Loop'), ('column.asm', 'Line_ExtractColumn'), ('receiver.asm', 'Rx_WaitByte')):
    p = os.path.join(tmp, 'src', f); s = open(p).read().split('\n')
    j = s.index(lab + ':') + 1
    while s[j].startswith(';'):
        j += 1
    s.insert(j, '        nop   ; inserted by the relocation test'); open(p, 'w').write('\n'.join(s))
img = t870asm.assemble(t870asm.load_source(os.path.join(tmp, 'src', 'main.asm')))
moved = bytearray([0xFF]) * 0x8000
for a, v in img.items():
    moved[a - 0x8000] = v
orig = open(os.path.join(ROOT, 'TMP87C840_Toshiba_printer_ROM.bin'), 'rb').read()
random.seed(1); IMG = [bytes(random.randrange(256) for _ in range(640)) for _ in range(3)]


def session(rom):
    p = Printer(rom); p.run_ms(1500); L = Link(p)
    r = [L.packet(1)[-1]] + [L.packet(4, IMG[i])[-1] for i in range(3)] + [L.packet(4)[-1], L.packet(2, bytes([1, 0x13, 0xE4, 0x40]))[-1]]
    seq, cnt, o = [], [0], p.sfr_wr

    def hook(a, v):
        if a == 0x14 and v == 0x18:
            cnt[0] += 1
        o(a, v)
    p.sfr_wr = hook
    for k in range(400):
        p.run_ms(50); s = L.packet(0x0F)[-1]
        if not seq or seq[-1] != s:
            seq.append(s)
        if k > 5 and not s & 2:
            break
    return r, seq, cnt[0], bytes(p.sram[:0x780])


a, b = session(orig), session(bytes(moved))
print('moved ROM differs from the original in %d bytes' % sum(x != y for x, y in zip(orig, moved)))
print('original: replies %s status %s bursts %d' % (a[0], a[1], a[2]))
print('moved   : replies %s status %s bursts %d' % (b[0], b[1], b[2]))
ok = a == b
print('RESULT:', 'same behaviour' if ok else 'DIFFERENT'); shutil.rmtree(tmp); sys.exit(0 if ok else 1)
