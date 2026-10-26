; Strobe timer, battery check, button / cam / encoder interrupts and the mechanism states


Int_TC1_StrobeTick:
; [C] TC1: write the next tick bytes to P0/P1; after 33 ticks stop TC1, sample battery
        ld RBS,1
        inc B
        jrs T,LAA8E
        ld WA,$0000
        xch A,(HL+)
        xch W,(DE)
        ld (P0),WA
        inc DE
        reti
LAA8E:
        ld (TC1CR),$08
        ldw (P0),$0000
        test (JobFlags).7   ; BattSample
        jrs F,LAA99
        reti
LAA99:
        clr (JobFlags).7   ; BattSample
        ld (ADCCR),$01
        set (ADCCR).6
LAAA0:
        test (ADCCR).7
        jrs T,LAAA0
        ld A,(ADCDR)
        cmp A,$9C
        jr GT,LAABF
        cmp A,$7E
        jr LE,LAAB9
        ld HL,BattAtStart
        ld W,(HL)
        sub W,A
        cmp W,$08
        jr CS,LAABF
LAAB9:
        set (P5).2
        set (Status).0   ; StLowBattery
        clr (P5).3
LAABF:
        reti

Int_TC3_BatteryCheck:
; [C] TC3: battery reading under load
        ldw (EIR),$2001
        ld (TC3CR),$08
        ld (ADCCR),$01
        set (ADCCR).6
LAACC:
        test (ADCCR).7
        jrs T,LAACC
        cmp (ADCDR),$7E
        jr GT,LAADD
        ldw (P0),$0000
        set (Status).0   ; StLowBattery
        set (RxFlags).1   ; LowBatHold
LAADD:
        clr (JobFlags).5   ; BattCheckDue
        di
        ldw (EIR),$FD10
        reti

Int_INT5_ButtonWake:
; [I] bare reti: the front button (P20 = INT5 pin) is enabled as an interrupt only to wake the CPU from IDLE
        reti

Int_INT4_CamSensor:
; [C] cam sensor rising edge: MechFlags.CamSeen
        test (P5).1
        jrs T,LAAEC
        set (MechFlags).2   ; CamSeen
LAAEC:
        reti

Int_INT3_Encoder:
; [C] encoder pulse: start a strobe burst, then run the mechanism state
        ld RBS,2
        test (P5).0
        jrs T,LAAF3
        reti
LAAF3:
        add (MechRequests),$20
        jrs F,LAAFA
        set (SysFlags).3   ; CamChange
LAAFA:
        set (MechFlags).5   ; EncoderSeen
        ld A,(MechState)
        jr Z,Mech_Dispatch
        cmp A,$10
        jr LE,LAB1A
        test (JobFlags).3   ; BreakReq
        jr T,Mech_Dispatch
        cmp A,$18
        jr T,Mech_Dispatch
        clr (MechFlags).2   ; CamSeen
        clr (MechSubState)
        ld (MechState),$18
        di
        ldw (EIR),$FD10
        reti
LAB1A:
        ld RBS,1
        ld B,$DF
        cpl (MechFlags).4   ; StrobeBufB
        jrs F,LAB29
        ld HL,StrobeA_P0
        ld DE,StrobeA_P1
        jrs T,LAB2F
LAB29:
        ld HL,StrobeB_P0
        ld DE,StrobeB_P1
LAB2F:
        ld WA,$0000
        xch A,(HL+)
        xch W,(DE)
        ld (P0),WA
        inc DE
        ld RBS,2
        ld DE,HeatCurvePtr
        ld HL,(DE)
        ld C,(LineCounter)
        dec C
        ld A,(HL+C)
        ld HL,HeatSoak
        ld C,(HL)
        ld HL,Tab_TickTrimBySoak
        sub A,(HL+C)
        ld W,$00
        ld (TREG1A),WA
        ld (TC1CR),$18
        ldw (EIR),$2011
        ld (TC3CR),$18
        ld A,(MechState)

