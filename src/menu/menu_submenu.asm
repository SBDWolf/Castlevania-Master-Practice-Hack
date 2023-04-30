// -- submenu logic -------------------------------------------------

	printSubMenuCursor:									
		ldy {tileDataPointer}									// draws cursor to the right 	
-;		lda cursorBytesSUB,y
		sta {PPUBuffer},y
		iny 
		cmp #$FF
		bne -
		sty {tileDataPointer}
		rts 
	
	handleSubMenuInputs:
		// x register has to be passed to this routine to determine the maximum value the menu cursor can allow
		// y register will contain a boolean return value, to be used to determine whether a menu action should be executed or not

		ldy {FALSE}
		clv 							// for later in this subroutine
		lda {currentInputOneFrame}
		and {MULTIPLEINPUT_UpOrDown}
		cmp #$00
		beq checkForBPress 
		cmp {INPUT_Down}
		beq pressedDown
		// assuming up got pressed, which means if you press up+down, it will get interpreted as up
		inc {practiceSubMenuCursor}
		cpx {practiceSubMenuCursor}
		bcc +
		bvc checkForBPress 

		// overflow cursor value
+;		lda #$00
		sta {practiceSubMenuCursor}
		bvc checkForBPress  

	pressedDown:
		dec {practiceSubMenuCursor}
		lda {practiceSubMenuCursor}
		cmp #$FF
		beq +
		bvc checkForBPress 

		// underflow cursor value
+;		stx {practiceSubMenuCursor}
	
	checkForBPress:
		lda {currentInputOneFrame}
		and {INPUT_B}
		cmp {INPUT_B}
		bne checkForAPress
		// should execute the menu action
		ldy {TRUE}
		rts 

	checkForAPress:
		lda {currentInputOneFrame}
		and {INPUT_A}
		cmp {INPUT_A}
		bne +

		// clear submenu cursor index
		lda #$00
		sta {practiceSubMenuCursor}
		// exit submenu
		lda #$01
		sta {practiceMenuPhaseIndex}
+;		rts 

	printCurrentNumericalValue:
		ldy {practiceSubMenuCursor}
		lda ones_digits_table,y

		ldx {tileDataPointer}
		dex 
		dex 
		sta {PPUBuffer},x

		dex 

		lda tens_digits_table,y
		sta {PPUBuffer},x

		rts 
    
    printCurrentTextValue:
		// x register is expected to be passed to this routine, containing the index of the text table to be used
        lda submenu_text_master_table,x
		sta $00
		lda submenu_text_master_table+1,x
		sta $01
		
		ldy {practiceSubMenuCursor}
		lda ($00),y
		tay 

		ldx {tileDataPointer}
		dex 
		dex 
		dex 
		
-;		lda ($00),y						// write text loop
		sta {PPUBuffer},x
		inx 
		iny 
		cmp #$FF
		bne -

		stx {tileDataPointer}

		rts

	printTextAtProvidedLocation:
		// x register determined ppu buffer location
		// y register determines table offset
		// $00 contains the pointer to the table
-;		lda ($00),y						// write text loop
		sta {PPUBuffer},x
		inx 
		iny 
		cmp #$FF
		bne -
		stx {tileDataPointer}

		rts 

	allowAnyInputToCloseMenu:
		lda {currentInputOneFrame}		// exit menu with select OR start
		and {MULTIPLEINPUT_AOrB}
		cmp #$00
		beq +;

		lda {PRACTICEMENU_DeconstructMenu00PhaseIndex}
		sta {practiceMenuPhaseIndex}
+;		rts 
