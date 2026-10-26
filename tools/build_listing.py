"""Build the annotated listing of the Game Boy Printer ROM from the symbol files.

usage: python3 tools/build_listing.py [ROM] [OUT]
   defaults: TMP87C840_Toshiba_printer_ROM.bin, TMP87C840_printer_rom.asm

Inputs (symbols/):
  sfr.csv        addr,name,desc                 special function registers (datasheet)
  ram.csv        addr,size,name,tag,desc         RAM variables and buffers
  ram_bits.csv   addr,bit,name,tag,desc          named flag bits (shown as comments on bit instructions)
  rom_names.csv  addr,name,tag,note              routine / label / table names
  rom_types.csv  start,end,type,width,tag,note   data blocks: words, bytes (row width), image, fill
  roots.csv      addr,reason                     extra code entry points for the tracer

Checks (the build aborts on any of them): duplicate names, a ROM name that is not on an instruction
or data boundary, a data block overlapping traced code, and the byte round trip: the hex column of
the listing, read back, must give the ROM again (md5 printed).
"""
import csv, hashlib, os, re, struct, sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, HERE)
import t870
from t870 import dis

rom_path = sys.argv[1] if len(sys.argv) > 1 else os.path.join(ROOT, 'TMP87C840_Toshiba_printer_ROM.bin')
out_path = sys.argv[2] if len(sys.argv) > 2 else os.path.join(ROOT, 'TMP87C840_printer_rom.asm')
rom = open(rom_path, 'rb').read()
assert len(rom) == 0x8000
m = bytearray(0x8000) + rom
SYMD = os.path.join(ROOT, 'symbols')


def rows(name):
    with open(os.path.join(SYMD, name), newline='') as f:
        return [r for r in csv.DictReader(f) if r and not list(r.values())[0].startswith('#')]


def H(s):
    return int(s, 16)


errors = []
sfr = {H(r['addr']): r for r in rows('sfr.csv')}
ram = {H(r['addr']): r for r in rows('ram.csv')}
bits = {(H(r['addr']), int(r['bit'])): r for r in rows('ram_bits.csv')}
names = {}
for r in rows('rom_names.csv'):
    a = H(r['addr'])
    if a in names:
        errors.append('two names at %04X' % a)
    names[a] = r
types = sorted((H(r['start']), H(r['end']), r) for r in rows('rom_types.csv'))
roots = [H(r['addr']) for r in rows('roots.csv')]

allnames = [r['name'] for r in sfr.values()] + [r['name'] for r in ram.values()] + [r['name'] for r in names.values()]
dups = {n for n in allnames if allnames.count(n) > 1}
if dups:
    errors.append('duplicate names: %s' % sorted(dups))

# direct-page names used by the disassembler for (x) operands
t870.SYM.clear()
for a, r in sfr.items():
    t870.SYM[a] = r['name']
for a, r in ram.items():
    if a < 0x100:
        t870.SYM[a] = r['name']

# ---------------------------------------------------------------- trace (same rules as tools/trace.py)
VEC = {}
vnames = ["V_FFE0", "V_FFE2", "V_FFE4", "V_FFE6", "V_FFE8", "V_FFEA", "V_FFEC", "V_FFEE",
          "V_FFF0", "V_FFF2", "V_FFF4", "V_FFF6", "V_FFF8", "V_FFFA", "V_FFFC", "RESET"]
for i in range(16):
    v = struct.unpack('<H', m[0xFFE0 + 2 * i:0xFFE2 + 2 * i])[0]
    VEC.setdefault(v, []).append(vnames[i])
data_ranges = [(s, e) for s, e, r in types]


def in_data(a):
    return any(s <= a <= e for s, e in data_ranges)


code, labels, TAB = {}, {}, {}
todo = list(VEC) + roots
for v in VEC:
    labels[v] = "/".join(VEC[v])
