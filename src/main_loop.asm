; Main loop: idle, tick work, watchdogs, command handlers, job start


Main_Loop:
; [C] main loop: watchdog clear, idle entry check, then the tick work
        ld (WDTCR2),$4E
        ld A,(MechState)
        jr Z,L80E0
        cmp A,$10
        jr LE,L80E4
L80E0:
        ldw (P0),$0000
L80E4:
        test (Status).0   ; StLowBattery
        jrs T,L80ED
        test (SysFlags).6   ; SupplyCut
        jrs F,L80ED
        jp Main_Wake
L80ED:
        ld A,(MechState)
        jr Z,L80F4
        jp Main_Wake
L80F4:
        test (Status).6   ; StBusy
        jrs T,L80FA
        jp Main_Wake
L80FA:
        test (RxFlags).0   ; RxInPacket
        jrs T,L8100
        jp Main_Wake
L8100:
        ld HL,ActivityTimer
        cmp (HL),$00
        jrs T,L810A
        jp Main_Wake
L810A:
        test (SIO2CR1).6
        jrs T,L8110
        jp Main_Wake
L8110:
        test (DecodeFlags).1   ; Decoding
        jrs T,L8116
        jp Main_Wake
L8116:
        test (Status).4   ; StUnprocessed
        jrs T,L811C
        jp Main_Wake
L811C:
        test (MechRequests).0   ; ReqHoming
        jrs T,L8122
        jp Main_Wake
L8122:
        test (MechRequests).2   ; ReqPrint
        jrs T,Main_EnterIdle
        jp Main_Wake

Main_EnterIdle:
; [C] nothing to do: slow tick (TREG2 0x03D5 = 1.0 s) and IDLE mode until an interrupt
        set (SysFlags).7   ; Idle
        clr (SysFlags).2   ; TickRunning
        ld (TC2CR),$04
        ldw (TREG2),$03D5
        ld (TC2CR),$24
        ld HL,$041D
        ld (HL),$6D
        ld (IdleDelay),$9C
        clr (DecodeFlags).7   ; Tick
        set (SYSCR2).4
        set (SysFlags).2   ; TickRunning
        ld (TC2CR),$04
        ldw (TREG2),$000A
        ld (TC2CR),$24
        clr (DecodeFlags).7   ; Tick
        jrs F,L8154
        jp Main_CheckTempBattery
L8154:
        test (JobFlags).7   ; BattSample
        jrs T,Heat_DecayIdle
        jp Main_CheckTempBattery

Heat_DecayIdle:
; [C] per tick: RowHeat *= Tab_DecayByTemp[temperature] / 256
        ld (ADCCR),$00
        set (ADCCR).6
