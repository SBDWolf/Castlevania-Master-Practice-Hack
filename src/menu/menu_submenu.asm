// -- submenu logic -------------------------------------------------

	printSubMenuCursor:									
		ldy $20									// draws cursor to the right 	
-;		lda cursorBytesSUB,y
		sta $700,y
		iny 
		cmp #$FF
		bne -
		sty $20
		rts 
	
	handleSubMenuInputs:
		clv 							// for later in this subroutine
		lda {currentInputOneFrame}
		and {multipleInput_UpOrDown}
		cmp #$00
		beq checkForAPress 
		cmp {input_Down}
		beq pressedDown
		// assuming up got pressed, which means if you press up+down, it will get interpreted as up
		inc {practiceSubMenuCursor}
		lda {practiceSubMenuCursorMaxValue}
		cmp {practiceSubMenuCursor}
		bcc +
		bvc checkForAPress 

		// overflow cursor value
+;		lda #$00
		sta {practiceSubMenuCursor}
		bvc checkForAPress  

	pressedDown:
		dec {practiceSubMenuCursor}
		lda {practiceSubMenuCursor}
		cmp #$FF
		beq +
		bvc checkForAPress 

		// underflow cursor value
+;		lda {practiceSubMenuCursorMaxValue}
		sta {practiceSubMenuCursor}
	
	checkForAPress:
		lda {currentInputOneFrame}
		and {input_B}
		cmp {input_B}
		bne +
		lda {true}
		sta {practiceSubMenuShouldExecuteMenuActionFlag}

+;		rts 


	printCurrentNumericalValue:
		lda {practiceSubMenuCursor}
		ldy $20
		ora #$D0								// make it a number character and print
		dey
		dey
		sta $700,y
		rts 
    
    printCurrentTextValue:
        //TODO