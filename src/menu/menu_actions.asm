	action_timer:
        ldx #$01
		jsr handleSubMenuInputs
        cpy {TRUE}
        beq +

		ldx {INDEX_TimerTextMasterTableIndex}
		jmp genericMenuPrint_selectBetweenTextValues
        		
+;		// enable/disable timer
		lda {practiceSubMenuCursor}
		cmp {TRUE}
		bne .timer_disableTool
		// enable timer
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


		.timer_disableTool:
			// disable timer
			lda {activeTools}
			and {TOOLS_TimerToolBitUnSet}
			sta {activeTools}

			jmp exitMenu


	action_scrollGlitch:
	    ldx #$01
		jsr handleSubMenuInputs
        cpy {TRUE}
        beq +

		ldx {INDEX_ScrollGlitchTextMasterTableIndex}
		jmp genericMenuPrint_selectBetweenTextValues
        		
+;		// enable/disable scroll glitch tool
		lda {practiceSubMenuCursor}
		cmp {TRUE}
		bne .scrollGlitch_disableTool
		// enable scroll glitch tool
		lda {activeTools}
		ora {TOOLS_ScrollGlitchToolBitSet}
		sta {activeTools}

		jmp exitMenu


		.scrollGlitch_disableTool:
			// disable scroll glitch tool
			lda {activeTools}
			and {TOOLS_ScrollGlitchToolBitUnSet}
			sta {activeTools}

			jmp exitMenu	


	action_memoryWatch00:
		ldx #$05
		jsr handleSubMenuInputs
        cpy {TRUE}
        beq +

		ldx {INDEX_MemoryWatchTextMasterTableIndex}
		jmp genericMenuPrint_selectBetweenTextValues
        		
+;		// select memory watch for slot 00
		
		lda {practiceSubMenuCursor}
		cmp {MEMORYWATCHMENU_DisabledIndex}
		beq .memoryWatch00_disableTool

		// enable memory watch
		lda {activeTools}
		ora {TOOLS_MemoryWatch00ToolBitSet}
		sta {activeTools}

		// store pointer to memory location it needs to watch
		lda {practiceSubMenuCursor}
		asl 
		tax 

		lda lookupTable_memoryWatchAddresses,x
		sta {memorywatch00Pointer}
		lda lookupTable_memoryWatchAddresses+1,x
		sta {memorywatch00Pointer}+1

		jmp exitMenu

		.memoryWatch00_disableTool:
			// disable memory watch 00
			lda {activeTools}
			and {TOOLS_MemoryWatch00ToolBitUnSet}
			sta {activeTools}

			jmp exitMenu


	action_memoryWatch01:
		ldx #$05
		jsr handleSubMenuInputs
        cpy {TRUE}
        beq +

		ldx {INDEX_MemoryWatchTextMasterTableIndex}
		jmp genericMenuPrint_selectBetweenTextValues
        		
+;		// select memory watch for slot 01
		
		lda {practiceSubMenuCursor}
		cmp {MEMORYWATCHMENU_DisabledIndex}
		beq .memoryWatch01_disableTool

		// enable memory watch
		lda {activeTools}
		ora {TOOLS_MemoryWatch01ToolBitSet}
		sta {activeTools}

		// store pointer to memory location it needs to watch
		lda {practiceSubMenuCursor}
		asl 
		tax 

		lda lookupTable_memoryWatchAddresses,x
		sta {memorywatch01Pointer}
		lda lookupTable_memoryWatchAddresses+1,x
		sta {memorywatch01Pointer}+1

		jmp exitMenu

		.memoryWatch01_disableTool:
			// disable memory watch 01
			lda {activeTools}
			and {TOOLS_MemoryWatch01ToolBitUnSet}
			sta {activeTools}

			jmp exitMenu


	action_memoryWatch02:
		ldx #$05
		jsr handleSubMenuInputs
        cpy {TRUE}
        beq +

		ldx {INDEX_MemoryWatchTextMasterTableIndex}
		jmp genericMenuPrint_selectBetweenTextValues
        		