L815F:
        test (ADCCR).7
        jrs T,L815F
        ld C,(ADCDR)
        ld WA,Tab_DecayByTemp
        ld B,$00
        add WA,BC
        ld HL,WA
        ld C,(HL)
        ld D,C
        ld E,(RowHeat)
        mul DE
        ld W,C
        ld A,($B8)
        mul W,A
        add A,D
        addc W,$00
        ld (RowHeat),WA
        ld D,C
        ld E,($B9)
        mul DE
        ld W,C
        ld A,($BA)
        mul W,A
        add A,D
        addc W,$00
        ld ($B9),WA
        ld D,C
        ld E,($BB)
        mul DE
        ld W,C
        ld A,($BC)
        mul W,A
        add A,D
        addc W,$00
        ld ($BB),WA
        ld D,C
        ld E,($BD)
        mul DE
        ld W,C
        ld A,($BE)
        mul W,A
        add A,D
        addc W,$00
        ld ($BD),WA
        ld D,C
        ld E,($BF)
        mul DE
        ld W,C
        ld A,($C0)
        mul W,A
        add A,D
        addc W,$00
        ld ($BF),WA
        ld D,C
        ld E,($C1)
        mul DE
        ld W,C
        ld A,($C2)
        mul W,A
        add A,D
        addc W,$00
        ld ($C1),WA
        ld D,C
        ld E,($C3)
        mul DE
        ld W,C
        ld A,($C4)
        mul W,A
        add A,D
        addc W,$00
        ld ($C3),WA
        ld D,C
        ld E,($C5)
        mul DE
        ld W,C
        ld A,($C6)
        mul W,A
        add A,D
        addc W,$00
        ld ($C5),WA
        ld D,C
        ld E,($C7)
        mul DE
        ld W,C
        ld A,($C8)
        mul W,A
        add A,D
        addc W,$00
        ld ($C7),WA
        ld D,C
        ld E,($C9)
        mul DE
        ld W,C
        ld A,($CA)
        mul W,A
        add A,D
        addc W,$00
        ld ($C9),WA
        ld D,C
        ld E,($CB)
        mul DE
        ld W,C
        ld A,($CC)
        mul W,A
        add A,D
        addc W,$00
        ld ($CB),WA
        ld D,C
        ld E,($CD)
        mul DE
        ld W,C
        ld A,($CE)
        mul W,A
        add A,D
        addc W,$00
        ld ($CD),WA
        ld D,C
        ld E,($CF)
        mul DE
        ld W,C
        ld A,($D0)
        mul W,A
        add A,D
        addc W,$00
        ld ($CF),WA
        ld D,C
        ld E,($D1)
        mul DE
        ld W,C
        ld A,($D2)
        mul W,A
        add A,D
        addc W,$00
        ld ($D1),WA
        ld D,C
        ld E,($D3)
        mul DE
        ld W,C
        ld A,($D4)
        mul W,A
        add A,D
        addc W,$00
        ld ($D3),WA
        ld D,C
        ld E,($D5)
        mul DE
        ld W,C
        ld A,($D6)
        mul W,A
        add A,D
        addc W,$00
        ld ($D5),WA
        ld HL,HeatSoak
        dec (HL)
        jrs F,Main_CheckTempBattery
        clr (HL)

Main_CheckTempBattery:
; [C] periodic temperature and battery check (Sub_CheckTempBattery)
        call Sub_CheckTempBattery
        jr Main_Tick

Main_Wake:
; [C] back from idle: clear SysFlags.Idle, reload EncoderIdleCount
        clr (SysFlags).7   ; Idle
        ld HL,EncoderIdleCount
        ld (HL),$E5
        cmp (MechState),$00
        jrs T,L82CD
        cmp (MechState),$11
        jr CS,Main_Tick
L82CD:
        call Sub_CheckTempBattery

Main_Tick:
; [C] work done once per 10.24 ms tick (flag E0.7)
        clr (DecodeFlags).7   ; Tick
        jrs F,L82D6
        jp L8508
L82D6:
        ld A,(LowBatTimer)
        jr Z,Main_IdleResetTimer
        inc (LowBatTimer)

Main_IdleResetTimer:
; [C] counts ActivityTimer while not busy; wrap = reset as Init
        test (Status).6   ; StBusy
        jr F,L8319
        ld HL,ActivityTimer
        cmp (HL),$00
        jr T,L8319
        inc (HL)
        jr NZ,L8319
        clr (RxErrFlags).5   ; BreakBlock
        clr (RxErrFlags).0   ; PacketError
        clr (SysFlags).0   ; MemFull
        clr (Status).5   ; StImageFull
        clr (DecodeFlags).1   ; Decoding
        clr (DecodeFlags).2   ; DecodeStarted
        clr (RxFlags).4   ; RxDataOk
        clr (RxFlags).5   ; RxEndMark
        test (Status).2   ; StPaperJam
        jrs F,L8300
        clr (Status).4   ; StUnprocessed
L8300:
        clr (JobFlags).0   ; AfterPrint
        clr (Copies)
        ldw (SlotBase),$0000
        ldw (PrintReadPos),$0000
        ldw (ImageBytes),$0000
        ld HL,RingBuf
        ld (RingWr),HL
        ld (RingRd),HL
