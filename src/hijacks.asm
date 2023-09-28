bank 7
base $C000
org {bank7_pauseCheckHijack}
	jsr {bank7_freedUpSpaceFromReroutedTable}

org {bank7_mainGameLoopHijack}
	jsr {bank7_naturalFreeSpace}
	nop 

org {bank7_NMIHijack}
	jsr incrementConsecutiveLagCounter
	nop 

org {bank7_freedUpSpaceFromReroutedTable}
		lda #$05
		sta $8000
		// in menu_main.asm
		jsr menuRoutine
		jsr {bank7_switchToBank_Bank6}
		jsr {bank7_pauseCheck}
		rts 

org {bank7_naturalFreeSpace}
		// switch bank to bank 5. quick! there is no space!
		lda #$05
		sta $8000
		jmp toolsRoutine

	// this code will only run if the game is lagging. it will also run during lag frames on loading screeens!
	incrementConsecutiveLagCounter:
		inc {consecutiveLagFramesCounter}
		// hijack fix
		lda $FE
		ldx $1F
		rts 

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

org {bank7_stagePropertyTableReadingHijack}
	lda reroutedStagePropertyTableFromBank7,x

org {bank7_stageTimerPPUDestination}+1
	db $53


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
	// i might need to dump x and y backups, which is what was in this code originally, but it seems to runs fine without doing that for now		
		lda {practiceMenuPhaseIndex}		// dont run any HUD upates while the menu is open!!
		bne +

		jsr {bank6_hijackedJsr}		// hijack fix
		rts 
	
+;		pla							// skip all update routines
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
		beq +
		lda #$01
		sta {generalTimer}					// set timer to 01 start (00 actually makes it underflow)
+;		jmp {bank7_originalIntroGameStatePointer}	// hijack fix

	allowSkippingCredits:
		lda {currentInputHeld}
		and {INPUT_Start}
		beq +
		lda #$01
		sta {generalTimer}					// set timer to 01 start (00 actually makes it underflow)
		lda {CREDITS_Ending}
		sta {systemSubState}
+;		jmp {bank7_originalCreditsGameStatePointer}	// hijack fix

	
	levelLoadHijack:
		//tya
		//pha

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
		//pla 
		//tay 
		lda $19								// hijack fix
		clc 
		rts 

	sprite0CheckIfInMenu:
		lda {practiceMenuPhaseIndex}
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

	reroutedStagePropertyTableFromBank7:
		db $FF,$FF,$FF,$FF,$0F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$3F,$1F
		db $FF,$FF,$0F

	printStageTimerIfNotThousandsDigit:
		cpy #$01
		beq +
		jmp {bank7_printStageTimerFirstDigit}
+;		jmp {bank7_printStageTimerSecondDigit}

	warnpc $C000

org {bank6_hudPrintHijack}
		// skips the writing of any unnecessary text in the HUD, such as SCORE-, PLAYER, ENEMY, TIME, etc.
		nop 
		nop 
		nop 
		nop 
		nop 
		nop 

org {bank6_stageTimerPrintHijack}
		jsr printStageTimerIfNotThousandsDigit