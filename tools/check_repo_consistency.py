"""Consistency check of the repository: every number the docs quote against the file it comes from,
generated files against a fresh run, links, symbol files, builds.

usage: python3 tools/check_repo_consistency.py [--slow]
  --slow also re-runs the emulator checks (claims.py, strobe_check.py, relocation_test.py; ~15 min)
Prints one line per check (ok / FAIL) and exits with the number of failures.
"""
import csv, hashlib, io, os, re, subprocess, sys, contextlib

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, HERE)
ROM_MD5 = 'aa393ec87ccb4220200255ab5adf8ac9'
SLOW = '--slow' in sys.argv
fails = []


def res(name, ok, detail=''):
    print('%-5s %-14s %s' % ('ok' if ok else 'FAIL', name, detail))
    if not ok:
        fails.append(name)


def rd(p):
    return open(os.path.join(ROOT, p), encoding='utf-8').read()


def run(args, cwd=ROOT):
    return subprocess.run([sys.executable] + args, cwd=cwd, capture_output=True, text=True)


# ---------------------------------------------------------------- ROM
rom = open(os.path.join(ROOT, 'TMP87C840_Toshiba_printer_ROM.bin'), 'rb').read()
res('rom', hashlib.md5(rom).hexdigest() == ROM_MD5 and len(rom) == 0x8000, 'md5 %s, %d bytes' % (hashlib.md5(rom).hexdigest(), len(rom)))
for f in ('README.md', 'Printer_protocol.md', 'src/README.md', 'symbols/README.md', 'Makefile', 'tools/build_listing.py', 'src/main.asm'):
    if f.endswith('.md') or f in ('Makefile',):
        txt = rd(f)
        bad = [x for x in re.findall(r'\b[0-9a-f]{32}\b', txt) if x != ROM_MD5]
        res('md5-quoted', not bad, '%s: %s' % (f, 'all md5 quotes are the ROM md5' if not bad else bad))

# ---------------------------------------------------------------- symbol files
def rows(n):
    return list(csv.DictReader(open(os.path.join(ROOT, 'symbols', n))))


names, ram, bits, sfr, types = rows('rom_names.csv'), rows('ram.csv'), rows('ram_bits.csv'), rows('sfr.csv'), rows('rom_types.csv')
tags = [r['tag'] for r in names + ram + bits]
res('tags', set(tags) <= {'C', 'I', '?'}, 'tags used: %s' % sorted(set(tags)))
nC, nI, nQ = tags.count('C'), tags.count('I'), tags.count('?')
allnames = [r['name'] for r in names + ram + sfr]
res('names-unique', len(allnames) == len(set(allnames)), '%d names' % len(allnames))
res('names-ident', all(re.match(r'^[A-Za-z_][A-Za-z0-9_]*$', n) for n in allnames), 'identifier syntax')

# ---------------------------------------------------------------- listing is fresh (build also reassembles it)
lst_path = os.path.join(ROOT, 'TMP87C840_printer_rom.asm')
committed = open(lst_path).read()
out = run(['tools/build_listing.py', os.path.join(ROOT, 'TMP87C840_Toshiba_printer_ROM.bin'), '/tmp/_fresh_listing.asm'])
fresh = open('/tmp/_fresh_listing.asm').read() if out.returncode == 0 else ''
res('listing-build', out.returncode == 0 and 'reassembled from the instruction text: md5 ' + ROM_MD5 in out.stdout, out.stdout.strip().splitlines()[-1] if out.stdout else out.stderr[-200:])
res('listing-fresh', fresh == committed, 'committed listing equals a fresh build' if fresh == committed else 'listing is stale: run make listing')
stats = out.stdout
m = re.search(r'bytes by type: (.*) \(total', stats)
bt = dict((k, int(v)) for k, v in re.findall(r'(\w+) (\d+)', m.group(1))) if m else {}
m = re.search(r'automatic labels left: (\d+)', stats)
auto = int(m.group(1)) if m else -1

