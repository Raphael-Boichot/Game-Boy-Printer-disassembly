; Head energy and timing tables


Tab_EnergyByHistory:
; [C] energy code by (previous dot, current dot), index prev*16+cur: white 0; black after white 0x6B, after black 0x4A
; bytes CCB6-CCF5: [C] Tab_EnergyByHistory (rows = previous dot)
        db $00, $3B, $52, $6B, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        db $00, $29, $45, $65, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        db $00, $25, $36, $60, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        db $00, $21, $2B, $4A, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

Tab_DotTicks:
; [C] 256 pairs (first tick, tick count) by energy code: the dot's on-window inside the 33-tick burst
; bytes CCF6-CEF5: [C] Tab_DotTicks
        incbin "data/dot_ticks.bin"   ; 512 bytes

Tab_HeatBaseByTemp:
; [C] 256 bytes: strobe base time by temperature reading
; bytes CEF6-CFF5: [C] Tab_HeatBaseByTemp
        incbin "data/heat_base_by_temp.bin"   ; 256 bytes

Tab_ExposureOffset:
; [C] 128 signed bytes: offset by exposure (-16 at 0x00, -7 at 0x40, +1 at 0x7F)
; bytes CFF6-D075: [C] Tab_ExposureOffset
        incbin "data/exposure_offset.bin"   ; 128 bytes

Tab_IdleCoolByTemp:
; [C] signed heat change per column of a white dot, by temperature (-> 0xF9)
; bytes D076-D175: [I] Tab_ParamByTemp
        incbin "data/idle_cool_by_temp.bin"   ; 256 bytes

Tab_HeatAddByCode:
; [C] heat added per column by a continuing dot, by energy code
        incbin "data/heat_add_by_code.bin"   ; 256 bytes

Tab_HeatAddFreshByTemp:
; [C] 256 words: heat added by a dot that follows a white one, by temperature
; words D276-D475: [C] Tab_HeatAddFreshByTemp
        incbin "data/heat_add_fresh_by_temp.bin"   ; 512 bytes

Tab_HeatCorr0:
; [C] energy correction for grey level 0, by row heat (RowHeatInt)
        incbin "data/heat_corr_0.bin"   ; 256 bytes

Tab_HeatCorr1:
; [C] energy correction for grey level 1, by row heat (RowHeatInt)
        incbin "data/heat_corr_1.bin"   ; 256 bytes

Tab_HeatCorr2:
; [C] energy correction for grey level 2, by row heat (RowHeatInt)
        incbin "data/heat_corr_2.bin"   ; 256 bytes

Tab_HeatCorr3:
; [C] energy correction for grey level 3, by row heat (RowHeatInt)
        incbin "data/heat_corr_3.bin"   ; 256 bytes

Tab_BandCoolByTemp:
; [C] 256 words: heat removed from every row at a band change, by temperature
; words D876-DA75: [C] Tab_BandCoolByTemp
        incbin "data/band_cool_by_temp.bin"   ; 512 bytes

Tab_DecayByTemp:
; [C] per-tick heat decay factor (/256), by temperature
        incbin "data/decay_by_temp.bin"   ; 256 bytes

Tab_TickCurvePtrsWarm:
; [C] 9 pointers (one per band) into Tab_TickCurvesWarm
; words DB76-DB87: [C] band curve pointers
        dw Tab_TickCurvesWarm_Band0, Tab_TickCurvesWarm_Band1, Tab_TickCurvesWarm_Band2, Tab_TickCurvesWarm_Band3, Tab_TickCurvesWarm_Band4
        dw Tab_TickCurvesWarm_Band5, Tab_TickCurvesWarm_Band6, Tab_TickCurvesWarm_Band7, Tab_TickCurvesWarm_Band8

Tab_TickCurvesWarm:
; [C] 9 curves x 25 steps: strobe tick length (us) per step of a band, head warm
; bytes DB88-DC68: [C] one row per band
Tab_TickCurvesWarm_Band0:
        db $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $66, $64, $62, $61, $60, $5F, $5E, $5E, $5D, $5D, $64, $64, $64
