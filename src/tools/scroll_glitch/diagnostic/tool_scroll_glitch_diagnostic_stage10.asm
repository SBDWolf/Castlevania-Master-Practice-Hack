        lda {simonXLowByte}
        cmp #$04
        bne stage10Pass

        lda {simonXHighByte}
        // giving 8 pixels of leeway left of the point where the column bookend changes
        cmp #$78
        bcc stage13Pass

        cmp #$E8
        bcs stage13Pass

        jmp logic_start


    stage10Pass:
        lda #$00
        sta {scrollGlitchDiagnosticTimer}
        sta {scrollGlitchDiagnosticHudCursor}
        sta {scrollGlitchDiagnosticHudClearPhase}
        lda {simonMovementState}
        and #$03
        sta {scrollGlitchDiagnosticPhaseCounter}
        jmp scrollGlitchDiagnostic_exitTool
        

