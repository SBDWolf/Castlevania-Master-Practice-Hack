tool_memoryWatch01:
    // don't print anything on screen if the menu is open!
    lda {practiceMenuPhaseIndex}
    bne +

    // backup tool index onto the stack
    txa 
    pha 

    lda {memorywatch01Pointer}
    sta $00
    lda {memorywatch01Pointer}+1
    sta $01

    // print on screen

    ldx {tileDataPointer}

    lda #$01
    sta {PPUBuffer},x
    inx
    lda #$20
    sta {PPUBuffer},x
    inx
    lda #$28
    sta {PPUBuffer},x
    inx

    ldy #$00
    lda ($00),y
    lsr 
    lsr 
    lsr 
    lsr 
    tay 

    lda hex_digits_table,y
    sta {PPUBuffer},x
    inx 

    ldy #$00
    lda ($00),y
    and #$0F
    tay 

    lda hex_digits_table,y
    sta {PPUBuffer},x
    inx 

    lda #$FF
    sta {PPUBuffer},x
    inx 

    stx {tileDataPointer}

    // restore tool index
    pla 
    tax 

    // execute next tool
+;  inx 
    inx 
    lda ({toolsToRunPointerList}),x
    sta $00
    lda ({toolsToRunPointerList})+1,x
    sta $01

    jmp ($0000)