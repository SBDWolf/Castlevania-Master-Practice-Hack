print_scroll_glitch_fail:
    ldx {tileDataPointer}

    lda #$01
    sta {PPUBuffer},x
    inx 
    lda #$20
    sta {PPUBuffer},x
    inx 
    ldy {scrollGlitchDiagnosticHudCursor}
    lda lookupTable_scrollGlitchDiagnosticHudDestinations,y
    sta {PPUBuffer},x
    iny 
    iny 
    cpy {SCROLLGLITCHDIAGNOSTIC_MaxHudCursorValue}
    bne + 
    ldy #$00
+;  sty {scrollGlitchDiagnosticHudCursor}
    inx 

    lda #$DC
    sta {PPUBuffer},x
    inx 


    lda #$FF
    sta {PPUBuffer},x
    inx 

    stx {tileDataPointer}
    rts 