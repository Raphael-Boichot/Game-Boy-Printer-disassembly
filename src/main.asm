; Game Boy Printer firmware (TMP87C840 / TMP87PM40AF), editable source.
; Build: make   (or: python3 tools/t870asm.py src/main.asm build/printer.bin)
; Check: make check   (md5 aa393ec87ccb4220200255ab5adf8ac9)
; Generated once by tools/make_source.py; regenerating overwrites src/.

include "hardware.inc"
include "ram.inc"

        org $8000
include "reset.asm"   ; 8000
include "main_loop.asm"   ; 80D5
include "line_pipeline.asm"   ; 8808
include "data_decoder.asm"   ; A2ED
include "interrupts_mech.asm"   ; AA7E
include "receiver.asm"   ; B370
include "column.asm"   ; B9C2
include "tables.asm"   ; CCB6
include "selftest.asm"   ; DD85
include "vectors.asm"   ; E06E
