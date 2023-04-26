        lda {currentSubStage}
        bne .stage13Pass

		lda $5D4
		beq .stage13Pass
		jsr killSimon

        .stage13Pass:
            jmp scrollGlitch_exitTool