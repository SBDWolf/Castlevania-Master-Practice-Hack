        lda {currentSubStage}
        beq stage05Pass

        lda {simonXLowByte}
        beq .onHighByte00

        cmp #$01
        beq .onHighByte01

        .onHighByte00:
            lda {simonXHighByte}
            cmp #$D8
            bcc stage05Pass
            jmp logic_start

        .onHighByte01:
            lda {simonXHighByte}
            cmp #$08
            bcs stage05Pass
            jmp logic_start


        //lda {leftBookendColumn}
        //cmp #$03
        //bne stage05Pass

        //jmp logic_start

    stage05Pass:
        lda #$00
        sta {scrollGlitchDiagnosticTimer}
        sta {scrollGlitchDiagnosticHudCursor}
        sta {scrollGlitchDiagnosticHudClearPhase}
        lda {simonMovementState}
        and #$03
        sta {scrollGlitchDiagnosticPhaseCounter}
        jmp scrollGlitchDiagnostic_exitTool