Tab_TickCurvesWarm_Band1:
        db $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $62, $60, $5F, $5E, $5D, $5D, $5C, $5B, $5B, $5B, $64, $64, $64
Tab_TickCurvesWarm_Band2:
        db $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $61, $5E, $5E, $5C, $5B, $5B, $5A, $5A, $59, $59, $64, $64, $64
Tab_TickCurvesWarm_Band3:
        db $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $5F, $5D, $5D, $5C, $5B, $5A, $59, $59, $59, $59, $64, $64, $64
Tab_TickCurvesWarm_Band4:
        db $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $5E, $5C, $5B, $5A, $5A, $59, $59, $58, $58, $58, $64, $64, $64
Tab_TickCurvesWarm_Band5:
        db $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $5D, $5B, $5A, $59, $59, $59, $58, $58, $57, $57, $64, $64, $64
Tab_TickCurvesWarm_Band6:
        db $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $5C, $5A, $59, $59, $58, $57, $56, $56, $56, $56, $64, $64, $64
Tab_TickCurvesWarm_Band7:
        db $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $5C, $5A, $59, $59, $58, $57, $57, $57, $56, $56, $64, $64, $64
Tab_TickCurvesWarm_Band8:
        db $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $5C, $5A, $59, $59, $58, $57, $57, $57, $56, $56, $64, $64, $64

Tab_TickCurvePtrsCold:
; [C] 9 pointers into Tab_TickCurvesCold
; words DC69-DC7A: [C] band curve pointers
        dw Tab_TickCurvesCold_Band0, Tab_TickCurvesCold_Band1, Tab_TickCurvesCold_Band2, Tab_TickCurvesCold_Band3, Tab_TickCurvesCold_Band4
        dw Tab_TickCurvesCold_Band5, Tab_TickCurvesCold_Band6, Tab_TickCurvesCold_Band7, Tab_TickCurvesCold_Band8

Tab_TickCurvesCold:
; [C] 9 curves x 25 steps: tick length when every row heat is zero (slightly longer)
; bytes DC7B-DD5B: [C] one row per band
Tab_TickCurvesCold_Band0:
        db $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $67, $66, $64, $62, $62, $61, $60, $5F, $5F, $5F, $64, $64, $64
Tab_TickCurvesCold_Band1:
        db $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $60, $5E, $5E, $5D, $5C, $5B, $5A, $5A, $5A, $64, $64, $64
Tab_TickCurvesCold_Band2:
        db $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $5E, $5C, $5B, $5A, $59, $59, $58, $58, $58, $58, $64, $64, $64
Tab_TickCurvesCold_Band3:
        db $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $5C, $5A, $59, $58, $58, $58, $57, $56, $56, $56, $64, $64, $64
Tab_TickCurvesCold_Band4:
        db $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $5B, $59, $58, $57, $56, $56, $55, $55, $55, $54, $64, $64, $64
Tab_TickCurvesCold_Band5:
        db $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $5A, $58, $57, $56, $56, $55, $55, $54, $53, $53, $64, $64, $64
Tab_TickCurvesCold_Band6:
        db $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $59, $57, $57, $55, $55, $54, $54, $54, $53, $53, $64, $64, $64
Tab_TickCurvesCold_Band7:
        db $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $59, $55, $55, $54, $53, $53, $53, $53, $52, $52, $64, $64, $64
Tab_TickCurvesCold_Band8:
        db $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $64, $59, $55, $55, $54, $53, $53, $52, $52, $51, $51, $64, $64, $64

Tab_TickTrimBySoak:
; [C] 41 values subtracted from the tick length, by HeatSoak (bands since the head was cold)
        db $00, $01, $03, $04, $06, $07, $08, $08, $09, $09, $0A, $0A, $0A, $0A, $0A, $0B
        db $0B, $0B, $0B, $0B, $0C, $0C, $0C, $0C, $0C, $0D, $0D, $0D, $0D, $0D, $0E, $0E
        db $0E, $0E, $0E, $0F, $0F, $0F, $0F, $0F, $0F
