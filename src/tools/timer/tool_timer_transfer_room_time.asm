    // stage changed, transfer room time
    lda {timerRoomTimerCurrentFrames}
    sta {timerRoomTimerPreviousFrames}
    clc 
    adc {timerLevelTimerFrames}
    cmp #60
    bcc +
    inc {timerLevelTimerSeconds}
    sec 
    sbc #60
+;  sta {timerLevelTimerFrames}


    lda {timerRoomTimerCurrentSeconds}
    sta {timerRoomTimerPreviousSeconds}
    clc 
    adc {timerLevelTimerSeconds}
    cmp #60
    bcc +
    inc {timerLevelTimerMinutes}
    sec 
    sbc #60
+;  sta {timerLevelTimerSeconds}

    lda {timerRoomTimerCurrentMinutes}
    sta {timerRoomTimerPreviousMinutes}
    clc 
    adc {timerLevelTimerMinutes}
    cmp #10
    bcc +
    lda #9
    sta {timerLevelTimerMinutes}
    lda #59
    sta {timerLevelTimerSeconds}
    sta {timerLevelTimerFrames}

+;  lda #$00
    sta {timerRoomTimerCurrentMinutes}
    sta {timerRoomTimerCurrentSeconds}
    sta {timerRoomTimerCurrentFrames}