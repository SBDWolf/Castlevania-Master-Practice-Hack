        lda {currentSubStage}
        bne .stage13Juggle

		lda $5D4
		beq .stage13Pass
		jmp killSimon

        .stage13Juggle:
            lda $61A
		    bne .stage13Pass
		    jmp killSimon

        .stage13Pass:
            jmp scrollGlitchDeath_exitTool