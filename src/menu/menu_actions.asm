	action_reset:
		//TODO: needs to hijack death routine to backup subweapon, multiplier and heart count (maybe time too?)
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
        
+;		ldx #$00
      	jsr printCurrentTextValue
        rts 

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
		
		lda {SYSTEMSTAGE_Win}
		sta {systemState}
		// i don't know what this 08 is, was in the original code for the level select
		lda #$08
		sta {systemSubState}
		jmp exitMenu
        
+;      jsr printCurrentNumericalValue
        rts 


	action_about:
		// this is done in two phases to hopefully not overload the ppu
		lda {practiceAboutPrintPhase}
		cmp #$02
		bcs +
		// beq might be enough here
		cmp #$00
		bne phase2

		// phase 1
		lda submenu_text_master_table+{ABOUT_MasterTableIndex}
		sta $00
		lda submenu_text_master_table+{ABOUT_MasterTableIndex}+1
		sta $01
		ldx {tileDataPointer}
		ldy #$00
		jsr printTextAtProvidedLocation
		dex 
		jsr printTextAtProvidedLocation
		inc {practiceAboutPrintPhase}
		rts 

		phase2: 
		lda submenu_text_master_table+{ABOUT_MasterTableIndex}
		sta $00
		lda submenu_text_master_table+{ABOUT_MasterTableIndex}+1
		sta $01
		ldy #$45
		ldx {tileDataPointer}
		jsr printTextAtProvidedLocation
		dex 
		jsr printTextAtProvidedLocation
		inc {practiceAboutPrintPhase}
+;		rts 

    exitMenu:
		lda {PRACTICEMENU_DeconstructMenu00PhaseIndex}
		sta {practiceMenuPhaseIndex}
        rts 