Mech_Dispatch:
; [C] jump through the state table with MechState
        shlc A
        jp (PC+A)
        dw Mech_State00_Idle
        dw Mech_State01_Column
        dw Mech_State02_Column
        dw Mech_State03_Column
        dw Mech_State04_Column
        dw Mech_State05_Column
        dw Mech_State06_Column
        dw Mech_State07_Column
        dw Mech_State08_Column
        dw Mech_State09_Column
        dw Mech_State0A_Column
        dw Mech_State0B_Column
        dw Mech_State0C_Column
        dw Mech_State0D_Column
        dw Mech_State0E_Column
        dw Mech_State0F_Column
        dw Mech_State10_Column
        dw Mech_State11_Homing
        dw Mech_State12_BandStart
        dw Mech_State13_BandAdvance
        dw Mech_State14_TopMargin
        dw Mech_State15_BottomMargin
        dw Mech_State16_FeedOnly
        dw Mech_State17_ButtonFeed
        dw Mech_State18_Stop
        dw Mech_StateInvalid
        dw Mech_StateInvalid
        dw Mech_StateInvalid
        dw Mech_StateInvalid
        dw Mech_StateInvalid
        dw Mech_StateInvalid

Mech_State00_Idle:
; [C] encoder pulse with no job: while idle, count EncoderIdleCount; on overflow (27 pulses) clear P5.3
        test (SysFlags).7   ; Idle
        jrs T,LABAD
        ld HL,EncoderIdleCount
        inc (HL)
        jrs F,LABAD
        clr (P5).3
LABAD:
        reti

Mech_State01_Column:
; [C] print states 01-10: one pixel column per state, 16 states per cycle, 10 cycles per band
        ld A,(BandIndex)
        shlc A
        ld W,$00
        test (RxErrFlags).2   ; ColdHead
        jrs T,LABBC
        add WA,Tab_TickCurvePtrsCold
        jr LABC0
LABBC:
        add WA,Tab_TickCurvePtrsWarm
LABC0:
        ld HL,WA
        ld DE,(HL)
        ld HL,HeatCurvePtr
        ld (HL),DE
        ld DE,$0270
        call StrobeB_Row00
        call StrobeB_Row01
        call StrobeB_Row02
        call StrobeB_Row03
        call StrobeB_Row04
        call StrobeB_Row05
        call StrobeB_Row06
        call StrobeB_Row07
        call StrobeB_Row08
        call StrobeB_Row09
        call StrobeB_Row10
        call StrobeB_Row11
        call StrobeB_Row12
        call StrobeB_Row13
        call StrobeB_Row14
        call StrobeB_Row15
        ld (MechState),$02
        di
        ldw (EIR),$FD10
        reti

Mech_State02_Column:
; [C]
        ld DE,$0280
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
        ld (MechState),$03
        di
        ldw (EIR),$FD10
        reti

Mech_State03_Column:
; [C]
        ld DE,$0290
        call StrobeB_Row00
        call StrobeB_Row01
        call StrobeB_Row02
        call StrobeB_Row03
        call StrobeB_Row04
        call StrobeB_Row05
        call StrobeB_Row06
        call StrobeB_Row07
        call StrobeB_Row08
        call StrobeB_Row09
        call StrobeB_Row10
        call StrobeB_Row11
        call StrobeB_Row12
        call StrobeB_Row13
        call StrobeB_Row14
        call StrobeB_Row15
        ld (MechState),$04
        di
        ldw (EIR),$FD10
        reti

Mech_State04_Column:
; [C]
        ld DE,$02A0
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
        ld (MechState),$05
        di
        ldw (EIR),$FD10
        reti

Mech_State05_Column:
; [C]
        ld DE,$02B0
        call StrobeB_Row00
        call StrobeB_Row01
        call StrobeB_Row02
        call StrobeB_Row03
        call StrobeB_Row04
        call StrobeB_Row05
        call StrobeB_Row06
        call StrobeB_Row07
        call StrobeB_Row08
        call StrobeB_Row09
        call StrobeB_Row10
        call StrobeB_Row11
        call StrobeB_Row12
        call StrobeB_Row13
        call StrobeB_Row14
        call StrobeB_Row15
        ld (MechState),$06
        di
        ldw (EIR),$FD10
        reti

Mech_State06_Column:
; [C]
        ld DE,$02C0
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
        ld (MechState),$07
        di
        ldw (EIR),$FD10
        reti

