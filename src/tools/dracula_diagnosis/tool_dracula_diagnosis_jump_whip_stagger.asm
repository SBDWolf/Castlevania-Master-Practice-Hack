//TODO: maybe don't run this while the game is paused?
//TODO: this counter might need to be initialized
        // check if a jump has already occurred in the last few frames
        lda {draculaToolJumpWhipStaggerFrameCount}
        bne .afterHavingJumped

        // check is A has just been pressed
        lda {currentInputOneFrame}
        and {INPUT_A}
        beq .endJumpWhipStaggerCheck

        // A has just been pressed, so reset the frame counter and check if B has been pressed
        // checking for B instead of immediately incrementing our counter handles the case in which A and B are pressed on the same frame
        lda #$00
        sta {draculaToolJumpWhipStaggerFrameCount}


        .afterHavingJumped:
            // check if B has just been pressed
            lda {currentInputOneFrame}
            and {INPUT_B}
            bne .printFrameCounterAndReset
            
            // increment counter
            inc {draculaToolJumpWhipStaggerFrameCount}
            bvc .endJumpWhipStaggerCheck
        
            .printFrameCounterAndReset:
                // print on screen, only the units digit
                ldx {tileDataPointer}

                lda #$01
                sta {PPUBuffer},x
                inx
                lda #$20
                sta {PPUBuffer},x
                inx
                lda #$35
                sta {PPUBuffer},x
                inx

                // if we've hit over 8 frames, reset this counter early and go back to checking for jumps on the next frame
                // this helps prevent this counter from showing up when undesired
                // additionally, print a blank space where the frame counter would be

                ldy {draculaToolJumpWhipStaggerFrameCount}
                cpy #9
                bmi .loadDigit
                lda #$00
                sta {draculaToolJumpWhipStaggerFrameCount}
                bvc +
                
                .loadDigit:
                   lda ones_digits_table,y
+;              sta {PPUBuffer},x
                inx 

                lda #$FF
                sta {PPUBuffer},x
                inx 

                stx {tileDataPointer}

                // reset frame counter
                lda #$00
                sta {draculaToolJumpWhipStaggerFrameCount}


        .endJumpWhipStaggerCheck: