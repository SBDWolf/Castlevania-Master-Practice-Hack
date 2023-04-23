	action_reset:
		//TODO: needs to hijack death routine to backup subweapon, multiplier and heart count (maybe time too?)
		lda #$00
		sta {practiceMenuCursor}
		sta {pauseFlag}                 // unpause
		
		lda {SYSTEMSTATE_Respawning}
		sta {systemState}
		
		lda {PRACTICEMENU_DeconstructMenu00PhaseIndex}
		sta {practiceMenuIndex}
		
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
		sta {practiceMenuIndex}

		rts 

	action_whipLevelSelect:
        lda #$02
        sta {practiceSubMenuCursorMaxValue}
        jsr printSubMenuCursor
        jsr handleSubMenuInputs
        lda {practiceSubMenuShouldExecuteMenuActionFlag}
        cmp {TRUE}
        bne +
		// perform action, for testing purposes i am updating the current whip level
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

	action_about:
		//TODO
		rts

    exitMenu:
		lda {PRACTICEMENU_DeconstructMenu00PhaseIndex}
		sta {practiceMenuIndex}

        rts 

    