L8319:
        ld A,(SioIdleTimer)
        jr Z,L831F
        inc (SioIdleTimer)
L831F:
        test (JobFlags).4   ; SioRearm
        jr F,L8336
        ld A,(SioIdleTimer)
        jr NZ,L834B
        ld (SioIdleTimer),$F4
        test (RxFlags).0   ; RxInPacket
        jr F,L8349
        test (SIO2CR1).6
        jr T,L8349
        set (JobFlags).4   ; SioRearm
        jr L834B
L8336:
        test (RxFlags).0   ; RxInPacket
        jrs F,L8349
        test (SIO2CR1).6
        jrs T,L8349
        ld A,(SioIdleTimer)
        jr NZ,L834B
        ld (SIO2CR1),$67
        ld (SIO2CR2),$00
        ld (SIO2CR1),$A7
L8349:
        clr (JobFlags).4   ; SioRearm
L834B:
        ld A,(MechState)
        jr NZ,L8358
        clr (EncoderTimeout)
        clr (MechFlags).5   ; EncoderSeen
        ld (EncoderTimeout),$F4
        jr Main_StartDelay
L8358:
        clr (MechFlags).5   ; EncoderSeen
        jrs T,L8360
        ld (EncoderTimeout),$F4
        jr Main_StartDelay
L8360:
        ld A,(EncoderTimeout)
        jr Z,Main_StartDelay
        inc (EncoderTimeout)
        jr F,Main_StartDelay
        ldw (P0),$0000
        set (P5).2
        set (Status).2   ; StPaperJam
        ld (MechState),$00
        set (Status).4   ; StUnprocessed
        clr (Status).5   ; StImageFull
        clr (Status).6   ; StBusy

Main_StartDelay:
; [C] counts StartDelay (12 ticks, about 123 ms) before a job or the next copy starts
        cmp (StartDelay),$01
        jrs T,L8384
        ld A,(StartDelay)
        jr Z,L8384
        inc (StartDelay)
L8384:
        test (SysFlags).2   ; TickRunning
        jrs F,L838A
        jp Main_LowBattery
L838A:
        ld A,(MechState)
        jr Z,L8391
        jp Main_LowBattery
L8391:
        test (Status).0   ; StLowBattery
        jrs T,L839F
        ld HL,$041D
        cmp (HL),$00
        jrs T,L839F
        inc (HL)
        jrs F,L839F
        clr (RxFlags).1   ; LowBatHold
L839F:
        inc (IdleDelay)
        jrs T,L83A5
        jp L8508
L83A5:
        ld HL,HeatSoak
        clr (HL)
        test (JobFlags).7   ; BattSample
        jrs T,Heat_DecayTick
        jp Main_LowBattery

Heat_DecayTick:
; [C] per tick: RowHeat *= Tab_DecayByTemp[temperature] / 256
        ld (ADCCR),$00
        set (ADCCR).6
