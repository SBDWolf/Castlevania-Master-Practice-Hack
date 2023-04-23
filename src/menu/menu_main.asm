    mainPracticeMenu:						
		lda {practiceMenuIndex}
		asl 
		tay 
		
		lda mainPauseMenu+1,y
		sta $01
		lda mainPauseMenu,y
		sta $00						// rts + 1 fix
		
		jmp ($0000)  				// menu jump table

// -- menu framework and logic ---------------------------------------	
	
	initWhilePause:
		lda {currentInputOneFrame}	// check if select is pressed 
		and {INPUT_Select}
		cmp {INPUT_Select}
		bne +
		lda #$01
		sta {practiceMenuIndex}		
		// hack: unset the pause flag. if the game is already paused, it'll allow this menu to come up with select while keeping the game paused.
		// this is because after unsetting this flag, the game will immediately pause again, instead of unpausing.	
		// other variables are also initialized to 00 here
		lda #$00
		sta {pauseFlag}
		sta {practiceSubMenuCursor}	
		sta {practiceSubMenuShouldExecuteMenuActionFlag}
	+;	rts 
	
	
	bufferFrame:
		lda {frameCounter}			// the game seems to offload routines to run on even or odd frames
		and #$01					
		cmp #$01
		bne +
		inc {practiceMenuIndex}
	+;	rts 	
		
	constructMenu00:		
		ldy {tileDataPointer}
		ldx #$41					// set loop size to fill blank
			
		lda #$01
		sta {PPUBuffer},y
		iny

		lda #$20
		sta {PPUBuffer},y
		iny
		lda #$20
		sta {PPUBuffer},y
		iny
	
		lda #$00
	-;	sta {PPUBuffer},y					// fill loop
		iny
		dex 
		bpl -	
		
		dey
		sty {tileDataPointer}						// ppu dest and backup table offset		
						
		dey
		lda #$FF					// end byte for PPU job
		sta {PPUBuffer},y

		// make subweapon frame invisible while contructing. it is actually made up of 8 sprites
		// DRY? what's that?
		// (this code is faster than a loop with an index on a y register, i have the ROM space, would rather optimize for speed)
		lda #$FF					
		sta {subweaponFrameSprite1ForOAM}
		sta {subweaponFrameSprite1ForOAM}+4
		sta {subweaponFrameSprite1ForOAM}+8
		sta {subweaponFrameSprite1ForOAM}+12
		sta {subweaponFrameSprite1ForOAM}+16
		sta {subweaponFrameSprite1ForOAM}+20
		sta {subweaponFrameSprite1ForOAM}+24
		sta {subweaponFrameSprite1ForOAM}+28
		
		inc {practiceMenuIndex}		// this is spliced in two parts so it runs without glitching		
		rts 

	constructMenu01:
		ldy {tileDataPointer}
		ldx #$41					// set loop size to fill blank
	
		lda #$01
		sta {PPUBuffer},y
		iny 

		lda #$20
		sta {PPUBuffer},y
		iny 
		lda #$60
		sta {PPUBuffer},y
		iny 
	
		lda #$00
	-;	sta {PPUBuffer},y					// fill loop
		iny 
		dex 
		bpl -						
		
		dey 
		sty {tileDataPointer}						// ppu dest and backup table offset		
						
		dey 
		lda #$FF					// end byte for PPU job
		sta {PPUBuffer},y

		// make subweapon sprite invisible while constructing. it is actually made up of 2 sprites!
		// after exiting the menu, the game will redraw the subweapon
		lda #$FF
		sta {subweaponSprite1ForOAM}
		sta {subweaponSprite2ForOAM}
		
		inc {practiceMenuIndex}		// run menu next frame 		
		rts 
    
    drawText:			
		lda #$23 						// set destination Base Pointer
		sta {practiceText_Dest}
		lda #$20
		sta {practiceText_Dest}+1
		
		lda #$00						// a counter to count 4 words to print
		sta $02							
		ldx {tileDataPointer}							// text draw loop 	
		lda {practiceTextPos}
		asl
		tay

    drawTextLoop:						// setBasePointer
		lda textTable_menuOptions,y
		sta {practiceMenuTextPointer}
		
		lda textTable_menuOptions+1,y
		sta {practiceMenuTextPointer}+1
		cmp #$FF						// check for end of text table. Just dont store text at $FFXX
		bne +
		dey								// stop table to advance
		dey
		sty {practiceTextPos}
		jmp drawTextLoop
	
	+;	lda #$01						// set job and destination 
		sta {PPUBuffer},x		
		inx
		
		lda {practiceText_Dest}+1		// set destination pointer
		sta {PPUBuffer},x
		inx
		lda {practiceText_Dest}		
		sta {PPUBuffer},x	
		inx				
		
		tya								// backup to keep track of text pointer
		pha

		ldy #$00		
	-;	lda ($00),y						// write text loop
		sta {PPUBuffer},x
		inx
		iny
		cmp #$FF
		bne -
		
		pla
		tay
		
		iny
		iny
		
		lda {practiceText_Dest}			// put base to next line of menu entery 
		clc 
		adc #$20
		sta {practiceText_Dest}
		
		lda $02							// check if we did draw 4 words 
		clc
		adc #$01
		sta $02
		cmp #$04							
		beq endDrawTextLoop
		jmp drawTextLoop

	endDrawTextLoop:
		stx {tileDataPointer}
		
		inc {practiceMenuIndex}			// go to sub menu logic	
		rts
    
    runMenu:	
		// move sprite 0 to not glitch the text's bottom 
		lda #$2F
		sta {sprite0ForOAM}

		// the game might have been already unpaused while the menu was drawing
		// we check if the game is still paused, and start deconstructing the menu if not	
		lda {pauseFlag}
		cmp {TRUE}
		bne +
		
		jsr cursorLogic					// we have indexed pointers with practice menuCurserPos and practiceTextPos when we change them we decrease the menu state 

		jmp checkIfShouldCloseMenu

