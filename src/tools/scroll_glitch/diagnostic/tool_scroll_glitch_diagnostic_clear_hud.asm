clear_movement_data_part1:
    ldx {tileDataPointer}

    lda #$01
    sta {PPUBuffer},x
    inx 
    lda #$20
    sta {PPUBuffer},x
    inx 
    ldy #$00
    lda lookupTable_scrollGlitchDiagnosticHudDestinations,y
    sta {PPUBuffer},x
    inx 
    lda #$00
-;  sta {PPUBuffer},x
    iny 
    inx 
    cpy {SCROLLGLITCHDIAGNOSTIC_MaxHudCursorValue}/$2
    bcc - 

    lda #$FF
    sta {PPUBuffer},x
    inx 

    stx {tileDataPointer}
    rts 

clear_movement_data_part2:
    ldx {tileDataPointer}

    lda #$01
    sta {PPUBuffer},x
    inx 
    lda #$20
    sta {PPUBuffer},x
    inx 
    ldy #$01
    lda lookupTable_scrollGlitchDiagnosticHudDestinations,y
    sta {PPUBuffer},x
    inx 
    dey 
    lda #$00
-;  sta {PPUBuffer},x
    iny 
    inx 
    cpy {SCROLLGLITCHDIAGNOSTIC_MaxHudCursorValue}/$2
    bcc - 

    lda #$FF
    sta {PPUBuffer},x
    inx 

    stx {tileDataPointer}
    rts 