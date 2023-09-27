        lda {currentSubStage}
        bne .stage13Pass

		lda $5D4
		beq .stage13Pass
		jmp killSimon

        .stage13Pass:
            jmp scrollGlitchDeath_exitTool