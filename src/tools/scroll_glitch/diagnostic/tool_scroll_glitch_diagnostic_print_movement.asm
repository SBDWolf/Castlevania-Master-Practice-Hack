print_movement_data:
    // this functions expects the value to print to be passed to the y register
    tya 
    pha 

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
    cpy {SCROLLGLITCHDIAGNOSTIC_MaxHudCursorValue}
    bne + 
    ldy #$00
+;  sty {scrollGlitchDiagnosticHudCursor}
    inx 

    
    pla 
    tay 
    lda base24_digits_table,y
    sta {PPUBuffer},x
    inx 


    lda #$FF
    sta {PPUBuffer},x
    inx 

    stx {tileDataPointer}
    rts 