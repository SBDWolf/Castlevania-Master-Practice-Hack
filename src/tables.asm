bank 5
base $8000
org {bank5_freeSpaceData}
	mainPauseMenu:
		dw initWhilePause,openMenu_clearHUD00
		dw bufferFrame,openMenu_clearHUD01
		dw bufferFrame,printMenuTextOptions
		dw bufferFrame,runMenu
		dw bufferFrame,closeMenu_clearHUD00
		dw bufferFrame,closeMenu_clearHUD01
		dw bufferFrame,reBuildHUD
		dw bufferFrame,menuAction			
		dw bufferFrame,closeMenu		
    
    textTable_menuOptions:							// this two following tables need to have the same size. They use the same index to execute the program 							
		dw text_reset								
		dw text_stageSelect
		dw text_whipLevelSelect
		dw text_subweaponSelect 
		dw text_subweaponMultiplierSelect
		dw text_gameLoop           	
		dw text_memoryWatch00
		dw text_memoryWatch01
		dw text_memoryWatch02
		dw text_memoryWatch03
		dw text_timer
		dw text_scrollGlitch
		dw text_about
        dw $FFFF    


	text_reset: 
		db "RESET STAGE  /"
	text_stageSelect:
		db "STAGE SELECT /"
	text_whipLevelSelect:
		db "WHIP LEVEL   /"		
	text_subweaponSelect:
		db "SUBWEAPON    /"
	text_subweaponMultiplierSelect:
		db "MULTIPLIER   /"
	text_gameLoop:
		db "GAME LOOP    /"
	text_memoryWatch00:
		db "VIEWER 1     /"
	text_memoryWatch01:
		db "VIEWER 2     /"
	text_memoryWatch02:
		db "VIEWER 3     /"
	text_memoryWatch03:
		db "VIEWER 4     /"
	text_timer:
		db "TIMER        /"
	text_scrollGlitch:
		db "SCROLL GLITCH/"
	text_about:
		db "ABOUT        /"
	
	                     

	pointerTable_actionTable:
		dw action_reset
		dw action_stageSelect
		dw action_whipLevelSelect
		dw action_subweaponSelect
		dw action_subweaponMultiplierSelect
		dw action_gameLoop
		dw action_memoryWatch00
		dw action_memoryWatch01
		dw action_memoryWatch02
		dw action_memoryWatch03
		dw action_timer
		dw action_scrollGlitch
		dw action_about
	
	

	submenu_text_master_table:
		dw textTable_timer
		dw textTable_scrollGlitch
		dw textTable_memoryWatch
		dw textTable_subweaponSelect
		dw textTable_about
		// etc

	textTable_timer:
		// header contains index of each text entry
		db $02,$0E
		db "DISABLED   /"
		db "ENABLED    /"

	textTable_scrollGlitch:
		db $02,$0E
		db "DISABLED   /"
		db "ENABLED    /"

	textTable_memoryWatch:
		// header contains index of each text entry
		db $06,$12,$1E,$2A,$36,$42
		db "DISABLED   /"
		db "SIMON K    /"
		db "SIMON Y    /"
		db "WHIP FRAMES/"
		db "BOSS HEALTH/"
		db "BLK COUNTER/"

	lookupTable_memoryWatchAddresses:
		dw $0000
		dw {simonXHighByte}
		dw {simonY}
		dw {whipAnimationTimer}
		dw {currentBossHealth}
		dw {blockCounter}

	textTable_subweaponSelect:
		db $05,$11,$1D,$29,$35
		db "DAGGER     /"
		db "CROSS      /"
		db "HOLY WATER /"
		db "HATCHET    /"
		db "STOPWATCH  /"
		// would be nice to not have to call the axe "hatchet" but there is no X character in castlevania's tileset :(

	lookupTable_subweaponSelect:
		// 0x08 = dagger, 0x09 = cross, 0x0B = holy water 0x0D = axe, 0x0F = stopwatch
		db $08,$09,$0B,$0D,$0F

	
	textTable_about:
		db $01,$20,$20," CASTLEVANIA PRACTICE HACK V0.1 /"
		db "    FOR A USER MANUAL VISIT     /"
		// done in two passes, so the ppu job destination is included in this third line
		db $01,$20,$60,"   TINYURL.COM SLASH 2P4E6FFM   /"
		db "                                /"

	pointerTable_toolsList:
		// WIP, $FFFF bytes are filler
		dw tool_timer
		dw tool_memoryWatch00
		dw tool_memoryWatch01
		dw tool_memoryWatch02
		dw tool_memoryWatch03
		dw tool_scrollGlitch
		dw $FFFF
		dw $FFFF

	pointerTable_scrollGlitchStageCode:
		dw scrollGlitch_stage00
		dw scrollGlitch_stage01
		dw scrollGlitch_stage02
		dw scrollGlitch_stage03
		dw scrollGlitch_stage04
		dw scrollGlitch_stage05
		dw scrollGlitch_stage06
		dw scrollGlitch_stage07
		dw scrollGlitch_stage08
		dw scrollGlitch_stage09
		dw scrollGlitch_stage10
		dw scrollGlitch_stage11
		dw scrollGlitch_stage12
		dw scrollGlitch_stage13
		dw scrollGlitch_stage14
		dw scrollGlitch_stage15
		dw scrollGlitch_stage16
		dw scrollGlitch_stage17
		dw scrollGlitch_stage18
		dw scrollGlitch_stage19Placeholder
		dw scrollGlitch_stageMap
	
	pointerTable_toolsEnd:
		dw returnToGame



	// lookup tables for quick hex to dec conversion. this saves CPU time at the expense of ROM space.
	tens_digits_table:
		db $D0,$D0,$D0,$D0,$D0,$D0,$D0,$D0,$D0,$D0 // 0
		db $D1,$D1,$D1,$D1,$D1,$D1,$D1,$D1,$D1,$D1 // 10
		db $D2,$D2,$D2,$D2,$D2,$D2,$D2,$D2,$D2,$D2 // 20
		db $D3,$D3,$D3,$D3,$D3,$D3,$D3,$D3,$D3,$D3 // 30
		db $D4,$D4,$D4,$D4,$D4,$D4,$D4,$D4,$D4,$D4 // 40
		db $D5,$D5,$D5,$D5,$D5,$D5,$D5,$D5,$D5,$D5 // 50
		db $D6,$D6,$D6,$D6,$D6,$D6,$D6,$D6,$D6,$D6 // 60
		db $D7,$D7,$D7,$D7,$D7,$D7,$D7,$D7,$D7,$D7 // 70
		db $D8,$D8,$D8,$D8,$D8,$D8,$D8,$D8,$D8,$D8 // 80
		db $D9,$D9,$D9,$D9,$D9,$D9,$D9,$D9,$D9,$D9 // 90

	ones_digits_table:
		db $D0,$D1,$D2,$D3,$D4,$D5,$D6,$D7,$D8,$D9 // 0
		db $D0,$D1,$D2,$D3,$D4,$D5,$D6,$D7,$D8,$D9 // 10
		db $D0,$D1,$D2,$D3,$D4,$D5,$D6,$D7,$D8,$D9 // 20
		db $D0,$D1,$D2,$D3,$D4,$D5,$D6,$D7,$D8,$D9 // 30
		db $D0,$D1,$D2,$D3,$D4,$D5,$D6,$D7,$D8,$D9 // 40
		db $D0,$D1,$D2,$D3,$D4,$D5,$D6,$D7,$D8,$D9 // 50
		db $D0,$D1,$D2,$D3,$D4,$D5,$D6,$D7,$D8,$D9 // 60
		db $D0,$D1,$D2,$D3,$D4,$D5,$D6,$D7,$D8,$D9 // 70
		db $D0,$D1,$D2,$D3,$D4,$D5,$D6,$D7,$D8,$D9 // 80
		db $D0,$D1,$D2,$D3,$D4,$D5,$D6,$D7,$D8,$D9 // 90

	// used for memory view
	hex_digits_table:
		db $D0,$D1,$D2,$D3,$D4,$D5,$D6,$D7,$D8,$D9,$E0,$E1,$E2,$E3,$E4,$E5

	cursorBytes:
		db $01,$00,$00,$DC,$FF,$00	
	cursorBytesSUB:
		db $01,$20,$31,$DC,"   ",$FF,$00	
	menuCursorPos:
		dw $2021,$2041,$2061,$2081,$FF,$FF	

	// the subweapon frame is made up of 8 sprites
	subweapon_frame_sprites:
		db $16,$FB,$03,$80,$16,$FD,$03,$88,$16,$FD,$03,$90,$16,$FB,$43,$98
		db $26,$9D,$03,$80,$2A,$FD,$03,$88,$2A,$FD,$03,$90,$26,$9D,$43,$98

	warnpc {bank5_mirrorCodeToBank6}