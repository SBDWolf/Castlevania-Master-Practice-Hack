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
    
    text_Table:							// this two following tables need to have the same size. They use the same index to execute the program 							
		dw text_reset								
		dw text_goToLevel               
		dw text_gameMod
		dw text_GiveEquip
		dw text_gameLoop                
		dw text_SlowMo 
		dw text_colorMode 
		dw text_subweaponSelect             	
		dw text_whipLevel	
		dw text_multiShot

		 
		dw text_placeHolder   
        dw $ffff                         

	text_Program_Table:					
		dw program_reset
		dw program_test
		dw program_test_text_options
//		dw program_goToLevel            
//		dw program_gameMode
//		dw program_giveEquip
//		dw program_gameLoop	
//		dw program_SlowMo
//		dw program_colorMode 		
//		dw program_subweaponSelect           		           
//		dw program_WhipLevel
//		dw program_multiShot

	program_maxSubMenuValues:				// SBDWolf: add values to this table for new actions
		db $05
		 
//		dw program_placeHolder   		
//	    dw $ffff                       	
	
	text_SlowMo:
		db "SLOW MOTION ",$ff		
	text_reset:
		db "RESET       ",$ff	
	text_gameLoop:
		db "GAME LOOP   ",$ff				// we waste space so it clears out other names when scrolling list
	text_goToLevel:
		db "SELECT LEVEL",$ff	
	text_subweaponSelect:
		db "SUBWEAPON   ",$ff	
	text_colorMode:
		db "COLOR MODE  ",$ff	
	text_placeHolder:
		db "PLACE HOLDER",$ff
	text_whipLevel:
		db "WHIP LEVEL  ",$ff	
	text_multiShot:
		db "MULTI SHOT  ",$ff	
	text_gameMod:
		db "GAME MODE   ",$FF
	text_GiveEquip:
		db "GIVE ALL    ",$FF	
	text_blank:
		db "              ",$FF
	text_level_numbers:
		db "00010203040506070809101112131415161718",$ff
	text_HEX_numbers:
		db "0123456789ABCDEF",$ff
	
	text_program_test_text:
		db "DAGGER    "
		db "CROSS     "
		db "HOLY WATER"
		db "AXE       "
		db "STOPWATCH "



	cursorBytes:
		db $01,$00,$00,$dc,$ff,$00	
	cursorBytesSUB:
		db $01,$20,$31,$dc," 00",$ff,$00	
	menuCursorPos:
		dw $2021,$2041,$2061,$2081,$ff,$ff	

	text_blank:
		db "              ",$FF

	// the subweapon frame is made up of 8 sprites
	subweapon_frame_sprites:
		db $16,$FB,$03,$80,$16,$FD,$03,$88,$16,$FD,$03,$90,$16,$FB,$43,$98
		db $26,$9D,$03,$80,$2A,$FD,$03,$88,$2A,$FD,$03,$90,$26,$9D,$43,$98