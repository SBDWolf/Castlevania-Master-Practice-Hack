checkIfInDemoModeCookieMonster:
    clv 
    lda {systemState}
    cmp #$02
    beq +
    
    lda #$42
    bvc .playSFX

+;  lda #$00

    .playSFX:
        jsr {bank7_playCookieMonsterMusicEntryPoint}
        rts 

checkifInDemoModeDracula:
    lda {systemState}
    cmp #$02
    bne +
    lda {frameCounter}
    cmp #$C8
    bne +

    lda #$7A
    and #$03
    rts 

+;  lda {RNG}
    and #$03
    rts 