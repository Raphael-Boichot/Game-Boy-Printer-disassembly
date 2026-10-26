; Data decoder (main loop side), temperature / battery check, SRAM access, RLE, SRAM layout table


Data_Main:
; [C] data decoder: runs in the main loop, fed by the ring buffer
        test (DecodeFlags).1   ; Decoding
        jr F,Data_Loop
        clr (DecodeFlags).0   ; DataPending
        jrs F,LA2F7
        jp Main_Loop
LA2F7:
        test (SysFlags).0   ; MemFull
        jrs T,LA2FD
        jp Main_Loop
LA2FD:
        test (RxFlags).6   ; RxCompressed
        ld (RxErrFlags).3,CF   ; DecCompressed
        set (DecodeFlags).1   ; Decoding
        set (DecodeFlags).2   ; DecodeStarted
        jrs F,LA315
        ldw (SlotBase),$0000
        ldw (ImageBytes),$0000
        ldw (SlotOffset),$0000
        clr (DecodeFlags).3   ; RleInRun
LA315:
        ld HL,(SlotBase)
        ld (SavedSlotBase),HL
        ld HL,(ImageBytes)
        ld (SavedImageBytes),HL
        ld HL,(SlotOffset)
        ld (SavedSlotOffset),HL

Data_Loop:
; [C] decode bytes until the packet ends
        ld (WDTCR2),$4E
        test (RxErrFlags).7   ; DataAbort
        jr F,Data_Rollback
        call Rle_NextByte
        jr CC,Data_StoreByte
        test (RxFlags).7   ; RxActive
        jrs T,LA339
        jp Main_Loop
LA339:
        call Rle_NextByte
        jr CC,Data_StoreByte
        ld WA,(SlotOffset)
        cmp WA,$0000
        jr T,Data_Commit
        test (RxErrFlags).3   ; DecCompressed
        jr T,Data_Commit

Data_PadSlot:
; [C] compressed packet ended early: pad the slot to 640 bytes with 0x00
        ld (WDTCR2),$4E
        call Sram_StorePos
        ld A,$00
        call Sram_Write
        ld WA,(SlotOffset)
        cmp WA,$0280
        jr CS,Data_PadSlot
        clr (DecodeFlags).3   ; RleInRun
        ldw (SlotOffset),$0000
        ld WA,(SlotBase)
        add WA,$0280
        ld (SlotBase),WA
        cmp WA,$1680
        jr CS,Data_Commit
        ldw (ImageBytes),$1680
        set (SysFlags).0   ; MemFull
        clr (DecodeFlags).1   ; Decoding
        clr (DecodeFlags).0   ; DataPending
        jp Main_Loop

Data_Rollback:
; [C] bad packet: restore the saved pointers
        ld HL,(SavedSlotBase)
        ld (SlotBase),HL
        ld HL,(SavedImageBytes)
        ld (ImageBytes),HL
        ld HL,(SavedSlotOffset)
        ld (SlotOffset),HL
        clr (DecodeFlags).3   ; RleInRun
        clr (DecodeFlags).1   ; Decoding
        jp Main_Loop

Data_Commit:
; [C] packet stored: set unprocessed (0x08), update ImageBytes
        set (Status).4   ; StUnprocessed
        ld WA,(SlotBase)
        ld HL,(SlotOffset)
        add WA,HL
        ld (ImageBytes),WA
        clr (DecodeFlags).1   ; Decoding
        jp Main_Loop

Data_StoreByte:
; [C] store one decoded byte; advance the slot every 640 bytes
        push WA
        ld WA,(SlotOffset)
        cmp WA,$0000
        jr F,LA3CA
        ld HL,(SlotBase)
        ld (SavedSlotBase),HL
        ld HL,(ImageBytes)
        ld (SavedImageBytes),HL
        ld HL,(SlotOffset)
        ld (SavedSlotOffset),HL
LA3CA:
        pop WA
        call Sram_StorePos
        call Sram_Write
        ld WA,(SlotOffset)
        cmp WA,$0280
        jr CC,LA3DE
        jp Data_Loop
LA3DE:
        clr (DecodeFlags).3   ; RleInRun
        test (RxFlags).6   ; RxCompressed
        ld (RxErrFlags).3,CF   ; DecCompressed
        ldw (SlotOffset),$0000
        ld WA,(SlotBase)
        add WA,$0280
        ld (SlotBase),WA
        cmp WA,$1680
        jr CC,LA3FC
        jp Data_Loop
LA3FC:
        ldw (ImageBytes),$1680
        set (SysFlags).0   ; MemFull
        clr (DecodeFlags).1   ; Decoding
        clr (DecodeFlags).0   ; DataPending
        jp Main_Loop

Sub_CheckTempBattery:
; [C] temperature (other error) and battery (low battery) checks
        test (JobFlags).5   ; BattCheckDue
        jr F,LA45D
        test (JobFlags).7   ; BattSample
        jr F,LA45D
        ld (ADCCR),$00
        set (ADCCR).6
LA416:
        test (ADCCR).7
        jrs T,LA416
        ld C,(ADCDR)
        ld (TempAdc),C
        cmp C,$34
        jr LE,LA429
        cmp C,$D7
        jr LE,LA42B
LA429:
        set (Status).1   ; StOtherError