+;		// select memory watch for slot 02
		
		lda {practiceSubMenuCursor}
		cmp {MEMORYWATCHMENU_DisabledIndex}
		beq .memoryWatch02_disableTool

		// enable memory watch
		lda {activeTools}
		ora {TOOLS_MemoryWatch02ToolBitSet}
		sta {activeTools}

		// store pointer to memory location it needs to watch
		lda {practiceSubMenuCursor}
		asl 
		tax 

		lda lookupTable_memoryWatchAddresses,x
		sta {memorywatch02Pointer}
		lda lookupTable_memoryWatchAddresses+1,x
		sta {memorywatch02Pointer}+1

		jmp exitMenu

		.memoryWatch02_disableTool:
			// disable memory watch 02
			lda {activeTools}
			and {TOOLS_MemoryWatch02ToolBitUnSet}
			sta {activeTools}

			jmp exitMenu


	action_memoryWatch03:
		ldx #$05
		jsr handleSubMenuInputs
        cpy {TRUE}
        beq +

		ldx {INDEX_MemoryWatchTextMasterTableIndex}
		jmp genericMenuPrint_selectBetweenTextValues
        		
+;		// select memory watch for slot 03
		
		lda {practiceSubMenuCursor}
		cmp {MEMORYWATCHMENU_DisabledIndex}
		beq .memoryWatch03_disableTool

		// enable memory watch
		lda {activeTools}
		ora {TOOLS_MemoryWatch03ToolBitSet}
		sta {activeTools}

		// store pointer to memory location it needs to watch
		lda {practiceSubMenuCursor}
		asl 
		tax 

		lda lookupTable_memoryWatchAddresses,x
		sta {memorywatch03Pointer}
		lda lookupTable_memoryWatchAddresses+1,x
		sta {memorywatch03Pointer}+1

		jmp exitMenu

		.memoryWatch03_disableTool:
			// disable memory watch 03
			lda {activeTools}
			and {TOOLS_MemoryWatch03ToolBitUnSet}
			sta {activeTools}

			jmp exitMenu

	
	action_reset:
		// done in two passes to maybe avoid graphical gliches?

		lda #$00				
		sta {practiceMenuCursor}			// SBDWolf -- can this be removed? there is no menu for this action
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
        ldx #$02
        jsr handleSubMenuInputs
        cpy {TRUE}
        beq +

		jmp genericMenuPrint_selectBetweenNumericalValue
        
+; 		lda {practiceSubMenuCursor}
        sta {currentWhipLevel}

		jmp exitMenu     

	action_subweaponSelect:
        ldx #$04
		jsr handleSubMenuInputs
        cpy {TRUE}
        beq +

		ldx {INDEX_SubweaponTextMasterTableIndex}
        jmp genericMenuPrint_selectBetweenTextValues
        
+;		ldy {practiceSubMenuCursor}
		lda lookupTable_subweaponSelect,y
		sta {currentSubweapon}

		jmp exitMenu	

	action_subweaponMultiplierSelect:
		ldx #$02
        jsr handleSubMenuInputs
        cpy {TRUE}
        beq +

		jmp genericMenuPrint_selectBetweenNumericalValue
     
+;      lda {practiceSubMenuCursor}
        sta {currentSubweaponMultiplier}

		jmp exitMenu
		

	action_gameLoop:
		ldx #$01
        jsr handleSubMenuInputs
        cpy {TRUE}
        beq +

		jmp genericMenuPrint_selectBetweenNumericalValue
        
+;		lda {practiceSubMenuCursor}
        sta {currentGameLoop}

		jmp exitMenu      




	action_stageSelect:
		ldx #$12
		jsr handleSubMenuInputs

        cpy {TRUE}
        beq +

		jmp genericMenuPrint_selectBetweenNumericalValue
     
+;      // select stage
		lda {practiceSubMenuCursor}
		sta {previousStage}
		
		lda {SYSTEMSTATE_Win}
		sta {systemState}
		// i don't know what this 08 is, was in the original code for the level select
		lda #$08
		sta {systemSubState}
		jmp exitMenu

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


	genericMenuPrint_selectBetweenNumericalValue:
		jsr printSubMenuCursor
		jsr printCurrentNumericalValue
		rts 

	genericMenuPrint_selectBetweenTextValues:
		// needs x register as a parameter to determine the index of the text master table to be used to print menu options
		jsr printSubMenuCursor
      	jsr printCurrentTextValue
		rts 


    exitMenu:
		lda {PRACTICEMENU_DeconstructMenu00PhaseIndex}
		sta {practiceMenuPhaseIndex}
        rts 
