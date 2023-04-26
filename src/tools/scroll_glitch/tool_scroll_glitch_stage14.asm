        lda {currentSubStage}
        beq .stage14Pass:

        lda {simonXLowByte}
        cmp #$02
        bne checkForStandard

        // 14 advanced
        lda {isSimonFacingLeft}
        beq .stage14Pass

        // protection so regular 14 works even if miss 14 advanced  -- SBDWolf: is this actually needed? copied from the old code
        lda {simonXHighByte}
        cmp #$EB
        bpl .stage14Pass

        lda $685
		beq .stage14Pass:
		jsr killSimon

        .checkForStandard:
        // TODO



        .stage14Pass:
            jmp scrollGlitch_exitTool