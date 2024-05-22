        lda {currentSubStage}
        bne stage06Medusa

        // crusher room
        lda {simonXLowByte}
        cmp #$01
        bne stage06Pass

        lda {simonXHighByte}
        cmp #$E8
        bcs stage06Pass
        cmp #$98
        bcc stage06Pass

        jmp logic_start

    stage06Medusa:
        lda {simonXLowByte}
        cmp #$02
        bcs stage06Pass
        beq .onLowByte00

        // low byte 01
        lda {simonXHighByte}
        cmp #$28
        bcs stage06Pass

        jmp logic_start

        .onLowByte00:
            lda {simonXHighByte}

            cmp #$F8
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