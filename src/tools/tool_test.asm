tool_test:
    // test tool. to be deleted
    inc {currentSubweapon}

    // execute next tool
    inx
    inx
    lda ({toolsToRunPointerList}),x
    sta $00
    lda ({toolsToRunPointerList})+1,x
    sta $01

    jmp ($0000)