        lda {currentSubStage}
        beq .stage05Pass

        lda {isSimonFacingLeft}
        bne .stage05Pass

        lda $5C7
        beq +
        jsr killSimon
        jmp scrollGlitch_exitTool

+;		lda $5E7
		bne .stage13Pass
		jsr killSimon

        .stage05Pass:
            jmp scrollGlitch_exitTool