Mech_State07_Column:
; [C]
        ld DE,$02D0
        call StrobeB_Row00
        call StrobeB_Row01
        call StrobeB_Row02
        call StrobeB_Row03
        call StrobeB_Row04
        call StrobeB_Row05
        call StrobeB_Row06
        call StrobeB_Row07
        call StrobeB_Row08
        call StrobeB_Row09
        call StrobeB_Row10
        call StrobeB_Row11
        call StrobeB_Row12
        call StrobeB_Row13
        call StrobeB_Row14
        call StrobeB_Row15
        clr (MechFlags).0   ; LineReady
        ld (MechState),$08
        di
        ldw (EIR),$FD10
        reti

Mech_State08_Column:
; [C]
        ld DE,$02E0
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
        ld (MechState),$09
        di
        ldw (EIR),$FD10
        reti

Mech_State09_Column:
; [C]
        ld DE,$02F0
        call StrobeB_Row00
        call StrobeB_Row01
        call StrobeB_Row02
        call StrobeB_Row03
        call StrobeB_Row04
        call StrobeB_Row05
        call StrobeB_Row06
        call StrobeB_Row07
        call StrobeB_Row08
        call StrobeB_Row09
        call StrobeB_Row10
        call StrobeB_Row11
        call StrobeB_Row12
        call StrobeB_Row13
        call StrobeB_Row14
        call StrobeB_Row15
        ld (MechState),$0A
        di
        ldw (EIR),$FD10
        reti

Mech_State0A_Column:
; [C]
        ld DE,$0300
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
        ld (MechState),$0B
        di
        ldw (EIR),$FD10
        reti

Mech_State0B_Column:
; [C]
        ld DE,$0310
        call StrobeB_Row00
        call StrobeB_Row01
        call StrobeB_Row02
        call StrobeB_Row03
        call StrobeB_Row04
        call StrobeB_Row05
        call StrobeB_Row06
        call StrobeB_Row07
        call StrobeB_Row08
        call StrobeB_Row09
        call StrobeB_Row10
        call StrobeB_Row11
        call StrobeB_Row12
        call StrobeB_Row13
        call StrobeB_Row14
        call StrobeB_Row15
        ld (MechState),$0C
        di
        ldw (EIR),$FD10
        reti

Mech_State0C_Column:
; [C]
        ld DE,$0320
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
        ld (MechState),$0D
        di
        ldw (EIR),$FD10
        reti

Mech_State0D_Column:
; [C]
        ld DE,$0330
        call StrobeB_Row00
        call StrobeB_Row01
        call StrobeB_Row02
        call StrobeB_Row03
        call StrobeB_Row04
        call StrobeB_Row05
        call StrobeB_Row06
        call StrobeB_Row07
        call StrobeB_Row08
        call StrobeB_Row09
        call StrobeB_Row10
        call StrobeB_Row11
        call StrobeB_Row12
        call StrobeB_Row13
        call StrobeB_Row14
        call StrobeB_Row15
        ld (MechState),$0E
        di
        ldw (EIR),$FD10
        reti

Mech_State0E_Column:
; [C]
        ld DE,$0340
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
        ld (MechState),$0F
        di
        ldw (EIR),$FD10
        reti

Mech_State0F_Column:
; [C]
        ld DE,$0350
        call StrobeB_Row00
        call StrobeB_Row01
        call StrobeB_Row02
        call StrobeB_Row03
        call StrobeB_Row04
        call StrobeB_Row05
        call StrobeB_Row06
        call StrobeB_Row07
        call StrobeB_Row08
        call StrobeB_Row09
        call StrobeB_Row10
        call StrobeB_Row11
        call StrobeB_Row12
        call StrobeB_Row13
        call StrobeB_Row14
        call StrobeB_Row15
        clr (MechFlags).1   ; LineFetch
        ld (MechState),$10
        di
        ldw (EIR),$FD10
        reti

Mech_State10_Column:
; [C] last column state of a cycle
        inc (LineCounter)
        cmp (LineCounter),$17
        jr CC,LAFA5
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
        ld (MechState),$01
        di
        ldw (EIR),$FD10
        reti
