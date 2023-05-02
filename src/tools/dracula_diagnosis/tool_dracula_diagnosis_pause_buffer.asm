        // check if game is paused
        lda {pauseFlag}
        cmp {TRUE}
        beq .onGamePaused

        // check if the game just got paused on this frame. if it was, reset the pause counter and perform a first increment
        // we can do this by checking if currentInputOneFrame for this frame is start
        lda {currentInputOneFrame}
        and {INPUT_Start}
        beq +

        lda #$01
        sta {draculaToolPauseBufferFrameCount}

+;      bvc .endPauseCheck



        .onGamePaused:
            // check if the game just got unpaused on this frame. if it was, print pauseBufferFrameCount on screen
            // we can also do this by checking if currentInputOneFrame for this frame is start
            lda {currentInputOneFrame}
            and {INPUT_Start}
            bne .printPauseCounterOnScreen

            inc {draculaToolPauseBufferFrameCount}
            // cap at 99
            lda {draculaToolPauseBufferFrameCount}
            cmp #100
            bmi +
            dec {draculaToolPauseBufferFrameCount}
+;          bvc .endPauseCheck

            .printPauseCounterOnScreen:
                // print on screen
                ldx {tileDataPointer}

                lda #$01
                sta {PPUBuffer},x
                inx
                lda #$20
                sta {PPUBuffer},x
                inx
                lda #$31
                sta {PPUBuffer},x
                inx

                
                ldy {draculaToolPauseBufferFrameCount}
                lda tens_digits_table,y
                sta {PPUBuffer},x
                inx 
                lda ones_digits_table,y
                sta {PPUBuffer},x
                inx 

                // print a heart if pause buffer was spot on (10 frames), "E" if early, "L" if late
                cpy #10
                bcc .early
                beq .perfect
                // late
                    lda #$EB
                    bvc +

                .perfect:
                    lda #$DC
                    bvc +

                .early:
                    lda #$E4

+;              sta {PPUBuffer},x
                inx 

                lda #$FF
                sta {PPUBuffer},x
                inx 

                stx {tileDataPointer}
                // end of print



        .endPauseCheck: