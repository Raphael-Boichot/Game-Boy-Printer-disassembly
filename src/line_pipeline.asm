; Line pipeline: first column, column preparation for strobe tables A / B, line buffer refill


Line_FirstColumn:
; [C] job start: extract, history, energy codes and heat accumulation for the first column
        call Line_ExtractColumn
        call Line_ColumnHistory
        ld DE,ColumnCodes
        call Line_ColumnEnergy
        ld DE,ColumnCodes
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,L884A
        set (DotMask).0
        jr F,L884C
        cmp (RowHistory),$03
        jr GT,L884C
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,(RowHeat)
        jr L885D
L884A:
        ld A,(IdleCool)
L884C:
        ld HL,(RowHeat)
        test A.7
        jrs T,L885B
        ld W,$FF
        add WA,HL
        jrs T,L8863
        ld WA,$0000
        jrs T,L8863
L885B:
        ld W,$00
L885D:
        add WA,HL
        jrs F,L8863
        ld WA,$FFFF
L8863:
        ld (RowHeat),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,L889A
        set (DotMask).1
        jr F,L889C
        cmp ($A8),$03
        jr GT,L889C
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($B9)
        jr L88AD
L889A:
        ld A,(IdleCool)
L889C:
        ld HL,($B9)
        test A.7
        jrs T,L88AB
        ld W,$FF
        add WA,HL
        jrs T,L88B3
        ld WA,$0000
        jrs T,L88B3
L88AB:
        ld W,$00
L88AD:
        add WA,HL
        jrs F,L88B3
        ld WA,$FFFF
L88B3:
        ld ($B9),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,L88EA
        set (DotMask).2
        jr F,L88EC
        cmp ($A9),$03
        jr GT,L88EC
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($BB)
        jr L88FD
L88EA:
        ld A,(IdleCool)
L88EC:
        ld HL,($BB)
        test A.7
        jrs T,L88FB
        ld W,$FF
        add WA,HL
        jrs T,L8903
        ld WA,$0000
        jrs T,L8903
L88FB:
        ld W,$00
L88FD:
        add WA,HL
        jrs F,L8903
        ld WA,$FFFF
L8903:
        ld ($BB),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,L893A
        set (DotMask).3
        jr F,L893C
        cmp ($AA),$03
        jr GT,L893C
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($BD)
        jr L894D
L893A:
        ld A,(IdleCool)
L893C:
        ld HL,($BD)
        test A.7
        jrs T,L894B
        ld W,$FF
        add WA,HL
        jrs T,L8953
        ld WA,$0000
        jrs T,L8953
L894B:
        ld W,$00
L894D:
        add WA,HL
        jrs F,L8953
        ld WA,$FFFF
L8953:
        ld ($BD),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,L898A
        set (DotMask).4
        jr F,L898C
        cmp ($AB),$03
        jr GT,L898C
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($BF)
        jr L899D
L898A:
        ld A,(IdleCool)
L898C:
        ld HL,($BF)
        test A.7
        jrs T,L899B
        ld W,$FF
        add WA,HL
        jrs T,L89A3
        ld WA,$0000
        jrs T,L89A3
L899B:
        ld W,$00
L899D:
        add WA,HL
        jrs F,L89A3
        ld WA,$FFFF
L89A3:
        ld ($BF),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,L89DA
        set (DotMask).5
        jr F,L89DC
        cmp ($AC),$03
        jr GT,L89DC
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($C1)
        jr L89ED
L89DA:
        ld A,(IdleCool)
L89DC:
        ld HL,($C1)
        test A.7
        jrs T,L89EB
        ld W,$FF
        add WA,HL
        jrs T,L89F3
        ld WA,$0000
        jrs T,L89F3
L89EB:
        ld W,$00
L89ED:
        add WA,HL
        jrs F,L89F3
        ld WA,$FFFF
L89F3:
        ld ($C1),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,L8A2A
        set (DotMask).6
        jr F,L8A2C
        cmp ($AD),$03
        jr GT,L8A2C
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($C3)
        jr L8A3D
L8A2A:
        ld A,(IdleCool)
L8A2C:
        ld HL,($C3)
        test A.7
        jrs T,L8A3B
        ld W,$FF
        add WA,HL
        jrs T,L8A43
        ld WA,$0000
        jrs T,L8A43
L8A3B:
        ld W,$00
L8A3D:
        add WA,HL
        jrs F,L8A43
        ld WA,$FFFF
L8A43:
        ld ($C3),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,L8A7A
        set (DotMask).7
        jr F,L8A7C
        cmp ($AE),$03
        jr GT,L8A7C
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($C5)
        jr L8A8D
L8A7A:
        ld A,(IdleCool)
L8A7C:
        ld HL,($C5)
        test A.7
        jrs T,L8A8B
        ld W,$FF
        add WA,HL
        jrs T,L8A93
        ld WA,$0000
        jrs T,L8A93
L8A8B:
        ld W,$00
L8A8D:
        add WA,HL
        jrs F,L8A93
        ld WA,$FFFF
L8A93:
        ld ($C5),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,L8ACA
        set ($FB).0
        jr F,L8ACC
        cmp ($AF),$03
        jr GT,L8ACC
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($C7)
        jr L8ADD
L8ACA:
        ld A,(IdleCool)
L8ACC:
        ld HL,($C7)
        test A.7
        jrs T,L8ADB
        ld W,$FF
        add WA,HL
        jrs T,L8AE3
        ld WA,$0000
        jrs T,L8AE3
L8ADB:
        ld W,$00
L8ADD:
        add WA,HL
        jrs F,L8AE3
        ld WA,$FFFF
