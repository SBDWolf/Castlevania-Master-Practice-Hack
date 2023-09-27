    logic_start:
        // execute the code for the appropriate phase we're in
        ldx {scrollGlitchDiagnosticPhaseCounter}
        txa 
        asl 
        tax 
        lda pointerTable_scrollGlitchDiagnosticMovementCode, x
        sta $00
        lda pointerTable_scrollGlitchDiagnosticMovementCode+1, x
        sta $01
        jmp ($0000)

    onIdle:
        lda {simonMovementState}
        and #$03
        beq .onIdleNow

        cmp #$01
        beq .onMovingRightNow

        .onMovingLeftNow:
            ldy {scrollGlitchDiagnosticTimer}
            iny 
            jsr print_movement_data
            lda #$04
            sta {scrollGlitchDiagnosticPhaseCounter}
            lda #$00
            sta {scrollGlitchDiagnosticTimer}
            jmp scrollGlitchDiagnostic_exitTool


        .onMovingRightNow:
            ldy {scrollGlitchDiagnosticTimer}
            iny 
            jsr print_movement_data
            lda #$03
            sta {scrollGlitchDiagnosticPhaseCounter}
            lda #$00
            sta {scrollGlitchDiagnosticTimer}
            jmp scrollGlitchDiagnostic_exitTool


        .onIdleNow:
            inc {scrollGlitchDiagnosticTimer}
            lda {scrollGlitchDiagnosticTimer}
            cmp {SCROLLGLITCHDIAGNOSTIC_TimerMaxValue}+1
            bcc +
            lda {SCROLLGLITCHDIAGNOSTIC_TimerMaxValue}
            sta {scrollGlitchDiagnosticTimer}
+;          jmp scrollGlitchDiagnostic_exitTool



    onFirstMovementRight:
        jsr clear_movement_data
        lda {simonMovementState}
        and #$03
        beq .onIdleNow

        cmp #$01
        beq .onMovingRightNow

        .onMovingLeftNow:
            ldy #$00
            jsr print_movement_data
            lda #$04
            sta {scrollGlitchDiagnosticPhaseCounter}
            jmp scrollGlitchDiagnostic_exitTool


        .onMovingRightNow:
            jmp scrollGlitchDiagnostic_exitTool

        .onIdleNow:
            lda #$00
            sta {scrollGlitchDiagnosticPhaseCounter}
            jmp scrollGlitchDiagnostic_exitTool
    
    
    
    onFirstMovementLeft:
        jsr clear_movement_data
        lda {simonMovementState}
        and #$03
        beq .onIdleNow

        cmp #$01
        beq .onMovingRightNow

        .onMovingLeftNow:
            jmp scrollGlitchDiagnostic_exitTool


        .onMovingRightNow:
            ldy #$00
            jsr print_movement_data
            lda #$03
            sta {scrollGlitchDiagnosticPhaseCounter}
            jmp scrollGlitchDiagnostic_exitTool


        .onIdleNow:
            lda #$00
            sta {scrollGlitchDiagnosticPhaseCounter}
            jmp scrollGlitchDiagnostic_exitTool

    
    
    onScrollGlitchMovementRight:
        lda {simonMovementState}
        and #$03
        beq .onIdleNow

        cmp #$01
        beq .onMovingRightNow

        .onMovingLeftNow:
            ldy {scrollGlitchDiagnosticTimer}
            iny 
            jsr print_movement_data
            ldy #$00
            jsr print_movement_data
            lda #$04
            sta {scrollGlitchDiagnosticPhaseCounter}
            lda #$00
            sta {scrollGlitchDiagnosticTimer}
            jmp scrollGlitchDiagnostic_exitTool


        .onMovingRightNow:
            inc {scrollGlitchDiagnosticTimer}
            lda {scrollGlitchDiagnosticTimer}
            cmp {SCROLLGLITCHDIAGNOSTIC_TimerMaxValue}+1
            bcc +
            lda {SCROLLGLITCHDIAGNOSTIC_TimerMaxValue}
            sta {scrollGlitchDiagnosticTimer}
+;          jmp scrollGlitchDiagnostic_exitTool


        .onIdleNow:
            ldy {scrollGlitchDiagnosticTimer}
            iny 
            jsr print_movement_data
            lda #$00
            sta {scrollGlitchDiagnosticPhaseCounter}
            sta {scrollGlitchDiagnosticTimer}
            jmp scrollGlitchDiagnostic_exitTool



    onScrollGlitchMovementLeft:
        lda {simonMovementState}
        and #$03
        beq .onIdleNow

        cmp #$01
        beq .onMovingRightNow

        .onMovingLeftNow:
            inc {scrollGlitchDiagnosticTimer}
            lda {scrollGlitchDiagnosticTimer}
            cmp {SCROLLGLITCHDIAGNOSTIC_TimerMaxValue}+1
            bcc +
            lda {SCROLLGLITCHDIAGNOSTIC_TimerMaxValue}
            sta {scrollGlitchDiagnosticTimer}
+;          jmp scrollGlitchDiagnostic_exitTool


        .onMovingRightNow:
            ldy {scrollGlitchDiagnosticTimer}
            iny 
            jsr print_movement_data
            ldy #$00
            jsr print_movement_data
            lda #$03
            sta {scrollGlitchDiagnosticPhaseCounter}
            lda #$00
            sta {scrollGlitchDiagnosticTimer}
            jmp scrollGlitchDiagnostic_exitTool


        .onIdleNow:
            ldy {scrollGlitchDiagnosticTimer}
            iny 
            jsr print_movement_data
            lda #$00
            sta {scrollGlitchDiagnosticPhaseCounter}
            sta {scrollGlitchDiagnosticTimer}
            jmp scrollGlitchDiagnostic_exitTool