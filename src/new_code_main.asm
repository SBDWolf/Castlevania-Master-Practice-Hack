// -- menu main ------------------------------------------------------
bank 5
base $8000
org {bank5_freeSpaceCode}
	practiceRoutine:
		txa 
		pha							// saving the state of the x register for when we return from the hijack
		jsr mainPracticeMenu		
		
		ldy #$00					// restore the state from before the hijack
		pla 
		tax 
		rts

incsrc "src/menu/menu_main.asm"
incsrc "src/menu/menu_submenu.asm"
incsrc "src/menu/menu_actions.asm"
incsrc "src/utility.asm"
