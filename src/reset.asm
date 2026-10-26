; Reset: ports, RAM clear, SRAM test, timers, serial port, battery check, self-test request


Reset:
; [C] boot: stack, watchdog off, ports, RAM clear, SRAM test, timers, SIO2, battery check, self-test check
        di
        ld SP,$043F
        ld (SYSCR1),$00
        ld (SYSCR2),$80
        ld (WDTCR1),$07
        ld (WDTCR2),$B1
        ld (P0),$00
        ld (P0CR),$FF
        ld (P1),$00
        ld (P1CR),$FF
        ld (P2),$07
        ld (P3),$00
        ld (P4),$E0
        ld (P5),$FF
        ld (P6),$00
        ld (P6CR),$03
        ld (P7),$00
        ld (P7CR),$00
        ld HL,$0048
        ld BC,$03F8
L803B:
        ld (HL+),$00
        dec BC
        jr NZ,L803B
        set (MechRequests).0   ; ReqHoming
        set (SysFlags).5   ; PowerOnLock
        set (SysFlags).2   ; TickRunning
        ldw (LineBufWr),$0100
        ldw (LineBufRd),$0100
        ld HL,RingBuf
        ld (RingWr),HL
        ld (RingRd),HL
        ld HL,$041D
        ld (HL),$6D
        ld (IdleDelay),$9C
        ld (StartDelay),$01
        ld (EncoderTimeout),$F4
        ld HL,EncoderIdleCount
        ld (HL),$E5
        call Boot_SramTest
        ldw (TREG1A),$0064
        ld (TC1CR),$08
        ldw (TREG2),$000A
        ld (TC2CR),$24
        ld (TREG3A),$5E
        ld (TC3CR),$08
        ld (TREG4),$14
        ld (TC4CR),$C0
        ld (SIO2CR1),$67
        ld (SIO2CR2),$00
        ld (SIO2CR1),$A7
        ld (EINTCR),$08
        ldw (IL),$02EF
        ldw (EIR),$FD11
        test (P2).0
        jrs F,Boot_SettleDelay
        test (P2).0
        jrs F,Boot_SettleDelay
        ld (SelfTest),$01
        call SelfTest_Load

Boot_SettleDelay:
; [C] 65,536-step busy-wait before the first battery reading
        ld WA,$0000
L80AB:
        inc WA
        jrs F,L80AB
        ld (ADCCR),$01
        set (ADCCR).6
L80B2:
        test (ADCCR).7
        jrs T,L80B2
        ld A,(ADCDR)
        cmp A,$7E
        jr GT,L80D2
        ld WA,$FEB3
L80BE:
        inc WA
        jrs F,L80BE
        ld (ADCCR),$01
        set (ADCCR).6
L80C5:
        test (ADCCR).7
        jrs T,L80C5
        ld A,(ADCDR)
        cmp A,$7E
        jr GT,L80D2
        set (Status).0   ; StLowBattery
        set (RxFlags).1   ; LowBatHold
L80D2:
        ld (WDTCR1),$0F