# ---------------------------------------------------------------- src builds, is fresh
out = run(['tools/t870asm.py', 'src/main.asm', '/tmp/_src.bin'])
srcmd5 = hashlib.md5(open('/tmp/_src.bin', 'rb').read()).hexdigest() if out.returncode == 0 else '-'
res('src-build', srcmd5 == ROM_MD5, 'src/main.asm -> md5 %s' % srcmd5)
import tempfile, shutil, filecmp
tmp = tempfile.mkdtemp()
shutil.copytree(ROOT, os.path.join(tmp, 'r'), ignore=shutil.ignore_patterns('.git', 'build', '__pycache__', 'emulator', 'hardware'))
o2 = run(['tools/make_source.py'], cwd=os.path.join(tmp, 'r'))
same = True; diffs = []
for dp, dn, fn in os.walk(os.path.join(ROOT, 'src')):
    for f in fn:
        if f == 'README.md':
            continue
        a = os.path.join(dp, f); b = a.replace(os.path.join(ROOT, 'src'), os.path.join(tmp, 'r', 'src'))
        if not os.path.exists(b) or not filecmp.cmp(a, b, shallow=False):
            same = False; diffs.append(os.path.relpath(a, ROOT))
res('src-fresh', same, 'src/ equals tools/make_source.py output' if same else 'differs (hand edits or stale): %s' % diffs[:5])
modules = re.findall(r'^include "(\w+\.asm)"', rd('src/main.asm'), re.M)
datafiles = sorted(os.listdir(os.path.join(ROOT, 'src', 'data')))
shutil.rmtree(tmp)

# ---------------------------------------------------------------- numbers quoted in the docs
readme = rd('README.md')
proto = rd('Printer_protocol.md')
symre = rd('symbols/README.md')


def need(name, text, pattern, expected):
    mm = re.search(pattern, text)
    got = mm.groups() if mm else None
    res(name, got == tuple(str(x) for x in expected), 'pattern %r: doc %s, actual %s' % (pattern[:50], got, expected))


fmt = lambda n: '{:,}'.format(n)
need('L1-bytes', readme, r'code ([\d,]+) B, jump tables ([\d,]+) B, tables ([\d,]+) B \(([\d,]+) B byte tables \+ ([\d,]+) B word tables\), fill ([\d,]+) B',
     (fmt(bt.get('code', 0)), fmt(bt.get('jumptable', 0)), fmt(bt.get('bytes', 0) + bt.get('words', 0)), fmt(bt.get('bytes', 0)), fmt(bt.get('words', 0)), fmt(bt.get('fill', 0))))
need('L3-names', readme, r'(\d+) ROM names, (\d+) RAM variables, (\d+) flag bits, (\d+) registers: (\d+) tagged C, (\d+) I, (\d+) \?; (\d+) short branch',
     (len(names), len(ram), len(bits), len(sfr), nC, nI, nQ, auto))
need('L6-inferred', readme, r'(\d+) inferred names left', (nI + nQ,))
need('L5-tree', readme, r'\(([\d]+) modules, (\d+) include files, (\d+) binary tables\)', (len(modules), 2, len(datafiles)))
need('doubt-list', symre, r'## Names not yet tagged C \((\d+)\)', (nI + nQ,))
rows_listed = len(re.findall(r'^\| (ROM|RAM|bit) \|', symre, re.M))
res('doubt-rows', rows_listed == nI + nQ, '%d rows listed, %d names not tagged C' % (rows_listed, nI + nQ))
co = rd('emulator/claims_output.txt')
mm = re.search(r'(\d+) checks, (\d+) match, (\d+) differ', co)
need('claims-count', readme, r'\((\d+) checks, all matching\)', (mm.group(1) if mm else '?',))
need('emu-readme', rd('emulator/README.md'), r'runs (\d+) protocol checks', (mm.group(1) if mm else '?',))
res('claims-output', bool(mm) and mm.group(2) == mm.group(1) and mm.group(3) == '0', mm.group(0) if mm else 'no summary line')
need('proto-checks', proto, r'all (\d+) checks give the result shown', (mm.group(1) if mm else '?',))
so = rd('emulator/strobe_output.txt')
need('strobe-black', so, r'temp ADC 40 black .*?50% ([\d.]+)', ('1.55',))
need('strobe-dark', so, r'temp ADC 40 dark .*?50% ([\d.]+)', ('1.20',))
need('proto-strobe', proto, r'\| Black \| ([\d.]+) ms \| 1\.56 ms \|', ('1.55',))

