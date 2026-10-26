"""Minimal TLCS-870 assembler for the listing format written by tools/build_listing.py.

usage: python3 tools/t870asm.py LISTING.asm OUT.bin

It reads only the instruction / data text of each line (never the hex column), computes every
address itself from `org`, resolves labels and `equ` names, and writes the 32 KB image 0x8000-0xFFFF.

The encoding table is generated from tools/t870.py: every opcode pattern is disassembled with marker
operand bytes, and the resulting text becomes a template. Assembly is therefore the exact inverse of
the disassembler. Where two encodings give the same text (for example `ld A,(x)` as 22 xx or E0 xx 58),
the listing marks the longer one with a `.l` suffix on the mnemonic.
"""
import os, re, sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import t870
from t870 import dis

MK = [0x5A, 0xA5, 0x3C]          # marker operand bytes (positions after the fixed opcode bytes)
START = 0x9000                   # address used while generating templates


def s8(v):
    return v - 0x100 if v & 0x80 else v


def gen_templates():
    t870.SYM.clear()
    cands = []
    for b0 in range(256):
        if 0xE0 <= b0 <= 0xE7:
            k = b0 & 7
            for bx in range(256):
                if k in (0, 4):
                    cands.append(([b0, None, bx], [1]))
                else:
                    cands.append(([b0, bx], []))
        elif 0xE8 <= b0 <= 0xEF:
            for bx in range(256):
                cands.append(([b0, bx], []))
        elif b0 in (0xF0, 0xF4):
            for bx in range(256):
                cands.append(([b0, None, bx], [1]))
        elif b0 in (0xF2, 0xF3, 0xF6, 0xF7):
            for bx in range(256):
                cands.append(([b0, bx], []))
        else:
            cands.append(([b0], []))
    table = {}
    for fixed, oppos in cands:
        mem = bytearray(0x10000)
        seq = []
        mi = 0
        for x in fixed:
            if x is None:
                seq.append(MK[mi]); mi += 1
            else:
                seq.append(x)
        nfix = len(seq)
        for j in range(3):
            seq.append(MK[mi + j] if mi + j < len(MK) else 0x77)
        mem[START:START + len(seq)] = bytes(seq)
        I = dis(mem, START)
        if I.t.startswith('??') or I.t.startswith('callv'):
            continue
        n = I.n
        # operand byte positions: the None positions in fixed, then everything after nfix up to n
        ops = [i for i, x in enumerate(fixed) if x is None] + list(range(nfix, n))
        text = I.t
        tmpl = text
        # relative jump targets
        if text.startswith('jr ') or text.startswith('jrs '):
            m = re.search(r'\$([0-9A-F]{4})$', text)
            tmpl = text[:m.start()] + '{REL}'
            kind = 'jrs' if text.startswith('jrs') else 'jr'
            key = tmpl
            enc = ('jrs', b0) if kind == 'jrs' else ('jr', bytes(seq[:n - 1]))
            if kind == 'jrs':
                key = tmpl.replace('jrs T,', 'jrs T,').replace('jrs F,', 'jrs F,')
                table.setdefault(key, ('jrs', 0x80 if 'T,' in text else 0xA0))
            else:
                table.setdefault(key, ('jr', bytes(seq[:n - 1])))
            continue
        vals = {}
        for p in ops:
            vals[p] = seq[p]
        # words (lo, hi) at consecutive operand positions
        for i, p in enumerate(ops):
            if i + 1 < len(ops) and ops[i + 1] == p + 1:
                w = seq[p] | (seq[p + 1] << 8)
                tmpl = tmpl.replace('$%04X' % w, '{W%d}' % p)
        for p in ops:
            tmpl = tmpl.replace('$%02X' % seq[p], '{B%d}' % p)
            tmpl = tmpl.replace('(HL%+d)' % s8(seq[p]), '(HL{D%d})' % p)
            if tmpl.startswith('ld RBS,'):
                tmpl = tmpl.replace('RBS,%d' % seq[p], 'RBS,{N%d}' % p)
        if '0x' in tmpl:
            continue
        enc = bytes(x if i not in ops else 0 for i, x in enumerate(seq[:n]))
        if tmpl in table and table[tmpl][0] == 'fix':
            old = table[tmpl][1]
            if len(enc) >= len(old):
                lt = tmpl.split(' ', 1)
                lt[0] = lt[0] + '.l'
                table.setdefault(' '.join(lt), ('fix', enc, ops))
                continue
        table[tmpl] = ('fix', enc, ops)
    # aliases the disassembler prints for one operand value only
    table['di'] = ('fix', bytes([0x48, 0x3A]), [])
    table['ei'] = ('fix', bytes([0x40, 0x3A]), [])
    return table


REGS = set('A W C B E D L H WA BC DE HL SP RBS PSW CF Z NZ CS CC LE GT T F PC'.split())


