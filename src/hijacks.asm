bank 7
base $C000
org {bank7_pauseCheckHijack}
	jsr {bank7_freeSpaceforMenu}

org {bank7_mainGameLoopHijack}
		jsr {bank7_freeSpaceforTools}
		nop 

// on the US version,the combination of these two next routines fills up exactly all the free space there is at this location in bank 7,
// down to the byte :)
org {bank7_freeSpaceforMenu}
		lda #$05
		sta $8000
		jsr menuRoutine
		jsr {bank7_pauseCheck}
		jmp {bank7_switchToBank_Bank6}

org {bank7_freeSpaceforTools}

		// switch bank to bank 5. quick! there is no space!
		lda #$05
		sta $8000
		jmp toolsRoutine



org {bank7_scorePrintHijack}
		// don't ever draw the score. overwriting a jsr instruction
		nop 
		nop 
		nop 

org {bank7_mainJumpTable}+2
		// this is hijacking the title screen
		dw initializeMemory

org {bank7_mainJumpTable}+8
		// this is hijacking the castle entrance scene
		dw allowSkippingIntro

org {bank7_mainJumpTable}+30
		// this is hijacking the credits scene
		dw allowSkippingCredits

org {bank7_pauseCheck}+14
		// letting the game pause even when pressing select, on top of start
		and {MULTIPLEINPUT_StartOrSelect}

org {bank7_pauseCheck}+32
		// letting the game unpause even when pressing select, on top of start
		and {MULTIPLEINPUT_StartOrSelect}

org {bank7_deathHijack}
		jsr levelLoadHijack

org {bank7_sprite0Hijack}
		// skip updating sprite 0's y position if the menu is open
		// switching to bank 6 because it's not always loaded, particularly in rooms with many enemies
		lda #$06
		sta $8000
		jsr sprite0CheckIfInMenu
		nop 
		nop 
		nop 


bank 6
base $8000
org {bank6_subweaponPrintHijack}
		jmp subweaponSpriteUpdate 	// intentionally not updating the stack with the program counter
		nop 
		nop 

org {bank6_scoreCheckHijack}
    	jsr scoreUpdate

org {bank6_freeSpace}
    scoreUpdate:		
		txa 
		pha
		tya
		pha 
		
		lda {practiceMenuPhaseIndex}		// dont run any HUD upates while the menu is open!!
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
		lda {practiceMenuPhaseIndex}		// dont run any HUD upates while the menu is open!!
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
		sta {generalTimer}					// set timer to 01 start (00 actually makes it underflow)
+;		jmp {bank7_originalIntroGameStatePointer}	// hijack fix

	allowSkippingCredits:
		lda {currentInputHeld}
		and {INPUT_Start}
		cmp {INPUT_Start}
		bne +
		lda #$01
		sta {generalTimer}					// set timer to 01 start (00 actually makes it underflow)
		lda {CREDITS_Ending}
		sta {systemSubState}
+;		jmp {bank7_originalCreditsGameStatePointer}	// hijack fix

	levelLoadHijack:
		tya
		pha

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

	sprite0CheckIfInMenu:
		lda {practiceMenuPhaseIndex}
		cmp #$00
		bne +
		ldx #$03
-;		lda {bank7_sprite0LocalOAMTable},x
		sta {sprite0ForOAM},x
		dex 
		bpl -

+;		rts 

	initializeMemory:
		lda localPointerTable_toolsEnd
		sta {toolsToRunPointerList}
		lda localPointerTable_toolsEnd+1
		sta {toolsToRunPointerList}+1

		jmp {bank7_originalTitleScreenGameStatePointer}

	localPointerTable_toolsEnd:
		dw returnToGame

	warnpc $C000

org {bank6_hudPrintHijack}
		// skips the writing of any unnecessary text in the HUD, such as SCORE-, PLAYER, ENEMY, TIME, etc.
		nop 
		nop 
		nop 
		nop 
		nop 
		nop 