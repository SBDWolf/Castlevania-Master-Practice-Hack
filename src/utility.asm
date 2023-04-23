    // this is code from the original game that prints the current stage in the top-right
    // i couldn't call it as-is because it is in bank 6, so i am copying it here in bank 5
    printHeartCount:
        lda {heartCount}
	    jsr someGenericPrintSubRoutine
	    sta $08
	    lda #$1B
	    jsr {someBank7GenericPrintSubRoutine1}
	    lda $08
	    jsr {someBank7GenericPrintSubRoutine2}
	    jmp {someBank7GenericPrintSubRoutine3}
    
    printCurrentStage:
        jsr someStagePrintSubRoutine
        sta $4B
        lda #$1C
        jsr {someBank7GenericPrintSubRoutine1}
        stx $4E
        lda $4B
        jsr someGenericPrintSubRoutine
        ldx $4E
        jsr {someBank7GenericPrintSubRoutine2}
        jmp {someBank7GenericPrintSubRoutine3}

    someStagePrintSubRoutine:
        lda $2B
        ldx {currentStage}
        cpx #$13
        bne +
        ldx #$01
+;      stx $4C
        cmp #$06
        bcs subRoutineEnd
        sta $4E
        asl 
        sta $4B
        asl 
        asl 
        asl 
        clc 
        adc $4B
        clc 
        adc $4E
        clc 
        adc $4C
        bcs subRoutineEnd
        cmp #$64
        bcs subRoutineEnd
        cmp #$00
        bne +
        lda #$01
+;	    rts 

    subRoutineEnd:
        lda #$63
        rts 

    someGenericPrintSubRoutine:
-;	    sta $4B
        sec 
        sbc #$65
        bcs -
        ldx #$00
-;	    lda $4B
        sec 
        sbc #$0A
        bcc +
        pha 
        txa 
        clc 
        adc #$10
        tax 
        pla 
        sta $4B
        jmp -	

+;	    txa 
        ora $4B
        rts 