njt = committed.count('jp (PC+A)')
need('jumptables', proto, r'the (\d+) `jp \(PC\+A\)` jump tables', (njt,))
used = 0x8000 - bt.get('fill', 0)
need('used-rom', proto, r'of the ([\d.]+) KB used ROM', ('%.1f' % (used / 1000),))
need('code-kb', proto, r'About (\d+) KB of the', (round(bt.get('code', 0) / 1000),))

# ---------------------------------------------------------------- links in markdown files
for md in ('README.md', 'Printer_protocol.md', 'src/README.md', 'symbols/README.md', 'emulator/README.md'):
    txt = rd(md)
    base = os.path.dirname(os.path.join(ROOT, md))
    links = [l for l in re.findall(r'\]\(([^)#]+)\)', txt) if not re.match(r'https?:', l)]
    missing = [l for l in links if not os.path.exists(os.path.join(base, l))]
    res('links', not missing, '%s: %d local links%s' % (md, len(links), (', missing %s' % missing) if missing else ''))
    files = set(re.findall(r'`((?:tools|emulator|symbols|src|hardware)/[\w./-]+\.\w+)`', txt))
    miss2 = [f for f in files if not os.path.exists(os.path.join(ROOT, f)) and not os.path.exists(os.path.join(base, f))]
    res('file-refs', not miss2, '%s: %d file names quoted%s' % (md, len(files), (', missing %s' % miss2) if miss2 else ''))

# ---------------------------------------------------------------- hardware facts quoted vs symbol files
need('pins-P0', rd('symbols/sfr.csv'), r'00,P0,port 0 \(QFP pins (3-10)\)', ('3-10',))
need('adc-range', proto, r'outside (0x35–0xD7) → "other error"', ('0x35–0xD7',))

# ---------------------------------------------------------------- statements known to be wrong must not come back
STALE = ['10 per pixel row', '10 bursts per row', 'regenerates the listing exactly', '30-entry', 'V_FFxx',
         'probably paper', 'Print | 0x0C', 'stops printing within', 'not done: the build only reads', 'Tab_PlaneCombine',
         'reports 0x80 at power-on']
for md in ('README.md', 'Printer_protocol.md', 'src/README.md', 'symbols/README.md', 'emulator/README.md'):
    hits = [x for x in STALE if x in rd(md)]
    res('stale', not hits, '%s: %s' % (md, hits if hits else 'no known-wrong statement'))
tools_files = sorted(f for f in os.listdir(HERE) if f.endswith('.py'))
unlisted = [f for f in tools_files if 'tools/' + f not in readme and f not in ('t870.py',)]
res('tools-listed', not unlisted, 'README lists %d of %d tool scripts%s' % (len(tools_files) - len(unlisted), len(tools_files), (', missing %s' % unlisted) if unlisted else ''))

# ---------------------------------------------------------------- tools run
o = run(['tools/check_md5.py', os.path.join(ROOT, 'TMP87C840_Toshiba_printer_ROM.bin'), ROM_MD5])
res('check_md5', o.returncode == 0, o.stdout.strip())
o = run(['tools/trace.py', os.path.join(ROOT, 'TMP87C840_Toshiba_printer_ROM.bin'), '/tmp/_plain.asm'])
res('trace.py', o.returncode == 0, 'plain tracer runs (%s)' % (o.stderr.strip().splitlines()[0] if o.stderr else ''))

if SLOW:
    for script, ok_text in (('claims.py', '0 differ'), ('strobe_check.py', 'temp ADC 80 light'), ('relocation_test.py', 'same behaviour')):
        o = run([script], cwd=os.path.join(ROOT, 'emulator'))
        res('emu-' + script, ok_text in o.stdout, o.stdout.strip().splitlines()[-1] if o.stdout else o.stderr[-200:])

print()
print('%d failed' % len(fails) + ('' if SLOW else ' (emulator checks not re-run; use --slow)'))
sys.exit(len(fails))