LAFA5:
        ld A,(SelfTest)
        jr Z,LAFCA
        set (JobFlags).5   ; BattCheckDue
        ldw (LineBufWr),$0100
        ldw (LineBufRd),$0100
        clr (MechFlags).0   ; LineReady
        clr (MechFlags).1   ; LineFetch
        ld (FeedLeft),$03
        clr (LineCounter)
        clr (MechFlags).2   ; CamSeen
        ld (MechState),$15
        clr (MechSubState)
        di
        ldw (EIR),$FD10
        reti
LAFCA:
        test (Status).0   ; StLowBattery
        jrs T,LAFDB
        clr (MechFlags).2   ; CamSeen
        ld (MechState),$18
        clr (MechSubState)
        di
        ldw (EIR),$FD10
        reti
LAFDB:
        set (JobFlags).5   ; BattCheckDue
        ld WA,(LineBufWr)
        ld HL,(LineBufRd)
        cmp WA,HL
        jr F,LB00F
        ld A,(MechFlags)
        and A,$03
        jr F,LB00F
        clr (MechFlags).2   ; CamSeen
        ld A,(MarginAfter)
        jr Z,LB003
        ld (FeedLeft),A
        clr (LineCounter)
        ld (MechState),$15
        clr (MechSubState)
        di
        ldw (EIR),$FD10
        reti
LB003:
        ld (MechState),$18
        clr (MechSubState)
        di
        ldw (EIR),$FD10
        reti
LB00F:
        test (JobFlags).3   ; BreakReq
        jrs T,LB020
        clr (MechFlags).2   ; CamSeen
        clr (MechSubState)
        ld (MechState),$18
        di
        ldw (EIR),$FD10
        reti
LB020:
        inc (BandIndex)
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
        ld (MechState),$13
        di
        ldw (EIR),$FD10
        reti

Mech_State11_Homing:
; [C] power-on homing: find the cam sensor twice, stop 3 pulses after; clears PowerOnLock
        cmp (SelfTest),$00
        jrs T,LB06D
        test (P2).0
        jrs T,LB06D
        test (P2).0
        jrs T,LB06D
        ld (SelfTest),$00
LB06D:
        ld HL,MechSubState
        cmp (HL),$00
        jr F,LB08E
        clr (MechFlags).2   ; CamSeen
        test (P5).1
        jrs F,LB083
        ld (HL),$01
        di
        ldw (EIR),$FD10
        reti
LB083:
        ld (HL),$02
        clr (LineCounter)
        di
        ldw (EIR),$FD10
        reti
LB08E:
        cmp (HL),$01
        jrs F,LB0A0
        clr (MechFlags).2   ; CamSeen
        jrs T,LB099
        ld (HL),$02
        clr (LineCounter)
LB099:
        di
        ldw (EIR),$FD10
        reti
LB0A0:
        cmp (HL),$02
        jr F,LB0B8
        inc (LineCounter)
        cmp (LineCounter),$1B
        jr CS,LB0B1
        clr (MechFlags).2   ; CamSeen
        ld (HL),$03
LB0B1:
        di
        ldw (EIR),$FD10
        reti
LB0B8:
        cmp (HL),$03
        jrs F,LB0CA
        clr (MechFlags).2   ; CamSeen
        jrs T,LB0C3
        ld (HL),$04
        clr (LineCounter)
LB0C3:
        di
        ldw (EIR),$FD10
        reti
LB0CA:
        test (P5).1
        jrs F,LB0D8
        clr (MechFlags).2   ; CamSeen
        ld (HL),$03
        di
        ldw (EIR),$FD10
        reti
LB0D8:
        inc (LineCounter)
        cmp (LineCounter),$03
        jr CS,LB0F4
        set (P5).2
        ld (MechState),$00
        clr (LineCounter)
        clr (SysFlags).5   ; PowerOnLock
        ld A,(SelfTest)
        jr Z,LB0F4
        cmp (SelfTest),$02
        jrs T,LB0F4
        set (MechRequests).2   ; ReqPrint
LB0F4:
        di
        ldw (EIR),$FD10
        reti

Mech_State12_BandStart:
; [C] before each band (13 pulses in the emulator)
        inc (LineCounter)
        cmp (LineCounter),$0D
        jr CS,LB106
        ld (MechState),$01
LB106:
        di
        ldw (EIR),$FD10
        reti