L8AE3:
        ld ($C7),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,L8B1A
        set ($FB).1
        jr F,L8B1C
        cmp ($B0),$03
        jr GT,L8B1C
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($C9)
        jr L8B2D
L8B1A:
        ld A,(IdleCool)
L8B1C:
        ld HL,($C9)
        test A.7
        jrs T,L8B2B
        ld W,$FF
        add WA,HL
        jrs T,L8B33
        ld WA,$0000
        jrs T,L8B33
L8B2B:
        ld W,$00
L8B2D:
        add WA,HL
        jrs F,L8B33
        ld WA,$FFFF
L8B33:
        ld ($C9),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,L8B6A
        set ($FB).2
        jr F,L8B6C
        cmp ($B1),$03
        jr GT,L8B6C
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($CB)
        jr L8B7D
L8B6A:
        ld A,(IdleCool)
L8B6C:
        ld HL,($CB)
        test A.7
        jrs T,L8B7B
        ld W,$FF
        add WA,HL
        jrs T,L8B83
        ld WA,$0000
        jrs T,L8B83
L8B7B:
        ld W,$00
L8B7D:
        add WA,HL
        jrs F,L8B83
        ld WA,$FFFF
L8B83:
        ld ($CB),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,L8BBA
        set ($FB).3
        jr F,L8BBC
        cmp ($B2),$03
        jr GT,L8BBC
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($CD)
        jr L8BCD
L8BBA:
        ld A,(IdleCool)
L8BBC:
        ld HL,($CD)
        test A.7
        jrs T,L8BCB
        ld W,$FF
        add WA,HL
        jrs T,L8BD3
        ld WA,$0000
        jrs T,L8BD3
L8BCB:
        ld W,$00
L8BCD:
        add WA,HL
        jrs F,L8BD3
        ld WA,$FFFF
L8BD3:
        ld ($CD),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,L8C0A
        set ($FB).4
        jr F,L8C0C
        cmp ($B3),$03
        jr GT,L8C0C
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($CF)
        jr L8C1D
L8C0A:
        ld A,(IdleCool)
L8C0C:
        ld HL,($CF)
        test A.7
        jrs T,L8C1B
        ld W,$FF
        add WA,HL
        jrs T,L8C23
        ld WA,$0000
        jrs T,L8C23
L8C1B:
        ld W,$00
L8C1D:
        add WA,HL
        jrs F,L8C23
        ld WA,$FFFF
L8C23:
        ld ($CF),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,L8C5A
        set ($FB).5
        jr F,L8C5C
        cmp ($B4),$03
        jr GT,L8C5C
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($D1)
        jr L8C6D
L8C5A:
        ld A,(IdleCool)
L8C5C:
        ld HL,($D1)
        test A.7
        jrs T,L8C6B
        ld W,$FF
        add WA,HL
        jrs T,L8C73
        ld WA,$0000
        jrs T,L8C73
L8C6B:
        ld W,$00
L8C6D:
        add WA,HL
        jrs F,L8C73
        ld WA,$FFFF
L8C73:
        ld ($D1),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,L8CAA
        set ($FB).6
        jr F,L8CAC
        cmp ($B5),$03
        jr GT,L8CAC
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($D3)
        jr L8CBD
L8CAA:
        ld A,(IdleCool)
L8CAC:
        ld HL,($D3)
        test A.7
        jrs T,L8CBB
        ld W,$FF
        add WA,HL
        jrs T,L8CC3
        ld WA,$0000
        jrs T,L8CC3
L8CBB:
        ld W,$00
L8CBD:
        add WA,HL
        jrs F,L8CC3
        ld WA,$FFFF
L8CC3:
        ld ($D3),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,L8CFA
        set ($FB).7
        jr F,L8CFC
        cmp ($B6),$03
        jr GT,L8CFC
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($D5)
        jr L8D0D
L8CFA:
        ld A,(IdleCool)
L8CFC:
        ld HL,($D5)
        test A.7
        jrs T,L8D0B
        ld W,$FF
        add WA,HL
        jrs T,L8D13
        ld WA,$0000
        jrs T,L8D13
L8D0B:
        ld W,$00
L8D0D:
        add WA,HL
        jrs F,L8D13
        ld WA,$FFFF
L8D13:
        ld ($D5),WA
        inc (TileColumnX)
        cmp (TileColumnX),$08
        jr CC,L8D21
        jp Line_FirstColumn
L8D21:
        ld DE,ColumnCodes
        call StrobeA_Row00
        call StrobeA_Row01
        call StrobeA_Row02
        call StrobeA_Row03
        call StrobeA_Row04
        call StrobeA_Row05
        call StrobeA_Row06
        call StrobeA_Row07
        call StrobeA_Row08
        call StrobeA_Row09
        call StrobeA_Row10
        call StrobeA_Row11
        call StrobeA_Row12
        call StrobeA_Row13
        call StrobeA_Row14
        call StrobeA_Row15
        set (MechFlags).0   ; LineReady
        clr (MechFlags).1   ; LineFetch
        ld A,(MarginBefore)
        jr Z,L8D6F
        ld (MarginBeforeLeft),A
        clr (MarginBefore)
        ld (MechState),$14
        clr (MechFlags).2   ; CamSeen
        clr (MechSubState)
        clr (P5).2
        set (MechFlags).3   ; MechActive
        set (Status).6   ; StBusy
        jr Main_LinePipeline
L8D6F:
        clr (LineCounter)
        ld (MechState),$12
        clr (P5).2
        set (MechFlags).3   ; MechActive
        set (Status).6   ; StBusy

