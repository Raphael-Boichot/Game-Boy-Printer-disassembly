"""Minimal TLCS-870 disassembler (written from the MAME tlcs870d opcode map) with recursive tracing."""
import sys, struct

R8 = ["A", "W", "C", "B", "E", "D", "L", "H"]
R16 = ["WA", "BC", "DE", "HL"]
CC = ["Z", "NZ", "CS", "CC", "LE", "GT", "T", "F"]
ALU = ["addc", "add", "subb", "sub", "and", "xor", "or", "cmp"]

# names for SFRs / known RAM (filled in as analysis progresses)
SYM = {}


def nm(x):
    return SYM.get(x, "$%02X" % x)


def s8(v):
    return v - 0x100 if v & 0x80 else v


class Ins:
    def __init__(s, a):
        s.a = a; s.n = 0; s.t = "??"; s.tg = []; s.end = False; s.call = []; s.cond = False


def dis(m, a):
    """returns Ins. m: bytes-like 64K"""
    I = Ins(a)
    p = [a]

    def r8():
        v = m[p[0] & 0xFFFF]; p[0] += 1; return v

    def r16():
        lo = r8(); return lo | (r8() << 8)

    b = r8()
    t = "??"
    if b == 0x00: t = "nop"
    elif b == 0x01: t = "swap A"
    elif b == 0x02: t = "mul W,A"
    elif b == 0x03: t = "div WA,C"
    elif b == 0x04: t = "reti"; I.end = True
    elif b == 0x05: t = "ret"; I.end = True
    elif b == 0x06: t = "pop PSW"
    elif b == 0x07: t = "push PSW"
    elif b == 0x0A: t = "daa A"
    elif b == 0x0B: t = "das A"
    elif b == 0x0C: t = "clr CF"
    elif b == 0x0D: t = "set CF"
    elif b == 0x0E: t = "cpl CF"
    elif b == 0x0F: t = "ld RBS,%d" % r8()
    elif 0x10 <= b <= 0x13: t = "inc " + R16[b & 3]
    elif 0x14 <= b <= 0x17: t = "ld %s,$%04X" % (R16[b & 3], r16())
    elif 0x18 <= b <= 0x1B: t = "dec " + R16[b & 3]
    elif b == 0x1C: t = "shlc A"
    elif b == 0x1D: t = "shrc A"
    elif b == 0x1E: t = "rolc A"
    elif b == 0x1F: t = "rorc A"
    elif b == 0x20: t = "inc (%s)" % nm(r8())
    elif b == 0x21: t = "inc (HL)"
    elif b == 0x22: t = "ld A,(%s)" % nm(r8())
    elif b == 0x23: t = "ld A,(HL)"
    elif b == 0x24: x = r8(); t = "ldw (%s),$%04X" % (nm(x), r16())
    elif b == 0x25: t = "ldw (HL),$%04X" % r16()
    elif b == 0x26: y = r8(); x = r8(); t = "ld (%s),(%s)" % (nm(x), nm(y))
    elif b == 0x28: t = "dec (%s)" % nm(r8())
    elif b == 0x29: t = "dec (HL)"
    elif b == 0x2A: t = "ld (%s),A" % nm(r8())
    elif b == 0x2B: t = "ld (HL),A"
    elif b == 0x2C: x = r8(); t = "ld (%s),$%02X" % (nm(x), r8())
    elif b == 0x2D: t = "ld (HL),$%02X" % r8()
    elif b == 0x2E: t = "clr (%s)" % nm(r8())
    elif b == 0x2F: t = "clr (HL)"
    elif 0x30 <= b <= 0x37: t = "ld %s,$%02X" % (R8[b & 7], r8())
    elif 0x40 <= b <= 0x47:
        x = r8(); t = "set (%s).%d" % (nm(x), b & 7)
        if x == 0x3A and b == 0x40: t = "ei"
    elif 0x48 <= b <= 0x4F:
        x = r8(); t = "clr (%s).%d" % (nm(x), b & 7)
        if x == 0x3A and b == 0x48: t = "di"
    elif 0x50 <= b <= 0x57: t = "ld A," + R8[b & 7]
    elif 0x58 <= b <= 0x5F: t = "ld %s,A" % R8[b & 7]
    elif 0x60 <= b <= 0x67: t = "inc " + R8[b & 7]
    elif 0x68 <= b <= 0x6F: t = "dec " + R8[b & 7]
    elif 0x70 <= b <= 0x77: t = "%s A,$%02X" % (ALU[b & 7], r8())
    elif 0x78 <= b <= 0x7F: t = "%s A,(%s)" % (ALU[b & 7], nm(r8()))
    elif 0x80 <= b <= 0x9F:
        d = b & 0x1F; d = d - 0x20 if d & 0x10 else d
        tg = (a + 2 + d) & 0xFFFF; t = "jrs T,$%04X" % tg; I.tg = [tg]; I.cond = True
    elif 0xA0 <= b <= 0xBF:
        d = b & 0x1F; d = d - 0x20 if d & 0x10 else d
        tg = (a + 2 + d) & 0xFFFF; t = "jrs F,$%04X" % tg; I.tg = [tg]; I.cond = True
    elif 0xC0 <= b <= 0xCF:
        v = 0xFFC0 + (b & 0xF) * 2; tg = m[v] | (m[v + 1] << 8)
        t = "callv %d ; ->$%04X" % (b & 0xF, tg); I.call = [tg]
    elif 0xD0 <= b <= 0xD7:
        tg = (a + 2 + s8(r8())) & 0xFFFF; t = "jr %s,$%04X" % (CC[b & 7], tg); I.tg = [tg]
        I.cond = True  # T/F test the JF flag, not always/never
    elif 0xD8 <= b <= 0xDF: t = "test (%s).%d" % (nm(r8()), b & 7)
    elif 0xE0 <= b <= 0xE7:
        k = b & 7
        v = r8() if k in (0, 4) else 0
        src = ["(%s)" % nm(v), "(PC+A)", "(DE)", "(HL)", "(HL%+d)" % s8(v), "(HL+C)", "(HL+)", "(-HL)"][k]
        bx = r8()
        if bx == 0x08: t = "rold A," + src
        elif bx == 0x09: t = "rord A," + src
        elif 0x14 <= bx <= 0x17: t = "ld %s,%s" % (R16[bx & 3], src)
        elif bx == 0x20: t = "inc " + src
        elif bx == 0x26: t = "ld (%s),%s" % (nm(r8()), src)
        elif bx == 0x27: t = "ld (HL),%s" % src
        elif bx == 0x28: t = "dec " + src
        elif bx == 0x2F: t = "mcmp %s,$%02X" % (src, r8())
        elif 0x40 <= bx <= 0x47: t = "set %s.%d" % (src, bx & 7)
        elif 0x48 <= bx <= 0x4F: t = "clr %s.%d" % (src, bx & 7)
        elif 0x58 <= bx <= 0x5F: t = "ld %s,%s" % (R8[bx & 7], src)
        elif 0x60 <= bx <= 0x67: t = "%s %s,(HL)" % (ALU[bx & 7], src)
        elif 0x70 <= bx <= 0x77: t = "%s %s,$%02X" % (ALU[bx & 7], src, r8())
        elif 0x78 <= bx <= 0x7F: t = "%s A,%s" % (ALU[bx & 7], src)
        elif 0xA8 <= bx <= 0xAF: t = "xch %s,%s" % (R8[bx & 7], src)
        elif 0xC0 <= bx <= 0xC7: t = "cpl %s.%d" % (src, bx & 7)
        elif 0xC8 <= bx <= 0xCF: t = "ld %s.%d,CF" % (src, bx & 7)
        elif 0xD0 <= bx <= 0xD7: t = "xor CF,%s.%d" % (src, bx & 7)
        elif 0xD8 <= bx <= 0xDF: t = "test %s.%d" % (src, bx & 7)
        elif 0xF8 <= bx <= 0xFC: t = "call " + src
        elif bx == 0xFE:
            t = "jp " + src; I.end = True
            if k == 0:
                tg = m[v] | (m[v + 1] << 8)
        else: t = "?? src %02X" % bx
    elif 0xE8 <= b <= 0xEF:
        g = b & 7; bx = r8(); gg = R16[b & 3]; G = R8[g]
        if bx == 0x01: t = "swap " + G
        elif bx == 0x02: t = "mul " + gg
        elif bx == 0x03: t = "div %s,C" % gg
        elif bx == 0x04 and b == 0xE8: t = "retn"; I.end = True
        elif bx == 0x06: t = "pop " + gg
        elif bx == 0x07: t = "push " + gg
        elif bx == 0x0A: t = "daa " + G
        elif bx == 0x0B: t = "das " + G
        elif 0x10 <= bx <= 0x13: t = "xch %s,%s" % (R16[bx & 3], gg)
        elif 0x14 <= bx <= 0x17: t = "ld %s,%s" % (R16[bx & 3], gg)
        elif bx == 0x1C: t = "shlc " + G
        elif bx == 0x1D: t = "shrc " + G
        elif bx == 0x1E: t = "rolc " + G
        elif bx == 0x1F: t = "rorc " + G
        elif 0x30 <= bx <= 0x37: t = "%s WA,%s" % (ALU[bx & 7], gg)
        elif 0x38 <= bx <= 0x3F: t = "%s %s,$%04X" % (ALU[bx & 7], gg, r16())
        elif 0x40 <= bx <= 0x47: t = "set %s.%d" % (G, bx & 7)
        elif 0x48 <= bx <= 0x4F: t = "clr %s.%d" % (G, bx & 7)
        elif 0x58 <= bx <= 0x5F: t = "ld %s,%s" % (R8[bx & 7], G)
        elif 0x60 <= bx <= 0x67: t = "%s A,%s" % (ALU[bx & 7], G)
        elif 0x68 <= bx <= 0x6F: t = "%s %s,A" % (ALU[bx & 7], G)
        elif 0x70 <= bx <= 0x77: t = "%s %s,$%02X" % (ALU[bx & 7], G, r8())
        elif bx in (0x82, 0x83): t = "set %s.%s" % (["(DE)", "(HL)"][bx & 1], R8[g])
        elif bx in (0x8A, 0x8B): t = "clr %s.%s" % (["(DE)", "(HL)"][bx & 1], R8[g])
        elif bx in (0x92, 0x93): t = "cpl %s.%s" % (["(DE)", "(HL)"][bx & 1], R8[g])
        elif bx in (0x9A, 0x9B): t = "ld %s.%s,CF" % (["(DE)", "(HL)"][bx & 1], R8[g])
        elif bx in (0x9E, 0x9F): t = "test %s.%s" % (["(DE)", "(HL)"][bx & 1], R8[g])
        elif 0xA8 <= bx <= 0xAF: t = "xch %s,%s" % (R8[bx & 7], G)
        elif 0xC0 <= bx <= 0xC7: t = "cpl %s.%d" % (G, bx & 7)
        elif 0xC8 <= bx <= 0xCF: t = "ld %s.%d,CF" % (G, bx & 7)
        elif 0xD0 <= bx <= 0xD7: t = "xor CF,%s.%d" % (G, bx & 7)
        elif 0xD8 <= bx <= 0xDF: t = "test %s.%d" % (G, bx & 7)
        elif bx == 0xFA: t = "ld SP," + gg
        elif bx == 0xFB: t = "ld %s,SP" % gg
        elif bx == 0xFC: t = "call " + gg
        elif bx == 0xFE: t = "jp " + gg; I.end = True
        else: t = "?? reg %02X %02X" % (b, bx)
    elif b in (0xF0, 0xF2, 0xF3, 0xF4, 0xF6, 0xF7):
        k = b & 7
        v = r8() if k in (0, 4) else 0
        dst = ["(%s)" % nm(v), "?", "(DE)", "(HL)", "(HL%+d)" % s8(v), "?", "(HL+)", "(-HL)"][k]
        bx = r8()
        if 0x10 <= bx <= 0x13: t = "ld %s,%s" % (dst, R16[bx & 3])
        elif bx == 0x2C: t = "ld %s,$%02X" % (dst, r8())
        elif 0x50 <= bx <= 0x57: t = "ld %s,%s" % (dst, R8[bx & 7])
        else: t = "?? dst %02X" % bx
    elif b == 0xFA: t = "ld SP,$%04X" % r16()
    elif b == 0xFB:
        tg = (a + 2 + s8(r8())) & 0xFFFF; t = "jr $%04X" % tg; I.tg = [tg]; I.end = True
    elif b == 0xFC:
        tg = r16(); t = "call $%04X" % tg; I.call = [tg]
    elif b == 0xFD:
        tg = 0xFF00 + r8(); t = "callp $%04X" % tg; I.call = [tg]
    elif b == 0xFE:
        tg = r16(); t = "jp $%04X" % tg; I.tg = [tg]; I.end = True
    elif b == 0xFF: t = "swi"; I.end = True
    I.n = p[0] - a
    I.t = t
    if t.startswith("??"): I.end = True; I.bad = True
    return I