Mech_State13_BandAdvance:
; [C] between bands (115 pulses in the emulator)
        inc (LineCounter)
        cmp (LineCounter),$8A
        jr CS,LB11A
        clr (LineCounter)
        ld (MechState),$12
LB11A:
        di
        ldw (EIR),$FD10
        reti

Mech_State14_TopMargin:
; [C] margin before printing
        ld HL,MechSubState
        cmp (HL),$00
        jr F,LB13E
        inc (LineCounter)
        cmp (LineCounter),$1B
        jr CS,LB137
        ld (HL),$01
        clr (MechFlags).2   ; CamSeen
        clr (LineCounter)
LB137:
        di
        ldw (EIR),$FD10
        reti
LB13E:
        cmp (HL),$01
        jrs F,LB150
        clr (MechFlags).2   ; CamSeen
        jrs T,LB149
        ld (HL),$0B
        clr (LineCounter)
LB149:
        di
        ldw (EIR),$FD10
        reti
LB150:
        clr (MechFlags).2   ; CamSeen
        test (P5).1
        jrs F,LB15E
        ld (HL),$01
        di
        ldw (EIR),$FD10
        reti
LB15E:
        inc (LineCounter)
        cmp (LineCounter),$06
        jr CS,LB17A
        clr (LineCounter)
        cmp (MarginBeforeLeft),$00
        jrs T,LB173
        ld (HL),$00
        dec (MarginBeforeLeft)
        jr NZ,LB17A
LB173:
        clr (LineCounter)
        ld (MechState),$12
        clr (MechSubState)
LB17A:
        di
        ldw (EIR),$FD10
        reti

Mech_State15_BottomMargin:
; [C] margin after printing (also the self-test)
        ld HL,MechSubState
        cmp (HL),$00
        jrs F,LB196
        clr (MechFlags).2   ; CamSeen
        jrs T,LB18F
        ld (HL),$0B
        clr (LineCounter)
LB18F:
        di
        ldw (EIR),$FD10
        reti
LB196:
        cmp (HL),$0B
        jr F,LB1BC
        clr (MechFlags).2   ; CamSeen
        test (P5).1
        jrs F,LB1A9
        ld (HL),$00
        di
        ldw (EIR),$FD10
        reti
LB1A9:
        inc (LineCounter)
        cmp (LineCounter),$03
        jr CS,LB1B5
        ld (HL),$01
        clr (LineCounter)
LB1B5:
        di
        ldw (EIR),$FD10
        reti
LB1BC:
        cmp (HL),$01
        jr F,LB1D4
        inc (LineCounter)
        cmp (LineCounter),$1B
        jr CS,LB1CD
        ld (HL),$02
        clr (MechFlags).2   ; CamSeen
LB1CD:
        di
        ldw (EIR),$FD10
        reti
LB1D4:
        cmp (HL),$02
        jrs F,LB1E6
        clr (MechFlags).2   ; CamSeen
        jrs T,LB1DF
        ld (HL),$03
        clr (LineCounter)
LB1DF:
        di
        ldw (EIR),$FD10
        reti
LB1E6:
        test (P5).1
        jrs F,LB1F4
        clr (MechFlags).2   ; CamSeen
        ld (HL),$02
        di
        ldw (EIR),$FD10
        reti
LB1F4:
        inc (LineCounter)
        cmp (LineCounter),$03
        jr CS,LB225
        clr (LineCounter)
        cmp (FeedLeft),$00
        jrs T,LB210
        dec (FeedLeft)
        jr Z,LB210
        ld (HL),$01
        di
        ldw (EIR),$FD10
        reti
LB210:
        set (P5).2
        clr (SelfTest)
        ld (MechState),$00
        test (JobFlags).3   ; BreakReq
        jrs F,LB225
        cmp (Copies),$00
        jrs T,LB225
        dec (Copies)
        jr Z,LB225
        set (MechRequests).2   ; ReqPrint
LB225:
        di
        ldw (EIR),$FD10
        reti

Mech_State16_FeedOnly:
; [C] print with 0 copies
        ld HL,MechSubState
        cmp (HL),$00
        jr F,LB247
        inc (LineCounter)
        cmp (LineCounter),$1B
        jr CS,LB240
        clr (MechFlags).2   ; CamSeen
        ld (HL),$01