Main_LinePipeline:
; [C] between bursts: refill LineBuf from SRAM when empty, else copy the next tile column and prepare the next column
        ld WA,(LineBufWr)
        ld DE,(LineBufRd)
        cmp WA,DE
        jrs F,L8D86
        jp Main_RefillLineBuf
L8D86:
        test (MechFlags).0   ; LineReady
        jrs T,L8D8C
        jp L9793
L8D8C:
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
        jr CS,L8E17
        ld DE,LineBuf
L8E17:
        ld (LineBufRd),DE
        clr (TileColumnX)

Line_NextColumnA:
; [I] same chain as Line_FirstColumn, unrolled, for the next column (strobe tables A)
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
        jr Z,L8F03
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
L8EE8:
        ld A,(HL)
        cmp A,$03
        jrs F,L8EEF
        ld (HL+),B
        jrs T,L8EFD
L8EEF:
        cmp A,$02
        jrs F,L8EF5
        ld (HL+),C
        jrs T,L8EFD
L8EF5:
        cmp A,$01
        jrs F,L8EFB
        ld (HL+),D
        jrs T,L8EFD
L8EFB:
        ld (HL+),E
L8EFD:
        cmp HL,$0096
        jr LE,L8EE8
L8F03:
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
        ld DE,ColumnCodes
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
        jrs F,L8FE6
        add A,W
        cmp A,$64
        jr LE,L8FEB
        ld A,$64
        jrs T,L8FEB
L8FE6:
        add A,W
        jrs T,L8FEB
        ld A,$00
L8FEB:
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
        jrs F,L9012
        add A,W
        cmp A,$64
        jr LE,L9017
        ld A,$64
        jrs T,L9017
L9012:
        add A,W
        jrs T,L9017
        ld A,$00
L9017:
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
        jrs F,L903E
        add A,W
        cmp A,$64
        jr LE,L9043
        ld A,$64
        jrs T,L9043
L903E:
        add A,W
        jrs T,L9043
        ld A,$00
L9043:
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
        jrs F,L906A
        add A,W
        cmp A,$64
        jr LE,L906F
        ld A,$64
        jrs T,L906F
L906A:
        add A,W
        jrs T,L906F
        ld A,$00
L906F:
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
        jrs F,L9096
        add A,W
        cmp A,$64
        jr LE,L909B
        ld A,$64
        jrs T,L909B
L9096:
        add A,W
        jrs T,L909B
        ld A,$00
L909B:
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
        jrs F,L90C2
        add A,W
        cmp A,$64
        jr LE,L90C7
        ld A,$64
        jrs T,L90C7
L90C2:
        add A,W
        jrs T,L90C7
        ld A,$00
L90C7:
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
        jrs F,L90EE
        add A,W
        cmp A,$64
        jr LE,L90F3
        ld A,$64
        jrs T,L90F3
L90EE:
        add A,W
        jrs T,L90F3
        ld A,$00
L90F3:
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
        jrs F,L911A
        add A,W
        cmp A,$64
        jr LE,L911F
        ld A,$64
        jrs T,L911F
L911A:
        add A,W
        jrs T,L911F
        ld A,$00
L911F:
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
        jrs F,L9146
        add A,W
        cmp A,$64
        jr LE,L914B
        ld A,$64
        jrs T,L914B
L9146:
        add A,W
        jrs T,L914B
        ld A,$00
L914B:
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
        jrs F,L9172
        add A,W
        cmp A,$64
        jr LE,L9177
        ld A,$64
        jrs T,L9177
L9172:
        add A,W
        jrs T,L9177
        ld A,$00
L9177:
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
        jrs F,L919E
        add A,W
        cmp A,$64
        jr LE,L91A3
        ld A,$64
        jrs T,L91A3
L919E:
        add A,W
        jrs T,L91A3
        ld A,$00
L91A3:
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
        jrs F,L91CA
        add A,W
        cmp A,$64
        jr LE,L91CF
        ld A,$64
        jrs T,L91CF
L91CA:
        add A,W
        jrs T,L91CF
        ld A,$00
L91CF:
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
        jrs F,L91F6
        add A,W
        cmp A,$64
        jr LE,L91FB
        ld A,$64
        jrs T,L91FB
L91F6:
        add A,W
        jrs T,L91FB
        ld A,$00
L91FB:
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
        jrs F,L9222
        add A,W
        cmp A,$64
        jr LE,L9227
        ld A,$64
        jrs T,L9227
L9222:
        add A,W
        jrs T,L9227
        ld A,$00
L9227:
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
        jrs F,L924E
        add A,W
        cmp A,$64
        jr LE,L9253
        ld A,$64
        jrs T,L9253
L924E:
        add A,W
        jrs T,L9253
        ld A,$00
L9253:
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
        jrs F,L927A
        add A,W
        cmp A,$64
        jr LE,L927F
        ld A,$64
        jrs T,L927F
L927A:
        add A,W
        jrs T,L927F
        ld A,$00
L927F:
        ld (DE),A
        ld DE,ColumnCodes
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,L92B7
        set (DotMask).0
        jr F,L92B9
        cmp (RowHistory),$03
        jr GT,L92B9
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,(RowHeat)
        jr L92CA
L92B7:
        ld A,(IdleCool)
L92B9:
        ld HL,(RowHeat)
        test A.7
        jrs T,L92C8
        ld W,$FF
        add WA,HL
        jrs T,L92D0
        ld WA,$0000
        jrs T,L92D0
L92C8:
        ld W,$00
L92CA:
        add WA,HL
        jrs F,L92D0
        ld WA,$FFFF
