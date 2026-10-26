; Column extraction, history, energy codes, strobe-table writers


Line_CopyColumnSource:
; [C] copy the 32 bytes (2 stacked tiles x 16 rows x 2 planes) of the tile column being printed
        ld HL,ColumnSource
        ld (HL),(DE)
        inc HL
        inc DE
        ld (HL),(DE)
        inc HL
        inc DE
        ld (HL),(DE)
        inc HL
        inc DE
        ld (HL),(DE)
        inc HL
        inc DE
        ld (HL),(DE)
        inc HL
        inc DE
        ld (HL),(DE)
        inc HL
        inc DE
        ld (HL),(DE)
        inc HL
        inc DE
        ld (HL),(DE)
        inc HL
        inc DE
        ld (HL),(DE)
        inc HL
        inc DE
        ld (HL),(DE)
        inc HL
        inc DE
        ld (HL),(DE)
        inc HL
        inc DE
        ld (HL),(DE)
        inc HL
        inc DE
        ld (HL),(DE)
        inc HL
        inc DE
        ld (HL),(DE)
        inc HL
        inc DE
        ld (HL),(DE)
        inc HL
        inc DE
        ld (HL),(DE)
        inc HL
        inc DE
        ld (HL),(DE)
        inc HL
        inc DE
        ld (HL),(DE)
        inc HL
        inc DE
        ld (HL),(DE)
        inc HL
        inc DE
        ld (HL),(DE)
        inc HL
        inc DE
        ld (HL),(DE)
        inc HL
        inc DE
        ld (HL),(DE)
        inc HL
        inc DE
        ld (HL),(DE)
        inc HL
        inc DE
        ld (HL),(DE)
        inc HL
        inc DE
        ld (HL),(DE)
        inc HL
        inc DE
        ld (HL),(DE)
        inc HL
        inc DE
        ld (HL),(DE)
        inc HL
        inc DE
        ld (HL),(DE)
        inc HL
        inc DE
        ld (HL),(DE)
        inc HL
        inc DE
        ld (HL),(DE)
        inc HL
        inc DE
        ld (HL),(DE)
        inc HL
        inc DE
        ld (HL),(DE)
        inc DE
        cmp DE,$0240
        jr CS,LBA4D
        ld DE,LineBuf
LBA4D:
        ld (LineBufRd),DE
        ret

Line_ExtractColumn:
; [C] pixel x = TileColumnX of each of the 16 rows -> ColumnPixels (0-3); ends with the palette remap
        ld HL,ColumnPixels
        ld DE,ColumnSource
        ld A,$07
        ld C,(TileColumnX)
        sub A,C
        test (DE).A
        ld (HL).0,CF
        inc DE
        test (DE).A
        ld (HL+).1,CF
        inc DE
        test (DE).A
        ld (HL).0,CF
        inc DE
        test (DE).A
        ld (HL+).1,CF
        inc DE
        test (DE).A
        ld (HL).0,CF
        inc DE
        test (DE).A
        ld (HL+).1,CF
        inc DE
        test (DE).A
        ld (HL).0,CF
        inc DE
        test (DE).A
        ld (HL+).1,CF
        inc DE
        test (DE).A
        ld (HL).0,CF
        inc DE
        test (DE).A
        ld (HL+).1,CF
        inc DE
        test (DE).A
        ld (HL).0,CF
        inc DE
        test (DE).A
        ld (HL+).1,CF
        inc DE
        test (DE).A
        ld (HL).0,CF
        inc DE
        test (DE).A
        ld (HL+).1,CF
        inc DE
        test (DE).A
        ld (HL).0,CF
        inc DE
        test (DE).A
        ld (HL+).1,CF
        inc DE
        test (DE).A
        ld (HL).0,CF
        inc DE
        test (DE).A
        ld (HL+).1,CF
        inc DE
        test (DE).A
        ld (HL).0,CF
        inc DE
        test (DE).A
        ld (HL+).1,CF
        inc DE
        test (DE).A
        ld (HL).0,CF
        inc DE
        test (DE).A
        ld (HL+).1,CF
        inc DE
        test (DE).A
        ld (HL).0,CF
        inc DE
        test (DE).A
        ld (HL+).1,CF
        inc DE
        test (DE).A
        ld (HL).0,CF
        inc DE
        test (DE).A
        ld (HL+).1,CF
        inc DE
        test (DE).A
        ld (HL).0,CF
        inc DE
        test (DE).A
        ld (HL+).1,CF
        inc DE
        test (DE).A
        ld (HL).0,CF
        inc DE
        test (DE).A
        ld (HL+).1,CF
        inc DE
        test (DE).A
        ld (HL).0,CF
        inc DE
        test (DE).A
        ld (HL).1,CF
        ld A,(Palette)
        jr Z,LBB38
        and A,$C0
        swap A
        shrc A
        shrc A
        ld B,A
        ld A,(Palette)
        and A,$30
        swap A
        ld C,A
        ld A,(Palette)
        and A,$0C
        shrc A
        shrc A
        ld D,A
        ld E,(Palette)
        and E,$03
        ld HL,ColumnPixels
LBB1D:
        ld A,(HL)
        cmp A,$03
        jrs F,LBB24
        ld (HL+),B
        jrs T,LBB32
LBB24:
        cmp A,$02
        jrs F,LBB2A
        ld (HL+),C
        jrs T,LBB32
LBB2A:
        cmp A,$01
        jrs F,LBB30
        ld (HL+),D
        jrs T,LBB32
LBB30:
        ld (HL+),E
LBB32:
        cmp HL,$0096
        jr LE,LBB1D
LBB38:
        ret

Line_ColumnHistory:
; [C] RowHistory = previous dot << 4 | current dot; ColumnHistCode = Tab_EnergyByHistory[RowHistory]
        ld HL,Tab_EnergyByHistory
        ld A,(ColumnPixels)
        rold A,(RowHistory)
        ld C,(RowHistory)
        ld (ColumnHistCode),(HL+C)
        ld A,($88)
        rold A,($A8)
        ld C,($A8)
        ld ($98),(HL+C)
        ld A,($89)
        rold A,($A9)
        ld C,($A9)
        ld ($99),(HL+C)
        ld A,($8A)
        rold A,($AA)
        ld C,($AA)
        ld ($9A),(HL+C)
        ld A,($8B)
        rold A,($AB)
        ld C,($AB)
        ld ($9B),(HL+C)
        ld A,($8C)
        rold A,($AC)
        ld C,($AC)
        ld ($9C),(HL+C)
        ld A,($8D)
        rold A,($AD)
        ld C,($AD)
        ld ($9D),(HL+C)
        ld A,($8E)
        rold A,($AE)
        ld C,($AE)
        ld ($9E),(HL+C)
        ld A,($8F)
        rold A,($AF)
        ld C,($AF)
        ld ($9F),(HL+C)
        ld A,($90)
        rold A,($B0)
        ld C,($B0)
        ld ($A0),(HL+C)
        ld A,($91)
        rold A,($B1)
        ld C,($B1)
        ld ($A1),(HL+C)
        ld A,($92)
        rold A,($B2)
        ld C,($B2)
        ld ($A2),(HL+C)
        ld A,($93)
        rold A,($B3)
        ld C,($B3)
        ld ($A3),(HL+C)
        ld A,($94)
        rold A,($B4)
        ld C,($B4)
        ld ($A4),(HL+C)
        ld A,($95)
        rold A,($B5)
        ld C,($B5)
        ld ($A5),(HL+C)
        ld A,($96)
        rold A,($B6)
        ld C,($B6)
        ld ($A6),(HL+C)
        ret

Line_ColumnEnergy:
; [C] code = HeatTime + Tab_HeatCorr<grey>[RowHeatInt] + ColumnHistCode, clamped 0-0x64, into ColumnCodes
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld DE,WA
        ld A,(ColumnPixels)
        shlc A
        ld C,A
        ld HL,Tab_HeatCorrPtrs
        ld HL,(HL+C)
        ld A,(RowHeatInt)
        ld W,$00
        add WA,HL
        ld HL,WA
        ld W,(ColumnHistCode)
        ld A,(HeatTime)
        add A,(HL)
        test A.7
        jrs F,LBC1A
        add A,W
        cmp A,$64
        jr LE,LBC1F
        ld A,$64
        jrs T,LBC1F