while todo:
    a = todo.pop()
    while a not in code and 0x8000 <= a <= 0xFFFF and not in_data(a):
        I = dis(m, a)
        code[a] = I
        for t in I.tg:
            labels.setdefault(t, "L%04X" % t); todo.append(t)
        for t in I.call:
            labels.setdefault(t, "S%04X" % t); todo.append(t)
        if "(PC+A)" in I.t:
            base = a + I.n; k = base; lo = 0x10000
            while k < lo:
                tgt = m[k] | (m[k + 1] << 8)
                if not (0x8000 <= tgt < 0xE071):
                    break
                lo = min(lo, tgt); labels.setdefault(tgt, "J%04X" % tgt); todo.append(tgt); k += 2
            TAB[base] = k
        if I.end:
            break
        a += I.n

starts = set(code)
covered = set()
for a, I in code.items():
    covered.update(range(a, a + I.n))
for s, e, r in types:
    if any(x in covered for x in range(s, e + 1)):
        errors.append('data block %04X-%04X overlaps traced code' % (s, e))
for a, r in names.items():
    ok = a in starts or a in TAB or any(s == a for s, e, _ in types) or a in VEC or a in labels
    if not ok:
        errors.append('name %s at %04X is not on an instruction or block start' % (r['name'], a))

# final label text
lab = dict(labels)
for a, r in names.items():
    lab[a] = r['name']
ram16 = {a: r['name'] for a, r in ram.items()}
for a, r in sfr.items():
    ram16.setdefault(a, r['name'])
data_names = {a: r['name'] for a, r in names.items() if in_data(a) or a in TAB}

IMM = re.compile(r'^(ld|add) (WA|BC|DE|HL),\$([0-9A-F]{4})$')


def render(I):
    t = I.t
    for tg in I.tg + I.call:
        if tg in lab:
            t = t.replace("$%04X" % tg, lab[tg])
    mm = IMM.match(t)
    if mm:
        v = int(mm.group(3), 16)
        if v in data_names:
            t = '%s %s,%s' % (mm.group(1), mm.group(2), data_names[v])
        elif mm.group(1) == 'ld' and v in ram16 and v >= 0x40:
            t = '%s %s,%s' % (mm.group(1), mm.group(2), ram16[v])
    cm = ''
    bm = re.search(r'\(([A-Za-z_][A-Za-z0-9_]*|\$[0-9A-F]{2})\)\.(\d)', t)
    if bm:
        key = bm.group(1)
        addr = None
        for a, n in t870.SYM.items():
            if n == key:
                addr = a
        if key.startswith('$'):
            addr = int(key[1:], 16)
        if addr is not None and (addr, int(bm.group(2))) in bits:
            cm = bits[(addr, int(bm.group(2)))]['name']
    return t, cm


def comment_for(a):
    r = names.get(a)
    if not r:
        return None
    note = r.get('note', '').strip()
    return '; [%s] %s' % (r['tag'], note) if note else '; [%s]' % r['tag']


# ---------------------------------------------------------------- emit
out = []
out.append('; Game Boy Printer firmware, Toshiba TMP87C840 / TMP87PM40AF (TLCS-870), ROM 0x8000-0xFFFF')
out.append('; md5 %s   generated by tools/build_listing.py from symbols/*.csv - do not edit by hand' % hashlib.md5(rom).hexdigest())
out.append('; columns: address, bytes, instruction.  [C] code-traced or run in the emulator, [I] inferred, [?] doubt')
out.append('')
for a in sorted(sfr):
    out.append('%-10s equ $%02X   ; %s' % (sfr[a]['name'], a, sfr[a]['desc']))
out.append('')
for a in sorted(ram):
    r = ram[a]
    out.append('%-16s equ $%04X   ; [%s] %s byte(s). %s' % (r['name'], a, r['tag'], r['size'], r['desc']))
    for b in range(8):
        if (a, b) in bits:
            br = bits[(a, b)]
            out.append(';   .%d %-14s [%s] %s' % (b, br['name'], br['tag'], br['desc']))
out.append('')

