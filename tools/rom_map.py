"""ROM layout map drawn as Game Boy 2bpp tiles.

usage: python3 tools/rom_map.py [OUT.png]     (default: rom_layout_map.png)

Every 16 bytes of the 32 KB ROM are drawn as one 8 x 8 Game Boy tile
(2 bytes per pixel row, low bit plane first), 32 tiles per row, so one row of
tiles is 0x200 bytes. Each pixel row is tinted by what its two bytes are,
taken from the listing (instructions, jump tables) and symbols/rom_types.csv
(byte tables, word tables, fill): the four Game Boy shades are kept, only the
hue changes. Tiles are counted from 0x8000, so data that does not start on a
16-byte boundary (the self-test band at 0xDDEE) is drawn shifted by its
offset. The right column names the source modules and the tables that start
in each row.
"""
import csv, os, re, sys
from PIL import Image, ImageDraw, ImageFont

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
ROM = os.path.join(ROOT, 'TMP87C840_Toshiba_printer_ROM.bin')
LISTING = os.path.join(ROOT, 'TMP87C840_printer_rom.asm')
OUT = sys.argv[1] if len(sys.argv) > 1 else os.path.join(ROOT, 'rom_layout_map.png')
BASE, SIZE = 0x8000, 0x8000
TILES_PER_ROW, SCALE = 32, 2
GFX = (0xDDEE, 0xE06D)       # Gfx_SelfTestBand
VECTORS = (0xFFE0, 0xFFFF)

rom = open(ROM, 'rb').read()
assert len(rom) == SIZE

# ---------------------------------------------------------------- byte kinds
kind = [None] * SIZE
for line in open(LISTING, encoding='utf-8'):
    m = re.match(r'^  ([0-9A-F]{4})  ([0-9a-f]+)\s+(\S+)', line)
    if not m:
        continue
    a, n = int(m.group(1), 16) - BASE, len(m.group(2)) // 2
    k = 'jumptable' if m.group(3) == 'dw' else 'table' if m.group(3) == 'db' else 'code'
    for i in range(a, a + n):
        kind[i] = k
for r in csv.DictReader(open(os.path.join(ROOT, 'symbols', 'rom_types.csv'), encoding='utf-8')):
    k = {'bytes': 'bytes', 'words': 'words', 'fill': 'fill'}[r['type']]
    for i in range(int(r['start'], 16) - BASE, int(r['end'], 16) - BASE + 1):
        kind[i] = k
for (s, e), k in ((GFX, 'gfx'), (VECTORS, 'vectors')):
    for i in range(s - BASE, e - BASE + 1):
        kind[i] = k
assert None not in kind and 'table' not in kind, 'listing and rom_types.csv do not cover the ROM'

CATS = [  # key, legend, colour
    ('code', 'code', (52, 101, 164)),
    ('jumptable', 'jump tables (jp (PC+A))', (117, 80, 123)),
    ('bytes', 'byte tables', (78, 154, 6)),
    ('words', 'word tables', (6, 152, 154)),
    ('gfx', 'graphics: self-test band', (206, 92, 0)),
    ('vectors', 'interrupt vectors', (204, 0, 0)),
    ('fill', 'unused (0xFF fill)', (110, 110, 110)),
]
COL = {k: c for k, _, c in CATS}
count = {k: kind.count(k) for k, _, _ in CATS}


def mix(c, d, t):
    return tuple(round(x + (y - x) * t) for x, y in zip(c, d))


# Game Boy shade 0 (lightest) .. 3 (darkest), tinted per kind
SHADES = {k: [mix(c, (255, 255, 255), 0.88), mix(c, (255, 255, 255), 0.45), c, mix(c, (0, 0, 0), 0.55)]
          for k, c in COL.items()}