LBC1A:
        add A,W
        jrs T,LBC1F
        ld A,$00
LBC1F:
        ld (DE),A
        inc DE
        ld A,($88)
        shlc A
        ld C,A
        ld HL,Tab_HeatCorrPtrs
        ld HL,(HL+C)
        ld A,($61)
        ld W,$00
        add WA,HL
        ld HL,WA
        ld W,($98)
        ld A,(HeatTime)
        add A,(HL)
        test A.7
        jrs F,LBC46
        add A,W
        cmp A,$64
        jr LE,LBC4B
        ld A,$64
        jrs T,LBC4B
LBC46:
        add A,W
        jrs T,LBC4B
        ld A,$00
LBC4B:
        ld (DE),A
        inc DE
        ld A,($89)
        shlc A
        ld C,A
        ld HL,Tab_HeatCorrPtrs
        ld HL,(HL+C)
        ld A,($62)
        ld W,$00
        add WA,HL
        ld HL,WA
        ld W,($99)
        ld A,(HeatTime)
        add A,(HL)
        test A.7
        jrs F,LBC72
        add A,W
        cmp A,$64
        jr LE,LBC77
        ld A,$64
        jrs T,LBC77
LBC72:
        add A,W
        jrs T,LBC77
        ld A,$00
LBC77:
        ld (DE),A
        inc DE
        ld A,($8A)
        shlc A
        ld C,A
        ld HL,Tab_HeatCorrPtrs
        ld HL,(HL+C)
        ld A,($63)
        ld W,$00
        add WA,HL
        ld HL,WA
        ld W,($9A)
        ld A,(HeatTime)
        add A,(HL)
        test A.7
        jrs F,LBC9E
        add A,W
        cmp A,$64
        jr LE,LBCA3
        ld A,$64
        jrs T,LBCA3
LBC9E:
        add A,W
        jrs T,LBCA3
        ld A,$00
LBCA3:
        ld (DE),A
        inc DE
        ld A,($8B)
        shlc A
        ld C,A
        ld HL,Tab_HeatCorrPtrs
        ld HL,(HL+C)
        ld A,($64)
        ld W,$00
        add WA,HL
        ld HL,WA
        ld W,($9B)
        ld A,(HeatTime)
        add A,(HL)
        test A.7
        jrs F,LBCCA
        add A,W
        cmp A,$64
        jr LE,LBCCF
        ld A,$64
        jrs T,LBCCF
LBCCA:
        add A,W
        jrs T,LBCCF
        ld A,$00
LBCCF:
        ld (DE),A
        inc DE
        ld A,($8C)
        shlc A
        ld C,A
        ld HL,Tab_HeatCorrPtrs
        ld HL,(HL+C)
        ld A,($65)
        ld W,$00
        add WA,HL
        ld HL,WA
        ld W,($9C)
        ld A,(HeatTime)
        add A,(HL)
        test A.7
        jrs F,LBCF6
        add A,W
        cmp A,$64
        jr LE,LBCFB
        ld A,$64
        jrs T,LBCFB
LBCF6:
        add A,W
        jrs T,LBCFB
        ld A,$00
LBCFB:
        ld (DE),A
        inc DE
        ld A,($8D)
        shlc A
        ld C,A
        ld HL,Tab_HeatCorrPtrs
        ld HL,(HL+C)
        ld A,($66)
        ld W,$00
        add WA,HL
        ld HL,WA
        ld W,($9D)
        ld A,(HeatTime)
        add A,(HL)
        test A.7
        jrs F,LBD22
        add A,W
        cmp A,$64
        jr LE,LBD27
        ld A,$64
        jrs T,LBD27
LBD22:
        add A,W
        jrs T,LBD27
        ld A,$00
LBD27:
        ld (DE),A
        inc DE
        ld A,($8E)
        shlc A
        ld C,A
        ld HL,Tab_HeatCorrPtrs
        ld HL,(HL+C)
        ld A,($67)
        ld W,$00
        add WA,HL
        ld HL,WA
        ld W,($9E)
        ld A,(HeatTime)
        add A,(HL)
        test A.7
        jrs F,LBD4E
        add A,W
        cmp A,$64
        jr LE,LBD53
        ld A,$64
        jrs T,LBD53
LBD4E:
        add A,W
        jrs T,LBD53
        ld A,$00
LBD53:
        ld (DE),A
        inc DE
        ld A,($8F)
        shlc A
        ld C,A
        ld HL,Tab_HeatCorrPtrs
        ld HL,(HL+C)
        ld A,($68)
        ld W,$00
        add WA,HL
        ld HL,WA
        ld W,($9F)
        ld A,(HeatTime)
        add A,(HL)
        test A.7
        jrs F,LBD7A
        add A,W
        cmp A,$64
        jr LE,LBD7F
        ld A,$64
        jrs T,LBD7F
LBD7A:
        add A,W
        jrs T,LBD7F
        ld A,$00
LBD7F:
        ld (DE),A
        inc DE
        ld A,($90)
        shlc A
        ld C,A
        ld HL,Tab_HeatCorrPtrs
        ld HL,(HL+C)
        ld A,($69)
        ld W,$00
        add WA,HL
        ld HL,WA
        ld W,($A0)
        ld A,(HeatTime)
        add A,(HL)
        test A.7
        jrs F,LBDA6
        add A,W
        cmp A,$64
        jr LE,LBDAB
        ld A,$64
        jrs T,LBDAB
LBDA6:
        add A,W
        jrs T,LBDAB
        ld A,$00
LBDAB:
        ld (DE),A
        inc DE
        ld A,($91)
        shlc A
        ld C,A
        ld HL,Tab_HeatCorrPtrs
        ld HL,(HL+C)
        ld A,($6A)
        ld W,$00
        add WA,HL
        ld HL,WA
        ld W,($A1)
        ld A,(HeatTime)
        add A,(HL)
        test A.7
        jrs F,LBDD2
        add A,W
        cmp A,$64
        jr LE,LBDD7
        ld A,$64
        jrs T,LBDD7
LBDD2:
        add A,W
        jrs T,LBDD7
        ld A,$00
LBDD7:
        ld (DE),A
        inc DE
        ld A,($92)
        shlc A
        ld C,A
        ld HL,Tab_HeatCorrPtrs
        ld HL,(HL+C)
        ld A,($6B)
        ld W,$00
        add WA,HL
        ld HL,WA
        ld W,($A2)
        ld A,(HeatTime)
        add A,(HL)
        test A.7
        jrs F,LBDFE
        add A,W
        cmp A,$64
        jr LE,LBE03
        ld A,$64
        jrs T,LBE03
LBDFE:
        add A,W
        jrs T,LBE03
        ld A,$00
LBE03:
        ld (DE),A
        inc DE
        ld A,($93)
        shlc A
        ld C,A
        ld HL,Tab_HeatCorrPtrs
        ld HL,(HL+C)
        ld A,($6C)
        ld W,$00
        add WA,HL
        ld HL,WA
        ld W,($A3)
        ld A,(HeatTime)
        add A,(HL)
        test A.7
        jrs F,LBE2A
        add A,W
        cmp A,$64
        jr LE,LBE2F
        ld A,$64
        jrs T,LBE2F
LBE2A:
        add A,W
        jrs T,LBE2F
        ld A,$00
LBE2F:
        ld (DE),A
        inc DE
        ld A,($94)
        shlc A
        ld C,A
        ld HL,Tab_HeatCorrPtrs
        ld HL,(HL+C)
        ld A,($6D)
        ld W,$00
        add WA,HL
        ld HL,WA
        ld W,($A4)
        ld A,(HeatTime)
        add A,(HL)
        test A.7
        jrs F,LBE56
        add A,W
        cmp A,$64
        jr LE,LBE5B
        ld A,$64
        jrs T,LBE5B
