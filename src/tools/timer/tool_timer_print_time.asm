    // backup tool index onto the stack
    txa 
    pha 

    ldx {tileDataPointer}

    // previous room timer
    lda #$01
    sta {PPUBuffer},x
    inx
    lda #$20
    sta {PPUBuffer},x
    inx
    lda #$60
    sta {PPUBuffer},x
    inx

    
    ldy {timerRoomTimerPreviousMinutes}
    lda ones_digits_table,y
    sta {PPUBuffer},x
    inx 

    lda #$EC
    sta {PPUBuffer},x
    inx 

    ldy {timerRoomTimerPreviousSeconds}
    lda tens_digits_table,y
    sta {PPUBuffer},x
    inx 
    lda ones_digits_table,y
    sta {PPUBuffer},x
    inx 

    lda #$F7
    sta {PPUBuffer},x
    inx 

    ldy {timerRoomTimerPreviousFrames}
    lda tens_digits_table,y
    sta {PPUBuffer},x
    inx 
    lda ones_digits_table,y
    sta {PPUBuffer},x
    inx 

    lda #$FF
    sta {PPUBuffer},x
    inx 

    // level timer

    lda #$01
    sta {PPUBuffer},x
    inx
    lda #$20
    sta {PPUBuffer},x
    inx
    lda #$80
    sta {PPUBuffer},x
    inx

    ldy {timerLevelTimerMinutes}
    lda ones_digits_table,y
    sta {PPUBuffer},x
    inx 

    lda #$EC
    sta {PPUBuffer},x
    inx 

    ldy {timerLevelTimerSeconds}
    lda tens_digits_table,y
    sta {PPUBuffer},x
    inx 
    lda ones_digits_table,y
    sta {PPUBuffer},x
    inx 
    
    lda #$F7
    sta {PPUBuffer},x
    inx 

    ldy {timerLevelTimerFrames}
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