def assemble(text_lines):
    table = gen_templates()
    # templates as regex
    pats = []
    for tmpl, enc in table.items():
        rx = re.escape(tmpl)
        rx = re.sub(r'\\\{B(\d)\\\}', r'(?P<B\1>\\$[0-9A-F]{2})', rx)
        rx = re.sub(r'\\\{W(\d)\\\}', r'(?P<W\1>\\$[0-9A-F]{4})', rx)
        rx = re.sub(r'\\\{D(\d)\\\}', r'(?P<D\1>[+-]\\d+)', rx)
        rx = re.sub(r'\\\{N(\d)\\\}', r'(?P<N\1>\\d+)', rx)
        rx = rx.replace(r'\{REL\}', r'(?P<REL>\$[0-9A-F]{4})')
        pats.append((re.compile('^' + rx + '$'), tmpl, enc))
    # bucket by mnemonic for speed
    buckets = {}
    for p in pats:
        buckets.setdefault(p[1].split(' ')[0], []).append(p)

    syms = {}
    items = []     # (kind, payload, srcline)
    for ln, raw in enumerate(text_lines, 1):
        line = raw.split(';', 1)[0].rstrip()
        if not line.strip():
            continue
        m = re.match(r'^([A-Za-z_][A-Za-z0-9_]*)\s+equ\s+\$([0-9A-F]+)$', line.strip())
        if m:
            syms[m.group(1)] = int(m.group(2), 16); continue
        m = re.match(r'^([A-Za-z_][A-Za-z0-9_/]*):$', line.strip())
        if m:
            items.append(('label', m.group(1), ln)); continue
        m = re.match(r'^\s*org\s+\$([0-9A-F]+)$', line)
        if m:
            items.append(('org', int(m.group(1), 16), ln)); continue
        # listing line: '  ADDR  HEX  text'  -> keep text only
        m = re.match(r'^  [0-9A-F]{4}  [0-9a-f]+\s+(.*)$', line)
        if not m:
            raise SystemExit('line %d: cannot parse: %r' % (ln, raw))
        items.append(('ins', m.group(1).strip(), ln))

    def resolve(tok_text, pc, lax=False):
        if tok_text.startswith('db '):
            return tok_text
        # replace identifiers by $hex: (Name) with value < 0x100 -> ($XX); others -> $XXXX
        def rep_paren(m):
            n = m.group(1)
            if n in REGS:
                return m.group(0)
            v = syms[n] if (n in syms or not lax) else pc
            return '($%02X)' % v if v < 0x100 else '($%04X)' % v

        t = re.sub(r'\(([A-Za-z_][A-Za-z0-9_/]*)\)', rep_paren, tok_text)

        def rep_id(m):
            n = m.group(0)
            if n in REGS:
                return n
            return '$%04X' % (syms[n] if (n in syms or not lax) else pc)
        head, _, rest = t.partition(' ')
        rest = re.sub(r'(?<![$\w])[A-Za-z_][A-Za-z0-9_/]*', rep_id, rest)
        return (head + ' ' + rest).strip()

    def encode(text, pc):
        if text.startswith('db '):
            body = text[3:]
            out = bytearray()
            for part in body.split(','):
                part = part.strip()
                m = re.match(r'^\$([0-9A-F]{2})(?: x(\d+))?$', part)
                if not m:
                    raise ValueError('bad db: ' + part)
                out += bytes([int(m.group(1), 16)]) * int(m.group(2) or 1)
            return bytes(out)
        if text.startswith('dw '):
            out = bytearray()
            for part in text[3:].split(','):
                v = int(part.strip()[1:], 16)
                out += bytes([v & 0xFF, v >> 8])
            return bytes(out)
        mnem = text.split(' ')[0]
        for rx, tmpl, enc in buckets.get(mnem, []):
            m = rx.match(text)
            if not m:
                continue
            if enc[0] == 'jrs':
                tg = int(m.group('REL')[1:], 16); d = tg - (pc + 2)
                if not -16 <= d <= 15:
                    raise ValueError('jrs out of range')
                return bytes([enc[1] | (d & 0x1F)])
            if enc[0] == 'jr':
                tg = int(m.group('REL')[1:], 16); d = tg - (pc + 2)
                if not -128 <= d <= 127:
                    raise ValueError('jr out of range')
                return enc[1] + bytes([d & 0xFF])
            _, b, ops = enc
            b = bytearray(b)
            for k, v in m.groupdict().items():
                if v is None:
                    continue
                p = int(k[1:])
                if k[0] == 'B':
                    b[p] = int(v[1:], 16)
                elif k[0] == 'W':
                    w = int(v[1:], 16); b[p] = w & 0xFF; b[p + 1] = w >> 8
                elif k[0] in 'DN':
                    b[p] = int(v) & 0xFF
            return bytes(b)
        raise ValueError('no encoding for: ' + text)

    def size_of(text):
        # sizes do not depend on operand values except data
        if text.startswith('db ') or text.startswith('dw '):
            return None
        return None

    # pass 1: label addresses (assemble with dummy resolution to get sizes)
    for passno in (1, 2):
        pc = 0
        image = {}
        for kind, payload, ln in items:
            if kind == 'org':
                pc = payload
            elif kind == 'label':
                if passno == 1:
                    syms[payload] = pc
            else:
                try:
                    txt = resolve(payload, pc, lax=(passno == 1))
                except KeyError as e:
                    raise SystemExit('line %d: unknown name %s' % (ln, e))
                try:
                    bs = encode(txt, pc)
                except ValueError as e:
                    raise SystemExit('line %d: %s  [%s]' % (ln, e, payload))
                for i, x in enumerate(bs):
                    image[pc + i] = x
                pc += len(bs)
    return image


def encode_guess(payload, txt, pc, encode):
    # pass 1 fallback for relative jumps to labels not yet known: assume target = pc
    t = re.sub(r'\$[0-9A-F]{4}$', '$%04X' % pc, txt)
    return encode(t, pc)


if __name__ == '__main__':
    src = open(sys.argv[1]).read().splitlines()
    img = assemble(src)
    out = bytearray([0xFF]) * 0x8000
    for a, v in img.items():
        if 0x8000 <= a <= 0xFFFF:
            out[a - 0x8000] = v
    open(sys.argv[2], 'wb').write(out)
    import hashlib
    print('assembled %d bytes, md5 %s' % (len(img), hashlib.md5(out).hexdigest()))
