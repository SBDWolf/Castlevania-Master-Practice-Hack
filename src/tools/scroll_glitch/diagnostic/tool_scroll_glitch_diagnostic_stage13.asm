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

		lda {scrollGlitchDiagnosticBlockPreviousState1}
		beq +
        lda {scrollGlitchDiagnosticScrollGlitchStatus}
        and #$FE
        sta {scrollGlitchDiagnosticScrollGlitchStatus}
        lda $5D4
        sta {scrollGlitchDiagnosticBlockPreviousState1}
        jmp logic_start

+;      lda {scrollGlitchDiagnosticScrollGlitchStatus}
        ora #$01
        sta {scrollGlitchDiagnosticScrollGlitchStatus}
        lda $5D4
        sta {scrollGlitchDiagnosticBlockPreviousState1}
        jmp logic_start

    stage13Pass:
        lda #$00
        sta {scrollGlitchDiagnosticTimer}
        sta {scrollGlitchDiagnosticHudCursor}
        sta {scrollGlitchDiagnosticHudClearPhase}
        sta {scrollGlitchDiagnosticScrollGlitchStatus}
        sta {scrollGlitchDiagnosticBlockPreviousState1}
        lda {simonMovementState}
        and #$03
        sta {scrollGlitchDiagnosticPhaseCounter}
        jmp scrollGlitchDiagnostic_exitTool