LB240:
        di
        ldw (EIR),$FD10
        reti
LB247:
        cmp (HL),$01
        jrs F,LB259
        clr (MechFlags).2   ; CamSeen
        jrs T,LB252
        ld (HL),$02
        clr (LineCounter)
LB252:
        di
        ldw (EIR),$FD10
        reti
LB259:
        test (P5).1
        jrs F,LB267
        clr (MechFlags).2   ; CamSeen
        ld (HL),$01
        di
        ldw (EIR),$FD10
        reti
LB267:
        inc (LineCounter)
        cmp (LineCounter),$03
        jr CS,LB29F
        clr (LineCounter)
        cmp (FeedLeft),$00
        jrs T,LB283
        dec (FeedLeft)
        jr Z,LB283
        ld (HL),$00
        di
        ldw (EIR),$FD10
        reti
LB283:
        cmp (Copies),$00
        jrs T,LB298
        dec (Copies)
        jr Z,LB298
        ld (FeedLeft),(FeedOnlyAmount)
        ld (HL),$00
        di
        ldw (EIR),$FD10
        reti
LB298:
        set (P5).2
        clr (LineCounter)
        ld (MechState),$00
LB29F:
        di
        ldw (EIR),$FD10
        reti

Mech_State17_ButtonFeed:
; [C] front button feed
        test (P2).0
        jr T,LB2CF
        test (P2).0
        jr T,LB2CF
        ld HL,MechSubState
        cmp (HL),$00
        jr F,LB2D8
        clr (MechFlags).2   ; CamSeen
        test (P5).1
        jrs F,LB2C4
        ld (HL),$02
        di
        ldw (EIR),$FD10
        reti
LB2C4:
        ld (HL),$01
        clr (LineCounter)
        di
        ldw (EIR),$FD10
        reti
LB2CF:
        clr (MechSubState)
        di
        ldw (EIR),$FD10
        reti
LB2D8:
        cmp (HL),$01
        jr F,LB2F0
        inc (LineCounter)
        cmp (LineCounter),$1B
        jr CS,LB2E9
        ld (HL),$02
        clr (MechFlags).2   ; CamSeen
LB2E9:
        di
        ldw (EIR),$FD10
        reti
LB2F0:
        cmp (HL),$02
        jrs F,LB302
        clr (MechFlags).2   ; CamSeen
        jrs T,LB2FB
        ld (HL),$03
        clr (LineCounter)
LB2FB:
        di
        ldw (EIR),$FD10
        reti
LB302:
        test (P5).1
        jrs F,LB310
        clr (MechFlags).2   ; CamSeen
        ld (HL),$02
        di
        ldw (EIR),$FD10
        reti
LB310:
        inc (LineCounter)
        cmp (LineCounter),$03
        jr CS,LB321
        set (P5).2
        ld (MechState),$00
        clr (LineCounter)
        clr (SysFlags).5   ; PowerOnLock
LB321:
        di
        ldw (EIR),$FD10
        reti

Mech_State18_Stop:
; [C] stop after low battery or Break
        ld HL,MechSubState
        cmp (HL),$00
        jrs F,LB33E
        clr (MechFlags).2   ; CamSeen
        jr T,Mech_StateInvalid
        clr (LineCounter)
        ld (HL),$01
        di
        ldw (EIR),$FD10
        reti
LB33E:
        test (P5).1
        jrs F,LB34C
        clr (MechFlags).2   ; CamSeen
        ld (HL),$00
        di
        ldw (EIR),$FD10
        reti
LB34C:
        inc (LineCounter)
        cmp (LineCounter),$03
        jr CS,Mech_StateInvalid
        clr (LineCounter)
        ld (MechState),$00
        set (P5).2
        test (JobFlags).3   ; BreakReq
        jrs F,Mech_StateInvalid
        cmp (Copies),$00
        jrs T,Mech_StateInvalid
        dec (Copies)
        jr Z,Mech_StateInvalid
        set (MechRequests).2   ; ReqPrint

Mech_StateInvalid:
; [I] states 0x19-0x1E
        di
        ldw (EIR),$FD10
        reti