LBE56:
        add A,W
        jrs T,LBE5B
        ld A,$00
LBE5B:
        ld (DE),A
        inc DE
        ld A,($95)
        shlc A
        ld C,A
        ld HL,Tab_HeatCorrPtrs
        ld HL,(HL+C)
        ld A,($6E)
        ld W,$00
        add WA,HL
        ld HL,WA
        ld W,($A5)
        ld A,(HeatTime)
        add A,(HL)
        test A.7
        jrs F,LBE82
        add A,W
        cmp A,$64
        jr LE,LBE87
        ld A,$64
        jrs T,LBE87
LBE82:
        add A,W
        jrs T,LBE87
        ld A,$00
LBE87:
        ld (DE),A
        inc DE
        ld A,($96)
        shlc A
        ld C,A
        ld HL,Tab_HeatCorrPtrs
        ld HL,(HL+C)
        ld A,($6F)
        ld W,$00
        add WA,HL
        ld HL,WA
        ld W,($A6)
        ld A,(HeatTime)
        add A,(HL)
        test A.7
        jrs F,LBEAE
        add A,W
        cmp A,$64
        jr LE,LBEB3
        ld A,$64
        jrs T,LBEB3
LBEAE:
        add A,W
        jrs T,LBEB3
        ld A,$00
LBEB3:
        ld (DE),A
        ret

Tab_HeatCorrPtrs:
; [C] pointers to Tab_HeatCorr0-3, by grey level
; words BEB6-BEBD: [I] Tab_ColumnTabPtrs
        dw Tab_HeatCorr0, Tab_HeatCorr1, Tab_HeatCorr2, Tab_HeatCorr3

StrobeA_Row00:
; [C] set P0.0 (band row 0) in strobe table A for the dot's tick count
        ld A,(DE)
        shlc A
        inc DE
        ld L,A
        ld H,$00
        add HL,Tab_DotTicks
        ld A,(HL+)
        ld C,(HL)
        ld W,$00
        add WA,$0360
        ld HL,WA
        ld A,C
        shlc A
        jp (PC+A)
        dw JCAE0
        dw JCADE
        dw JCADC
        dw JCADA
        dw JCAD8
        dw JCAD6
        dw JCAD4
        dw JCAD2
        dw JCAD0
        dw JCACE
        dw JCACC
        dw JCACA
        dw JCAC8
        dw JCAC6
        dw JCAC4
        dw JCAC2
        dw JCAC0
        dw JCABE
        dw JCABC
        dw JCABA
        dw JCAB8
        dw JCAB6
        dw JCAB4
        dw JCAB2
        dw JCAB0
        dw JCAAE
        dw JCAAC
        dw JCAAA
        dw JCAA8
        dw JCAA6
        dw JCAA4
        dw JCAA2
        dw JCAA0
        dw JCA9E

StrobeA_Row01:
; [C] set P0.1 (band row 1) in strobe table A for the dot's tick count
        ld A,(DE)
        shlc A
        inc DE
        ld L,A
        ld H,$00
        add HL,Tab_DotTicks
        ld A,(HL+)
        ld C,(HL)
        ld W,$00
        add WA,$0360
        ld HL,WA
        ld A,C
        shlc A
        jp (PC+A)
        dw JCB23
        dw JCB21
        dw JCB1F
        dw JCB1D
        dw JCB1B
        dw JCB19
        dw JCB17
        dw JCB15
        dw JCB13
        dw JCB11
        dw JCB0F
        dw JCB0D
        dw JCB0B
        dw JCB09
        dw JCB07
        dw JCB05
        dw JCB03
        dw JCB01
        dw JCAFF
        dw JCAFD
        dw JCAFB
        dw JCAF9
        dw JCAF7
        dw JCAF5
        dw JCAF3
        dw JCAF1
        dw JCAEF
        dw JCAED
        dw JCAEB
        dw JCAE9
        dw JCAE7
        dw JCAE5
        dw JCAE3
        dw JCAE1

StrobeA_Row02:
; [C] set P0.2 (band row 2) in strobe table A for the dot's tick count
        ld A,(DE)
        shlc A
        inc DE
        ld L,A
        ld H,$00
        add HL,Tab_DotTicks
        ld A,(HL+)
        ld C,(HL)
        ld W,$00
        add WA,$0360
        ld HL,WA
        ld A,C
        shlc A
        jp (PC+A)
        dw JCB66
        dw JCB64
        dw JCB62
        dw JCB60
        dw JCB5E
        dw JCB5C
        dw JCB5A
        dw JCB58
        dw JCB56
        dw JCB54
        dw JCB52
        dw JCB50
        dw JCB4E
        dw JCB4C
        dw JCB4A
        dw JCB48
        dw JCB46
        dw JCB44
        dw JCB42
        dw JCB40
        dw JCB3E
        dw JCB3C
        dw JCB3A
        dw JCB38
        dw JCB36
        dw JCB34
        dw JCB32
        dw JCB30
        dw JCB2E
        dw JCB2C
        dw JCB2A
        dw JCB28
        dw JCB26
        dw JCB24

StrobeA_Row03:
; [C] set P0.3 (band row 3) in strobe table A for the dot's tick count
        ld A,(DE)
        shlc A
        inc DE
        ld L,A
        ld H,$00
        add HL,Tab_DotTicks
        ld A,(HL+)
        ld C,(HL)
        ld W,$00
        add WA,$0360
        ld HL,WA
        ld A,C
        shlc A
        jp (PC+A)
        dw JCBA9
        dw JCBA7
        dw JCBA5
        dw JCBA3
        dw JCBA1
        dw JCB9F
        dw JCB9D
        dw JCB9B
        dw JCB99
        dw JCB97
        dw JCB95
        dw JCB93
        dw JCB91
        dw JCB8F
        dw JCB8D
        dw JCB8B
        dw JCB89
        dw JCB87
        dw JCB85
        dw JCB83
        dw JCB81
        dw JCB7F
        dw JCB7D
        dw JCB7B
        dw JCB79
        dw JCB77
        dw JCB75
        dw JCB73
        dw JCB71
        dw JCB6F
        dw JCB6D
        dw JCB6B
        dw JCB69
        dw JCB67

StrobeA_Row04:
; [C] set P0.4 (band row 4) in strobe table A for the dot's tick count
        ld A,(DE)
        shlc A
        inc DE
        ld L,A
        ld H,$00
        add HL,Tab_DotTicks
        ld A,(HL+)
        ld C,(HL)
        ld W,$00
        add WA,$0360
        ld HL,WA
        ld A,C
        shlc A
        jp (PC+A)
        dw JCBEC
        dw JCBEA
        dw JCBE8
        dw JCBE6
        dw JCBE4
        dw JCBE2
        dw JCBE0
        dw JCBDE
        dw JCBDC
        dw JCBDA
        dw JCBD8
        dw JCBD6
        dw JCBD4
        dw JCBD2
        dw JCBD0
        dw JCBCE
        dw JCBCC
        dw JCBCA
        dw JCBC8
        dw JCBC6
        dw JCBC4
        dw JCBC2
        dw JCBC0
        dw JCBBE
        dw JCBBC
        dw JCBBA
        dw JCBB8
        dw JCBB6
        dw JCBB4
        dw JCBB2
        dw JCBB0
        dw JCBAE
        dw JCBAC
        dw JCBAA

StrobeA_Row05:
; [C] set P0.5 (band row 5) in strobe table A for the dot's tick count
        ld A,(DE)
        shlc A
        inc DE
        ld L,A
        ld H,$00
        add HL,Tab_DotTicks
        ld A,(HL+)
        ld C,(HL)
        ld W,$00
        add WA,$0360
        ld HL,WA
        ld A,C
        shlc A
        jp (PC+A)
        dw JCC2F
        dw JCC2D
        dw JCC2B
        dw JCC29
        dw JCC27
        dw JCC25
        dw JCC23
        dw JCC21
        dw JCC1F
        dw JCC1D
        dw JCC1B
        dw JCC19
        dw JCC17
        dw JCC15
        dw JCC13
        dw JCC11
        dw JCC0F
        dw JCC0D
        dw JCC0B
        dw JCC09
        dw JCC07
        dw JCC05
        dw JCC03
        dw JCC01
        dw JCBFF
        dw JCBFD
        dw JCBFB
        dw JCBF9
        dw JCBF7
        dw JCBF5
        dw JCBF3
        dw JCBF1
        dw JCBEF
        dw JCBED