L92D0:
        ld (RowHeat),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,L9307
        set (DotMask).1
        jr F,L9309
        cmp ($A8),$03
        jr GT,L9309
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($B9)
        jr L931A
L9307:
        ld A,(IdleCool)
L9309:
        ld HL,($B9)
        test A.7
        jrs T,L9318
        ld W,$FF
        add WA,HL
        jrs T,L9320
        ld WA,$0000
        jrs T,L9320
L9318:
        ld W,$00
L931A:
        add WA,HL
        jrs F,L9320
        ld WA,$FFFF
L9320:
        ld ($B9),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,L9357
        set (DotMask).2
        jr F,L9359
        cmp ($A9),$03
        jr GT,L9359
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($BB)
        jr L936A
L9357:
        ld A,(IdleCool)
L9359:
        ld HL,($BB)
        test A.7
        jrs T,L9368
        ld W,$FF
        add WA,HL
        jrs T,L9370
        ld WA,$0000
        jrs T,L9370
L9368:
        ld W,$00
L936A:
        add WA,HL
        jrs F,L9370
        ld WA,$FFFF
L9370:
        ld ($BB),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,L93A7
        set (DotMask).3
        jr F,L93A9
        cmp ($AA),$03
        jr GT,L93A9
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($BD)
        jr L93BA
L93A7:
        ld A,(IdleCool)
L93A9:
        ld HL,($BD)
        test A.7
        jrs T,L93B8
        ld W,$FF
        add WA,HL
        jrs T,L93C0
        ld WA,$0000
        jrs T,L93C0
L93B8:
        ld W,$00
L93BA:
        add WA,HL
        jrs F,L93C0
        ld WA,$FFFF
L93C0:
        ld ($BD),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,L93F7
        set (DotMask).4
        jr F,L93F9
        cmp ($AB),$03
        jr GT,L93F9
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($BF)
        jr L940A
L93F7:
        ld A,(IdleCool)
L93F9:
        ld HL,($BF)
        test A.7
        jrs T,L9408
        ld W,$FF
        add WA,HL
        jrs T,L9410
        ld WA,$0000
        jrs T,L9410
L9408:
        ld W,$00
L940A:
        add WA,HL
        jrs F,L9410
        ld WA,$FFFF
L9410:
        ld ($BF),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,L9447
        set (DotMask).5
        jr F,L9449
        cmp ($AC),$03
        jr GT,L9449
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($C1)
        jr L945A
L9447:
        ld A,(IdleCool)
L9449:
        ld HL,($C1)
        test A.7
        jrs T,L9458
        ld W,$FF
        add WA,HL
        jrs T,L9460
        ld WA,$0000
        jrs T,L9460
L9458:
        ld W,$00
L945A:
        add WA,HL
        jrs F,L9460
        ld WA,$FFFF
L9460:
        ld ($C1),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,L9497
        set (DotMask).6
        jr F,L9499
        cmp ($AD),$03
        jr GT,L9499
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($C3)
        jr L94AA
L9497:
        ld A,(IdleCool)
L9499:
        ld HL,($C3)
        test A.7
        jrs T,L94A8
        ld W,$FF
        add WA,HL
        jrs T,L94B0
        ld WA,$0000
        jrs T,L94B0
L94A8:
        ld W,$00
L94AA:
        add WA,HL
        jrs F,L94B0
        ld WA,$FFFF
L94B0:
        ld ($C3),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,L94E7
        set (DotMask).7
        jr F,L94E9
        cmp ($AE),$03
        jr GT,L94E9
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($C5)
        jr L94FA
L94E7:
        ld A,(IdleCool)
L94E9:
        ld HL,($C5)
        test A.7
        jrs T,L94F8
        ld W,$FF
        add WA,HL
        jrs T,L9500
        ld WA,$0000
        jrs T,L9500
L94F8:
        ld W,$00
L94FA:
        add WA,HL
        jrs F,L9500
        ld WA,$FFFF
L9500:
        ld ($C5),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,L9537
        set ($FB).0
        jr F,L9539
        cmp ($AF),$03
        jr GT,L9539
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($C7)
        jr L954A
L9537:
        ld A,(IdleCool)
L9539:
        ld HL,($C7)
        test A.7
        jrs T,L9548
        ld W,$FF
        add WA,HL
        jrs T,L9550
        ld WA,$0000
        jrs T,L9550
L9548:
        ld W,$00
L954A:
        add WA,HL
        jrs F,L9550
        ld WA,$FFFF
L9550:
        ld ($C7),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,L9587
        set ($FB).1
        jr F,L9589
        cmp ($B0),$03
        jr GT,L9589
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($C9)
        jr L959A
L9587:
        ld A,(IdleCool)
L9589:
        ld HL,($C9)
        test A.7
        jrs T,L9598
        ld W,$FF
        add WA,HL
        jrs T,L95A0
        ld WA,$0000
        jrs T,L95A0
L9598:
        ld W,$00
L959A:
        add WA,HL
        jrs F,L95A0
        ld WA,$FFFF
L95A0:
        ld ($C9),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,L95D7
        set ($FB).2
        jr F,L95D9
        cmp ($B1),$03
        jr GT,L95D9
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($CB)
        jr L95EA
L95D7:
        ld A,(IdleCool)
L95D9:
        ld HL,($CB)
        test A.7
        jrs T,L95E8
        ld W,$FF
        add WA,HL
        jrs T,L95F0
        ld WA,$0000
        jrs T,L95F0
L95E8:
        ld W,$00
L95EA:
        add WA,HL
        jrs F,L95F0
        ld WA,$FFFF
