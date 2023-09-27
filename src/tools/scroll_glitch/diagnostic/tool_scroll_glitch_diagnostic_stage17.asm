        lda {currentSubStage}
        beq stage17Pass

        lda {leftBookendColumn}
        cmp #$0B
        bcc stage17Pass
        cmp #$0D
        bcs stage17Pass

        jmp logic_start

    stage17Pass:
        lda #$00
        sta {scrollGlitchDiagnosticTimer}
        sta {scrollGlitchDiagnosticHudCursor}
        lda {simonMovementState}
        and #$03
        sta {scrollGlitchDiagnosticPhaseCounter}
        jmp scrollGlitchDiagnostic_exitTool