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

//org {bank7_scorePrintHijack}
		// don't ever draw the score. overwriting a jsr instruction
		//nop 
		//nop 
		//nop 

org {bank7_scorePrintHijack}
		// don't ever draw the score.
		bvc {bank7_scorePrintBranchDestination}

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

// hardcoded music removal - has issues such as playing a screeching sound when a holy water bottle explodes...
// ...at the same time as an end-stage orb is grabbed
// most addresses are for the JP version

// stages
//org $C097
//org $C2C8 - US
//org $C2E7
		//lda #$00
		//nop

// orb
//org $E8B5
		//lda #$00

// dracula orb
//org $E8B0
		//lda #$00

// cookie monster
//org $FD5B
		//lda #$00

// boss music
//bank 6
//org $998A
		//lda #$00
		//sta $60

// credits music
//org $8C9A
		//lda #$00

//org $B727
		//lda #$00
//org $c1bf
		//nop
		//nop
		//nop

//bank 0
//base $8000
//org $8187
//		rts
//		nop
//org $83ac
//		nop
//		nop
//		nop


bank 6
base $8000
org {bank6_subweaponPrintHijack}
		jmp subweaponSpriteUpdate 	// intentionally not updating the stack with the program counter
		nop 
		nop 

org {bank6_scoreCheckHijack}
    	jsr scoreUpdate

org {bank6_demoSetupHijack}
		jsr addSimonStats
		nop 
		nop 

org {bank6_demoSetup2Hijack}
		nop 
		nop 
		nop 
		nop 
		nop 

org {bank6_musicContinuityHijack}
		jsr checkIfInDemoModeMusicContinuity
		nop 
		nop 
		nop 
		nop 
		nop 

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

	addSimonStats:
		lda #$01
		sta {currentWhipLevel}
		lda #$02
		sta {currentSubweaponMultiplier}
		lda #$0B
		sta {currentSubweapon}
		rts 

	checkIfInDemoModeMusicContinuity:
		lda {systemState}
		cmp #$02
		bne +
		
		lda #$00
		sta $4A
		lda #$05
		sta $18
		sta $1F
		rts 

+;  	lda #$05
		sta $18
		sta $4A
		sta $1F
		rts 

warnpc $C000

org {bank6_hudPrintHijack}
		// skips the writing of any unnecessary text in the HUD, such as SCORE-, PLAYER, ENEMY, TIME, etc.
		nop 
		nop 
		nop 
		nop 
		nop 
		nop 

bank 0
base $8000
org {bank0_musicVolumeMelodyHijack}
	jsr complyWithUserMusicSettingMelody

org {bank0_musicVolumeNoiseHijack}
	jsr complyWithUserMusicSettingNoise
	nop 

org {bank0_musicValueNoiseDirectHijack}
	jsr complyWithUserMusicSettingAdditionalNoise

org {bank0_musicBossFadeOutHijack}
	jsr checkIfShouldSkipFadeOut
	nop 
	nop 
	nop 

org {bank0_freeSpace}
	complyWithUserMusicSettingMelody:
		// restore hijacked instructions
		sta $05,x
		iny 

		lda {disableMusic}
		beq complyWithUserMusicSettingMelodyExit
		// add exceptions for some jingles
		lda {musicSquare1Track}
		cmp {SFX_GameOverTrack}
		beq complyWithUserMusicSettingMelodyExit



		// if processing the triangle channel, write a #$00, otherwise write a #$10
		cpx #$A0
		bne +

		lda #$00
		sta $05,x
		rts 

+;		lda #$10
		sta $05,x

	complyWithUserMusicSettingMelodyExit:
		rts 


	complyWithUserMusicSettingNoise:
		// restore hijacked instructions
		beq +
		sta $07,x

		lda {disableMusic}
		beq +

		// only process for specifically the noise channel
		cpx #$B0
		bne +

		// add exception for whip SFX (which should get processed)
		lda {noiseTrack}
		cmp #$05
		bcs +

		lda #$00
		sta $07,x

+;		rts 

	checkIfShouldSkipFadeOut:
		lda {disableMusic}
		beq +
		lda #$00
		rts 


		// restore hijacked instructions
+;		dec $85
		lda $85
		and #$0F
		rts 

	complyWithUserMusicSettingAdditionalNoise:
		cmp #$FF
		bne +
		lda #$30
+;		sta $4000,x
		rts 

bank 5
base $8000

org {bank5_cookieMonsterMusicChangeHijack}
	jsr checkIfInDemoModeCookieMonster

org {bank5_draculaPatternHijack}
	jsr checkifInDemoModeDracula
	nop 