        lda {currentSubStage}
        bne .stage06Pass

		lda $5F6
		beq +
		jsr killSimon
        jmp scrollGlitch_exitTool
	+	lda $5F5
		beq .stage06Pass
		jsr killSimon

        .stage06Pass:
            jmp scrollGlitch_exitTool