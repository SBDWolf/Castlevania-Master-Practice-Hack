        lda {currentSubStage}
        bne .stage13Pass

        lda {rightBookendColumn}
        cmp #$10
        bne .stage13Pass

        // code it up

        lda $5D4
		beq .stage13Pass
		jmp killSimon

		

        .stage13Pass:
            jmp scrollGlitchDiagnostic_exitTool