L95F0:
        ld ($CB),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,L9627
        set ($FB).3
        jr F,L9629
        cmp ($B2),$03
        jr GT,L9629
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($CD)
        jr L963A
L9627:
        ld A,(IdleCool)
L9629:
        ld HL,($CD)
        test A.7
        jrs T,L9638
        ld W,$FF
        add WA,HL
        jrs T,L9640
        ld WA,$0000
        jrs T,L9640
L9638:
        ld W,$00
L963A:
        add WA,HL
        jrs F,L9640
        ld WA,$FFFF
L9640:
        ld ($CD),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,L9677
        set ($FB).4
        jr F,L9679
        cmp ($B3),$03
        jr GT,L9679
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($CF)
        jr L968A
L9677:
        ld A,(IdleCool)
L9679:
        ld HL,($CF)
        test A.7
        jrs T,L9688
        ld W,$FF
        add WA,HL
        jrs T,L9690
        ld WA,$0000
        jrs T,L9690
L9688:
        ld W,$00
L968A:
        add WA,HL
        jrs F,L9690
        ld WA,$FFFF
L9690:
        ld ($CF),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,L96C7
        set ($FB).5
        jr F,L96C9
        cmp ($B4),$03
        jr GT,L96C9
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($D1)
        jr L96DA
L96C7:
        ld A,(IdleCool)
L96C9:
        ld HL,($D1)
        test A.7
        jrs T,L96D8
        ld W,$FF
        add WA,HL
        jrs T,L96E0
        ld WA,$0000
        jrs T,L96E0
L96D8:
        ld W,$00
L96DA:
        add WA,HL
        jrs F,L96E0
        ld WA,$FFFF
L96E0:
        ld ($D1),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,L9717
        set ($FB).6
        jr F,L9719
        cmp ($B5),$03
        jr GT,L9719
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($D3)
        jr L972A
L9717:
        ld A,(IdleCool)
L9719:
        ld HL,($D3)
        test A.7
        jrs T,L9728
        ld W,$FF
        add WA,HL
        jrs T,L9730
        ld WA,$0000
        jrs T,L9730
L9728:
        ld W,$00
L972A:
        add WA,HL
        jrs F,L9730
        ld WA,$FFFF
L9730:
        ld ($D3),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,L9767
        set ($FB).7
        jr F,L9769
        cmp ($B6),$03
        jr GT,L9769
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($D5)
        jr L977A
L9767:
        ld A,(IdleCool)
L9769:
        ld HL,($D5)
        test A.7
        jrs T,L9778
        ld W,$FF
        add WA,HL
        jrs T,L9780
        ld WA,$0000
        jrs T,L9780
L9778:
        ld W,$00
L977A:
        add WA,HL
        jrs F,L9780
        ld WA,$FFFF
L9780:
        ld ($D5),WA
        inc (TileColumnX)
        cmp (TileColumnX),$08
        jr CC,L978E
        jp Line_NextColumnA
L978E:
        set (MechFlags).0   ; LineReady
        jp Line_TileColumnDone
L9793:
        test (MechFlags).1   ; LineFetch
        jrs T,L9799
        jp Main_RefillLineBuf
L9799:
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
        jr CS,L9824
        ld DE,LineBuf
L9824:
        ld (LineBufRd),DE
        clr (TileColumnX)

Line_NextColumnB:
; [I] same chain for the strobe tables B
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
        jr Z,L9910
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
L98F5:
        ld A,(HL)
        cmp A,$03
        jrs F,L98FC
        ld (HL+),B
        jrs T,L990A
L98FC:
        cmp A,$02
        jrs F,L9902
        ld (HL+),C
        jrs T,L990A
L9902:
        cmp A,$01
        jrs F,L9908
        ld (HL+),D
        jrs T,L990A
L9908:
        ld (HL+),E
L990A:
        cmp HL,$0096
        jr LE,L98F5
L9910:
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
        ld DE,$02E0
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
        jrs F,L99F3
        add A,W
        cmp A,$64
        jr LE,L99F8
        ld A,$64
        jrs T,L99F8
L99F3:
        add A,W
        jrs T,L99F8
        ld A,$00
L99F8:
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
        jrs F,L9A1F
        add A,W
        cmp A,$64
        jr LE,L9A24
        ld A,$64
        jrs T,L9A24
L9A1F:
        add A,W
        jrs T,L9A24
        ld A,$00
L9A24:
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
        jrs F,L9A4B
        add A,W
        cmp A,$64
        jr LE,L9A50
        ld A,$64
        jrs T,L9A50
L9A4B:
        add A,W
        jrs T,L9A50
        ld A,$00
L9A50:
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
        jrs F,L9A77
        add A,W
        cmp A,$64
        jr LE,L9A7C
        ld A,$64
        jrs T,L9A7C
L9A77:
        add A,W
        jrs T,L9A7C
        ld A,$00
L9A7C:
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
        jrs F,L9AA3
        add A,W
        cmp A,$64
        jr LE,L9AA8
        ld A,$64
        jrs T,L9AA8
L9AA3:
        add A,W
        jrs T,L9AA8
        ld A,$00
L9AA8:
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
        jrs F,L9ACF
        add A,W
        cmp A,$64
        jr LE,L9AD4
        ld A,$64
        jrs T,L9AD4
L9ACF:
        add A,W
        jrs T,L9AD4
        ld A,$00
L9AD4:
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
        jrs F,L9AFB
        add A,W
        cmp A,$64
        jr LE,L9B00
        ld A,$64
        jrs T,L9B00
L9AFB:
        add A,W
        jrs T,L9B00
        ld A,$00