+;		lda {PRACTICEMENU_DeconstructMenu00PhaseIndex}
		sta {practiceMenuIndex}
		rts 

    deconstructMenu00:	
		lda {FALSE}
		sta {pauseFlag}					// unpause, intended for if coming after selecting a submenu option
		jmp constructMenu00				// clear
 	
	deconstructMenu01:			
		jmp constructMenu01
	
	reBuildHUD:
		ldx #$1F					// rebuild sub-weapon Frame
-;		lda subweapon_frame_sprites,x
		sta $021C,x
		dex 
		bpl -		
		
		jsr printCurrentStage		// in src/utility.asm
		jsr printHeartCount

		inc $141					// update subweapon multiplier appear 
		inc $44 					// update player life meter
		inc $1AA					// update boss life meter
		
		lda #$00						
		sta {practiceMenuCursor}	// close subMenu
		sta {practiceTextPos}
		sta {practiceSubMenuCursor}
		
		lda {PRACTICEMENU_LastPhaseIndex}
		sta {practiceMenuIndex}		// extra buffer cycle
		rts
	
	cursorLogic:	// ------------------- cursor logic -------------------------------			
		ldy {tileDataPointer}									
	-;	lda cursorBytes,y
		sta {PPUBuffer},y
		iny 
		cmp #$FF
		bne -
		sty {tileDataPointer}
	
	updateCursorPos:
		lda {practiceMenuCursor}				// update pos
		asl 
		tax
		
		lda menuCursorPos+1,x
		sta $701
		lda menuCursorPos,x
		sta $702
		cmp #$FF								// check end of table	
		bne +
		
		lda #$03								// end of selection range							
		sta {practiceMenuCursor}
		jmp updateCursorPos				

								
	+;	lda {currentInputOneFrame}				// ------------------- press down -------------------------------
		and {INPUT_Down}
		cmp {INPUT_Down}
		bne endDownCheckInMenu
		
		lda #$00								// undraw Heart
		sta $703								
		
		lda {practiceMenuCursor}				// when we reach the end of the line we increase the text pointer
		clc
		adc #$01
		cmp #$04
		bne +
		
		clc 
		adc {practiceTextPos}					// check if we are at the end of the TEXT list
		asl
		tay
		lda textTable_menuOptions,y
		cmp #$FF
		beq endDownCheckInMenu
		
		inc {practiceTextPos}					// move list on screen
		bpl skipCursorMovingPastMenuBounderies
	+;	sta {practiceMenuCursor}
	skipCursorMovingPastMenuBounderies:
		
		lda #$02								// clear redraw
		sta {practiceMenuIndex}		
	endDownCheckInMenu:	
	
		lda {currentInputOneFrame}				// ------------------- press up -------------------------------	
		and {INPUT_Up}
		cmp {INPUT_Up}				
		bne endUpCheckInMenu
		

		lda #$00								// undraw Heart
		sta {PPUBuffer}+3
		
		lda {practiceMenuCursor}				// when we reach the end of the line we increase the text pointer
		sec
		sbc #$01
		cmp #$FF
		bne +
		
		adc {practiceTextPos}					// check if we are at the end of the list
		beq endUpCheckInMenu
		
		dec {practiceTextPos}
		bpl doNotUnderflowCursorIndexSkip
	
	+;	sta {practiceMenuCursor}
	doNotUnderflowCursorIndexSkip:	
		
		lda #$02								// clear redraw
		sta {practiceMenuIndex}		
	endUpCheckInMenu:	
		
		lda {currentInputOneFrame}				// ------------------- press B button -------------------------------	
		and {INPUT_B}
		cmp {INPUT_B}
		bne +
		
		lda #$00								// undraw Heart
		sta {PPUBuffer}+3								
		
		lda {PRACTICEMENU_MenuActionPhaseIndex}		// enter sub menu 
		sta {practiceMenuIndex}	
	+;	rts 

	menuAction:
		jsr menuActionJumpText2MenuTable
		jmp checkIfShouldCloseMenu

	menuActionJumpText2MenuTable:
		lda {practiceMenuCursor}				// execute selected menu code
		clc 
		adc {practiceTextPos}					// to get text table offset we add cursor pos + text offset
		asl 
		tay 
		lda pointerTable_actionTable,y
		sta $00
		lda pointerTable_actionTable+1,y
		sta $01
		jmp ($0000)

	checkIfShouldCloseMenu:
		lda {currentInputOneFrame}		// exit menu with select OR start
		and {MULTIPLEINPUT_StartOrSelect}
		cmp #$00
		beq +;

		lda {PRACTICEMENU_DeconstructMenu00PhaseIndex}
		sta {practiceMenuIndex}
+;		rts 

	closeMenu:
		// move sprite 0 back to its original position 
		lda #$25						
		sta {sprite0ForOAM}
		lda #$00
		sta {practiceMenuIndex}
		rts 