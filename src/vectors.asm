; Unused interrupt handlers, unused ROM, interrupt vectors


Int_Unused_Reti:
; [C]
        reti

Int_Unused_Retn:
; [C]
        retn

; fill E071-FFDF: [C] unused, 0xFF
; unused ROM E071-FFDF (8047 bytes): the assembler fills gaps with $FF

; words FFE0-FFFF: [C] interrupt vectors (FFE0 INT5 ... FFFE reset)
        org $FFE0
Vectors:
; FFE0 INT5, FFE2 INTTC2, FFE4 INTSIO2, FFE6 INT4, FFE8 INT3, FFEA INTTC4, FFEC INTSIO1, FFEE INTTC3,
; FFF0 INT2, FFF2 INTTBT, FFF4 INT1, FFF6 INTTC1, FFF8 INT0, FFFA INTWDT, FFFC INTSW, FFFE RESET
        dw Int_INT5_ButtonWake, Int_TC2_Tick, Int_SIO2_Receiver, Int_INT4_CamSensor
        dw Int_INT3_Encoder, Int_TC4_ByteTimeout, Int_Unused_Reti, Int_TC3_BatteryCheck
        dw Int_Unused_Reti, Int_Unused_Reti, Int_Unused_Reti, Int_TC1_StrobeTick
        dw Int_Unused_Reti, Int_Unused_Retn, Int_Unused_Retn, Reset
