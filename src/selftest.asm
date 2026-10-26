; SRAM test and self-test image


Boot_SramTest:
; [C] write and read back 0x1680 SRAM bytes; failure = other error (0x40)
        ld BC,$0000
        ld D,$00
LDD8A:
        ld A,D
        call Sram_Write
        inc D
        inc BC
        cmp BC,$1680
        jr CS,LDD8A
        ld BC,$0000
        ld D,$00
LDD9B:
        call Sram_Read
        cmp A,D
        jrs F,LDDAA
        inc D
        inc BC
        cmp BC,$1680
        jr CS,LDD9B
        ret
LDDAA:
        set (Status).1   ; StOtherError
        ret

SelfTest_Load:
; [C] copy the self-test band to SRAM as one data packet
        ld HL,Gfx_SelfTestBand
        ld BC,$0000
        ld W,$00
LDDB5:
        ld D,$13
LDDB7:
        push HL
        ld E,$0F
LDDBB:
        ld A,(HL+)
        call Sram_Write
        inc BC
        dec E
        jrs F,LDDBB
        pop HL
        push HL
        add HL,$0140
        ld E,$0F
LDDCD:
        ld A,(HL+)
        call Sram_Write
        inc BC
        dec E
        jrs F,LDDCD
        pop HL
        add HL,$0010
        dec D
        jr F,LDDB7
        add HL,$0140
        dec W
        jr F,LDDB5
        ldw (PrintReadPos),$0000
        ldw (ImageBytes),$0280
        ret

Gfx_SelfTestBand:
; [C] self-test image: 640 bytes, 20 x 2 tiles 2bpp (160 x 16 px)
; bytes DDEE-E06D: [C] 2bpp tiles
        incbin "data/selftest_band.2bpp"   ; 640 bytes