L83B4:
        test (ADCCR).7
        jrs T,L83B4
        ld C,(ADCDR)
        ld WA,Tab_DecayByTemp
        ld B,$00
        add WA,BC
        ld HL,WA
        ld C,(HL)
        ld D,C
        ld E,(RowHeat)
        mul DE
        ld W,C
        ld A,($B8)
        mul W,A
        add A,D
        addc W,$00
        ld (RowHeat),WA
        ld D,C
        ld E,($B9)
        mul DE
        ld W,C
        ld A,($BA)
        mul W,A
        add A,D
        addc W,$00
        ld ($B9),WA
        ld D,C
        ld E,($BB)
        mul DE
        ld W,C
        ld A,($BC)
        mul W,A
        add A,D
        addc W,$00
        ld ($BB),WA
        ld D,C
        ld E,($BD)
        mul DE
        ld W,C
        ld A,($BE)
        mul W,A
        add A,D
        addc W,$00
        ld ($BD),WA
        ld D,C
        ld E,($BF)
        mul DE
        ld W,C
        ld A,($C0)
        mul W,A
        add A,D
        addc W,$00
        ld ($BF),WA
        ld D,C
        ld E,($C1)
        mul DE
        ld W,C
        ld A,($C2)
        mul W,A
        add A,D
        addc W,$00
        ld ($C1),WA
        ld D,C
        ld E,($C3)
        mul DE
        ld W,C
        ld A,($C4)
        mul W,A
        add A,D
        addc W,$00
        ld ($C3),WA
        ld D,C
        ld E,($C5)
        mul DE
        ld W,C
        ld A,($C6)
        mul W,A
        add A,D
        addc W,$00
        ld ($C5),WA
        ld D,C
        ld E,($C7)
        mul DE
        ld W,C
        ld A,($C8)
        mul W,A
        add A,D
        addc W,$00
        ld ($C7),WA
        ld D,C
        ld E,($C9)
        mul DE
        ld W,C
        ld A,($CA)
        mul W,A
        add A,D
        addc W,$00
        ld ($C9),WA
        ld D,C
        ld E,($CB)
        mul DE
        ld W,C
        ld A,($CC)
        mul W,A
        add A,D
        addc W,$00
        ld ($CB),WA
        ld D,C
        ld E,($CD)
        mul DE
        ld W,C
        ld A,($CE)
        mul W,A
        add A,D
        addc W,$00
        ld ($CD),WA
        ld D,C
        ld E,($CF)
        mul DE
        ld W,C
        ld A,($D0)
        mul W,A
        add A,D
        addc W,$00
        ld ($CF),WA
        ld D,C
        ld E,($D1)
        mul DE
        ld W,C
        ld A,($D2)
        mul W,A
        add A,D
        addc W,$00
        ld ($D1),WA
        ld D,C
        ld E,($D3)
        mul DE
        ld W,C
        ld A,($D4)
        mul W,A
        add A,D
        addc W,$00
        ld ($D3),WA
        ld D,C
        ld E,($D5)
        mul DE
        ld W,C
        ld A,($D6)
        mul W,A
        add A,D
        addc W,$00
        ld ($D5),WA

Main_LowBattery:
; [C] after low battery: once reported (and LowBatTimer expired) or held while idle, clear P5.3
        ld (IdleDelay),$9C
L8508:
        test (Status).0   ; StLowBattery
        jrs F,L8511
        clr (RxFlags).1   ; LowBatHold
        clr (RxFlags).2   ; LowBatReported
        jr Main_CamWatchdog
L8511:
        test (RxFlags).2   ; LowBatReported
        jrs F,L8520
        test (RxFlags).1   ; LowBatHold
        jr F,Main_CamWatchdog
        ld HL,ActivityTimer
        cmp (HL),$00
        jrs T,L8525
        jrs T,Main_CamWatchdog
L8520:
        cmp (LowBatTimer),$00
        jrs F,Main_CamWatchdog
L8525:
        set (SysFlags).6   ; SupplyCut
        clr (P5).3

Main_CamWatchdog:
; [C] jam if the cam sensor does not change within 13 ticks (high) / 51 ticks (low)
        test (MechFlags).3   ; MechActive
        jrs F,L8532
        clr (SysFlags).3   ; CamChange
        clr (CamTimeout)
        jr Main_Commands
L8532:
        test (P5).1
        xor CF,(SysFlags).4   ; CamLevel
        jr T,L854B
        cpl (SysFlags).4   ; CamLevel
        clr (SysFlags).3   ; CamChange
        test (SysFlags).4   ; CamLevel
        jrs T,L8546
        ld (CamTimeout),$F3
        jr Main_Commands
L8546:
        ld (CamTimeout),$CD
        jr Main_Commands