StrobeA_Row06:
; [C] set P0.6 (band row 6) in strobe table A for the dot's tick count
        ld A,(DE)
        shlc A
        inc DE
        ld L,A
        ld H,$00
        add HL,Tab_DotTicks
        ld A,(HL+)
        ld C,(HL)
        ld W,$00
        add WA,$0360
        ld HL,WA
        ld A,C
        shlc A
        jp (PC+A)
        dw JCC72
        dw JCC70
        dw JCC6E
        dw JCC6C
        dw JCC6A
        dw JCC68
        dw JCC66
        dw JCC64
        dw JCC62
        dw JCC60
        dw JCC5E
        dw JCC5C
        dw JCC5A
        dw JCC58
        dw JCC56
        dw JCC54
        dw JCC52
        dw JCC50
        dw JCC4E
        dw JCC4C
        dw JCC4A
        dw JCC48
        dw JCC46
        dw JCC44
        dw JCC42
        dw JCC40
        dw JCC3E
        dw JCC3C
        dw JCC3A
        dw JCC38
        dw JCC36
        dw JCC34
        dw JCC32
        dw JCC30

StrobeA_Row07:
; [C] set P0.7 (band row 7) in strobe table A for the dot's tick count
        ld A,(DE)
        shlc A
        inc DE
        ld L,A
        ld H,$00
        add HL,Tab_DotTicks
        ld A,(HL+)
        ld C,(HL)
        ld W,$00
        add WA,$0360
        ld HL,WA
        ld A,C
        shlc A
        jp (PC+A)
        dw JCCB5
        dw JCCB3
        dw JCCB1
        dw JCCAF
        dw JCCAD
        dw JCCAB
        dw JCCA9
        dw JCCA7
        dw JCCA5
        dw JCCA3
        dw JCCA1
        dw JCC9F
        dw JCC9D
        dw JCC9B
        dw JCC99
        dw JCC97
        dw JCC95
        dw JCC93
        dw JCC91
        dw JCC8F
        dw JCC8D
        dw JCC8B
        dw JCC89
        dw JCC87
        dw JCC85
        dw JCC83
        dw JCC81
        dw JCC7F
        dw JCC7D
        dw JCC7B
        dw JCC79
        dw JCC77
        dw JCC75
        dw JCC73

StrobeA_Row08:
; [C] set P1.0 (band row 8) in strobe table A for the dot's tick count
        ld A,(DE)
        shlc A
        inc DE
        ld L,A
        ld H,$00
        add HL,Tab_DotTicks
        ld A,(HL+)
        ld C,(HL)
        ld W,$00
        add WA,$0383
        ld HL,WA
        ld A,C
        shlc A
        jp (PC+A)
        dw JCAE0
        dw JCADE
        dw JCADC
        dw JCADA
        dw JCAD8
        dw JCAD6
        dw JCAD4
        dw JCAD2
        dw JCAD0
        dw JCACE
        dw JCACC
        dw JCACA
        dw JCAC8
        dw JCAC6
        dw JCAC4
        dw JCAC2
        dw JCAC0
        dw JCABE
        dw JCABC
        dw JCABA
        dw JCAB8
        dw JCAB6
        dw JCAB4
        dw JCAB2
        dw JCAB0
        dw JCAAE
        dw JCAAC
        dw JCAAA
        dw JCAA8
        dw JCAA6
        dw JCAA4
        dw JCAA2
        dw JCAA0
        dw JCA9E

StrobeA_Row09:
; [C] set P1.1 (band row 9) in strobe table A for the dot's tick count
        ld A,(DE)
        shlc A
        inc DE
        ld L,A
        ld H,$00
        add HL,Tab_DotTicks
        ld A,(HL+)
        ld C,(HL)
        ld W,$00
        add WA,$0383
        ld HL,WA
        ld A,C
        shlc A
        jp (PC+A)
        dw JCB23
        dw JCB21
        dw JCB1F
        dw JCB1D
        dw JCB1B
        dw JCB19
        dw JCB17
        dw JCB15
        dw JCB13
        dw JCB11
        dw JCB0F
        dw JCB0D
        dw JCB0B
        dw JCB09
        dw JCB07
        dw JCB05
        dw JCB03
        dw JCB01
        dw JCAFF
        dw JCAFD
        dw JCAFB
        dw JCAF9
        dw JCAF7
        dw JCAF5
        dw JCAF3
        dw JCAF1
        dw JCAEF
        dw JCAED
        dw JCAEB
        dw JCAE9
        dw JCAE7
        dw JCAE5
        dw JCAE3
        dw JCAE1

StrobeA_Row10:
; [C] set P1.2 (band row 10) in strobe table A for the dot's tick count
        ld A,(DE)
        shlc A
        inc DE
        ld L,A
        ld H,$00
        add HL,Tab_DotTicks
        ld A,(HL+)
        ld C,(HL)
        ld W,$00
        add WA,$0383
        ld HL,WA
        ld A,C
        shlc A
        jp (PC+A)
        dw JCB66
        dw JCB64
        dw JCB62
        dw JCB60
        dw JCB5E
        dw JCB5C
        dw JCB5A
        dw JCB58
        dw JCB56
        dw JCB54
        dw JCB52
        dw JCB50
        dw JCB4E
        dw JCB4C
        dw JCB4A
        dw JCB48
        dw JCB46
        dw JCB44
        dw JCB42
        dw JCB40
        dw JCB3E
        dw JCB3C
        dw JCB3A
        dw JCB38
        dw JCB36
        dw JCB34
        dw JCB32
        dw JCB30
        dw JCB2E
        dw JCB2C
        dw JCB2A
        dw JCB28
        dw JCB26
        dw JCB24

StrobeA_Row11:
; [C] set P1.3 (band row 11) in strobe table A for the dot's tick count
        ld A,(DE)
        shlc A
        inc DE
        ld L,A
        ld H,$00
        add HL,Tab_DotTicks
        ld A,(HL+)
        ld C,(HL)
        ld W,$00
        add WA,$0383
        ld HL,WA
        ld A,C
        shlc A
        jp (PC+A)
        dw JCBA9
        dw JCBA7
        dw JCBA5
        dw JCBA3
        dw JCBA1
        dw JCB9F
        dw JCB9D
        dw JCB9B
        dw JCB99
        dw JCB97
        dw JCB95
        dw JCB93
        dw JCB91
        dw JCB8F
        dw JCB8D
        dw JCB8B
        dw JCB89
        dw JCB87
        dw JCB85
        dw JCB83
        dw JCB81
        dw JCB7F
        dw JCB7D
        dw JCB7B
        dw JCB79
        dw JCB77
        dw JCB75
        dw JCB73
        dw JCB71
        dw JCB6F
        dw JCB6D
        dw JCB6B
        dw JCB69
        dw JCB67

StrobeA_Row12:
; [C] set P1.4 (band row 12) in strobe table A for the dot's tick count
        ld A,(DE)
        shlc A
        inc DE
        ld L,A
        ld H,$00
        add HL,Tab_DotTicks
        ld A,(HL+)
        ld C,(HL)
        ld W,$00
        add WA,$0383
        ld HL,WA
        ld A,C
        shlc A
        jp (PC+A)
        dw JCBEC
        dw JCBEA
        dw JCBE8
        dw JCBE6
        dw JCBE4
        dw JCBE2
        dw JCBE0
        dw JCBDE
        dw JCBDC
        dw JCBDA
        dw JCBD8
        dw JCBD6
        dw JCBD4
        dw JCBD2
        dw JCBD0
        dw JCBCE
        dw JCBCC
        dw JCBCA
        dw JCBC8
        dw JCBC6
        dw JCBC4
        dw JCBC2
        dw JCBC0
        dw JCBBE
        dw JCBBC
        dw JCBBA
        dw JCBB8
        dw JCBB6
        dw JCBB4
        dw JCBB2
        dw JCBB0
        dw JCBAE
        dw JCBAC
        dw JCBAA

