        lda {currentSubStage}
        bne stage07Pass

        lda {simonXLowByte}
        cmp #$02
        beq .onLowByte02

        cmp #$01
        beq .onLowByte01

        bvc stage07Pass

        .onLowByte02:
            lda {simonXHighByte}
            cmp #$68
            bcs stage07Pass
            jmp logic_start

        .onLowByte01:
            lda {simonXHighByte}
            cmp #$D8
            bcc stage07Pass
            jmp logic_start

    stage07Pass:
        lda #$00
        sta {scrollGlitchDiagnosticTimer}
        sta {scrollGlitchDiagnosticHudCursor}
        sta {scrollGlitchDiagnosticHudClearPhase}
        lda {simonMovementState}
        and #$03
        sta {scrollGlitchDiagnosticPhaseCounter}
        jmp scrollGlitchDiagnostic_exitTool
        

