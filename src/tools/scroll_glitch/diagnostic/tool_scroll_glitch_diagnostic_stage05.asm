        lda {currentSubStage}
        beq stage05Pass

        lda {leftBookendColumn}
        cmp #$03
        bne stage05Pass

        jmp logic_start

    stage05Pass:
        lda #$00
        sta {scrollGlitchDiagnosticTimer}
        sta {scrollGlitchDiagnosticHudCursor}
        lda {simonMovementState}
        and #$03
        sta {scrollGlitchDiagnosticPhaseCounter}
        jmp scrollGlitchDiagnostic_exitTool