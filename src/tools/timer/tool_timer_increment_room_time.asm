    // increment timer
    inc {timerRoomTimerCurrentFrames}
    lda {timerRoomTimerCurrentFrames}
    cmp #60
    bcc +
    // set frames to 0 and process seconds
    clc 
    lda #$00
    sta {timerRoomTimerCurrentFrames}
    inc {timerRoomTimerCurrentSeconds}
    lda {timerRoomTimerCurrentSeconds}
    cmp #60
    bcc +
    // set seconds to 0 and process minutes
    clc 
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
+;