        lda {currentSubStage}
        bne .stage06Medusa

		lda $5F6
		beq +
		jmp killSimon
        jmp scrollGlitchDeath_exitTool
+;		lda $5F5
		beq .stage06Pass
		jmp killSimon

        .stage06Medusa:
            // for this, we kill simon only if both blocks fail
            lda $5F8
            beq .stage06Pass
            lda $618
            cmp #$55
            beq .stage06Pass
		    jmp killSimon

        .stage06Pass:
            jmp scrollGlitchDeath_exitTool