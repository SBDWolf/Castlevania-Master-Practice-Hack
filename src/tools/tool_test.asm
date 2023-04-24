tool_test:
    // test
    inc {currentSubweapon}

    // execute next tool
    inx
    inx
    lda ({toolsToRunPointerList}),x
    sta $00
    lda ({toolsToRunPointerList})+1,x
    sta $01

    jmp ($0000)