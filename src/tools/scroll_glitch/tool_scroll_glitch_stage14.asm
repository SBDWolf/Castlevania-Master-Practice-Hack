        lda {currentSubStage}
        beq .stage14Pass

        lda {simonXLowByte}
        cmp #$02
        bne .checkForStandard

        // 14 advanced
        lda {isSimonFacingLeft}
        beq .stage14Pass


        lda {simonXHighByte}
        cmp #$EB
        bpl .stage14Pass

        lda $685
		beq .stage14Pass
		jsr killSimon

        .checkForStandard:
        // TODO



        .stage14Pass:
            jmp scrollGlitch_exitTool