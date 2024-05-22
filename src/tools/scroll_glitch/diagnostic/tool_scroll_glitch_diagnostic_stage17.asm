        lda {currentSubStage}
        beq stage17Pass

        lda {simonXLowByte}
        cmp #$02
        beq .onLowByte02
        cmp #$01
        beq .onLowByte01
        jmp stage17Pass

        .onLowByte02:
            lda {simonXHighByte}
            cmp #$28
            bcs stage17Pass
            jmp logic_start

        .onLowByte01:
            lda {simonXHighByte}
            cmp #$D8
            bcc stage17Pass
            jmp logic_start


    stage17Pass:
        lda #$00
        sta {scrollGlitchDiagnosticTimer}
        sta {scrollGlitchDiagnosticHudCursor}
        sta {scrollGlitchDiagnosticHudClearPhase}
        lda {simonMovementState}
        and #$03
        sta {scrollGlitchDiagnosticPhaseCounter}
        jmp scrollGlitchDiagnostic_exitTool