L854B:
        clr (SysFlags).3   ; CamChange
        jr T,Main_Commands
        inc (CamTimeout)
        jr F,Main_Commands
        ldw (P0),$0000
        set (P5).2
        set (Status).2   ; StPaperJam
        ld (MechState),$00
        set (Status).4   ; StUnprocessed
        clr (Status).5   ; StImageFull
        clr (Status).6   ; StBusy

Main_Commands:
; [C] run the commands posted by the receiver (CmdRequests)
        clr (CmdRequests).7   ; ReqInit
        jr F,Cmd_Init
        clr (CmdRequests).6   ; ReqPrint
        jr F,Cmd_Print
        clr (CmdRequests).5   ; ReqBreak
        jrs T,L8572
        jp Cmd_Break
L8572:
        clr (CmdRequests).4   ; ReqStatus
        jrs T,L8578
        jp Main_JobControl
L8578:
        jp Main_JobControl

Cmd_Init:
; [C] clear image memory, decoder, image-full, unprocessed (unless jammed), break block
        clr (SysFlags).0   ; MemFull
        clr (Status).5   ; StImageFull
        clr (DecodeFlags).1   ; Decoding
        clr (DecodeFlags).2   ; DecodeStarted
        clr (RxFlags).4   ; RxDataOk
        clr (RxFlags).5   ; RxEndMark
        test (Status).2   ; StPaperJam
        jrs F,L858C
        clr (Status).4   ; StUnprocessed
L858C:
        clr (JobFlags).0   ; AfterPrint
        clr (Copies)
        clr (RxErrFlags).5   ; BreakBlock
        clr (RxErrFlags).0   ; PacketError
        ldw (SlotBase),$0000
        ldw (PrintReadPos),$0000
        ldw (ImageBytes),$0000
        ld HL,RingBuf
        ld (RingWr),HL
        ld (RingRd),HL
        jr Main_JobControl

Cmd_Print:
; [C] take the 4 print arguments: copies, margins, palette, exposure
        test (JobFlags).1   ; Printing
        jr F,L85F1
        test (JobFlags).2   ; Feeding
        jr F,L85F1
        test (DecodeFlags).1   ; Decoding
        jr F,L85F1
        set (JobFlags).0   ; AfterPrint
        ld HL,PktArgs
        ld A,(HL+)
        ld (Copies),A
        jr Z,Cmd_Print_FeedOnly
        ld WA,(ImageBytes)
        cmp WA,$0000
        jr T,Cmd_Print_FeedOnly
        ld A,(HL)
        swap A
        and A,$0F
        ld (MarginBefore),A
        ld A,(HL+)
        and A,$0F
        ld (MarginAfter),A
        ld (Palette),(HL)
        inc HL
        ld C,(HL)
        cmp C,$7F
        jr LE,L85E4
        ld C,$40
L85E4:
        ld HL,Tab_ExposureOffset
        ld (ExposureOffset),(HL+C)
        set (MechRequests).2   ; ReqPrint
        test (Status).2   ; StPaperJam
        jrs F,L85F1
        clr (Status).4   ; StUnprocessed
L85F1:
        jr Main_JobControl

Cmd_Print_FeedOnly:
; [C] 0 copies or no image data: feed the after-margin only
        ld A,(HL)
        and A,$0F
        jrs T,L85FB
        ld (FeedOnlyAmount),A
        set (MechRequests).1   ; ReqFeed
L85FB:
        jr Main_JobControl

Cmd_Break:
; [C] stop at the next feed phase; block data until Init
        test (JobFlags).2   ; Feeding
        jrs F,L8605
        test (JobFlags).1   ; Printing
        jrs T,L8607
        set (RxErrFlags).5   ; BreakBlock
L8605:
        set (JobFlags).3   ; BreakReq
L8607:
        jr Main_JobControl

Main_JobControl:
; [I] job end, copies, busy flag
        test (MechFlags).3   ; MechActive
        jr T,Main_StartJob
        ld A,(MechState)
        jr Z,L8614
        jp Main_LinePipeline
