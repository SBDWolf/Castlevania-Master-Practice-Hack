        lda {currentSubStage}
        bne stage13Pass

        lda {rightBookendColumn}
        cmp #$10
        bne stage13Pass

        // execute the code for the appropriate phase we're in
        ldx {scrollGlitchDiagnosticPhaseCounter}
        txa 
        asl 
        tax 
        lda pointerTable_scrollGlitchDiagnosticMovementCode, x
        sta $00
        lda pointerTable_scrollGlitchDiagnosticMovementCode+1, x
        sta $01
        jmp ($0000)

    stage13Pass:
        lda #$00
        sta {scrollGlitchDiagnosticTimer}
        lda {simonMovementState}
        and #$03
        sta {scrollGlitchDiagnosticPhaseCounter}
        jmp scrollGlitchDiagnostic_exitTool

    
    onIdle:
        lda {simonMovementState}
        and #$03
        beq .onIdleNow

        cmp #$01
        beq .onMovingRightNow

        .onMovingLeftNow:
            // print scrollGlitchDiagnosticTimer on screen
            // presumably there's going to be a cursor used to figure out what hud column to print on
            lda #$04
            sta {scrollGlitchDiagnosticPhaseCounter}
            lda #$00
            sta {scrollGlitchDiagnosticTimer}
            jmp scrollGlitchDiagnostic_exitTool


        .onMovingRightNow:
            // print scrollGlitchDiagnosticTimer on screen
            // presumably there's going to be a cursor used to figure out what hud column to print on
            lda #$03
            sta {scrollGlitchDiagnosticPhaseCounter}
            lda #$00
            sta {scrollGlitchDiagnosticTimer}
            jmp scrollGlitchDiagnostic_exitTool


        .onIdleNow:
            // TODO: cap counter at 15
            inc {scrollGlitchDiagnosticTimer}
            jmp scrollGlitchDiagnostic_exitTool



    onFirstMovementRight:
        lda {simonMovementState}
        and #$03
        beq .onIdleNow

        cmp #$01
        beq .onMovingRightNow

        .onMovingLeftNow:
            lda #$04
            sta {scrollGlitchDiagnosticPhaseCounter}
            jmp scrollGlitchDiagnostic_exitTool


        .onMovingRightNow:
            jmp scrollGlitchDiagnostic_exitTool

        .onIdleNow:
            lda #$00
            sta {scrollGlitchDiagnosticPhaseCounter}
            jmp scrollGlitchDiagnostic_exitTool
    
    
    
    onFirstMovementLeft:
        lda {simonMovementState}
        and #$03
        beq .onIdleNow

        cmp #$01
        beq .onMovingRightNow

        .onMovingLeftNow:
            jmp scrollGlitchDiagnostic_exitTool


        .onMovingRightNow:
            lda #$03
            sta {scrollGlitchDiagnosticPhaseCounter}
            jmp scrollGlitchDiagnostic_exitTool


        .onIdleNow:
            lda #$00
            sta {scrollGlitchDiagnosticPhaseCounter}
            jmp scrollGlitchDiagnostic_exitTool

    
    
    onScrollGlitchMovementRight:
        lda {simonMovementState}
        and #$03
        beq .onIdleNow

        cmp #$01
        beq .onMovingRightNow

        .onMovingLeftNow:
            // print scrollGlitchDiagnosticTimer on screen
            // presumably there's going to be a cursor used to figure out what hud column to print on
            lda #$04
            sta {scrollGlitchDiagnosticPhaseCounter}
            lda #$00
            sta {scrollGlitchDiagnosticTimer}
            jmp scrollGlitchDiagnostic_exitTool


        .onMovingRightNow:
            inc {scrollGlitchDiagnosticTimer}
            jmp scrollGlitchDiagnostic_exitTool


        .onIdleNow:
            // print scrollGlitchDiagnosticTimer on screen
            // presumably there's going to be a cursor used to figure out what hud column to print on
            lda #$00
            sta {scrollGlitchDiagnosticPhaseCounter}
            sta {scrollGlitchDiagnosticTimer}
            jmp scrollGlitchDiagnostic_exitTool



    onScrollGlitchMovementLeft:
        lda {simonMovementState}
        and #$03
        beq .onIdleNow

        cmp #$01
        beq .onMovingRightNow

        .onMovingLeftNow:
            inc {scrollGlitchDiagnosticTimer}
            jmp scrollGlitchDiagnostic_exitTool


        .onMovingRightNow:
            // print scrollGlitchDiagnosticTimer on screen
            // presumably there's going to be a cursor used to figure out what hud column to print on
            lda #$03
            sta {scrollGlitchDiagnosticPhaseCounter}
            lda #$00
            sta {scrollGlitchDiagnosticTimer}
            jmp scrollGlitchDiagnostic_exitTool


        .onIdleNow:
            // print scrollGlitchDiagnosticTimer on screen
            // presumably there's going to be a cursor used to figure out what hud column to print on
            lda #$00
            sta {scrollGlitchDiagnosticPhaseCounter}
            sta {scrollGlitchDiagnosticTimer}
            jmp scrollGlitchDiagnostic_exitTool