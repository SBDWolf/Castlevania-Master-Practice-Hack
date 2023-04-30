tool_inputDisplay:
        // don't print anything on screen if the menu is open!
        lda {practiceMenuPhaseIndex}
        beq +
        jmp tool_exitInputDisplay

+;      clv 
        // backup tool index onto the stack
        txa 
        pha 

        ldx {tileDataPointer}

        // print dpad up, it will be on the top row of the hud

        lda #$01
        sta {PPUBuffer},x
        inx
        lda #$20
        sta {PPUBuffer},x
        inx
        lda #$37
        sta {PPUBuffer},x
        inx

        lda {currentInputHeld}
        and {INPUT_Up}
        beq +

        // heart
        lda #$DC
        bvc PrintDpadUp

+;      lda #$00

    PrintDpadUp:
        sta {PPUBuffer},x
        inx

        lda #$FF
        sta {PPUBuffer},x
        inx 


        // now start printing on the row below
+;      lda #$01
        sta {PPUBuffer},x
        inx
        lda #$20
        sta {PPUBuffer},x
        inx
        lda #$56
        sta {PPUBuffer},x
        inx



        lda {currentInputHeld}
        and {INPUT_Left}
        beq +

        // heart
        lda #$DC
        bvc printDpadLeft

+;      lda #$00

    printDpadLeft:
        sta {PPUBuffer},x
        inx       



        lda {currentInputHeld}
        and {INPUT_Down}
        beq +

        // heart
        lda #$DC
        bvc printDpadDown

+;      lda #$00

    printDpadDown:
        sta {PPUBuffer},x
        inx 


        lda {currentInputHeld}
        and {INPUT_Right}
        beq +

        // heart
        lda #$DC
        bvc printDpadRight

+;      lda #$00

    printDpadRight:
        sta {PPUBuffer},x
        inx   


        lda {currentInputHeld}
        and {INPUT_Select}
        beq +

        lda #$F2
        bvc printSelect

+;      lda #$00

    printSelect:
        sta {PPUBuffer},x
        inx   


        lda {currentInputHeld}
        and {INPUT_Start}
        beq +

        lda #$F3
        bvc printStart

+;      lda #$00

    printStart:
        sta {PPUBuffer},x
        inx 


        lda {currentInputHeld}
        and {INPUT_B}
        beq +

        lda #$E1
        bvc printB

+;      lda #$00

    printB:
        sta {PPUBuffer},x
        inx 

        
        lda {currentInputHeld}
        and {INPUT_A}
        beq +

        lda #$E0
        bvc printA

+;      lda #$00

    printA:
        sta {PPUBuffer},x
        inx 




        lda #$FF
        sta {PPUBuffer},x
        inx 

        stx {tileDataPointer}

        // restore tool index
        pla 
        tax 

tool_exitInputDisplay:
        // execute next tool
        inx 
        inx 
        lda ({toolsToRunPointerList}),x
        sta $00
        lda ({toolsToRunPointerList})+1,x
        sta $01

        jmp ($0000)