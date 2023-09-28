        lda {currentSubStage}
        beq stage17Pass

        lda {simonXLowByte}
        cmp #$02
        beq .onHighByte02
        cmp #$01
        beq .onHighByte01
        jmp stage17Pass

        .onHighByte02:
            lda {simonXHighByte}
            cmp #$28
            bcs stage17Pass
            jmp logic_start

        .onHighByte01:
            lda {simonXHighByte}
            cmp #$D8
            bcc stage17Pass
            jmp logic_start


        

        //lda {leftBookendColumn}
        //cmp #$0A
        //bcc stage17Pass
        //cmp #$0E
        //bcs stage17Pass


    stage17Pass:
        lda #$00
        sta {scrollGlitchDiagnosticTimer}
        sta {scrollGlitchDiagnosticHudCursor}
        sta {scrollGlitchDiagnosticHudClearPhase}
        lda {simonMovementState}
        and #$03
        sta {scrollGlitchDiagnosticPhaseCounter}
        jmp scrollGlitchDiagnostic_exitTool