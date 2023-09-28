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
		dw text_heartSelect
		dw text_gameLoop           	
		dw text_memoryWatch00
		dw text_memoryWatch01
		dw text_memoryWatch02
		dw text_timer
		dw text_scrollGlitch
		dw text_inputDisplay
		dw text_draculaDiagnosis
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
	text_heartSelect:
		db "HEARTS       /"
	text_gameLoop:
		db "GAME LOOP    /"
	text_memoryWatch00:
		db "VIEWER 1     /"
	text_memoryWatch01:
		db "VIEWER 2     /"
	text_memoryWatch02:
		db "VIEWER 3     /"
	text_timer:
		db "TIMER        /"
	text_scrollGlitch:
		db "SCROLL GLITCH/"
	text_inputDisplay:
		db "INPUT DISPLAY/"
	text_draculaDiagnosis:
		db "DRACULA TOOL /"
	text_about:
		db "ABOUT        /"
	
	                     

	pointerTable_actionTable:
		dw action_reset
		dw action_stageSelect
		dw action_whipLevelSelect
		dw action_subweaponSelect
		dw action_subweaponMultiplierSelect
		dw action_heartSelect
		dw action_gameLoop
		dw action_memoryWatch00
		dw action_memoryWatch01
		dw action_memoryWatch02
		dw action_timer
		dw action_scrollGlitch
		dw action_inputDisplay
		dw action_draculaDiagnosis
		dw action_about
	
	

	submenu_text_master_table:
		dw textTable_binaryEnable
		dw textTable_scrollGlitch
		dw textTable_memoryWatch
		dw textTable_subweaponSelect
		dw textTable_about
		// etc

	textTable_binaryEnable:
		// header contains index of each text entry
		db $02,$0E
		db "DISABLED   /"
		db "ENABLED    /"

	textTable_scrollGlitch:
		// header contains index of each text entry
		db $03,$0F,$1B
		db "DISABLED   /"
		db "DEATH      /"
		db "DIAGNOSTIC /"

	textTable_memoryWatch:
		// header contains index of each text entry
		db $06,$12,$1E,$2A,$36,$42
		db "DISABLED   /"
		db "SIMON X    /"
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
		db "AXE        /"
		db "STOPWATCH  /"

	lookupTable_subweaponSelect:
		// 0x08 = dagger, 0x09 = cross, 0x0B = holy water 0x0D = axe, 0x0F = stopwatch
		db $08,$09,$0B,$0D,$0F

	
	textTable_about:
		db $01,$20,$20," CASTLEVANIA PRACTICE HACK V0.5 /"
		db "    FOR A USER MANUAL VISIT     /"
		// done in two passes, so the ppu job destination is included in this third line
		db $01,$20,$60,"   TINYURL.COM SLASH 2P4E6FFM   /"
		db "                                /"

	pointerTable_toolsList:
		// WIP, $FFFF bytes are filler
		// game crashes when 9 tools are active at the moment!
		// that is because i am storing these pointers in an area of memory that has up to 16 bytes available...
		// ...so 8 tools enabled will cause 9 pointers to be stored there, which overflows and kills the game
		dw tool_timer
		dw tool_memoryWatch00
		dw tool_memoryWatch01
		dw tool_memoryWatch02
		dw tool_scrollGlitchDiagnostic
		dw tool_scrollGlitchDeath
		dw tool_inputDisplay
		dw tool_draculaDiagnosis

	pointerTable_scrollGlitchDeathStageCode:
		dw scrollGlitchDeath_stage00
		dw scrollGlitchDeath_stage01
		dw scrollGlitchDeath_stage02
		dw scrollGlitchDeath_stage03
		dw scrollGlitchDeath_stage04
		dw scrollGlitchDeath_stage05
		dw scrollGlitchDeath_stage06
		dw scrollGlitchDeath_stage07
		dw scrollGlitchDeath_stage08
		dw scrollGlitchDeath_stage09
		dw scrollGlitchDeath_stage10
		dw scrollGlitchDeath_stage11
		dw scrollGlitchDeath_stage12
		dw scrollGlitchDeath_stage13
		dw scrollGlitchDeath_stage14
		dw scrollGlitchDeath_stage15
		dw scrollGlitchDeath_stage16
		dw scrollGlitchDeath_stage17
		dw scrollGlitchDeath_stage18
		dw scrollGlitchDeath_stage19Placeholder
		dw scrollGlitchDeath_stageMap

	pointerTable_scrollGlitchDiagnosticStageCode:
		dw scrollGlitchDiagnostic_stage00
		dw scrollGlitchDiagnostic_stage01
		dw scrollGlitchDiagnostic_stage02
		dw scrollGlitchDiagnostic_stage03
		dw scrollGlitchDiagnostic_stage04
		dw scrollGlitchDiagnostic_stage05
		dw scrollGlitchDiagnostic_stage06
		dw scrollGlitchDiagnostic_stage07
		dw scrollGlitchDiagnostic_stage08
		dw scrollGlitchDiagnostic_stage09
		dw scrollGlitchDiagnostic_stage10
		dw scrollGlitchDiagnostic_stage11
		dw scrollGlitchDiagnostic_stage12
		dw scrollGlitchDiagnostic_stage13
		dw scrollGlitchDiagnostic_stage14
		dw scrollGlitchDiagnostic_stage15
		dw scrollGlitchDiagnostic_stage16
		dw scrollGlitchDiagnostic_stage17
		dw scrollGlitchDiagnostic_stage18
		dw scrollGlitchDiagnostic_stage19Placeholder
		dw scrollGlitchDiagnostic_stageMap
	
	pointerTable_scrollGlitchDiagnosticMovementCode:
		dw onIdle
		dw onFirstMovementRight
		dw onFirstMovementLeft
		dw onScrollGlitchMovementRight
		dw onScrollGlitchMovementLeft

	lookupTable_scrollGlitchDiagnosticHudDestinations:
		db $22,$42
		db $23,$43
		db $24,$44
		db $25,$45
		db $26,$46
		db $27,$47
		db $28,$48
		db $29,$49
		db $2A,$4A
		db $2B,$4B
		db $2C,$4C
		db $2D,$4D
		db $2E,$4E
		db $2F,$4F
		db $30,$50
		db $31,$51
		db $32,$52

	pointerTable_toolsEnd:
		dw returnToGame



	// lookup table for printing a "base24" number on screen. this is used by the scroll glitch diagnostic tool
	base24_digits_table:
		db $D0,$D1,$D2,$D3,$D4,$D5,$D6,$D7,$D8,$D9,$E0,$E1,$E2,$E3,$E4,$E5,$E6,$E7,$E8,$E9,$EA,$EB,$EC,$ED

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

	// used for the input display tool
	inputDisplay_character_table:
		db "BATS",$DC,$DC,$DC

	// the subweapon frame is made up of 8 sprites
	subweapon_frame_sprites:
		db $16,$FB,$03,$80,$16,$FD,$03,$88,$16,$FD,$03,$90,$16,$FB,$43,$98
		db $26,$9D,$03,$80,$2A,$FD,$03,$88,$2A,$FD,$03,$90,$26,$9D,$43,$98

	warnpc {bank5_mirrorCodeToBank6}