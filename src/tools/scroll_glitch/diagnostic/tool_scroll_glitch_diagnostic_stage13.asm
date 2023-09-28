        lda {currentSubStage}
        bne stage13Pass

        lda {simonXLowByte}
        bne stage13Pass

        lda {simonXHighByte}
        // giving 4 pixels of leeway left of the point where the column bookend changes
        cmp #$98
        bcc stage13Pass

        cmp #$C8
        bcs stage13Pass

        jmp logic_start

    stage13Pass:
        lda #$00
        sta {scrollGlitchDiagnosticTimer}
        sta {scrollGlitchDiagnosticHudCursor}
        sta {scrollGlitchDiagnosticHudClearPhase}
        lda {simonMovementState}
        and #$03
        sta {scrollGlitchDiagnosticPhaseCounter}
        jmp scrollGlitchDiagnostic_exitTool