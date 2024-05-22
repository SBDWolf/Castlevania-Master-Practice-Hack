        // don't run checks unless simon is far enough right
        // otherwise simon will gets spawnkilled...
        clc 
        lda {simonXLowByte}
        cmp #$04
        bne .stage10Pass

        

+;      lda $6AB
        bne +

        jmp killSimon
        

+;      lda $68D
        bne .stage10Pass

        jmp killSimon

        .stage10Pass:
            jmp scrollGlitchDeath_exitTool