L9B00:
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
        jrs F,L9B27
        add A,W
        cmp A,$64
        jr LE,L9B2C
        ld A,$64
        jrs T,L9B2C
L9B27:
        add A,W
        jrs T,L9B2C
        ld A,$00
L9B2C:
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
        jrs F,L9B53
        add A,W
        cmp A,$64
        jr LE,L9B58
        ld A,$64
        jrs T,L9B58
L9B53:
        add A,W
        jrs T,L9B58
        ld A,$00
L9B58:
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
        jrs F,L9B7F
        add A,W
        cmp A,$64
        jr LE,L9B84
        ld A,$64
        jrs T,L9B84
L9B7F:
        add A,W
        jrs T,L9B84
        ld A,$00
L9B84:
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
        jrs F,L9BAB
        add A,W
        cmp A,$64
        jr LE,L9BB0
        ld A,$64
        jrs T,L9BB0
L9BAB:
        add A,W
        jrs T,L9BB0
        ld A,$00
L9BB0:
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
        jrs F,L9BD7
        add A,W
        cmp A,$64
        jr LE,L9BDC
        ld A,$64
        jrs T,L9BDC
L9BD7:
        add A,W
        jrs T,L9BDC
        ld A,$00
L9BDC:
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
        jrs F,L9C03
        add A,W
        cmp A,$64
        jr LE,L9C08
        ld A,$64
        jrs T,L9C08
L9C03:
        add A,W
        jrs T,L9C08
        ld A,$00
L9C08:
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
        jrs F,L9C2F
        add A,W
        cmp A,$64
        jr LE,L9C34
        ld A,$64
        jrs T,L9C34
L9C2F:
        add A,W
        jrs T,L9C34
        ld A,$00
L9C34:
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
        jrs F,L9C5B
        add A,W
        cmp A,$64
        jr LE,L9C60
        ld A,$64
        jrs T,L9C60
L9C5B:
        add A,W
        jrs T,L9C60
        ld A,$00
L9C60:
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
        jrs F,L9C87
        add A,W
        cmp A,$64
        jr LE,L9C8C
        ld A,$64
        jrs T,L9C8C
L9C87:
        add A,W
        jrs T,L9C8C
        ld A,$00
L9C8C:
        ld (DE),A
        ld DE,$02E0
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,L9CC4
        set (DotMask).0
        jr F,L9CC6
        cmp (RowHistory),$03
        jr GT,L9CC6
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,(RowHeat)
        jr L9CD7
L9CC4:
        ld A,(IdleCool)
L9CC6:
        ld HL,(RowHeat)
        test A.7
        jrs T,L9CD5
        ld W,$FF
        add WA,HL
        jrs T,L9CDD
        ld WA,$0000
        jrs T,L9CDD
L9CD5:
        ld W,$00
L9CD7:
        add WA,HL
        jrs F,L9CDD
        ld WA,$FFFF
L9CDD:
        ld (RowHeat),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,L9D14
        set (DotMask).1
        jr F,L9D16
        cmp ($A8),$03
        jr GT,L9D16
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($B9)
        jr L9D27
L9D14:
        ld A,(IdleCool)
L9D16:
        ld HL,($B9)
        test A.7
        jrs T,L9D25
        ld W,$FF
        add WA,HL
        jrs T,L9D2D
        ld WA,$0000
        jrs T,L9D2D
L9D25:
        ld W,$00
L9D27:
        add WA,HL
        jrs F,L9D2D
        ld WA,$FFFF
L9D2D:
        ld ($B9),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,L9D64
        set (DotMask).2
        jr F,L9D66
        cmp ($A9),$03
        jr GT,L9D66
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($BB)
        jr L9D77
L9D64:
        ld A,(IdleCool)
L9D66:
        ld HL,($BB)
        test A.7
        jrs T,L9D75
        ld W,$FF
        add WA,HL
        jrs T,L9D7D
        ld WA,$0000
        jrs T,L9D7D
L9D75:
        ld W,$00
L9D77:
        add WA,HL
        jrs F,L9D7D
        ld WA,$FFFF
L9D7D:
        ld ($BB),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,L9DB4
        set (DotMask).3
        jr F,L9DB6
        cmp ($AA),$03
        jr GT,L9DB6
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($BD)
        jr L9DC7
L9DB4:
        ld A,(IdleCool)
L9DB6:
        ld HL,($BD)
        test A.7
        jrs T,L9DC5
        ld W,$FF
        add WA,HL
        jrs T,L9DCD
        ld WA,$0000
        jrs T,L9DCD
L9DC5:
        ld W,$00
L9DC7:
        add WA,HL
        jrs F,L9DCD
        ld WA,$FFFF
L9DCD:
        ld ($BD),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,L9E04
        set (DotMask).4
        jr F,L9E06
        cmp ($AB),$03
        jr GT,L9E06
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($BF)
        jr L9E17
L9E04:
        ld A,(IdleCool)
L9E06:
        ld HL,($BF)
        test A.7
        jrs T,L9E15
        ld W,$FF
        add WA,HL
        jrs T,L9E1D
        ld WA,$0000
        jrs T,L9E1D
L9E15:
        ld W,$00
L9E17:
        add WA,HL
        jrs F,L9E1D
        ld WA,$FFFF
L9E1D:
        ld ($BF),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,L9E54
        set (DotMask).5
        jr F,L9E56
        cmp ($AC),$03
        jr GT,L9E56
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($C1)
        jr L9E67
L9E54:
        ld A,(IdleCool)
L9E56:
        ld HL,($C1)
        test A.7
        jrs T,L9E65
        ld W,$FF
        add WA,HL
        jrs T,L9E6D
        ld WA,$0000
        jrs T,L9E6D
