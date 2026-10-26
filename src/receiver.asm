; Main tick, serial packet receiver (coroutine), inter-byte timeout


Int_TC2_Tick:
; [C] main tick: set DecodeFlags.Tick
        set (DecodeFlags).7   ; Tick
        reti

Int_SIO2_Receiver:
; [C] packet receiver (coroutine resumed at RxResume after each byte)
        ld RBS,3
        ld HL,(EIR)
        ld (RxSavedEIR),HL
        ldw (EIR),$0011
        ld HL,ActivityTimer
        ld (HL),$F3
        test (RxFlags).0   ; RxInPacket
        jrs T,Rx_PacketStart
        jp (RxResume)

Rx_PacketStart:
; [C] first byte: must be 0x88 (0x11 bit-reversed)
        ld HL,Sio2Buf
        ld A,(HL)
        test (RxErrFlags).4   ; SyncLostBusy
        jr F,Rx_SyncLost
        cmp A,$11
        jr F,Rx_SyncLost
        test (Status).2   ; StPaperJam
        jrs F,LB39D
        test (SysFlags).5   ; PowerOnLock
        jr F,Rx_AbortFF
LB39D:
        ld (HL),$00
        ld (TC4CR),$C0
        ld (TREG4),$14
        ld (TC4CR),$D0
        call Rx_WaitByte
        ld HL,Sio2Buf
        ld A,(HL)
        cmp A,$CC
        jr T,Rx_Header
        jrs T,Rx_SyncLost

Rx_AbortFF:
; [C] reply 0xFF and drop the packet
        ld (HL),$FF

Rx_Exit:
; [C] end of packet
        clr (RxFlags).0   ; RxInPacket
        ld HL,(RxSavedEIR)
        ld (EIR),HL
        reti

Rx_SyncLost:
; [C] bad first byte: Init if idle, answer 0xFF until the inter-byte timeout
        test (JobFlags).1   ; Printing
        jrs F,LB3C4
        set (CmdRequests).7   ; ReqInit
LB3C4:
        ld (HL),$FF
        ld HL,ActivityTimer
        ld (HL),$F3
        test (Status).6   ; StBusy
        jrs T,LB3D0
        set (RxErrFlags).4   ; SyncLostBusy
LB3D0:
        ld (TC4CR),$C0
        ld (TREG4),$14
        ld (TC4CR),$D0
        call Rx_WaitByte
        ld HL,Sio2Buf
        ld A,(HL)
        jr LB3C4

Rx_Header:
; [C] command, compression, length; checksum starts
        ld (HL),$00
        ld (TC4CR),$C0
        ld (TC4CR),$D0
        call Rx_WaitByte
        ld HL,PktCommand
        ld DE,Sio2Buf
        ld A,(DE)
        ld (DE),$00
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        ld A,W
        ld (HL),A
        ld W,$00
        ld HL,PktChecksum
        ld (HL),WA
        ld (TC4CR),$C0
        ld (TC4CR),$D0
        call Rx_WaitByte
        ld HL,PktCompress
        ld DE,Sio2Buf
        ld A,(DE)
        ld (DE),$00
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        ld A,W
        ld (HL),A
        ld HL,PktChecksum
        ld DE,(HL)
        ld W,$00
        add WA,DE
        ld (HL),WA
        ld (TC4CR),$C0
        ld (TC4CR),$D0
        call Rx_WaitByte
        ld HL,PktLength
        ld DE,Sio2Buf
        ld A,(DE)
        ld (DE),$00
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        ld A,W
        ld (HL),A
        ld HL,PktChecksum
        ld DE,(HL)
        ld W,$00
        add WA,DE
        ld (HL),WA
        ld (TC4CR),$C0
        ld (TC4CR),$D0
        call Rx_WaitByte
        ld HL,$03EF
        ld DE,Sio2Buf
        ld A,(DE)
        ld (DE),$00
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        ld A,W
        ld (HL),A
        ld HL,PktChecksum
        ld DE,(HL)
        ld W,$00
        add WA,DE
        ld (HL),WA
        ld (TC4CR),$C0
        ld (TC4CR),$D0
        ld HL,PktRemaining
        ld DE,PktLength
        ld WA,(DE)
        ld (HL),WA

