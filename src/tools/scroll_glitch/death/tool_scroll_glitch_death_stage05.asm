        lda {currentSubStage}
        beq .stage05Pass

        lda {isSimonFacingLeft}
        beq .stage05Pass

        lda $5C7
        beq +
        jmp killSimon

+;		lda $5E7
		bne .stage05Pass
		jmp killSimon

        .stage05Pass:
            jmp scrollGlitchDeath_exitTool