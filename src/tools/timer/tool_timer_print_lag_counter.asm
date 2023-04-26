    // backup tool index onto the stack
    txa 
    pha 

    ldx {tileDataPointer}

    lda #$01
    sta {PPUBuffer},x
    inx
    lda #$20
    sta {PPUBuffer},x
    inx
    lda #$20
    sta {PPUBuffer},x
    inx

    
    ldy {totalLagFrameCounter}
    lda tens_digits_table,y
    sta {PPUBuffer},x
    inx 
    lda ones_digits_table,y
    sta {PPUBuffer},x
    inx 

    lda #$FF
    sta {PPUBuffer},x
    inx 

    stx {tileDataPointer}

    // restore tool index
    pla 
    tax 