Rx_CheckCommand:
; [C]
        clr (RxErrFlags).1   ; RxIgnored
        clr (RxFlags).3   ; RxIsData
        clr (RxErrFlags).7   ; DataAbort
        ld HL,PktCommand
        cmp (HL),$0F
        jrs F,LB4ED
        clr (SysFlags).1   ; EndMarkMask
        test (JobFlags).1   ; Printing
        jrs F,LB4EF
        test (Status).2   ; StPaperJam
        jrs F,LB4EF
        clr (Status).4   ; StUnprocessed
        jr LB4EF
LB4ED:
        clr (RxErrFlags).0   ; PacketError
LB4EF:
        cmp (HL),$01
        jrs F,LB4FE
        test (Status).6   ; StBusy
        jrs F,LB4F9
        jp Rx_ReadArgs
LB4F9:
        set (Status).4   ; StUnprocessed
        jp Rx_OtherCommand
LB4FE:
        cmp (HL),$04
        jrs T,LB505
        jp Rx_OtherCommand
LB505:
        test (Status).6   ; StBusy
        jrs T,Rx_Data
        jp Rx_DataWhileBusy

Rx_Data:
; [C] data packet checks
        ld HL,PktRemaining
        ld WA,(HL)
        cmp WA,$0400
        jr CS,LB519
        jp Rx_DataTooLong
LB519:
        cmp WA,$0000
        jr F,LB536
        ld HL,PktCommand
        ld A,(HL+1)
        jr NZ,LB531
        set (Status).5   ; StImageFull
        jrs F,LB531
        set (SysFlags).1   ; EndMarkMask
        set (RxFlags).5   ; RxEndMark
        jp Rx_Checksum
LB531:
        set (RxErrFlags).0   ; PacketError
        jp Rx_Checksum
LB536:
        test (RxErrFlags).5   ; BreakBlock
        jrs T,LB53E
        set (RxErrFlags).0   ; PacketError
        jp Rx_IgnorePayload
LB53E:
        clr (JobFlags).0   ; AfterPrint
        jr T,LB56C
        ld HL,Sio2Buf
        test (Status).4   ; StUnprocessed
        jrs T,LB54B
        jp Rx_AbortFF
LB54B:
        clr (Status).5   ; StImageFull
        clr (SysFlags).0   ; MemFull
        clr (DecodeFlags).1   ; Decoding
        clr (DecodeFlags).2   ; DecodeStarted
        clr (RxFlags).4   ; RxDataOk
        clr (RxFlags).5   ; RxEndMark
        ldw (SlotBase),$0000
        ldw (PrintReadPos),$0000
        ldw (ImageBytes),$0000
        ld HL,RingBuf
        ld (RingWr),HL
        ld (RingRd),HL
LB56C:
        test (Status).5   ; StImageFull
        jrs T,LB572
        jp Rx_SkipWithError
LB572:
        ld HL,PktCompress
        ld A,(HL)
        cmp A,$01
        jr LE,LB57D
        jp Rx_SkipWithError
LB57D:
        test (HL).0
        ld (RxFlags).6,CF   ; RxCompressed
        set (RxFlags).3   ; RxIsData
        set (DecodeFlags).0   ; DataPending
        set (RxFlags).7   ; RxActive

Rx_DataPayload:
; [C] payload bytes into the ring buffer
        test (Status).6   ; StBusy
        jrs T,LB599
        set (RxErrFlags).7   ; DataAbort
        ld HL,RingBuf
        ld (RingWr),HL
        ld (RingRd),HL
        jp Rx_IgnorePayload
LB599:
        call Rx_WaitByte
        ld DE,RingWr
        ld HL,(DE)
        ld DE,Sio2Buf
        ld A,(DE)
        ld (DE),$00
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        ld A,W
        ld (HL),A
        inc HL
        cmp HL,$0413
        jr LE,LB5CD
        ld HL,RingBuf
LB5CD:
        ld DE,RingWr
        ld (DE),HL
        ld DE,PktChecksum
        ld HL,(DE)
        ld W,$00
        add WA,HL
        ld (DE),WA
        ld (TC4CR),$C0
        ld (TC4CR),$D0
        ld HL,PktRemaining
        ld WA,(HL)
        dec WA
        jr Z,Rx_Checksum
        ld (HL),WA
        jr Rx_DataPayload

