bank 7
base $C000
org {bank7_pauseCheckHijack}
		jsr {bank7_freeSpace}

org {bank7_freeSpace}
		// switch bank to bank 5. quick! there is no space!
		lda #$05
		sta $8000
		jsr practiceRoutine
		// switch back to bank 6 real quick, which is what the game is expecting at this point
		lda #$06
		sta $8000
		// hijack fix
		jsr {bank7_pauseCheck}
		rts 

org {bank7_scorePrintHijack}
		// don't ever draw the score. overwriting a jsr instruction
		nop 
		nop 
		nop 

org {bank7_mainJumpTable}+8
		// this is hijacking the castle entrance scene
		dw allowSkippingIntro

org {bank7_pauseCheck}+14
		// letting the game pause even when pressing select, on top of start
		and {MULTIPLEINPUT_StartOrSelect}

org {bank7_pauseCheck}+32
		// letting the game unpause even when pressing select, on top of start
		and {MULTIPLEINPUT_StartOrSelect}

org {bank7_deathHijack}
		jsr levelLoadHijack

bank 6
base $8000
org {bank6_subweaponPrintHijack}
		jmp subweaponSpriteUpdate 	// intentionally not updating the stack with the program counter
		nop 

org {bank6_scoreCheckHijack}
    	jsr scoreUpdate

org {bank6_freeSpace}
    scoreUpdate:		
		txa 
		pha
		tya
		pha 
		
		lda {practiceMenuIndex}		// dont run any HUD upates while the menu is open!!
		bne +
		
		pla
		tay
		pla
		tax

		jsr {bank6_hijackedJsr}		// hijack fix
		rts 
	
+;		pla							// dump x y backups
		pla 
		pla							// skip all update routines
		pla							
		rts 

	subweaponSpriteUpdate:	
		lda {practiceMenuIndex}		// dont run any HUD upates while the menu is open!!
		bne +

		ldx #$1A					// hijack fix
		lda {currentSubweapon}
		jmp {bank6_subweaponPrintHijack}+5 	// return to main routine
+;		rts 

	allowSkippingIntro:   	
		lda {currentInputHeld}
		and {INPUT_Start}
		cmp {INPUT_Start}
		bne +
		lda #$01
		sta {introTimer}					// set timer to 01 start (00 actually makes it underflow)
+;		jmp {bank7_originalIntroGameStatePointer}	// hijack fix

	levelLoadHijack:
		tya
		pha

//		jsr print2CharacterTable
//		lda #$37							// set PPU pointer to a different location
//		sta PPU_BurstUpdateTable
//		lda #$20
//		sta PPU_BurstUpdateTable+1		
//		lda #$60
//		sta PPU_BurstUpdateTable+2			// draw a block ..

		lda {practiceShouldKeepPlayerStatsOnDeathFlag}
		cmp {TRUE}
		bne deathEnd
		
		lda {backupCurrentWhipLevel}
		sta {currentWhipLevel}
		lda {backupCurrentSubweaponMultiplier}					
		sta {currentSubweaponMultiplier}
		lda {backupCurrentSubweapon}				
		sta {currentSubweapon}
		lda {backupCurrentHeartCount}
		sta {currentHeartCount}
//		lda lifeBackup
//		bne +
//		lda #$02						// give lifes in case the counter was 00 else the game goes to gameover with minus lifes 
//	+	sta $2a							// simon_Lifes

//		lda colorModBackup				
//		sta $fe
		lda #$04						// make the multiplier appear again
		sta	$141
		lda {FALSE}
		sta {practiceShouldKeepPlayerStatsOnDeathFlag}
		
	deathEnd:			
		pla
		tay
		lda $19								// hijack fix
		clc 
		rts 




org {bank6_hudPrintHijack}
		// skips the writing of any unnecessary text in the HUD, such as SCORE-, PLAYER, ENEMY, TIME, etc.
		nop 
		nop 
		nop 
		nop 
		nop 
		nop 