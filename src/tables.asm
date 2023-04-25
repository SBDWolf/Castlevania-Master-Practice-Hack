bank 5
base $8000
org {bank5_freeSpaceData}
	mainPauseMenu:
		dw initWhilePause,constructMenu00
		dw bufferFrame,constructMenu01
		dw bufferFrame,drawText
		dw bufferFrame,runMenu
		dw bufferFrame,deconstructMenu00
		dw bufferFrame,deconstructMenu01
		dw bufferFrame,reBuildHUD
		dw bufferFrame,menuAction			
		dw bufferFrame,closeMenu		
    
    textTable_menuOptions:							// this two following tables need to have the same size. They use the same index to execute the program 							
		dw text_timer
		dw text_memoryWatch00
		dw text_toolTest
		dw text_reset								
		dw text_whipLevelSelect
		dw text_subweaponSelect 
		dw text_subweaponMultiplierSelect
		dw text_gameLoop           	
		dw text_stageSelect
		dw text_about
        dw $FFFF    

	text_timer:
		db "TIMER       /"
	text_memoryWatch00:
		db "VIEWER 1    /"
	text_toolTest:
		db "TOOL TEST   /"
	text_reset:
		db "RESET STAGE /"
	text_whipLevelSelect:
		db "WHIP LEVEL  /"		
	text_subweaponSelect:
		db "SUBWEAPON   /"
	text_subweaponMultiplierSelect:
		db "MULTIPLIER  /"
	text_gameLoop:
		db "GAME LOOP   /"
	text_stageSelect:
		db "STAGE SELECT/"
	text_about:
		db "ABOUT       /"
	
	                     

	pointerTable_actionTable:
		dw action_timer	
		dw action_memoryWatch00
		dw action_toolTest	
		dw action_reset
		dw action_whipLevelSelect
		dw action_subweaponSelect
		dw action_subweaponMultiplierSelect
		dw action_gameLoop
		dw action_stageSelect
		dw action_about
	
	

	submenu_text_master_table:
		dw textTable_timer
		dw textTable_memoryWatch00
		dw textTable_subweaponSelect
		dw textTable_about
		// etc

	textTable_timer:
		// header contains index of each text entry
		db $02,$0E
		db "DISABLED   /"
		db "ENABLED    /"

	textTable_memoryWatch00:
		db $05,$11,$1D,$29,$35
		db "DISABLED   /"
		db "LAG COUNTER/"
		db "SIMON X    /"
		db "SIMON Y    /"
		db "WHIP FRAMES/"
		// etc

	lookupTable_memoryWatchAddresses:
		dw $0000
		dw {totalLagFrameCounter}
		dw {simonXHighByte}
		dw {simonY}
		dw {whipAnimationTimer}

	textTable_subweaponSelect:
		db $05,$11,$1D,$29,$35
		db "DAGGER     /"
		db "CROSS      /"
		db "HOLY WATER /"
		db "HATCHET    /"						//TODO: FIX (as if)
		db "STOPWATCH  /"

	lookupTable_subweaponSelect:
		// 0x08 = dagger, 0x09 = cross, 0x0B = holy water 0x0D = axe, 0x0F
		db $08,$09,$0B,$0D,$0F

	
	textTable_about:
		// TODO: header -- maybe i don't need it in this case after all
		db $01,$20,$20,"CASTLEVANIA PRACTICE HACK V0.DEV/"
		db "    FOR A USER MANUAL VISIT     /"
		db $01,$20,$60,"   TINYURL.COM SLASH 2P4E6FFM   /"
		db "                                /"

	pointerTable_toolsList:
		dw tool_test
		dw tool_memoryWatch00
		dw $FFFF
		dw $FFFF
		dw $FFFF
		dw $FFFF
		dw tool_timer
		dw $FFFF
	
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