LA42B:
        test (Status).0   ; StLowBattery
        jr F,LA45D
        test (JobFlags).5   ; BattCheckDue
        jr F,LA45D
        test (JobFlags).7   ; BattSample
        jr F,LA45D
        ld (ADCCR),$01
        set (ADCCR).6
LA43C:
        test (ADCCR).7
        jrs T,LA43C
        cmp (ADCDR),$7E
        jr GT,LA45D
        ldw (P0),$0000
        set (Status).0   ; StLowBattery
        set (RxFlags).1   ; LowBatHold
        cmp (MechState),$11
        jr CS,LA45B
        clr (MechFlags).2   ; CamSeen
        ld (MechState),$18
        clr (MechSubState)
        ret
LA45B:
        set (P5).2
LA45D:
        ret

Sub_PrimeLineBuf:
; [C] clear LineBuf and preload 0x120 bytes from SRAM (LineBufWr = 0x0220, LineBufRd = 0x0100)
        ld (P2),$07
        ld (P7CR),$00
        ld HL,LineBuf
        ld B,$9F
LA469:
        ld (HL+),$00
        ld (HL+),$00
        dec B
        jrs F,LA469
        ld HL,LineBuf
        ld BC,$0000
LA477:
        call Sram_Read
        ld (HL+),A
        inc BC
        cmp BC,$0120
        jr CS,LA477
        ld (PrintReadPos),BC
        ldw (LineBufWr),$0220
        ldw (LineBufRd),$0100
        ret

Sram_Read:
; [C] A = SRAM[BC]
        ld (P3),C
        ld A,B
        or A,$E0
        ld (P4),A
        clr (P2).2
        clr (P5).4
        nop
        nop
        ld A,(P7)
        set (P5).4
        set (P2).2
        ret

Sram_Write:
; [C] SRAM[BC] = A
        ld (P7CR),$FF
        ld (P7),A
        ld (P3),C
        ld A,B
        or A,$E0
        ld (P4),A
        nop
        clr (P2).2
        nop
        clr (P2).1
        nop
        set (P2).1
        set (P2).2
        ld (P7CR),$00
        ret

Rle_NextByte:
; [C] next decoded byte from the ring buffer (CF = 1: none yet)
        test (RxErrFlags).3   ; DecCompressed
        jr F,LA4DF
        ld WA,(RingWr)
        ld HL,(RingRd)
        cmp WA,HL
        jrs F,LA4CF
        set CF
        ret
LA4CF:
        ld A,(HL+)
        cmp HL,$0414
        jr CS,LA4DA
        ld HL,RingBuf
LA4DA:
        ld (RingRd),HL
        clr CF
        ret
LA4DF:
        test (DecodeFlags).3   ; RleInRun
        jr F,LA514
        ld WA,(RingWr)
        ld HL,(RingRd)
        cmp WA,HL
        jrs F,LA4EE
        set CF
        ret
LA4EE:
        set (DecodeFlags).3   ; RleInRun
        clr (DecodeFlags).4   ; RleLiteral
        clr (DecodeFlags).5   ; RleRepeat
        clr (DecodeFlags).6   ; RleHaveByte
        ld A,(HL+)
        cmp HL,$0414
        jr CS,LA501
        ld HL,RingBuf
LA501:
        ld (RingRd),HL
        cmp A,$80
        jr CC,LA50E
        set (DecodeFlags).4   ; RleLiteral
        inc A
        ld (RleCount),A
        jrs T,LA514
LA50E:
        set (DecodeFlags).5   ; RleRepeat
        sub A,$7E
        ld (RleCount),A
LA514:
        test (DecodeFlags).5   ; RleRepeat
        jr F,LA539
        ld WA,(RingWr)
        ld HL,(RingRd)
        cmp WA,HL
        jrs F,LA523
        set CF
        ret
LA523:
        ld A,(HL+)
        cmp HL,$0414
        jr CS,LA52E
        ld HL,RingBuf
LA52E:
        ld (RingRd),HL
        dec (RleCount)
        jr NZ,LA537
        clr (DecodeFlags).3   ; RleInRun
LA537:
        clr CF
        ret
LA539:
        test (DecodeFlags).6   ; RleHaveByte
        jr F,LA55A
        ld WA,(RingWr)
        ld HL,(RingRd)
        cmp WA,HL
        jrs F,LA548
        set CF
        ret
LA548:
        ld A,(HL+)
        ld (RleByte),A
        set (DecodeFlags).6   ; RleHaveByte
        cmp HL,$0414
        jr CS,LA557
        ld HL,RingBuf
LA557:
        ld (RingRd),HL
LA55A:
        ld A,(RleByte)
        dec (RleCount)
        jr NZ,LA562
        clr (DecodeFlags).3   ; RleInRun
LA562:
        clr CF
        ret

Sram_StorePos:
; [C] SRAM position of the next packet byte: SlotBase + Tab_SramLayout[SlotOffset]
        ld C,A
        ld WA,(SlotOffset)
        inc WA
        ld (SlotOffset),WA
        add WA,WA
        add WA,Tab_SramLayout-2
        ld HL,WA
        ld WA,(HL)
        ld HL,(SlotBase)
        add WA,HL
        xch WA,BC
        ret

Tab_SramLayout:
; [C] 640 words: packet byte index -> offset in its SRAM slot (tiles reordered by column)
; words A57E-AA7D: [C] Tab_SramLayout
        incbin "data/sram_layout.bin"   ; 1280 bytes
