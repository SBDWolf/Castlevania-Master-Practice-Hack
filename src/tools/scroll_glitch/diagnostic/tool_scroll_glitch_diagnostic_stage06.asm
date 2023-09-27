        lda {currentSubStage}
        bne stage06Pass

        lda {leftBookendColumn}
        cmp #$09
        bcc stage06Pass
        cmp #$0B
        bcs stage06Pass

        jmp logic_start

    stage06Pass:
        lda #$00
        sta {scrollGlitchDiagnosticTimer}
        sta {scrollGlitchDiagnosticHudCursor}
        lda {simonMovementState}
        and #$03
        sta {scrollGlitchDiagnosticPhaseCounter}
        jmp scrollGlitchDiagnostic_exitTool