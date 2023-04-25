bank 5
base $8000
org {bank5_freeSpaceCode}
	// only runs during the in-gameplay state (systemState == 0x05)
	menuRoutine:
	// backup state of the x register
		txa 
		pha 
		
		jsr mainPracticeMenu

		// hijack fix
		ldy #$00
		pla 
		tax 
		rts 


	toolsRoutine:
		// this gets stepped into every frame regardless of systemState

		// only run tools if in an acceptable system state
		lda {systemState}
		cmp {SYSTEMSTATE_InGame}
		beq .runTools

//		cmp {SYSTEMSTATE_Respawning}
//		beq .runTools

		cmp {SYSTEMSTATE_DoorTransition}
		beq .runTools

		cmp {SYSTEMSTATE_AutoWalk}
		beq .runTools

		cmp {SYSTEMSTATE_EnteringCastle}
		beq .runTools

		cmp {SYSTEMSTATE_AutoClimb}
		beq .runTools

		cmp {SYSTEMSTATE_Win}
		beq .runTools

		cmp {SYSTEMSTATE_Falling}
		bne returnToGame

		// start going through tools. the last pointer is the address of returnToGame
		// the x register is the index of the tool being run
		.runTools:
			ldx #$00
			jmp ({toolsToRunPointerList})

		


	returnToGame:
		// hijack fix
		inc {frameCounter}
		lda {systemState}

		jmp {bank7_switchToBank_Bank6}

mainPracticeMenu:	
	incsrc "src/menu/menu_main.asm"
	
incsrc "src/menu/menu_submenu.asm"
incsrc "src/menu/menu_actions.asm"

incsrc "src/tools/tool_test.asm"
incsrc "src/tools/timer/tool_timer_main.asm"
incsrc "src/tools/memory_watch/tool_memory_watch_00.asm"

incsrc "src/utility.asm"


