tool_timer:
    // the map screen in-between stages is considered to be "stage 20" by the game
    lda {currentStage}
    cmp {STAGE_MapScreen}
    beq onMapScreen

    // check for dracula's room. need to check for substage as well, because SYSTEMSTAGE_Win is set between stage 17 and 18
    cmp {STAGE_DraculaStage}
    bne +
    lda {currentSubStage}
    cmp {STAGE_DraculaSubStage}
    bne +
    lda {systemState}
    cmp {SYSTEMSTATE_Win}
    beq onDraculaOrbGrab

+;  lda {currentStage}
    cmp {timerPreviousFrameStage}
    bne onScreenTransition
    lda {currentSubStage}
    cmp {timerPreviousFrameSubStage}
    // current screen is exactly the same
    beq onRegularGameplay

onScreenTransition:
//    lda {timerAlreadyRanUpdatesFlag}
 //   cmp {TRUE}
//    beq +
    // update previous stage
    lda {currentStage}
    sta {timerPreviousFrameStage}
    lda {currentSubStage}
    sta {timerPreviousFrameSubStage}

    jsr transferRoomTime

    // TODO: force graphical update

    jsr incrementTimer
    lda {TRUE}
    sta {timerAlreadyRanUpdatesFlag}
    jmp tool_timerExit

onRegularGameplay:
    jsr incrementTimer
    lda {FALSE}
    sta {timerAlreadyRanUpdatesFlag}
    jmp tool_timerExit



onMapScreen:
    lda {timerAlreadyRanUpdatesFlag}
    cmp {TRUE}
    beq +

    // update previous stage
    lda {currentStage}
    sta {timerPreviousFrameStage}
    lda {currentSubStage}
    sta {timerPreviousFrameSubStage}

    jsr transferRoomTime

    // TODO: force graphical update

    // zero out level timer
    lda #$00
    sta {timerLevelTimerMinutes}
    sta {timerLevelTimerSeconds}
    sta {timerLevelTimerFrames}

    lda {TRUE}
    sta {timerAlreadyRanUpdatesFlag}

+;  jmp tool_timerExit


onDraculaOrbGrab:
    lda {timerAlreadyRanUpdatesFlag}
    cmp {TRUE}
    beq +

    jsr transferRoomTime

    // TODO: force graphical update

    // zero out level timer
    lda #$00
    sta {timerLevelTimerMinutes}
    sta {timerLevelTimerSeconds}
    sta {timerLevelTimerFrames}

    lda {TRUE}
    sta {timerAlreadyRanUpdatesFlag}

+;  jmp tool_timerExit


transferRoomTime:
    incsrc "src/tools/timer/tool_timer_transfer_room_time.asm"
    rts 
incrementTimer:
    incsrc "src/tools/timer/tool_timer_increment_room_time.asm"
    rts 

tool_timerExit:
    // execute next tool
    inx 
    inx 
    lda ({toolsToRunPointerList}),x
    sta $00
    lda ({toolsToRunPointerList})+1,x
    sta $01

    jmp ($0000)