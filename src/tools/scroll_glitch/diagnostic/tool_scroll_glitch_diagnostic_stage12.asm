lda {simonXLowByte}
cmp #$02
bne stage12Pass

lda {simonXHighByte}

cmp #$B8
bcc stage12Pass

cmp #$E8
bcs stage12Pass

jmp logic_start

stage12Pass:
    lda #$00
    sta {scrollGlitchDiagnosticTimer}
    sta {scrollGlitchDiagnosticHudCursor}
    sta {scrollGlitchDiagnosticHudClearPhase}
    lda {simonMovementState}
    and #$03
    sta {scrollGlitchDiagnosticPhaseCounter}
    jmp scrollGlitchDiagnostic_exitTool