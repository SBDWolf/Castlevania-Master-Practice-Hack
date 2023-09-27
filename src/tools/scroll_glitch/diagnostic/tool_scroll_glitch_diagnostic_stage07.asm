        lda {currentSubStage}
        bne stage07Pass

        lda {leftBookendColumn}
        cmp #$0E
        beq executeLogic
        cmp #$0B
        beq executeLogic

    stage07Pass:
        lda #$00
        sta {scrollGlitchDiagnosticTimer}
        sta {scrollGlitchDiagnosticHudCursor}
        lda {simonMovementState}
        and #$03
        sta {scrollGlitchDiagnosticPhaseCounter}
        jmp scrollGlitchDiagnostic_exitTool

    executeLogic:
        jmp logic_start

