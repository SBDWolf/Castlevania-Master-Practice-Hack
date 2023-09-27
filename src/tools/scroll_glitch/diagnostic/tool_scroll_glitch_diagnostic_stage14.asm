        lda {currentSubStage}
        beq stage14Pass

        lda {leftBookendColumn}
        cmp #$1D
        beq executeLogic
        cmp #$1E
        beq executeLogic
        cmp #$12
        beq executeLogic
        cmp #$15
        beq executeLogic


    stage14Pass:
        lda #$00
        sta {scrollGlitchDiagnosticTimer}
        sta {scrollGlitchDiagnosticHudCursor}
        lda {simonMovementState}
        and #$03
        sta {scrollGlitchDiagnosticPhaseCounter}
        jmp scrollGlitchDiagnostic_exitTool

    executeLogic:
        jmp logic_start

