; SRAM test and self-test image


;==============================================================================
; Boot_SramTest  [C]
;   Power-on SRAM test: writes an incrementing pattern to the 0x1680 image
;   bytes and reads it back; a mismatch is other error (0x40). The pattern
;   stays in memory.
;   Called by: Reset
;==============================================================================
Boot_SramTest:
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

;==============================================================================
; SelfTest_Load  [C]
;   Self-test: copies the 640-byte band Gfx_SelfTestBand into SRAM in print
;   order, as if one data packet had been received (ImageBytes = 0x280).
;   Called by: Reset
;==============================================================================
SelfTest_Load:
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
