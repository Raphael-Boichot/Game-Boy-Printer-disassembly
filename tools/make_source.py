"""Write the editable source tree src/ from the generated listing.

usage: python3 tools/make_source.py [LISTING] [ROM]
   defaults: TMP87C840_printer_rom.asm, TMP87C840_Toshiba_printer_ROM.bin

Overwrites src/ (and src/data/). Build it with `make` (or `python3 tools/t870asm.py src/main.asm
build/printer.bin`) and check it with `make check`.

Layout:
  src/main.asm         includes, org, module order
  src/hardware.inc     special function registers (equ)
  src/ram.inc          RAM variables and flag bits (equ + comments)
  src/<module>.asm     code, in address order
  src/data/*.bin       large tables, src/data/*.2bpp the self-test image (incbin)
Small tables are kept as db / dw lines; pointer tables, tick curves and the interrupt vectors use labels.
"""
import os, re, struct, sys, shutil, csv

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
lst_path = sys.argv[1] if len(sys.argv) > 1 else os.path.join(ROOT, 'TMP87C840_printer_rom.asm')
rom_path = sys.argv[2] if len(sys.argv) > 2 else os.path.join(ROOT, 'TMP87C840_Toshiba_printer_ROM.bin')
rom = open(rom_path, 'rb').read()
m = bytearray(0x8000) + rom
SRC = os.path.join(ROOT, 'src')

MODULES = [  # (start address, file, title)
    (0x8000, 'reset.asm', 'Reset: ports, RAM clear, SRAM test, timers, serial port, battery check, self-test request'),
    (0x80D5, 'main_loop.asm', 'Main loop: idle, tick work, watchdogs, command handlers, job start'),
    (0x8808, 'line_pipeline.asm', 'Line pipeline: first column, column preparation for strobe tables A / B, line buffer refill'),
    (0xA2ED, 'data_decoder.asm', 'Data decoder (main loop side), temperature / battery check, SRAM access, RLE, SRAM layout table'),
    (0xAA7E, 'interrupts_mech.asm', 'Strobe timer, battery check, button / cam / encoder interrupts and the mechanism states'),
    (0xB370, 'receiver.asm', 'Main tick, serial packet receiver (coroutine), inter-byte timeout'),
    (0xB9C2, 'column.asm', 'Column extraction, history, energy codes, strobe-table writers'),
    (0xCCB6, 'tables.asm', 'Head energy and timing tables'),
    (0xDD85, 'selftest.asm', 'SRAM test and self-test image'),
    (0xE06E, 'vectors.asm', 'Unused interrupt handlers, unused ROM, interrupt vectors'),
]
INCBIN = {  # table label -> file name (bytes taken from the ROM)
    'Tab_SramLayout': 'sram_layout.bin', 'Tab_DotTicks': 'dot_ticks.bin',
    'Tab_HeatBaseByTemp': 'heat_base_by_temp.bin', 'Tab_ExposureOffset': 'exposure_offset.bin',
    'Tab_IdleCoolByTemp': 'idle_cool_by_temp.bin', 'Tab_HeatAddByCode': 'heat_add_by_code.bin',
    'Tab_HeatAddFreshByTemp': 'heat_add_fresh_by_temp.bin',
    'Tab_HeatCorr0': 'heat_corr_0.bin', 'Tab_HeatCorr1': 'heat_corr_1.bin',
    'Tab_HeatCorr2': 'heat_corr_2.bin', 'Tab_HeatCorr3': 'heat_corr_3.bin',
    'Tab_BandCoolByTemp': 'band_cool_by_temp.bin', 'Tab_DecayByTemp': 'decay_by_temp.bin',
    'Gfx_SelfTestBand': 'selftest_band.2bpp',
}
CURVES = {'Tab_TickCurvesWarm': 0xDB88, 'Tab_TickCurvesCold': 0xDC7B}
CURVE_PTRS = {'Tab_TickCurvePtrsWarm': 'Tab_TickCurvesWarm', 'Tab_TickCurvePtrsCold': 'Tab_TickCurvesCold'}

types = [(int(r['start'], 16), int(r['end'], 16), r) for r in csv.DictReader(open(os.path.join(ROOT, 'symbols', 'rom_types.csv')))]
lines = open(lst_path).read().splitlines()

# labels -> address
labels = {}
pending = []
for ln in lines:
    mm = re.match(r'^([A-Za-z_][A-Za-z0-9_]*):$', ln)
    if mm:
        pending.append(mm.group(1)); continue
    mm = re.match(r'^  ([0-9A-F]{4})  ', ln)
    if mm:
        for n in pending:
            labels[n] = int(mm.group(1), 16)
        pending = []
addr2label = {}
for n, a in labels.items():
    addr2label.setdefault(a, n)


def block_at(a):
    for s, e, r in types:
        if s == a:
            return s, e, r
    return None


if os.path.isdir(SRC):
    shutil.rmtree(SRC)
os.makedirs(os.path.join(SRC, 'data'))

# ---------------------------------------------------------------- includes from the equ section
hw, ram = [], []
for ln in lines:
    if re.match(r'^[A-Za-z_][A-Za-z0-9_]*\s+equ\s+\$', ln):
        v = int(re.search(r'equ \$([0-9A-F]+)', ln).group(1), 16)
        (hw if v < 0x40 and len(re.search(r'equ \$([0-9A-F]+)', ln).group(1)) == 2 else ram).append(ln)
    elif ln.startswith(';   .'):
        ram.append(ln)
open(os.path.join(SRC, 'hardware.inc'), 'w').write(
    '; TMP87C840 special function registers (names from the datasheet; pin use from the IF-GBP-02 schematic)\n\n' + '\n'.join(hw) + '\n')
