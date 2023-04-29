	menuRoutine:
	// backup state of the x register
		txa 
		pha 
		
		jsr menuManager

		// hijack fix
		ldy #$00
		pla 
		tax 
		rts 

// -- menu main -----------------------------------------------------
	
	menuManager:
		// check in what phase of the menu we're on (awaiting for select press, constructing, deconstructing, etc.) and execute the matching code

		lda {practiceMenuPhaseIndex}
		asl 
		tay 
		
		lda mainPauseMenu+1,y
		sta $01
		lda mainPauseMenu,y
		sta $00

		jmp ($0000)

// -- menu framework and logic --------------------------------------
	
	initWhilePause:
		// check if the game is currently paused, don't allow menu to be opened if so

		// branch instructions are a CPU cycle slower if followed...
		// ...so we want the path that is going to be taken during normal gameplay (that is, during action and the player is not opening the menu)...
		// ... to be the fastest one.
		lda {pauseFlag}
		bne + 
		rts 

		// check if select is pressed, and open the menu if so 
+;		lda {currentInputOneFrame}	
		and {INPUT_Select}

		bne +
		rts 
+;		lda #$01
		sta {practiceMenuPhaseIndex}		

		// initialize some variables tused in the menu
		lda #$00
		sta {practiceSubMenuCursor}	
		sta {practiceAboutPrintPhase}
		rts 
	
	
	bufferFrame:
		// the game seems to offload routines to run on even or odd frames, so we respect this practice
		lda {frameCounter}			
		and #$01					
		bne +
		rts 
	+;	inc {practiceMenuPhaseIndex}
		rts 	
		
	openMenu_clearHUD00:
		// clear hud. this is the first pass
		ldy {tileDataPointer}
		// the x register here is the loop size
		ldx #$41
			
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
	-;	sta {PPUBuffer},y
		iny
		dex 
		bpl -	
		
		dey
		sty {tileDataPointer}	
						
		dey
		// 0xFF is terminator byte for the PPU job
		lda #$FF
		sta {PPUBuffer},y

		// make subweapon frame invisible while contructing. it is actually made up of 8 sprites
		// unrolled loop
		lda #$FF					
		sta {subweaponFrameSprite1ForOAM}
		sta {subweaponFrameSprite1ForOAM}+4
		sta {subweaponFrameSprite1ForOAM}+8
		sta {subweaponFrameSprite1ForOAM}+12
		sta {subweaponFrameSprite1ForOAM}+16
		sta {subweaponFrameSprite1ForOAM}+20
		sta {subweaponFrameSprite1ForOAM}+24
		sta {subweaponFrameSprite1ForOAM}+28
		
		// end of first pass
		inc {practiceMenuPhaseIndex}	
		rts 

	openMenu_clearHUD01:
		// clear hud. this is the second pass
		ldy {tileDataPointer}
		// the x register here is the loop size
		ldx #$41
	
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
	-;	sta {PPUBuffer},y
		iny 
		dex 
		bpl -
		
		dey 
		sty {tileDataPointer}

		// 0xFF is terminator byte for the PPU job
		dey 
		lda #$FF
		sta {PPUBuffer},y

		// make subweapon sprite invisible while constructing. it is actually made up of 2 sprites!
		// after exiting the menu, the game will redraw the subweapon
		lda #$FF
		sta {subweaponSprite1ForOAM}
		sta {subweaponSprite2ForOAM}

		// end of second pass
		inc {practiceMenuPhaseIndex}
		rts 
    
	printMenuTextOptions:
		// set destination Base Pointer		
		lda #$23 						
		sta {practiceText_Dest}
		lda #$20
		sta {practiceText_Dest}+1
		
		// $02 is used as a counter here, to stop printing words after having printed four
		lda #$00
		sta $02							
		ldx {tileDataPointer}
		lda {practiceTextPos}
		asl
		tay

    printMenuTextMainLoop:
		// set the pointer to the menu option text
		lda textTable_menuOptions,y
		sta {practiceMenuTextPointer}
		
		lda textTable_menuOptions+1,y
		sta {practiceMenuTextPointer}+1
		// check if the end of the table has been reached
		cmp #$FF
		bne +
		dey
		dey
		sty {practiceTextPos}
		jmp printMenuTextMainLoop
	
		// SBDWolf: i'm not actually sure what this byte is for, but it seems important to signal the PPU to actually print stuff :)
	+;	lda #$01
		sta {PPUBuffer},x		
		inx
		
		// set destination pointer in the nametable
		lda {practiceText_Dest}+1
		sta {PPUBuffer},x
		inx
		lda {practiceText_Dest}		
		sta {PPUBuffer},x	
		inx				
		
		// backup to keep track of the text pointer
		tya								
		pha

		ldy #$00
	-;	lda ($00),y
		sta {PPUBuffer},x
		inx
		iny
		cmp #$FF
		bne -
		
		pla
		tay
		
		iny
		iny
		
		// move the destination address in the nametable forward, so that the next menu option gets printed on a new line in the HUD
		lda {practiceText_Dest}
		clc 
		adc #$20
		sta {practiceText_Dest}
		
		// check if four words have been drawn
		lda $02
		clc
		adc #$01
		sta $02
		cmp #$04							
		beq endprintMenuTextMainLoop
		jmp printMenuTextMainLoop

	endprintMenuTextMainLoop:
		stx {tileDataPointer}
		
		// menu has been fully initialized! the main logic will run on the next frame
		inc {practiceMenuPhaseIndex}
		rts
    
    runMenu:	
		// move sprite 0 to not glitch the text's bottom 
		lda {SPRITE0_MenuMovedPosition}
		sta {sprite0ForOAM}

		// the game might have been already unpaused while the menu was drawing
		// we check if the game is still paused, and start deconstructing the menu if not	
		lda {pauseFlag}
		cmp {TRUE}
		bne +
		
		// we have indexed pointers with practice menuCurserPos and practiceTextPos when we change them we decrease the menu state 
		jsr cursorLogic

		jmp checkIfShouldCloseMenu