typemap = {s: (e, r) for s, e, r in types}
a = 0x8000
counts = {'code': 0, 'jumptable': 0}
while a < 0x10000:
    if a in typemap:
        e, r = typemap[a]
        c = comment_for(a)
        out.append('')
        if a in lab:
            out.append('%s:' % lab[a])
        if c:
            out.append(c)
        if r.get('note'):
            out.append('; %s %04X-%04X: [%s] %s' % (r['type'], a, e, r['tag'], r['note']))
        n = e - a + 1
        counts[r['type']] = counts.get(r['type'], 0) + n
        if r['type'] == 'words':
            for k in range(a, e + 1, 16):
                ws = struct.unpack('<%dH' % (min(16, e + 1 - k) // 2), m[k:min(k + 16, e + 1)])
                out.append('  %04X  %-32s dw %s' % (k, m[k:min(k + 16, e + 1)].hex(), ', '.join('$%04X' % w for w in ws)))
        elif r['type'] == 'fill':
            for k in range(a, e + 1, 16):
                out.append('  %04X  %-32s db fill' % (k, m[k:min(k + 16, e + 1)].hex()))
        else:
            w = int(r.get('width') or 16)
            for k in range(a, e + 1, w):
                seg = m[k:min(k + w, e + 1)]
                out.append('  %04X  %-32s db %s' % (k, seg.hex(), ', '.join('$%02X' % x for x in seg)))
        a = e + 1
        continue
    if a in code:
        I = code[a]
        if a in lab:
            if a in names or a in VEC:
                out.append('')
            out.append('%s:' % lab[a])
            c = comment_for(a)
            if c:
                out.append(c)
        t, cm = render(I)
        out.append('  %04X  %-10s %s%s' % (a, m[a:a + I.n].hex(), t, ('   ; ' + cm) if cm else ''))
        counts['code'] += I.n
        a += I.n
        continue
    if a in TAB:
        if a in lab:
            out.append('%s:' % lab[a])
        for k in range(a, TAB[a], 2):
            tg = m[k] | (m[k + 1] << 8)
            out.append('  %04X  %-10s dw %s' % (k, m[k:k + 2].hex(), lab.get(tg, '$%04X' % tg)))
        counts['jumptable'] += TAB[a] - a
        a = TAB[a]
        continue
    s = a
    while a < 0x10000 and a not in code and a not in TAB and a not in typemap:
        a += 1
    counts['untyped'] = counts.get('untyped', 0) + (a - s)
    out.append('; untyped %04X-%04X' % (s, a - 1))
    for k in range(s, a, 16):
        seg = m[k:min(k + 16, a)]
        out.append('  %04X  %-32s db %s' % (k, seg.hex(), ', '.join('$%02X' % x for x in seg)))

text = '\n'.join(out) + '\n'

# round trip: rebuild the ROM from the hex column
img = bytearray(0x8000)
seen = bytearray(0x8000)
for line in text.splitlines():
    mm = re.match(r'^  ([0-9A-F]{4})  ([0-9a-f]+)\s', line + ' ')
    if mm:
        ad = int(mm.group(1), 16) - 0x8000
        bs = bytes.fromhex(mm.group(2))
        img[ad:ad + len(bs)] = bs
        for i in range(len(bs)):
            seen[ad + i] += 1
if bytes(img) != rom:
    errors.append('round trip: rebuilt bytes differ from the ROM')
if any(x != 1 for x in seen):
    errors.append('round trip: %d bytes not listed exactly once' % sum(1 for x in seen if x != 1))

if errors:
    print('BUILD FAILED'); [print('  ' + e) for e in errors]; sys.exit(1)
open(out_path, 'w').write(text)
tot = sum(counts.values())
print('wrote %s' % out_path)
print('round trip md5 %s (ROM %s)' % (hashlib.md5(bytes(img)).hexdigest(), hashlib.md5(rom).hexdigest()))
print('bytes by type: ' + ', '.join('%s %d' % (k, v) for k, v in sorted(counts.items())) + ' (total %d)' % tot)
tags = [r['tag'] for r in names.values()] + [r['tag'] for r in ram.values()] + [r['tag'] for r in bits.values()]
print('names: ROM %d, RAM %d, flag bits %d, SFR %d; tags C %d / I %d / ? %d' % (
    len(names), len(ram), len(bits), len(sfr), tags.count('C'), tags.count('I'), tags.count('?')))
auto = sum(1 for a in labels if a not in names and a not in VEC)
print('automatic labels left: %d' % auto)