L8614:
        ld A,(SelfTest)
        jr Z,L861B
        jp Job_StartPrint
L861B:
        clr (JobFlags).3   ; BreakReq
        jrs T,L862D
        test (Status).0   ; StLowBattery
        jrs T,L8624
        test (RxFlags).2   ; LowBatReported
        jrs T,L862D
L8624:
        clr (Status).6   ; StBusy
        clr (RxErrFlags).4   ; SyncLostBusy
        test (Status).2   ; StPaperJam
        jrs F,L862D
        clr (Status).4   ; StUnprocessed
L862D:
        clr (JobFlags).2   ; Feeding
        clr (JobFlags).1   ; Printing
        test (JobFlags).6   ; InitDeferred
        jrs T,L863E
        test (RxFlags).7   ; RxActive
        jrs F,L863B
        clr (JobFlags).6   ; InitDeferred
        set (CmdRequests).7   ; ReqInit
L863B:
        jp Main_LinePipeline
L863E:
        ld A,(Copies)
        jr Z,L864A
        clr (MechFlags).3   ; MechActive
        ld (StartDelay),$F4
        jp Main_LinePipeline
L864A:
        test (RxFlags).7   ; RxActive
        jrs F,L8659
        test (Status).0   ; StLowBattery
        jrs T,L8653
        test (RxFlags).2   ; LowBatReported
        jrs T,L8659
L8653:
        clr (Status).6   ; StBusy
        clr (MechFlags).3   ; MechActive
        clr (RxErrFlags).4   ; SyncLostBusy
L8659:
        jp Main_LinePipeline

Main_StartJob:
; [C] start a mechanism job if no error
        test (Status).0   ; StLowBattery
        jrs T,L8662
        jp Main_LinePipeline
L8662:
        test (Status).2   ; StPaperJam
        jrs T,L8668
        jp Main_LinePipeline
L8668:
        test (Status).1   ; StOtherError
        jrs T,L866E
        jp Main_LinePipeline
L866E:
        clr (MechRequests).0   ; ReqHoming
        jr T,Job_StartFeed

Job_StartHoming:
; [C] state 0x11 (power-on homing)
        test (Status).0   ; StLowBattery
        jrs F,L8685
        ld (ADCCR),$01
        set (ADCCR).6
L867A:
        test (ADCCR).7
        jrs T,L867A
        ld A,(ADCDR)
        ld HL,BattAtStart
        ld (HL),A
        set (JobFlags).7   ; BattSample
L8685:
        ld (MechState),$11
        set (MechFlags).3   ; MechActive
        set (Status).6   ; StBusy
        clr (MechFlags).2   ; CamSeen
        clr (MechSubState)
        ld RBS,1
        ld B,$EB
        ld WA,$0000
        ld (P0),WA
        ld HL,$0361
        ld DE,$0384
        ld RBS,0
        ld (TC1CR),$18
        clr (P5).2
        jp Main_LinePipeline

Job_StartFeed:
; [C] state 0x16 (feed only)
        clr (MechRequests).1   ; ReqFeed
        jr T,Job_ButtonFeed
        set (JobFlags).2   ; Feeding
        ld (FeedLeft),(FeedOnlyAmount)
        ld (MechState),$16
        clr (MechSubState)
        clr (LineCounter)
        clr (MechFlags).2   ; CamSeen
        clr (P5).2
        set (MechFlags).3   ; MechActive
        set (Status).6   ; StBusy
        jp Main_LinePipeline

Job_ButtonFeed:
; [C] state 0x17 while the front button is pressed
        ld A,(SelfTest)
        jr NZ,Job_StartPrint
        test (P2).0
        jr F,Job_StartPrint
        test (P2).0
        jrs F,Job_StartPrint
        set (JobFlags).2   ; Feeding
        ld (MechState),$17
        clr (P5).2
        set (MechFlags).3   ; MechActive
        set (Status).6   ; StBusy
        clr (MechSubState)
        jp Main_LinePipeline