StrobeA_Row13:
; [C] set P1.5 (band row 13) in strobe table A for the dot's tick count
        ld A,(DE)
        shlc A
        inc DE
        ld L,A
        ld H,$00
        add HL,Tab_DotTicks
        ld A,(HL+)
        ld C,(HL)
        ld W,$00
        add WA,$0383
        ld HL,WA
        ld A,C
        shlc A
        jp (PC+A)
        dw JCC2F
        dw JCC2D
        dw JCC2B
        dw JCC29
        dw JCC27
        dw JCC25
        dw JCC23
        dw JCC21
        dw JCC1F
        dw JCC1D
        dw JCC1B
        dw JCC19
        dw JCC17
        dw JCC15
        dw JCC13
        dw JCC11
        dw JCC0F
        dw JCC0D
        dw JCC0B
        dw JCC09
        dw JCC07
        dw JCC05
        dw JCC03
        dw JCC01
        dw JCBFF
        dw JCBFD
        dw JCBFB
        dw JCBF9
        dw JCBF7
        dw JCBF5
        dw JCBF3
        dw JCBF1
        dw JCBEF
        dw JCBED

StrobeA_Row14:
; [C] set P1.6 (band row 14) in strobe table A for the dot's tick count
        ld A,(DE)
        shlc A
        inc DE
        ld L,A
        ld H,$00
        add HL,Tab_DotTicks
        ld A,(HL+)
        ld C,(HL)
        ld W,$00
        add WA,$0383
        ld HL,WA
        ld A,C
        shlc A
        jp (PC+A)
        dw JCC72
        dw JCC70
        dw JCC6E
        dw JCC6C
        dw JCC6A
        dw JCC68
        dw JCC66
        dw JCC64
        dw JCC62
        dw JCC60
        dw JCC5E
        dw JCC5C
        dw JCC5A
        dw JCC58
        dw JCC56
        dw JCC54
        dw JCC52
        dw JCC50
        dw JCC4E
        dw JCC4C
        dw JCC4A
        dw JCC48
        dw JCC46
        dw JCC44
        dw JCC42
        dw JCC40
        dw JCC3E
        dw JCC3C
        dw JCC3A
        dw JCC38
        dw JCC36
        dw JCC34
        dw JCC32
        dw JCC30

StrobeA_Row15:
; [C] set P1.7 (band row 15) in strobe table A for the dot's tick count
        ld A,(DE)
        shlc A
        inc DE
        ld L,A
        ld H,$00
        add HL,Tab_DotTicks
        ld A,(HL+)
        ld C,(HL)
        ld W,$00
        add WA,$0383
        ld HL,WA
        ld A,C
        shlc A
        jp (PC+A)
        dw JCCB5
        dw JCCB3
        dw JCCB1
        dw JCCAF
        dw JCCAD
        dw JCCAB
        dw JCCA9
        dw JCCA7
        dw JCCA5
        dw JCCA3
        dw JCCA1
        dw JCC9F
        dw JCC9D
        dw JCC9B
        dw JCC99
        dw JCC97
        dw JCC95
        dw JCC93
        dw JCC91
        dw JCC8F
        dw JCC8D
        dw JCC8B
        dw JCC89
        dw JCC87
        dw JCC85
        dw JCC83
        dw JCC81
        dw JCC7F
        dw JCC7D
        dw JCC7B
        dw JCC79
        dw JCC77
        dw JCC75
        dw JCC73

StrobeB_Row00:
; [C] set P0.0 (band row 0) in strobe table B for the dot's tick count
        ld A,(DE)
        shlc A
        inc DE
        ld L,A
        ld H,$00
        add HL,Tab_DotTicks
        ld A,(HL+)
        ld C,(HL)
        ld W,$00
        add WA,$03A6
        ld HL,WA
        ld A,C
        shlc A
        jp (PC+A)
        dw JCAE0
        dw JCADE
        dw JCADC
        dw JCADA
        dw JCAD8
        dw JCAD6
        dw JCAD4
        dw JCAD2
        dw JCAD0
        dw JCACE
        dw JCACC
        dw JCACA
        dw JCAC8
        dw JCAC6
        dw JCAC4
        dw JCAC2
        dw JCAC0
        dw JCABE
        dw JCABC
        dw JCABA
        dw JCAB8
        dw JCAB6
        dw JCAB4
        dw JCAB2
        dw JCAB0
        dw JCAAE
        dw JCAAC
        dw JCAAA
        dw JCAA8
        dw JCAA6
        dw JCAA4
        dw JCAA2
        dw JCAA0
        dw JCA9E

StrobeB_Row01:
; [C] set P0.1 (band row 1) in strobe table B for the dot's tick count
        ld A,(DE)
        shlc A
        inc DE
        ld L,A
        ld H,$00
        add HL,Tab_DotTicks
        ld A,(HL+)
        ld C,(HL)
        ld W,$00
        add WA,$03A6
        ld HL,WA
        ld A,C
        shlc A
        jp (PC+A)
        dw JCB23
        dw JCB21
        dw JCB1F
        dw JCB1D
        dw JCB1B
        dw JCB19
        dw JCB17
        dw JCB15
        dw JCB13
        dw JCB11
        dw JCB0F
        dw JCB0D
        dw JCB0B
        dw JCB09
        dw JCB07
        dw JCB05
        dw JCB03
        dw JCB01
        dw JCAFF
        dw JCAFD
        dw JCAFB
        dw JCAF9
        dw JCAF7
        dw JCAF5
        dw JCAF3
        dw JCAF1
        dw JCAEF
        dw JCAED
        dw JCAEB
        dw JCAE9
        dw JCAE7
        dw JCAE5
        dw JCAE3
        dw JCAE1

StrobeB_Row02:
; [C] set P0.2 (band row 2) in strobe table B for the dot's tick count
        ld A,(DE)
        shlc A
        inc DE
        ld L,A
        ld H,$00
        add HL,Tab_DotTicks
        ld A,(HL+)
        ld C,(HL)
        ld W,$00
        add WA,$03A6
        ld HL,WA
        ld A,C
        shlc A
        jp (PC+A)
        dw JCB66
        dw JCB64
        dw JCB62
        dw JCB60
        dw JCB5E
        dw JCB5C
        dw JCB5A
        dw JCB58
        dw JCB56
        dw JCB54
        dw JCB52
        dw JCB50
        dw JCB4E
        dw JCB4C
        dw JCB4A
        dw JCB48
        dw JCB46
        dw JCB44
        dw JCB42
        dw JCB40
        dw JCB3E
        dw JCB3C
        dw JCB3A
        dw JCB38
        dw JCB36
        dw JCB34
        dw JCB32
        dw JCB30
        dw JCB2E
        dw JCB2C
        dw JCB2A
        dw JCB28
        dw JCB26
        dw JCB24

StrobeB_Row03:
; [C] set P0.3 (band row 3) in strobe table B for the dot's tick count
        ld A,(DE)
        shlc A
        inc DE
        ld L,A
        ld H,$00
        add HL,Tab_DotTicks
        ld A,(HL+)
        ld C,(HL)
        ld W,$00
        add WA,$03A6
        ld HL,WA
        ld A,C
        shlc A
        jp (PC+A)
        dw JCBA9
        dw JCBA7
        dw JCBA5
        dw JCBA3
        dw JCBA1
        dw JCB9F
        dw JCB9D
        dw JCB9B
        dw JCB99
        dw JCB97
        dw JCB95
        dw JCB93
        dw JCB91
        dw JCB8F
        dw JCB8D
        dw JCB8B
        dw JCB89
        dw JCB87
        dw JCB85
        dw JCB83
        dw JCB81
        dw JCB7F
        dw JCB7D
        dw JCB7B
        dw JCB79
        dw JCB77
        dw JCB75
        dw JCB73
        dw JCB71
        dw JCB6F
        dw JCB6D
        dw JCB6B
        dw JCB69
        dw JCB67