# ---------------------------------------------------------------- tile sheet
rows = SIZE // 16 // TILES_PER_ROW
sheet = Image.new('RGB', (TILES_PER_ROW * 8, rows * 8))
px = sheet.load()
for t in range(SIZE // 16):
    tx, ty = (t % TILES_PER_ROW) * 8, (t // TILES_PER_ROW) * 8
    for y in range(8):
        a = t * 16 + y * 2
        lo, hi, k = rom[a], rom[a + 1], kind[a]
        for x in range(8):
            b = 7 - x
            px[tx + x, ty + y] = SHADES[k][((hi >> b) & 1) << 1 | ((lo >> b) & 1)]
sheet = sheet.resize((sheet.width * SCALE, sheet.height * SCALE), Image.NEAREST)

# ---------------------------------------------------------------- notes per row
notes = [[] for _ in range(rows)]
for line in open(os.path.join(ROOT, 'src', 'main.asm'), encoding='utf-8'):
    m = re.match(r'^include "(\w+)\.asm"\s+;\s*([0-9A-F]{4})', line)
    if m:
        notes[(int(m.group(2), 16) - BASE) // (TILES_PER_ROW * 16)].append(('mod', m.group(1) + '.asm'))
for r in csv.DictReader(open(os.path.join(ROOT, 'symbols', 'rom_names.csv'), encoding='utf-8')):
    a = int(r['addr'], 16)
    if kind[a - BASE] in ('bytes', 'words', 'gfx') and (a == BASE or kind[a - BASE - 1] != kind[a - BASE] or r['name'].startswith(('Tab_', 'Gfx_'))):
        notes[(a - BASE) // (TILES_PER_ROW * 16)].append(('tab', r['name']))
notes[(VECTORS[0] - BASE) // (TILES_PER_ROW * 16)].append(('tab', 'vectors (FFE0-FFFF)'))

# ---------------------------------------------------------------- page
FONT = '/usr/share/fonts/truetype/dejavu/DejaVuSansMono.ttf'
BOLD = '/usr/share/fonts/truetype/dejavu/DejaVuSansMono-Bold.ttf'
try:
    f_s, f_b, f_t = ImageFont.truetype(FONT, 11), ImageFont.truetype(BOLD, 11), ImageFont.truetype(BOLD, 16)
except OSError:
    f_s = f_b = f_t = ImageFont.load_default()
PAD, RULER, NOTEW = 16, 52, 520
ROWH = 8 * SCALE
legend_h = 22 * ((len(CATS) + 1) // 2) + 8
top = PAD + 26 + legend_h + 10
W = PAD + RULER + sheet.width + 12 + NOTEW + PAD
H = top + sheet.height + PAD + 18
page = Image.new('RGB', (W, H), (250, 250, 248))
d = ImageDraw.Draw(page)
ink, faint = (34, 34, 34), (120, 120, 120)
d.text((PAD, PAD), 'Game Boy Printer ROM 0x8000-0xFFFF as Game Boy 2bpp tiles (16 bytes per tile, 0x200 bytes per row)',
       font=f_t, fill=ink)
for i, (k, label, c) in enumerate(CATS):
    x, y = PAD + (i % 2) * 380, PAD + 30 + (i // 2) * 22
    for j, s in enumerate(SHADES[k]):
        d.rectangle([x + j * 9, y, x + j * 9 + 8, y + 14], fill=s)
    d.text((x + 44, y), '%-26s %6s B' % (label, format(count[k], ',')), font=f_s, fill=ink)
mx, my = PAD + RULER, top
page.paste(sheet, (mx, my))
for r in range(rows):
    y = my + r * ROWH
    d.text((PAD, y + 2), '%04X' % (BASE + r * TILES_PER_ROW * 16), font=f_s, fill=faint)
    x = mx + sheet.width + 12
    for typ, text in notes[r]:
        f, col = (f_b, ink) if typ == 'mod' else (f_s, (60, 60, 60))
        w = d.textlength(text + '  ', font=f)
        if x + w > W - PAD:
            break
        d.text((x, y + 2), text, font=f, fill=col)
        x += w
for c in range(0, TILES_PER_ROW + 1, 8):     # column ruler every 8 tiles (0x80 bytes)
    d.line([mx + c * 8 * SCALE, my - 4, mx + c * 8 * SCALE, my - 1], fill=faint)
d.text((PAD, H - PAD - 12), 'Bold: source module start (src/). Generated by tools/rom_map.py from the listing and symbols/.',
       font=f_s, fill=faint)
page.save(OUT, optimize=True)
print('%s: %d x %d px; %s' % (os.path.relpath(OUT, ROOT) if OUT.startswith(ROOT) else OUT, W, H,
                              ', '.join('%s %d' % (k, count[k]) for k, _, _ in CATS)))