L9E65:
        ld W,$00
L9E67:
        add WA,HL
        jrs F,L9E6D
        ld WA,$FFFF
L9E6D:
        ld ($C1),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,L9EA4
        set (DotMask).6
        jr F,L9EA6
        cmp ($AD),$03
        jr GT,L9EA6
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($C3)
        jr L9EB7
L9EA4:
        ld A,(IdleCool)
L9EA6:
        ld HL,($C3)
        test A.7
        jrs T,L9EB5
        ld W,$FF
        add WA,HL
        jrs T,L9EBD
        ld WA,$0000
        jrs T,L9EBD
L9EB5:
        ld W,$00
L9EB7:
        add WA,HL
        jrs F,L9EBD
        ld WA,$FFFF
L9EBD:
        ld ($C3),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,L9EF4
        set (DotMask).7
        jr F,L9EF6
        cmp ($AE),$03
        jr GT,L9EF6
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($C5)
        jr L9F07
L9EF4:
        ld A,(IdleCool)
L9EF6:
        ld HL,($C5)
        test A.7
        jrs T,L9F05
        ld W,$FF
        add WA,HL
        jrs T,L9F0D
        ld WA,$0000
        jrs T,L9F0D
L9F05:
        ld W,$00
L9F07:
        add WA,HL
        jrs F,L9F0D
        ld WA,$FFFF
L9F0D:
        ld ($C5),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,L9F44
        set ($FB).0
        jr F,L9F46
        cmp ($AF),$03
        jr GT,L9F46
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($C7)
        jr L9F57
L9F44:
        ld A,(IdleCool)
L9F46:
        ld HL,($C7)
        test A.7
        jrs T,L9F55
        ld W,$FF
        add WA,HL
        jrs T,L9F5D
        ld WA,$0000
        jrs T,L9F5D
L9F55:
        ld W,$00
L9F57:
        add WA,HL
        jrs F,L9F5D
        ld WA,$FFFF
L9F5D:
        ld ($C7),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,L9F94
        set ($FB).1
        jr F,L9F96
        cmp ($B0),$03
        jr GT,L9F96
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($C9)
        jr L9FA7
L9F94:
        ld A,(IdleCool)
L9F96:
        ld HL,($C9)
        test A.7
        jrs T,L9FA5
        ld W,$FF
        add WA,HL
        jrs T,L9FAD
        ld WA,$0000
        jrs T,L9FAD
L9FA5:
        ld W,$00
L9FA7:
        add WA,HL
        jrs F,L9FAD
        ld WA,$FFFF
L9FAD:
        ld ($C9),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,L9FE4
        set ($FB).2
        jr F,L9FE6
        cmp ($B1),$03
        jr GT,L9FE6
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($CB)
        jr L9FF7
L9FE4:
        ld A,(IdleCool)
L9FE6:
        ld HL,($CB)
        test A.7
        jrs T,L9FF5
        ld W,$FF
        add WA,HL
        jrs T,L9FFD
        ld WA,$0000
        jrs T,L9FFD
L9FF5:
        ld W,$00
L9FF7:
        add WA,HL
        jrs F,L9FFD
        ld WA,$FFFF
L9FFD:
        ld ($CB),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,LA034
        set ($FB).3
        jr F,LA036
        cmp ($B2),$03
        jr GT,LA036
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($CD)
        jr LA047
LA034:
        ld A,(IdleCool)
LA036:
        ld HL,($CD)
        test A.7
        jrs T,LA045
        ld W,$FF
        add WA,HL
        jrs T,LA04D
        ld WA,$0000
        jrs T,LA04D
LA045:
        ld W,$00
LA047:
        add WA,HL
        jrs F,LA04D
        ld WA,$FFFF
LA04D:
        ld ($CD),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,LA084
        set ($FB).4
        jr F,LA086
        cmp ($B3),$03
        jr GT,LA086
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($CF)
        jr LA097
LA084:
        ld A,(IdleCool)
LA086:
        ld HL,($CF)
        test A.7
        jrs T,LA095
        ld W,$FF
        add WA,HL
        jrs T,LA09D
        ld WA,$0000
        jrs T,LA09D
LA095:
        ld W,$00
LA097:
        add WA,HL
        jrs F,LA09D
        ld WA,$FFFF
LA09D:
        ld ($CF),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,LA0D4
        set ($FB).5
        jr F,LA0D6
        cmp ($B4),$03
        jr GT,LA0D6
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($D1)
        jr LA0E7
LA0D4:
        ld A,(IdleCool)
LA0D6:
        ld HL,($D1)
        test A.7
        jrs T,LA0E5
        ld W,$FF
        add WA,HL
        jrs T,LA0ED
        ld WA,$0000
        jrs T,LA0ED
LA0E5:
        ld W,$00
LA0E7:
        add WA,HL
        jrs F,LA0ED
        ld WA,$FFFF
LA0ED:
        ld ($D1),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,LA124
        set ($FB).6
        jr F,LA126
        cmp ($B5),$03
        jr GT,LA126
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($D3)
        jr LA137
LA124:
        ld A,(IdleCool)
LA126:
        ld HL,($D3)
        test A.7
        jrs T,LA135
        ld W,$FF
        add WA,HL
        jrs T,LA13D
        ld WA,$0000
        jrs T,LA13D
LA135:
        ld W,$00
LA137:
        add WA,HL
        jrs F,LA13D
        ld WA,$FFFF
