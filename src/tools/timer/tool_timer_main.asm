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

    // check for door transition.
    // on left-facing doors specifically, the stage index increments as soon as you touch the door, as opposed to after with right-facing ones.
    // this makes it so that onScreenTransition doesn't get run in those circumstances, until simon has fully gone through the door.
+;  lda {systemState}
    cmp {SYSTEMSTATE_DoorTransition}
    beq onRegularGameplay


    // don't go to onScreenTransition if the current stage is the first screen. this fixes a 1-frame room that would exist after credits.
    lda {currentStage}
    beq onRegularGameplay

    // check if we've changed room
    cmp {timerPreviousFrameStage}
    bne onScreenTransition
    lda {currentSubStage}
    cmp {timerPreviousFrameSubStage}   
    bne onScreenTransition
    // fall-through to onRegularGameplay

// current screen is exactly the same
onRegularGameplay:
    jsr incrementTimer
    lda {FALSE}
    sta {timerAlreadyRanUpdatesFlag}
    jmp tool_timerExit



onScreenTransition:
//    lda {timerAlreadyRanUpdatesFlag}
//    cmp {TRUE}
//    beq +
    // update previous stage
    lda {currentStage}
    sta {timerPreviousFrameStage}
    lda {currentSubStage}
    sta {timerPreviousFrameSubStage}

    // transfer room time
    jsr transferRoomTime

    // force graphical update
    jsr printRoomAndLevelTime

    jsr incrementTimer
    lda {TRUE}
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

    // transfer room time
    jsr transferRoomTime

    // force graphical update
    jsr printRoomAndLevelTime

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

    // transfer room time
    jsr transferRoomTime

    // force graphical update
    jsr printRoomAndLevelTime

    // zero out level timer
    lda #$00
    sta {timerLevelTimerMinutes}
    sta {timerLevelTimerSeconds}
    sta {timerLevelTimerFrames}

    // set previous stage to 00. this allows the timer to not bug out when starting level 1 on the next loop.
    lda #$00
    sta {timerPreviousFrameStage}
    lda #$01
    sta {timerPreviousFrameSubStage}

    lda {TRUE}
    sta {timerAlreadyRanUpdatesFlag}

+;  jmp tool_timerExit


transferRoomTime:
    incsrc "src/tools/timer/tool_timer_transfer_room_time.asm"
    rts 
incrementTimer:
    incsrc "src/tools/timer/tool_timer_increment_room_time.asm"
    rts 
printRoomAndLevelTime:
    incsrc "src/tools/timer/tool_timer_print_time.asm"
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