+;		lda {PRACTICEMENU_DeconstructMenu00PhaseIndex}
		sta {practiceMenuPhaseIndex}
		rts 

    closeMenu_clearHUD00:	
		// update the list of active tools
		clv 
		lda {TOOLS_ToolCount}
		sta {toolsCountForMenuDeconstruction}
		asl {toolsCountForMenuDeconstruction}

		lda {activeTools}
		// y register is used as a cursor to determine where to store the pointer to the tool's code
		ldy #$00
		// x register is used both as an index to determine which pointer to store, as well as a loop counter
		ldx #$00

		// in this loop, we check activeTools bit for bit, and determine which tools are active.
		// we check the first bit, then asl at every iteration until we've checked for every tool
		// expanding the number of tools past 8 will require modifying this loop and using a second byte

		// push the value in the accumulator to the stack. this is used to memorize the current state of the byte for the next iteration
-;		pha 
		and #$80
		cmp #$80
		bne + 
		lda pointerTable_toolsList,x
		sta {toolsToRunPointerList},y
		iny 
		lda pointerTable_toolsList+1,x
		sta {toolsToRunPointerList},y
		iny 
		
		// retrieve the value pushed earlier
+;		pla 
		asl 
		inx 
		inx  
		cpx {toolsCountForMenuDeconstruction}
		bne -

		lda pointerTable_toolsEnd
		sta {toolsToRunPointerList},y
		lda pointerTable_toolsEnd+1
		sta {toolsToRunPointerList}+1,y
		
		
		// clear hud. this is again done in two passes. this is the first pass
		ldy {tileDataPointer}
		// the x register here is the loop size
		ldx #$41
			
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
	-;	sta {PPUBuffer},y
		iny
		dex 
		bpl -	
		
		dey
		sty {tileDataPointer}	
						
		dey
		// 0xFF is terminator byte for the PPU job
		lda #$FF
		sta {PPUBuffer},y

		// end of first pass
		inc {practiceMenuPhaseIndex}	
		rts 

 	
	closeMenu_clearHUD01:
		// clear hud. this is the second pass
		ldy {tileDataPointer}
		// the x register here is the loop size
		ldx #$41
	
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
	-;	sta {PPUBuffer},y
		iny 
		dex 
		bpl -
		
		dey 
		sty {tileDataPointer}

		// 0xFF is terminator byte for the PPU job
		dey 
		lda #$FF
		sta {PPUBuffer},y

		// end of second pass
		inc {practiceMenuPhaseIndex}	
		rts 


	reBuildHUD:
		// rebuild sub-weapon Frame
		ldx #$1F
-;		lda subweapon_frame_sprites,x
		sta $021C,x
		dex 
		bpl -		
		
		// in src/utility.asm
		jsr printCurrentStage		
		jsr printHeartCount

		// this inc $141 will update the graphic for the subweapon multiplier
		inc $141
		// update the player's life meter			
		inc $44
		// update the boss's life meter			
		inc $1AA
		
		// close subMenu
		lda #$00						
		sta {practiceMenuCursor}
		sta {practiceTextPos}
		sta {practiceSubMenuCursor}
		
		lda {PRACTICEMENU_LastPhaseIndex}
		sta {practiceMenuPhaseIndex}
		rts
	
	// ------------------- cursor logic -------------------------------	
	cursorLogic:			
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
		sta {practiceMenuPhaseIndex}		
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
		sta {practiceMenuPhaseIndex}		
	endUpCheckInMenu:	
		
		lda {currentInputOneFrame}				// ------------------- press B button -------------------------------	
		and {INPUT_B}
		cmp {INPUT_B}
		bne +
		
		lda #$00								// undraw Heart
		sta {PPUBuffer}+3								
		
		lda {PRACTICEMENU_MenuActionPhaseIndex}	// enter sub menu 
		sta {practiceMenuPhaseIndex}	
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
		lda {currentInputOneFrame}				// exit menu with select OR start
		and {MULTIPLEINPUT_StartOrSelect}
		cmp #$00
		beq +;

		lda {PRACTICEMENU_DeconstructMenu00PhaseIndex}
		sta {practiceMenuPhaseIndex}
+;		rts 

	closeMenu:
		// move sprite 0 back to its original position 
		lda {SPRITE0_OriginalPosition}						
		sta {sprite0ForOAM}
		lda #$00
		sta {practiceMenuPhaseIndex}
		rts 