    // increment timer
    // uses consecutiveLagFramesCounter to calculate how many frames should be added to the timer while keeping lag into account
    inc {consecutiveLagFramesCounter}
    lda {consecutiveLagFramesCounter}
    clc 
    adc {timerRoomTimerCurrentFrames}
    sta {timerRoomTimerCurrentFrames}

    cmp #60
    bcc +
    // subtract 60 from frames and process seconds
    sec 
    sbc #60
    sta {timerRoomTimerCurrentFrames}
    inc {timerRoomTimerCurrentSeconds}
    lda {timerRoomTimerCurrentSeconds}
    cmp #60
    bcc +
    // set seconds to 0 and process minutes. no need to subtract 60 from the seconds this time, the game is never gonna lag for more than a second
    clc // is this clc necessary?
    lda #$00
    sta {timerRoomTimerCurrentSeconds}
    inc {timerRoomTimerCurrentMinutes}
    lda {timerRoomTimerCurrentMinutes}
    cmp #10
    bcc +
    // cap timer if it hits 9:59.59
    lda #9
    sta {timerRoomTimerCurrentMinutes}
    lda #59
    sta {timerRoomTimerCurrentSeconds}
    sta {timerRoomTimerCurrentFrames}

    // clear consecutiveLagFramesCounter so that it can be processed properly the next frame the timer runs
+;  lda #$00
    sta {consecutiveLagFramesCounter}