// -- menu main ------------------------------------------------------
bank 5
base $8000
org {bank5_freeSpaceCode}
	practiceRoutine:
	// saving the state of the x register for when we return from the hijack
		txa 
		pha	

		

		jsr mainPracticeMenu
		
		// start going through tools. the last pointer is the address of returnToGame
		// the x register is the index of the tool being run
		ldx #$00
		jmp ({toolsToRunPointerList})

	// restore the state from before the hijack	
	returnToGame:
		ldy #$00
		pla 
		tax 
		rts 


incsrc "src/menu/menu_main.asm"
incsrc "src/menu/menu_submenu.asm"
incsrc "src/menu/menu_actions.asm"

incsrc "src/tools/tool_test.asm"
incsrc "src/tools/tool_timer.asm"

incsrc "src/utility.asm"


