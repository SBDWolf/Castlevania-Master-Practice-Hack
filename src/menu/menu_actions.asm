	action_timer:
        lda #$01
        sta {practiceSubMenuCursorMaxValue}
		jsr printSubMenuCursor
		jsr handleSubMenuInputs
		lda {practiceSubMenuShouldExecuteMenuActionFlag}
        cmp {TRUE}
        bne +
		
		// enable/disable timer
		lda {practiceSubMenuCursor}
		cmp {TRUE}
		bne timer_disableTool
		lda {activeTools}
		ora {TOOLS_TimerToolBitSet}
		sta {activeTools}

		// initialize stuff used for the timer
		lda #$00
		sta {timerLevelTimerMinutes}
		sta {timerLevelTimerSeconds}
		sta {timerLevelTimerFrames}
		sta {timerRoomTimerCurrentMinutes}
		sta {timerRoomTimerCurrentSeconds}
		sta {timerRoomTimerCurrentFrames}
		sta {timerRoomTimerPreviousMinutes}
		sta {timerRoomTimerPreviousSeconds}
		sta {timerRoomTimerPreviousFrames}
		sta {timerPreviousFrameStage}
		sta {timerPreviousFrameSubStage}
		sta {timerAlreadyRanUpdatesFlag}

		jmp exitMenu


	timer_disableTool:
		lda {activeTools}
		and {TOOLS_TimerToolBitUnSet}
		sta {activeTools}

	timer_localExitMenu:
		jmp exitMenu
        
+;		ldx {INDEX_TimerTextMasterTableIndex}
      	jsr printCurrentTextValue
        rts 

		rts
	
	action_toolTest:
	// testing the tool orchestration
	    lda #$01
        sta {practiceSubMenuCursorMaxValue}
        jsr printSubMenuCursor
        jsr handleSubMenuInputs
        lda {practiceSubMenuShouldExecuteMenuActionFlag}
        cmp {TRUE}
        bne +

		lda {practiceSubMenuCursor}
		cmp {TRUE}
		bne test_disableTool
		lda {activeTools}
		ora {TOOLS_TestToolBitSet}
		sta {activeTools}
		jmp exitMenu

	test_disableTool:
		lda {activeTools}
		and {TOOLS_TestToolBitUnSet}
		sta {activeTools}
		jmp exitMenu
        
+;      jsr printCurrentNumericalValue
        rts 	


	
	action_reset:
		lda #$00
		sta {practiceMenuCursor}
		sta {pauseFlag}                 // unpause
		
		lda {SYSTEMSTATE_Respawning}
		sta {systemState}
		
		lda {PRACTICEMENU_DeconstructMenu00PhaseIndex}
		sta {practiceMenuPhaseIndex}
		
		// backup player stats
		lda {currentWhipLevel}
		sta {backupCurrentWhipLevel}
		lda {currentSubweapon}
		sta {backupCurrentSubweapon}
		lda {currentSubweaponMultiplier} 
		sta {backupCurrentSubweaponMultiplier}
		lda {currentHeartCount}
		sta {backupCurrentHeartCount}

		inc {currentLifeCount} // add a life

		lda {TRUE}
		sta {practiceShouldKeepPlayerStatsOnDeathFlag}
		
		lda {PRACTICEMENU_DeconstructMenu00PhaseIndex}								// exit menu
		sta {practiceMenuPhaseIndex}

		rts 

	action_whipLevelSelect:
        lda #$02
        sta {practiceSubMenuCursorMaxValue}
        jsr printSubMenuCursor
        jsr handleSubMenuInputs
        lda {practiceSubMenuShouldExecuteMenuActionFlag}
        cmp {TRUE}
        bne +
		lda {practiceSubMenuCursor}
        sta {currentWhipLevel}

		jmp exitMenu
        
+;      jsr printCurrentNumericalValue
        rts 

	action_subweaponSelect:
        lda #$04
        sta {practiceSubMenuCursorMaxValue}
		jsr printSubMenuCursor
		jsr handleSubMenuInputs
		lda {practiceSubMenuShouldExecuteMenuActionFlag}
        cmp {TRUE}
        bne +
		
		ldy {practiceSubMenuCursor}
		lda lookupTable_subweaponSelect,y
		sta {currentSubweapon}

		jmp exitMenu
        
+;		ldx {INDEX_SubweaponTextMasterTableIndex}
      	jsr printCurrentTextValue
        rts 

		rts

	action_subweaponMultiplierSelect:
		lda #$02
        sta {practiceSubMenuCursorMaxValue}
        jsr printSubMenuCursor
        jsr handleSubMenuInputs
        lda {practiceSubMenuShouldExecuteMenuActionFlag}
        cmp {TRUE}
        bne +
		lda {practiceSubMenuCursor}
        sta {currentSubweaponMultiplier}

		jmp exitMenu
        
+;      jsr printCurrentNumericalValue
        rts 

	action_gameLoop:
		lda #$01
        sta {practiceSubMenuCursorMaxValue}
        jsr printSubMenuCursor
        jsr handleSubMenuInputs
        lda {practiceSubMenuShouldExecuteMenuActionFlag}
        cmp {TRUE}
        bne +
		lda {practiceSubMenuCursor}
        sta {currentGameLoop}

		jmp exitMenu
        
+;      jsr printCurrentNumericalValue
        rts 


	action_stageSelect:
		lda #$12
        sta {practiceSubMenuCursorMaxValue}
		jsr printSubMenuCursor
		jsr handleSubMenuInputs

        lda {practiceSubMenuShouldExecuteMenuActionFlag}
        cmp {TRUE}
        bne +
		// select stage
		lda {practiceSubMenuCursor}
		sta {previousStage}
		
		lda {SYSTEMSTATE_Win}
		sta {systemState}
		// i don't know what this 08 is, was in the original code for the level select
		lda #$08
		sta {systemSubState}
		jmp exitMenu
        
+;      jsr printCurrentNumericalValue
        rts 

	action_about:
		clv 
		// this is done in two phases to hopefully not overload the ppu
		lda {practiceAboutPrintPhase}
		cmp #$02
		bcs +
		// beq might be enough here
		cmp #$00
		bne phase2

		// phase 1
		lda submenu_text_master_table+{INDEX_AboutTextMasterTableIndex}
		sta $00
		lda submenu_text_master_table+{INDEX_AboutTextMasterTableIndex}+1
		sta $01
		ldx {tileDataPointer}
		ldy #$00
		jsr printTextAtProvidedLocation
		dex 
		jsr printTextAtProvidedLocation
		inc {practiceAboutPrintPhase}
		bvc + 

		phase2: 
		lda submenu_text_master_table+{INDEX_AboutTextMasterTableIndex}
		sta $00
		lda submenu_text_master_table+{INDEX_AboutTextMasterTableIndex}+1
		sta $01
		ldy #$45
		ldx {tileDataPointer}
		jsr printTextAtProvidedLocation
		dex 
		jsr printTextAtProvidedLocation
		inc {practiceAboutPrintPhase}

		// allow any input to close the menu
+;		jmp allowAnyInputToCloseMenu 

    exitMenu:
		lda {PRACTICEMENU_DeconstructMenu00PhaseIndex}
		sta {practiceMenuPhaseIndex}
        rts 
