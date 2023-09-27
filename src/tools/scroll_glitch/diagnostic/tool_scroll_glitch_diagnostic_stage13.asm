        lda {currentSubStage}
        bne stage13Pass

        lda {rightBookendColumn}
        cmp #$10
        bne stage13Pass

        jmp logic_start

    stage13Pass:
        lda #$00
        sta {scrollGlitchDiagnosticTimer}
        sta {scrollGlitchDiagnosticHudCursor}
        lda {simonMovementState}
        and #$03
        sta {scrollGlitchDiagnosticPhaseCounter}
        jmp scrollGlitchDiagnostic_exitTool