open(os.path.join(SRC, 'ram.inc'), 'w').write(
    '; RAM variables and flag bits. [C] code-traced or run in the emulator, [I] inferred\n\n' + '\n'.join(ram) + '\n')

# ---------------------------------------------------------------- modules
out = {f: ['; %s' % t, ''] for s, f, t in MODULES}


def module_of(a):
    f = MODULES[0][1]
    for s, fn, t in MODULES:
        if a >= s:
            f = fn
    return f


skip_until = -1
pend = []      # label / comment lines waiting for the next addressed line
started = False
for ln in lines:
    if ln.strip() == 'org $8000':
        started = True; continue
    if not started:
        continue
    mm = re.match(r'^  ([0-9A-F]{4})  ([0-9a-f]+)\s+(.*)$', ln)
    if not mm:
        if ln.startswith('; untyped'):
            continue
        pend.append(ln)
        continue
    a = int(mm.group(1), 16)
    text = mm.group(3)
    if a <= skip_until:
        pend = []
        continue
    f = module_of(a)
    body = out[f]
    lab = addr2label.get(a)
    blk = block_at(a)
    if blk and lab in INCBIN:
        s, e, r = blk
        fn = INCBIN[lab]
        open(os.path.join(SRC, 'data', fn), 'wb').write(bytes(m[s:e + 1]))
        body += pend + ['        incbin "data/%s"   ; %d bytes' % (fn, e - s + 1)]
        pend = []; skip_until = e
        continue
    if blk and lab in CURVES:
        s, e, r = blk
        body += pend
        for i in range(9):
            body.append('%s_Band%d:' % (lab, i))
            row = m[s + 25 * i:s + 25 * i + 25]
            body.append('        db ' + ', '.join('$%02X' % x for x in row))
        pend = []; skip_until = e
        continue
    if blk and lab in CURVE_PTRS:
        s, e, r = blk
        tgt = CURVE_PTRS[lab]
        base = CURVES[tgt]
        names = []
        for k in range(s, e + 1, 2):
            w = m[k] | (m[k + 1] << 8)
            i, rem = divmod(w - base, 25)
            assert rem == 0 and 0 <= i < 9, hex(w)
            names.append('%s_Band%d' % (tgt, i))
        body += pend + ['        dw ' + ', '.join(names[:5]), '        dw ' + ', '.join(names[5:])]
        pend = []; skip_until = e
        continue
    if blk and blk[2]['type'] == 'fill':
        s, e, r = blk
        body += pend + ['; unused ROM %04X-%04X (%d bytes): the assembler fills gaps with $FF' % (s, e, e - s + 1)]
        pend = []; skip_until = e
        continue
    if a == 0xFFE0:
        vec = []
        for k in range(0xFFE0, 0x10000, 2):
            w = m[k - 0x8000 + 0x8000] | (m[k + 1] << 8)
            vec.append(addr2label[w])
        body += pend + ['        org $FFE0', 'Vectors:', '; FFE0 INT5, FFE2 INTTC2, FFE4 INTSIO2, FFE6 INT4, FFE8 INT3, FFEA INTTC4, FFEC INTSIO1, FFEE INTTC3,',
                        '; FFF0 INT2, FFF2 INTTBT, FFF4 INT1, FFF6 INTTC1, FFF8 INT0, FFFA INTWDT, FFFC INTSW, FFFE RESET']
        for i in range(0, 16, 4):
            body.append('        dw ' + ', '.join(vec[i:i + 4]))
        pend = []; skip_until = 0xFFFF
        continue
    if blk and blk[2]['type'] == 'words' and lab not in INCBIN:
        s, e, r = blk
        ws = [m[k] | (m[k + 1] << 8) for k in range(s, e + 1, 2)]
        if all(w in addr2label for w in ws):     # pointer table
            body += pend + ['        dw ' + ', '.join(addr2label[w] for w in ws)]
            pend = []; skip_until = e
            continue
    # 16-bit immediates that are ROM addresses -> labels (Label-n when just before a table)
    mi = re.match(r'^(ld|ldw|add) (.*),\$([0-9A-F]{4})(.*)$', text)
    if mi and int(mi.group(3), 16) >= 0x8000:
        v = int(mi.group(3), 16)
        sym = addr2label.get(v)
        if sym is None:
            for k in range(1, 5):
                if v + k in addr2label and block_at(v + k):
                    sym = '%s-%d' % (addr2label[v + k], k); break
        if sym:
            text = '%s %s,%s%s' % (mi.group(1), mi.group(2), sym, mi.group(4))
    body += pend
    pend = []
    body.append('        ' + text)

main = ['; Game Boy Printer firmware (TMP87C840 / TMP87PM40AF), editable source.',
        '; Build: make   (or: python3 tools/t870asm.py src/main.asm build/printer.bin)',
        '; Check: make check   (md5 aa393ec87ccb4220200255ab5adf8ac9)',
        '; Generated once by tools/make_source.py; regenerating overwrites src/.', '',
        'include "hardware.inc"', 'include "ram.inc"', '', '        org $8000']
for s, f, t in MODULES:
    open(os.path.join(SRC, f), 'w').write('\n'.join(out[f]).rstrip() + '\n')
    main.append('include "%s"   ; %04X' % (f, s))
open(os.path.join(SRC, 'main.asm'), 'w').write('\n'.join(main) + '\n')
print('wrote src/: %d modules, %d data files' % (len(MODULES), len(os.listdir(os.path.join(SRC, 'data')))))
