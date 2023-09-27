        lda {currentSubStage}
        beq .stage14Pass

        // check if we have to process 14 advanced OR 14 race
        lda {simonXLowByte}
        cmp #$02
        beq .on02XPositionBranch

        // check if we have to process 14 standard
        cmp #$03
        beq .on14Standard

        cmp #$04
        bne +
        lda {simonY}
        cmp #$B0
        bcc .on14Top

        // if it falls here, then simon is in a spot where we shouldn't process a scroll glitch
+;      jmp scrollGlitchDeath_exitTool
        
        .on02XPositionBranch:
            lda {simonXHighByte}
            cmp #$80
            bcc .on14Race
            // fall through to .on14Advanced if simonXHighByte is greater or equal than 0x80

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

        .on14Race:
            // for this, we kill simon only if both blocks fail
            lda $6A0
            beq .stage14Pass
            lda $6C0
            beq .stage14Pass
            jmp killSimon


        .stage14Pass:
            jmp scrollGlitchDeath_exitTool