Job_StartPrint:
; [C] print: temperature check, heat time, line pipeline set-up
        test (MechRequests).2   ; ReqPrint
        jrs F,L86E6
        jp Main_LinePipeline
L86E6:
        cmp (StartDelay),$01
        jrs T,L86F4
        ld A,(StartDelay)
        jr Z,L86F2
        jp Main_LinePipeline
L86F2:
        inc (StartDelay)
L86F4:
        clr (MechRequests).2   ; ReqPrint
        di
        ld (ADCCR),$00
        set (ADCCR).6
L86FD:
        test (ADCCR).7
        jrs T,L86FD
        ld C,(ADCDR)
        ei
        ld (TempAdc),C
        cmp C,$34
        jr LE,Job_TempError
        cmp C,$D7
        jr LE,Job_SetHeatTime

Job_TempError:
; [C] temperature reading outside 0x35-0xD7: other error (0x40)
        ldw (P0),$0000
        set (P5).2
        set (Status).1   ; StOtherError
        jp Main_LinePipeline

Job_SetHeatTime:
; [C] HeatTime = Tab_HeatBaseByTemp[temp] + ExposureOffset
        ld WA,Tab_HeatBaseByTemp
        ld B,$00
        add WA,BC
        ld HL,WA
        ld A,(HL)
        ld (HeatBase),A
        add A,(ExposureOffset)
        ld (HeatTime),A
        ld WA,Tab_IdleCoolByTemp
        ld B,$00
        add WA,BC
        ld HL,WA
        ld (IdleCool),(HL)
        set (JobFlags).1   ; Printing
        clr (MechFlags).4   ; StrobeBufB
        set (MechFlags).6   ; LineBufFill
        ldw (LineBufWr),$0100
        ldw (LineBufRd),$0100
        ldw (PrintReadPos),$0000
        ld (TileColumnsLeft),$13
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
        ld (RowHeatInt),($B8)
        ld ($61),($BA)
        ld ($62),($BC)
        ld ($63),($BE)
        ld ($64),($C0)
        ld ($65),($C2)
        ld ($66),($C4)
        ld ($67),($C6)
        ld ($68),($C8)
        ld ($69),($CA)
        ld ($6A),($CC)
        ld ($6B),($CE)
        ld ($6C),($D0)
        ld ($6D),($D2)
        ld ($6E),($D4)
        ld ($6F),($D6)
        clr (BandIndex)
        ld HL,HeatCurvePtr
        ld A,(RowHeatInt)
        jr NZ,L87ED
        ld A,($61)
        jr NZ,L87ED
        ld A,($62)
        jr NZ,L87ED
        ld A,($63)
        jr NZ,L87ED
        ld A,($64)
        jr NZ,L87ED
        ld A,($65)
        jr NZ,L87ED
        ld A,($66)
        jr NZ,L87ED
        ld A,($67)
        jr NZ,L87ED
        ld A,($68)
        jr NZ,L87ED
        ld A,($69)
        jr NZ,L87ED
        ld A,($6A)
        jr NZ,L87ED
        ld A,($6B)
        jr NZ,L87ED
        ld A,($6C)
        jr NZ,L87ED
        ld A,($6D)
        jr NZ,L87ED
        ld A,($6E)
        jr NZ,L87ED
        ld A,($6F)
        jr NZ,L87ED
        ldw (HL),Tab_TickCurvesCold
        set (RxErrFlags).2   ; ColdHead
        ld HL,HeatSoak
        clr (HL)
        jrs T,L87FD
L87ED:
        ldw (HL),Tab_TickCurvesWarm
        clr (RxErrFlags).2   ; ColdHead
        ld HL,HeatSoak
        inc (HL)
        cmp (HL),$28
        jr LE,L87FD
        ld (HL),$28
L87FD:
        call Sub_PrimeLineBuf
        ld DE,(LineBufRd)
        call Line_CopyColumnSource
        clr (TileColumnX)