StrobeB_Row04:
; [C] set P0.4 (band row 4) in strobe table B for the dot's tick count
        ld A,(DE)
        shlc A
        inc DE
        ld L,A
        ld H,$00
        add HL,Tab_DotTicks
        ld A,(HL+)
        ld C,(HL)
        ld W,$00
        add WA,$03A6
        ld HL,WA
        ld A,C
        shlc A
        jp (PC+A)
        dw JCBEC
        dw JCBEA
        dw JCBE8
        dw JCBE6
        dw JCBE4
        dw JCBE2
        dw JCBE0
        dw JCBDE
        dw JCBDC
        dw JCBDA
        dw JCBD8
        dw JCBD6
        dw JCBD4
        dw JCBD2
        dw JCBD0
        dw JCBCE
        dw JCBCC
        dw JCBCA
        dw JCBC8
        dw JCBC6
        dw JCBC4
        dw JCBC2
        dw JCBC0
        dw JCBBE
        dw JCBBC
        dw JCBBA
        dw JCBB8
        dw JCBB6
        dw JCBB4
        dw JCBB2
        dw JCBB0
        dw JCBAE
        dw JCBAC
        dw JCBAA

StrobeB_Row05:
; [C] set P0.5 (band row 5) in strobe table B for the dot's tick count
        ld A,(DE)
        shlc A
        inc DE
        ld L,A
        ld H,$00
        add HL,Tab_DotTicks
        ld A,(HL+)
        ld C,(HL)
        ld W,$00
        add WA,$03A6
        ld HL,WA
        ld A,C
        shlc A
        jp (PC+A)
        dw JCC2F
        dw JCC2D
        dw JCC2B
        dw JCC29
        dw JCC27
        dw JCC25
        dw JCC23
        dw JCC21
        dw JCC1F
        dw JCC1D
        dw JCC1B
        dw JCC19
        dw JCC17
        dw JCC15
        dw JCC13
        dw JCC11
        dw JCC0F
        dw JCC0D
        dw JCC0B
        dw JCC09
        dw JCC07
        dw JCC05
        dw JCC03
        dw JCC01
        dw JCBFF
        dw JCBFD
        dw JCBFB
        dw JCBF9
        dw JCBF7
        dw JCBF5
        dw JCBF3
        dw JCBF1
        dw JCBEF
        dw JCBED

StrobeB_Row06:
; [C] set P0.6 (band row 6) in strobe table B for the dot's tick count
        ld A,(DE)
        shlc A
        inc DE
        ld L,A
        ld H,$00
        add HL,Tab_DotTicks
        ld A,(HL+)
        ld C,(HL)
        ld W,$00
        add WA,$03A6
        ld HL,WA
        ld A,C
        shlc A
        jp (PC+A)
        dw JCC72
        dw JCC70
        dw JCC6E
        dw JCC6C
        dw JCC6A
        dw JCC68
        dw JCC66
        dw JCC64
        dw JCC62
        dw JCC60
        dw JCC5E
        dw JCC5C
        dw JCC5A
        dw JCC58
        dw JCC56
        dw JCC54
        dw JCC52
        dw JCC50
        dw JCC4E
        dw JCC4C
        dw JCC4A
        dw JCC48
        dw JCC46
        dw JCC44
        dw JCC42
        dw JCC40
        dw JCC3E
        dw JCC3C
        dw JCC3A
        dw JCC38
        dw JCC36
        dw JCC34
        dw JCC32
        dw JCC30

StrobeB_Row07:
; [C] set P0.7 (band row 7) in strobe table B for the dot's tick count
        ld A,(DE)
        shlc A
        inc DE
        ld L,A
        ld H,$00
        add HL,Tab_DotTicks
        ld A,(HL+)
        ld C,(HL)
        ld W,$00
        add WA,$03A6
        ld HL,WA
        ld A,C
        shlc A
        jp (PC+A)
        dw JCCB5
        dw JCCB3
        dw JCCB1
        dw JCCAF
        dw JCCAD
        dw JCCAB
        dw JCCA9
        dw JCCA7
        dw JCCA5
        dw JCCA3
        dw JCCA1
        dw JCC9F
        dw JCC9D
        dw JCC9B
        dw JCC99
        dw JCC97
        dw JCC95
        dw JCC93
        dw JCC91
        dw JCC8F
        dw JCC8D
        dw JCC8B
        dw JCC89
        dw JCC87
        dw JCC85
        dw JCC83
        dw JCC81
        dw JCC7F
        dw JCC7D
        dw JCC7B
        dw JCC79
        dw JCC77
        dw JCC75
        dw JCC73

StrobeB_Row08:
; [C] set P1.0 (band row 8) in strobe table B for the dot's tick count
        ld A,(DE)
        shlc A
        inc DE
        ld L,A
        ld H,$00
        add HL,Tab_DotTicks
        ld A,(HL+)
        ld C,(HL)
        ld W,$00
        add WA,$03C9
        ld HL,WA
        ld A,C
        shlc A
        jp (PC+A)
        dw JCAE0
        dw JCADE
        dw JCADC
        dw JCADA
        dw JCAD8
        dw JCAD6
        dw JCAD4
        dw JCAD2
        dw JCAD0
        dw JCACE
        dw JCACC
        dw JCACA
        dw JCAC8
        dw JCAC6
        dw JCAC4
        dw JCAC2
        dw JCAC0
        dw JCABE
        dw JCABC
        dw JCABA
        dw JCAB8
        dw JCAB6
        dw JCAB4
        dw JCAB2
        dw JCAB0
        dw JCAAE
        dw JCAAC
        dw JCAAA
        dw JCAA8
        dw JCAA6
        dw JCAA4
        dw JCAA2
        dw JCAA0
        dw JCA9E

StrobeB_Row09:
; [C] set P1.1 (band row 9) in strobe table B for the dot's tick count
        ld A,(DE)
        shlc A
        inc DE
        ld L,A
        ld H,$00
        add HL,Tab_DotTicks
        ld A,(HL+)
        ld C,(HL)
        ld W,$00
        add WA,$03C9
        ld HL,WA
        ld A,C
        shlc A
        jp (PC+A)
        dw JCB23
        dw JCB21
        dw JCB1F
        dw JCB1D
        dw JCB1B
        dw JCB19
        dw JCB17
        dw JCB15
        dw JCB13
        dw JCB11
        dw JCB0F
        dw JCB0D
        dw JCB0B
        dw JCB09
        dw JCB07
        dw JCB05
        dw JCB03
        dw JCB01
        dw JCAFF
        dw JCAFD
        dw JCAFB
        dw JCAF9
        dw JCAF7
        dw JCAF5
        dw JCAF3
        dw JCAF1
        dw JCAEF
        dw JCAED
        dw JCAEB
        dw JCAE9
        dw JCAE7
        dw JCAE5
        dw JCAE3
        dw JCAE1

StrobeB_Row10:
; [C] set P1.2 (band row 10) in strobe table B for the dot's tick count
        ld A,(DE)
        shlc A
        inc DE
        ld L,A
        ld H,$00
        add HL,Tab_DotTicks
        ld A,(HL+)
        ld C,(HL)
        ld W,$00
        add WA,$03C9
        ld HL,WA
        ld A,C
        shlc A
        jp (PC+A)
        dw JCB66
        dw JCB64
        dw JCB62
        dw JCB60
        dw JCB5E
        dw JCB5C
        dw JCB5A
        dw JCB58
        dw JCB56
        dw JCB54
        dw JCB52
        dw JCB50
        dw JCB4E
        dw JCB4C
        dw JCB4A
        dw JCB48
        dw JCB46
        dw JCB44
        dw JCB42
        dw JCB40
        dw JCB3E
        dw JCB3C
        dw JCB3A
        dw JCB38
        dw JCB36
        dw JCB34
        dw JCB32
        dw JCB30
        dw JCB2E
        dw JCB2C
        dw JCB2A
        dw JCB28
        dw JCB26
        dw JCB24

