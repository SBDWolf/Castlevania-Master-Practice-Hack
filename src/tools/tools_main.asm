	toolsRoutine:
		// this gets stepped into every frame regardless of systemState
		// so we have to manually check for that variable and not run tools in certain states

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


incsrc "src/tools/timer/tool_timer_main.asm"
incsrc "src/tools/memory_watch/tool_memory_watch_00.asm"
incsrc "src/tools/memory_watch/tool_memory_watch_01.asm"
incsrc "src/tools/memory_watch/tool_memory_watch_02.asm"
incsrc "src/tools/scroll_glitch/death/tool_scroll_glitch_death_main.asm"
incsrc "src/tools/scroll_glitch/diagnostic/tool_scroll_glitch_diagnostic_main.asm"
incsrc "src/tools/input_display/tool_input_display.asm"
incsrc "src/tools/dracula_diagnosis/tool_dracula_diagnosis_main.asm"