Rx_Checksum:
; [C] checksum bytes; the status reply is built before the comparison
        call Rx_WaitByte
        ld DE,Sio2Buf
        ld A,(DE)
        ld (DE),$00
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        ld A,W
        ld W,$00
        ld DE,WA
        ld HL,PktChecksum
        ld WA,(HL)
        sub WA,DE
        ld (HL),WA
        ld (TC4CR),$C0
        ld (TC4CR),$D0
        test (RxErrFlags).0   ; PacketError
        jrs F,LB62D
        clr (Status).3   ; StPacketError
        jr LB62F
LB62D:
        set (Status).3   ; StPacketError
LB62F:
        ld A,(Status)
        test (SysFlags).1   ; EndMarkMask
        jrs T,LB636
        and A,$DF
LB636:
        test (Status).0   ; StLowBattery
        jrs T,LB63E
        test (RxFlags).1   ; LowBatHold
        jrs T,LB63E
        and A,$FE
LB63E:
        test (RxFlags).3   ; RxIsData
        jrs T,LB646
        test (RxErrFlags).1   ; RxIgnored
        jrs F,LB646
        and A,$BF
LB646:
        ld B,A
        call Rx_WaitByte
        ld (TC4CR),$C0
        ld (TC4CR),$D0
        ld DE,Sio2Buf
        ld A,(DE)
        ld (DE),$00
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        ld A,W
        ld A,$00
        ld DE,WA
        ld HL,PktChecksum
        ld WA,(HL)
        sub WA,DE
        jr NZ,LB682
        clr (Status).7   ; StChecksumErr
        jr Rx_Reply
LB682:
        ld HL,PktCommand
        cmp (HL),$02
        jrs T,LB68F
        cmp (HL),$08
        jrs T,LB68F
        clr (Status).5   ; StImageFull
LB68F:
        set (Status).7   ; StChecksumErr

Rx_Reply:
; [C] queue 0x81 and the status byte
        ld (SIO2CR1),$67
        ld (SIO2CR2),$01
        ld HL,Sio2Buf
        ld (HL+),$81
        ld (HL),B
        ld (SIO2CR1),$A7
        call Rx_WaitByte
        ld HL,Sio2Buf
        ld (HL),$00
        clr (RxFlags).7   ; RxActive
        test (Status).0   ; StLowBattery
        jrs T,LB6B7
        test B.0
        jrs T,LB6B7
        ld (LowBatTimer),$6D
        set (RxFlags).2   ; LowBatReported
LB6B7:
        ld (SIO2CR1),$67
        ld (SIO2CR2),$00
        ld (SIO2CR1),$A7
        ld (TC4CR),$C0
        test (RxErrFlags).1   ; RxIgnored
        jrs T,Rx_PostCommand
        jp Rx_Exit

Rx_PostCommand:
; [C] post the command to the main loop if no error
        test (RxFlags).3   ; RxIsData
        jr F,LB728
        test (Status).7   ; StChecksumErr
        jrs T,LB6D3
        jp Rx_Exit
LB6D3:
        test (Status).3   ; StPacketError
        jrs T,LB6D9
        jp Rx_Exit
LB6D9:
        ld HL,PktCommand
        cmp (HL),$01
        jr F,LB6FF
        test (Status).6   ; StBusy
        jrs T,LB6E9
        cmp (MechState),$17
        jrs F,LB6F4
LB6E9:
        set (CmdRequests).7   ; ReqInit
        clr (RxFlags).0   ; RxInPacket
        ld HL,(RxSavedEIR)
        ld (EIR),HL
        reti
LB6F4:
        set (JobFlags).6   ; InitDeferred
        clr (RxFlags).0   ; RxInPacket
        ld HL,(RxSavedEIR)
        ld (EIR),HL
        reti
LB6FF:
        cmp (HL),$02
        jrs F,LB70E
        set (CmdRequests).6   ; ReqPrint
        clr (RxFlags).0   ; RxInPacket
        ld HL,(RxSavedEIR)
        ld (EIR),HL
        reti
LB70E:
        cmp (HL),$08
        jrs F,LB71D
        set (CmdRequests).5   ; ReqBreak
        clr (RxFlags).0   ; RxInPacket
        ld HL,(RxSavedEIR)
        ld (EIR),HL
        reti
