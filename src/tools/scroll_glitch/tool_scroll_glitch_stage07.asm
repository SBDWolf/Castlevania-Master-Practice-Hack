        lda {currentSubStage}
        bne .stage07Pass

        // don't run checks unless simon is far left enough
        // otherwise simon will gets spawnkilled...
        clc 
        lda {simonXLowByte}
        cmp #$02
        bne +

        lda {simonXHighByte}
        cmp #$C0
        bcs .stage07Pass

        

+;      lda $6EA
        bne +

        jmp killSimon
        

+;      lda $5F7
        bne .stage07Pass

        jmp killSimon

        .stage07Pass:
            jmp scrollGlitch_exitTool