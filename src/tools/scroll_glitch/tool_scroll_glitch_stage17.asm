        lda {currentSubStage}
        beq .stage17Pass

        lda {simonY}
        cmp #$70
        bpl .stage17Pass

        // checking for either for the two blocks on the right side that can allow for the skip if taking top route
        lda $688
        bne +

        lda $6A8
        bne +
        jmp killSimon

+;      lda $5D7
        bne .stage17Pass
        jmp killSimon


        .stage17Pass:
            jmp scrollGlitch_exitTool