LB71D:
        set (CmdRequests).4   ; ReqStatus
        clr (RxFlags).0   ; RxInPacket
        ld HL,(RxSavedEIR)
        ld (EIR),HL
        reti
LB728:
        ld A,(Status)
        and A,$88
        jr NZ,LB739
        set (RxFlags).4   ; RxDataOk
        clr (RxFlags).0   ; RxInPacket
        ld HL,(RxSavedEIR)
        ld (EIR),HL
        reti
LB739:
        set (RxErrFlags).7   ; DataAbort
        clr (RxFlags).0   ; RxInPacket
        ld HL,(RxSavedEIR)
        ld (EIR),HL
        reti

Rx_OtherCommand:
; [C] print / break / status / unknown
        cmp (HL),$02
        jr F,LB761
        test (JobFlags).1   ; Printing
        jrs T,LB74F
        jp Rx_IgnorePayload
LB74F:
        test (RxFlags).5   ; RxEndMark
        jrs T,LB75D
        ld HL,PktRemaining
        ld WA,(HL)
        cmp WA,$0004
        jr CC,Rx_ReadArgs
LB75D:
        set (RxErrFlags).0   ; PacketError
        jr Rx_ReadArgs
LB761:
        cmp (HL),$08
        jrs F,LB774
        ld HL,PktRemaining
        ld WA,(HL)
        cmp WA,$0400
        jr CS,Rx_ReadArgs
        set (RxErrFlags).0   ; PacketError
        jr Rx_ReadArgs
LB774:
        cmp (HL),$0F
        jrs T,LB77B
        jp Rx_IgnorePayload
LB77B:
        ld HL,PktRemaining
        ld WA,(HL)
        cmp WA,$0400
        jr CS,Rx_ReadArgs
        set (RxErrFlags).0   ; PacketError

Rx_ReadArgs:
; [C] keep up to 4 payload bytes in PktArgs
        ld HL,PktArgs
        ld (HL+),$00
        ld (HL+),$00
        ld (HL+),$00
        ld (HL),$00
        ld HL,PktRemaining
        ld WA,(HL)
        cmp WA,$0000
        jrs F,LB7A3
        jp Rx_Checksum
LB7A3:
        cmp WA,$03FF
        jr LE,LB7AC
        jp Rx_SkipWithError
LB7AC:
        cmp WA,$0004
        jr LE,LB7B8
        ld HL,PktRemaining
        ldw (HL),$0004
LB7B8:
        call Rx_WaitByte
        ld HL,PktRemaining
        ld W,(HL)
        ld A,$04
        sub A,W
        ld W,$00
        ld HL,PktArgs
        add WA,HL
        ld HL,WA
        ld DE,Sio2Buf
        ld A,(DE)
        ld (DE),$00
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        ld A,W
        ld (HL),A
        ld D,$00
        ld E,A
        ld HL,PktChecksum
        ld WA,(HL)
        add WA,DE
        ld (HL),WA
        ld (TC4CR),$C0
        ld (TC4CR),$D0
        ld HL,PktRemaining
        ld WA,(HL)
        dec WA
        jr Z,LB80D
        ld (HL),WA
        jr LB7B8
LB80D:
        ld HL,PktLength
        ld WA,(HL)
        cmp WA,$0004
        jr GT,LB81B
        jp Rx_Checksum
LB81B:
        sub WA,$0004
        ld HL,PktRemaining
        ld (HL),WA
LB824:
        call Rx_WaitByte
        ld DE,Sio2Buf
        ld A,(DE)
        ld (DE),$00
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        ld A,W
        ld D,$00
        ld E,A
        ld HL,PktChecksum
        ld WA,(HL)
        add WA,DE
        ld (HL),WA
        ld (TC4CR),$C0
        ld (TC4CR),$D0
        ld HL,PktRemaining
        ld WA,(HL)
        dec WA
        jr NZ,LB865
        jp Rx_Checksum
LB865:
        ld (HL),WA
        jr LB824

Rx_SkipWithError:
; [C] packet error; sum and drop the payload
        set (RxErrFlags).0   ; PacketError