LA13D:
        ld ($D3),WA
        inc DE
        ld A,(TileColumnX)
        swap A
        ld W,$00
        add WA,DE
        ld HL,WA
        ld C,(HL)
        ld HL,Tab_HeatAddByCode
        ld A,(HL+C)
        jr Z,LA174
        set ($FB).7
        jr F,LA176
        cmp ($B6),$03
        jr GT,LA176
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        ld WA,Tab_HeatAddFreshByTemp
        add WA,BC
        ld HL,WA
        ld WA,(HL)
        ld HL,($D5)
        jr LA187
LA174:
        ld A,(IdleCool)
LA176:
        ld HL,($D5)
        test A.7
        jrs T,LA185
        ld W,$FF
        add WA,HL
        jrs T,LA18D
        ld WA,$0000
        jrs T,LA18D
LA185:
        ld W,$00
LA187:
        add WA,HL
        jrs F,LA18D
        ld WA,$FFFF
LA18D:
        ld ($D5),WA
        inc (TileColumnX)
        cmp (TileColumnX),$08
        jr CC,LA19B
        jp Line_NextColumnB
LA19B:
        set (MechFlags).1   ; LineFetch

Line_TileColumnDone:
; [C] after 8 pixel columns: next tile column; after 20, a new band
        dec (TileColumnsLeft)
        jr Z,Heat_BandStart
        jp Main_RefillLineBuf

Heat_BandStart:
; [C] new band: clear RowHistory, RowHeat -= Tab_BandCoolByTemp[temperature]
        ld (TileColumnsLeft),$14
        clr (RowHistory)
        clr ($A8)
        clr ($A9)
        clr ($AA)
        clr ($AB)
        clr ($AC)
        clr ($AD)
        clr ($AE)
        clr ($AF)
        clr ($B0)
        clr ($B1)
        clr ($B2)
        clr ($B3)
        clr ($B4)
        clr ($B5)
        clr ($B6)
        ld WA,Tab_BandCoolByTemp
        ld C,(TempAdc)
        ld B,$00
        shlc C
        rolc B
        add WA,BC
        ld HL,WA
        ld BC,(HL)
        ld WA,(RowHeat)
        sub WA,BC
        jrs F,LA1E2
        ld WA,$0000
LA1E2:
        ld (RowHeat),WA
        ld WA,($B9)
        sub WA,BC
        jrs F,LA1EE
        ld WA,$0000
LA1EE:
        ld ($B9),WA
        ld WA,($BB)
        sub WA,BC
        jrs F,LA1FA
        ld WA,$0000
LA1FA:
        ld ($BB),WA
        ld WA,($BD)
        sub WA,BC
        jrs F,LA206
        ld WA,$0000
LA206:
        ld ($BD),WA
        ld WA,($BF)
        sub WA,BC
        jrs F,LA212
        ld WA,$0000
LA212:
        ld ($BF),WA
        ld WA,($C1)
        sub WA,BC
        jrs F,LA21E
        ld WA,$0000
LA21E:
        ld ($C1),WA
        ld WA,($C3)
        sub WA,BC
        jrs F,LA22A
        ld WA,$0000
LA22A:
        ld ($C3),WA
        ld WA,($C5)
        sub WA,BC
        jrs F,LA236
        ld WA,$0000
LA236:
        ld ($C5),WA
        ld WA,($C7)
        sub WA,BC
        jrs F,LA242
        ld WA,$0000
LA242:
        ld ($C7),WA
        ld WA,($C9)
        sub WA,BC
        jrs F,LA24E
        ld WA,$0000
LA24E:
        ld ($C9),WA
        ld WA,($CB)
        sub WA,BC
        jrs F,LA25A
        ld WA,$0000
LA25A:
        ld ($CB),WA
        ld WA,($CD)
        sub WA,BC
        jrs F,LA266
        ld WA,$0000
LA266:
        ld ($CD),WA
        ld WA,($CF)
        sub WA,BC
        jrs F,LA272
        ld WA,$0000
LA272:
        ld ($CF),WA
        ld WA,($D1)
        sub WA,BC
        jrs F,LA27E
        ld WA,$0000
LA27E:
        ld ($D1),WA
        ld WA,($D3)
        sub WA,BC
        jrs F,LA28A
        ld WA,$0000
LA28A:
        ld ($D3),WA
        ld WA,($D5)
        sub WA,BC
        jrs F,LA296
        ld WA,$0000
LA296:
        ld ($D5),WA
        ldw (DotMask),$0000

Main_RefillLineBuf:
; [C] copy 32-byte chunks from SRAM into LineBuf while printing
        test (MechFlags).6   ; LineBufFill
        jr T,LA2E9
        ld WA,(PrintReadPos)
        ld HL,(ImageBytes)
        cmp WA,HL
        jr CC,LA2EB
        ld WA,(LineBufWr)
        ld HL,(LineBufRd)
        cmp WA,HL
        jr T,LA2CA
        jr CC,LA2C2
        xch WA,HL
        sub WA,HL
        cmp WA,$0040
        jr CS,LA2E9
        jrs T,LA2CA
LA2C2:
        sub WA,HL
        cmp WA,$0100
        jr CC,LA2E9
LA2CA:
        ld HL,(LineBufWr)
        ld BC,(PrintReadPos)
        ld E,$1F
LA2D2:
        call Sram_Read
        ld (HL+),A
        inc BC
        dec E
        jrs F,LA2D2
        ld (PrintReadPos),BC
        cmp HL,$0240
        jr CS,LA2E6
        ld HL,LineBuf
LA2E6:
        ld (LineBufWr),HL
LA2E9:
        jr Data_Main
LA2EB:
        clr (MechFlags).6   ; LineBufFill
