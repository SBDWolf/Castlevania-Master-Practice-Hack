        lda {currentSubStage}
        beq .stage14Pass

        // check if we have to process 14 advanced
        lda {simonXLowByte}
        cmp #$02
        beq .on14Advanced

        // check if we have to process 14 standard
        cmp #$03
        beq .on14Standard

        cmp #$04
        bne +
        lda {simonY}
        cmp #$B0
        bcc .on14Top

        // if it falls here, that simon is in a spot where we shouldn't process a scroll glitch
+;      jmp scrollGlitch_exitTool
        
        .on14Advanced:
            lda {isSimonFacingLeft}
            bne .stage14Pass

            // protection so regular 14 works even if missing 14 advanced
            lda {simonXHighByte}
            cmp #$EB
            bpl .stage14Pass

            lda $685
            beq .stage14Pass
            jmp killSimon
        
        
        .on14Standard:
            lda {isSimonFacingLeft}
            bne .stage14Pass

            // this prevents death when you turn right walking on stairs
            lda {simonY}
            cmp #$A0
            bmi .stage14Pass

            lda $618 
            beq .stage14Pass
            jmp killSimon

        .on14Top:
            // for this, we kill simon only if both blocks fail
            lda $68A
            beq .stage14Pass
            lda $689
            beq .stage14Pass
            jmp killSimon


        .stage14Pass:
            jmp scrollGlitch_exitTool