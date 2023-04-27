        lda {currentSubStage}
        bne .stage06Pass

		lda $5F6
		beq +
		jmp killSimon
        jmp scrollGlitch_exitTool
+;		lda $5F5
		beq .stage06Pass
		jmp killSimon

        .stage06Pass:
            jmp scrollGlitch_exitTool