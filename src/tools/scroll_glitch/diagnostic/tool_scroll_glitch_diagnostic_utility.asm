    checkIfSimonIsMoving:
        // compares previous simon X with his current X, and returns #$00 if he's not moving, #$01 if he is moving left, and #$02 if he is moving right, on the Y register
        lda {simonXHighByte}
        cmp {scrollGlitchDiagnosticSimonPreviousX}
        bcc .probablyMovingLeft

        beq .definitelyIdle
        
    .probablyMovingRight:
        // if the accumulator contains 0xff, we are actually moving left (x high byte underflew)
        cmp #$ff
        beq .definitelyMovingLeft


    .definitelyMovingRight:
        ldy #$01
        sta {scrollGlitchDiagnosticSimonPreviousX}
        rts 

        
    .probablyMovingLeft:
        // if the accumulator contains 0x00, we are actually moving right (x high byte overflew)
        cmp #$00
        beq .definitelyMovingRight

    .definitelyMovingLeft: 
        ldy #$01
        sta {scrollGlitchDiagnosticSimonPreviousX}
        rts

    .definitelyIdle:
        ldy #$00
        sta {scrollGlitchDiagnosticSimonPreviousX}
        rts 