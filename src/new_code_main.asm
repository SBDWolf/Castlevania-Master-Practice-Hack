// -- menu main ------------------------------------------------------
bank 5
base $8000
org {bank5_freeSpaceCode}
	practiceRoutine:

		// don't run the menu if not in the middle of gameplay
		lda {systemState}
		cmp {SYSTEMSTATE_InGame}
		bne +
		
		jsr mainPracticeMenu
		// start going through tools. the last pointer is the address of returnToGame
		// the x register is the index of the tool being run
-;		ldx #$00
		jmp ({toolsToRunPointerList})

		// only run tools if in an acceptable system state
+;		lda {systemState}
//		cmp {SYSTEMSTATE_Respawning}
//		beq -

		cmp {SYSTEMSTATE_DoorTransition}
		beq -

		cmp {SYSTEMSTATE_AutoWalk}
		beq -

		cmp {SYSTEMSTATE_EnteringCastle}
		beq -

		cmp {SYSTEMSTATE_AutoClimb}
		beq -

		cmp {SYSTEMSTATE_Win}
		beq -

		cmp {SYSTEMSTATE_Falling}
		beq -

	returnToGame:
		rts 


incsrc "src/menu/menu_main.asm"
incsrc "src/menu/menu_submenu.asm"
incsrc "src/menu/menu_actions.asm"

incsrc "src/tools/tool_test.asm"
incsrc "src/tools/timer/tool_timer_main.asm"

incsrc "src/utility.asm"