StrobeB_Row11:
; [C] set P1.3 (band row 11) in strobe table B for the dot's tick count
        ld A,(DE)
        shlc A
        inc DE
        ld L,A
        ld H,$00
        add HL,Tab_DotTicks
        ld A,(HL+)
        ld C,(HL)
        ld W,$00
        add WA,$03C9
        ld HL,WA
        ld A,C
        shlc A
        jp (PC+A)
        dw JCBA9
        dw JCBA7
        dw JCBA5
        dw JCBA3
        dw JCBA1
        dw JCB9F
        dw JCB9D
        dw JCB9B
        dw JCB99
        dw JCB97
        dw JCB95
        dw JCB93
        dw JCB91
        dw JCB8F
        dw JCB8D
        dw JCB8B
        dw JCB89
        dw JCB87
        dw JCB85
        dw JCB83
        dw JCB81
        dw JCB7F
        dw JCB7D
        dw JCB7B
        dw JCB79
        dw JCB77
        dw JCB75
        dw JCB73
        dw JCB71
        dw JCB6F
        dw JCB6D
        dw JCB6B
        dw JCB69
        dw JCB67

StrobeB_Row12:
; [C] set P1.4 (band row 12) in strobe table B for the dot's tick count
        ld A,(DE)
        shlc A
        inc DE
        ld L,A
        ld H,$00
        add HL,Tab_DotTicks
        ld A,(HL+)
        ld C,(HL)
        ld W,$00
        add WA,$03C9
        ld HL,WA
        ld A,C
        shlc A
        jp (PC+A)
        dw JCBEC
        dw JCBEA
        dw JCBE8
        dw JCBE6
        dw JCBE4
        dw JCBE2
        dw JCBE0
        dw JCBDE
        dw JCBDC
        dw JCBDA
        dw JCBD8
        dw JCBD6
        dw JCBD4
        dw JCBD2
        dw JCBD0
        dw JCBCE
        dw JCBCC
        dw JCBCA
        dw JCBC8
        dw JCBC6
        dw JCBC4
        dw JCBC2
        dw JCBC0
        dw JCBBE
        dw JCBBC
        dw JCBBA
        dw JCBB8
        dw JCBB6
        dw JCBB4
        dw JCBB2
        dw JCBB0
        dw JCBAE
        dw JCBAC
        dw JCBAA

StrobeB_Row13:
; [C] set P1.5 (band row 13) in strobe table B for the dot's tick count
        ld A,(DE)
        shlc A
        inc DE
        ld L,A
        ld H,$00
        add HL,Tab_DotTicks
        ld A,(HL+)
        ld C,(HL)
        ld W,$00
        add WA,$03C9
        ld HL,WA
        ld A,C
        shlc A
        jp (PC+A)
        dw JCC2F
        dw JCC2D
        dw JCC2B
        dw JCC29
        dw JCC27
        dw JCC25
        dw JCC23
        dw JCC21
        dw JCC1F
        dw JCC1D
        dw JCC1B
        dw JCC19
        dw JCC17
        dw JCC15
        dw JCC13
        dw JCC11
        dw JCC0F
        dw JCC0D
        dw JCC0B
        dw JCC09
        dw JCC07
        dw JCC05
        dw JCC03
        dw JCC01
        dw JCBFF
        dw JCBFD
        dw JCBFB
        dw JCBF9
        dw JCBF7
        dw JCBF5
        dw JCBF3
        dw JCBF1
        dw JCBEF
        dw JCBED

StrobeB_Row14:
; [C] set P1.6 (band row 14) in strobe table B for the dot's tick count
        ld A,(DE)
        shlc A
        inc DE
        ld L,A
        ld H,$00
        add HL,Tab_DotTicks
        ld A,(HL+)
        ld C,(HL)
        ld W,$00
        add WA,$03C9
        ld HL,WA
        ld A,C
        shlc A
        jp (PC+A)
        dw JCC72
        dw JCC70
        dw JCC6E
        dw JCC6C
        dw JCC6A
        dw JCC68
        dw JCC66
        dw JCC64
        dw JCC62
        dw JCC60
        dw JCC5E
        dw JCC5C
        dw JCC5A
        dw JCC58
        dw JCC56
        dw JCC54
        dw JCC52
        dw JCC50
        dw JCC4E
        dw JCC4C
        dw JCC4A
        dw JCC48
        dw JCC46
        dw JCC44
        dw JCC42
        dw JCC40
        dw JCC3E
        dw JCC3C
        dw JCC3A
        dw JCC38
        dw JCC36
        dw JCC34
        dw JCC32
        dw JCC30

StrobeB_Row15:
; [C] set P1.7 (band row 15) in strobe table B for the dot's tick count
        ld A,(DE)
        shlc A
        inc DE
        ld L,A
        ld H,$00
        add HL,Tab_DotTicks
        ld A,(HL+)
        ld C,(HL)
        ld W,$00
        add WA,$03C9
        ld HL,WA
        ld A,C
        shlc A
        jp (PC+A)
        dw JCCB5
        dw JCCB3
        dw JCCB1
        dw JCCAF
        dw JCCAD
        dw JCCAB
        dw JCCA9
        dw JCCA7
        dw JCCA5
        dw JCCA3
        dw JCCA1
        dw JCC9F
        dw JCC9D
        dw JCC9B
        dw JCC99
        dw JCC97
        dw JCC95
        dw JCC93
        dw JCC91
        dw JCC8F
        dw JCC8D
        dw JCC8B
        dw JCC89
        dw JCC87
        dw JCC85
        dw JCC83
        dw JCC81
        dw JCC7F
        dw JCC7D
        dw JCC7B
        dw JCC79
        dw JCC77
        dw JCC75
        dw JCC73
JCA9E:
        set (HL+).0
JCAA0:
        set (HL+).0
JCAA2:
        set (HL+).0
JCAA4:
        set (HL+).0
JCAA6:
        set (HL+).0
JCAA8:
        set (HL+).0
JCAAA:
        set (HL+).0
JCAAC:
        set (HL+).0
JCAAE:
        set (HL+).0
JCAB0:
        set (HL+).0
JCAB2:
        set (HL+).0
JCAB4:
        set (HL+).0
JCAB6:
        set (HL+).0
JCAB8:
        set (HL+).0
JCABA:
        set (HL+).0
JCABC:
        set (HL+).0
JCABE:
        set (HL+).0
JCAC0:
        set (HL+).0
JCAC2:
        set (HL+).0
JCAC4:
        set (HL+).0
JCAC6:
        set (HL+).0
JCAC8:
        set (HL+).0
JCACA:
        set (HL+).0
JCACC:
        set (HL+).0
JCACE:
        set (HL+).0
JCAD0:
        set (HL+).0
JCAD2:
        set (HL+).0
JCAD4:
        set (HL+).0
JCAD6:
        set (HL+).0
JCAD8:
        set (HL+).0
JCADA:
        set (HL+).0
JCADC:
        set (HL+).0
JCADE:
        set (HL+).0
JCAE0:
        ret
JCAE1:
        set (HL+).1
JCAE3:
        set (HL+).1
JCAE5:
        set (HL+).1
JCAE7:
        set (HL+).1
JCAE9:
        set (HL+).1
JCAEB:
        set (HL+).1
JCAED:
        set (HL+).1
JCAEF:
        set (HL+).1
JCAF1:
        set (HL+).1
JCAF3:
        set (HL+).1
JCAF5:
        set (HL+).1
JCAF7:
        set (HL+).1
JCAF9:
        set (HL+).1
JCAFB:
        set (HL+).1
JCAFD:
        set (HL+).1
JCAFF:
        set (HL+).1
JCB01:
        set (HL+).1
JCB03:
        set (HL+).1
JCB05:
        set (HL+).1
JCB07:
        set (HL+).1
JCB09:
        set (HL+).1
JCB0B:
        set (HL+).1
JCB0D:
        set (HL+).1
JCB0F:
        set (HL+).1
JCB11:
        set (HL+).1
JCB13:
        set (HL+).1
JCB15:
        set (HL+).1
