        lda {currentSubStage}
        bne stage06Pass

        lda {simonXLowByte}
        cmp #$01
        bne stage06Pass

        lda {simonXHighByte}
        cmp #$E8
        bcs stage06Pass
        cmp #$98
        bcc stage06Pass

        jmp logic_start


    stage06Pass:
        lda #$00
        sta {scrollGlitchDiagnosticTimer}
        sta {scrollGlitchDiagnosticHudCursor}
        sta {scrollGlitchDiagnosticHudClearPhase}
        lda {simonMovementState}
        and #$03
        sta {scrollGlitchDiagnosticPhaseCounter}
        jmp scrollGlitchDiagnostic_exitTool