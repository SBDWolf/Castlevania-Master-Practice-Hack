	program_reset:
		lda #$00
		sta {practiceMenuCursor}
		sta $22                 // unpause
		
		lda #$06
		sta $18
		
		lda #$08
		sta {practiceMenuIndex}
		
		lda $64         // backup subweapon and multiplier
		sta $600e
		lda $15b
		sta $600f
		
		inc $2a // add a life
		
		lda {practiceMenuDeconstructMenu00PhaseIndex}								// exit menu
		sta {practiceMenuIndex}

		rts 

	program_test:
        lda #$05
        sta {practiceSubMenuCursorMaxValue}
        jsr printSubMenuCursor
        jsr handleSubMenuInputs
        lda {practiceSubMenuShouldExecuteMenuActionFlag}
        cmp {true}
        bne +
		// perform action, for testing purposes i am updating the current whip level
		lda {practiceSubMenuCursor}
        sta {currentWhipLevel}

		jmp exitMenu
        
+;      jsr printCurrentNumericalValue
        rts 

	program_test_text_options:
        lda #$04
        sta {practiceSubMenuCursorMaxValue}
		jsr printSubMenuCursor
		jsr handleSubMenuInputs
		lda {practiceSubMenuShouldExecuteMenuActionFlag}
        cmp {true}
        bne +
		// convert cursor position to subweapon
		jmp exitMenu
        
+;      jsr printCurrentTextValue
        rts 

		rts

    exitMenu:
		lda {practiceMenuDeconstructMenu00PhaseIndex}
		sta {practiceMenuIndex}

        rts 

    