JCB17:
        set (HL+).1
JCB19:
        set (HL+).1
JCB1B:
        set (HL+).1
JCB1D:
        set (HL+).1
JCB1F:
        set (HL+).1
JCB21:
        set (HL+).1
JCB23:
        ret
JCB24:
        set (HL+).2
JCB26:
        set (HL+).2
JCB28:
        set (HL+).2
JCB2A:
        set (HL+).2
JCB2C:
        set (HL+).2
JCB2E:
        set (HL+).2
JCB30:
        set (HL+).2
JCB32:
        set (HL+).2
JCB34:
        set (HL+).2
JCB36:
        set (HL+).2
JCB38:
        set (HL+).2
JCB3A:
        set (HL+).2
JCB3C:
        set (HL+).2
JCB3E:
        set (HL+).2
JCB40:
        set (HL+).2
JCB42:
        set (HL+).2
JCB44:
        set (HL+).2
JCB46:
        set (HL+).2
JCB48:
        set (HL+).2
JCB4A:
        set (HL+).2
JCB4C:
        set (HL+).2
JCB4E:
        set (HL+).2
JCB50:
        set (HL+).2
JCB52:
        set (HL+).2
JCB54:
        set (HL+).2
JCB56:
        set (HL+).2
JCB58:
        set (HL+).2
JCB5A:
        set (HL+).2
JCB5C:
        set (HL+).2
JCB5E:
        set (HL+).2
JCB60:
        set (HL+).2
JCB62:
        set (HL+).2
JCB64:
        set (HL+).2
JCB66:
        ret
JCB67:
        set (HL+).3
JCB69:
        set (HL+).3
JCB6B:
        set (HL+).3
JCB6D:
        set (HL+).3
JCB6F:
        set (HL+).3
JCB71:
        set (HL+).3
JCB73:
        set (HL+).3
JCB75:
        set (HL+).3
JCB77:
        set (HL+).3
JCB79:
        set (HL+).3
JCB7B:
        set (HL+).3
JCB7D:
        set (HL+).3
JCB7F:
        set (HL+).3
JCB81:
        set (HL+).3
JCB83:
        set (HL+).3
JCB85:
        set (HL+).3
JCB87:
        set (HL+).3
JCB89:
        set (HL+).3
JCB8B:
        set (HL+).3
JCB8D:
        set (HL+).3
JCB8F:
        set (HL+).3
JCB91:
        set (HL+).3
JCB93:
        set (HL+).3
JCB95:
        set (HL+).3
JCB97:
        set (HL+).3
JCB99:
        set (HL+).3
JCB9B:
        set (HL+).3
JCB9D:
        set (HL+).3
JCB9F:
        set (HL+).3
JCBA1:
        set (HL+).3
JCBA3:
        set (HL+).3
JCBA5:
        set (HL+).3
JCBA7:
        set (HL+).3
JCBA9:
        ret
JCBAA:
        set (HL+).4
JCBAC:
        set (HL+).4
JCBAE:
        set (HL+).4
JCBB0:
        set (HL+).4
JCBB2:
        set (HL+).4
JCBB4:
        set (HL+).4
JCBB6:
        set (HL+).4
JCBB8:
        set (HL+).4
JCBBA:
        set (HL+).4
JCBBC:
        set (HL+).4
JCBBE:
        set (HL+).4
JCBC0:
        set (HL+).4
JCBC2:
        set (HL+).4
JCBC4:
        set (HL+).4
JCBC6:
        set (HL+).4
JCBC8:
        set (HL+).4
JCBCA:
        set (HL+).4
JCBCC:
        set (HL+).4
JCBCE:
        set (HL+).4
JCBD0:
        set (HL+).4
JCBD2:
        set (HL+).4
JCBD4:
        set (HL+).4
JCBD6:
        set (HL+).4
JCBD8:
        set (HL+).4
JCBDA:
        set (HL+).4
JCBDC:
        set (HL+).4
JCBDE:
        set (HL+).4
JCBE0:
        set (HL+).4
JCBE2:
        set (HL+).4
JCBE4:
        set (HL+).4
JCBE6:
        set (HL+).4
JCBE8:
        set (HL+).4
JCBEA:
        set (HL+).4
JCBEC:
        ret
JCBED:
        set (HL+).5
JCBEF:
        set (HL+).5
JCBF1:
        set (HL+).5
JCBF3:
        set (HL+).5
JCBF5:
        set (HL+).5
JCBF7:
        set (HL+).5
JCBF9:
        set (HL+).5
JCBFB:
        set (HL+).5
JCBFD:
        set (HL+).5
JCBFF:
        set (HL+).5
JCC01:
        set (HL+).5
JCC03:
        set (HL+).5
JCC05:
        set (HL+).5
JCC07:
        set (HL+).5
JCC09:
        set (HL+).5
JCC0B:
        set (HL+).5
JCC0D:
        set (HL+).5
JCC0F:
        set (HL+).5
JCC11:
        set (HL+).5
JCC13:
        set (HL+).5
JCC15:
        set (HL+).5
JCC17:
        set (HL+).5
JCC19:
        set (HL+).5
JCC1B:
        set (HL+).5
JCC1D:
        set (HL+).5
JCC1F:
        set (HL+).5
JCC21:
        set (HL+).5
JCC23:
        set (HL+).5
JCC25:
        set (HL+).5
JCC27:
        set (HL+).5
JCC29:
        set (HL+).5
JCC2B:
        set (HL+).5
JCC2D:
        set (HL+).5
JCC2F:
        ret
JCC30:
        set (HL+).6
JCC32:
        set (HL+).6
JCC34:
        set (HL+).6
JCC36:
        set (HL+).6
JCC38:
        set (HL+).6
JCC3A:
        set (HL+).6
JCC3C:
        set (HL+).6
JCC3E:
        set (HL+).6
JCC40:
        set (HL+).6
JCC42:
        set (HL+).6
JCC44:
        set (HL+).6
JCC46:
        set (HL+).6
JCC48:
        set (HL+).6
JCC4A:
        set (HL+).6
JCC4C:
        set (HL+).6
JCC4E:
        set (HL+).6
JCC50:
        set (HL+).6
JCC52:
        set (HL+).6
JCC54:
        set (HL+).6
JCC56:
        set (HL+).6
JCC58:
        set (HL+).6
JCC5A:
        set (HL+).6
JCC5C:
        set (HL+).6
JCC5E:
        set (HL+).6
JCC60:
        set (HL+).6
JCC62:
        set (HL+).6
JCC64:
        set (HL+).6
JCC66:
        set (HL+).6
JCC68:
        set (HL+).6
JCC6A:
        set (HL+).6
JCC6C:
        set (HL+).6
JCC6E:
        set (HL+).6
JCC70:
        set (HL+).6
JCC72:
        ret
JCC73:
        set (HL+).7
JCC75:
        set (HL+).7
JCC77:
        set (HL+).7
JCC79:
        set (HL+).7
JCC7B:
        set (HL+).7
JCC7D:
        set (HL+).7
JCC7F:
        set (HL+).7
JCC81:
        set (HL+).7
JCC83:
        set (HL+).7
JCC85:
        set (HL+).7
JCC87:
        set (HL+).7
JCC89:
        set (HL+).7
JCC8B:
        set (HL+).7
JCC8D:
        set (HL+).7
JCC8F:
        set (HL+).7
JCC91:
        set (HL+).7
JCC93:
        set (HL+).7
JCC95:
        set (HL+).7
JCC97:
        set (HL+).7
JCC99:
        set (HL+).7
JCC9B:
        set (HL+).7
JCC9D:
        set (HL+).7
JCC9F:
        set (HL+).7
JCCA1:
        set (HL+).7
JCCA3:
        set (HL+).7
JCCA5:
        set (HL+).7
JCCA7:
        set (HL+).7
JCCA9:
        set (HL+).7
JCCAB:
        set (HL+).7
JCCAD:
        set (HL+).7
JCCAF:
        set (HL+).7
JCCB1:
        set (HL+).7
JCCB3:
        set (HL+).7
JCCB5:
        ret