LB86B:
        call Rx_WaitByte
        ld DE,Sio2Buf
        ld A,(DE)
        ld (DE),$00
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        ld A,W
        ld D,$00
        ld E,A
        ld HL,PktChecksum
        ld WA,(HL)
        add WA,DE
        ld (HL),WA
        ld (TC4CR),$C0
        ld (TC4CR),$D0
        ld HL,PktRemaining
        ld WA,(HL)
        dec WA
        jr NZ,LB8AC
        jp Rx_Checksum
LB8AC:
        ld (HL),WA
        jr LB86B

Rx_DataTooLong:
; [C] length >= 0x400
        ld HL,PktCommand
        ld A,(HL+1)
        jr NZ,LB8D1
        set (RxErrFlags).0   ; PacketError
        jr LB8D1

Rx_DataWhileBusy:
; [C]
        set (RxFlags).7   ; RxActive

Rx_IgnorePayload:
; [C] ignored packet: payload summed (or skipped while busy)
        set (RxErrFlags).1   ; RxIgnored
        test (Status).6   ; StBusy
        jr F,LB916
        ld HL,PktRemaining
        ld WA,(HL)
        cmp WA,$0000
        jrs F,LB8D1
        jp Rx_Checksum
LB8D1:
        call Rx_WaitByte
        ld DE,Sio2Buf
        ld A,(DE)
        ld (DE),$00
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        ld A,W
        ld D,$00
        ld E,A
        ld HL,PktChecksum
        ld WA,(HL)
        add WA,DE
        ld (HL),WA
        ld (TC4CR),$C0
        ld (TC4CR),$D0
        ld HL,PktRemaining
        ld WA,(HL)
        dec WA
        jr NZ,LB912
        jp Rx_Checksum
LB912:
        ld (HL),WA
        jr LB8D1
LB916:
        ld HL,PktRemaining
        ld WA,(HL)
        cmp WA,$0000
        jr T,LB93E
LB921:
        call Rx_WaitByte
        ld DE,Sio2Buf
        ld A,(DE)
        ld (DE),$00
        ld (TC4CR),$C0
        ld (TC4CR),$D0
        ld HL,PktRemaining
        ld WA,(HL)
        dec WA
        jr Z,LB93E
        ld (HL),WA
        jr LB921
LB93E:
        call Rx_WaitByte
        ld DE,Sio2Buf
        ld A,(DE)
        ld (DE),$00
        ld (TC4CR),$C0
        ld (TC4CR),$D0
        test (RxErrFlags).0   ; PacketError
        jrs F,LB956
        clr (Status).3   ; StPacketError
        jr LB958
LB956:
        set (Status).3   ; StPacketError
LB958:
        ld A,(Status)
        test (SysFlags).1   ; EndMarkMask
        jrs T,LB95F
        and A,$DF
LB95F:
        test (Status).0   ; StLowBattery
        jrs T,LB967
        test (RxFlags).1   ; LowBatHold
        jrs T,LB967
        and A,$FE
LB967:
        test (RxFlags).3   ; RxIsData
        jrs T,LB96F
        test (RxErrFlags).1   ; RxIgnored
        jrs F,LB96F
        and A,$BF
LB96F:
        ld B,A
        call Rx_WaitByte
        ld DE,Sio2Buf
        ld A,(DE)
        ld (DE),$00
        ld (TC4CR),$C0
        ld (TC4CR),$D0
        jp Rx_Reply

Sub_BitReverse_Unused:
; [C] unreferenced: A = bit-reversed A (the receiver inlines the same code); dead
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        shrc A
        rolc W
        ld A,W
        ret

Int_TC4_ByteTimeout:
; [C] no byte for 5.12 ms: abort the packet, roll back data
        ld (TC4CR),$C0
        ld (TREG4),$14
        clr (RxFlags).0   ; RxInPacket
        ld (SIO2CR1),$67
        ld (SIO2CR2),$00
        ld (SIO2CR1),$A7
        set (RxErrFlags).7   ; DataAbort
        clr (RxFlags).7   ; RxActive
        reti

Rx_WaitByte:
; [C] save the return address in RxResume and leave the interrupt
        set (RxFlags).0   ; RxInPacket
        pop HL
        ld (RxResume),HL
        ld HL,(RxSavedEIR)
        ld (EIR),HL
        reti
