// -- menu main ------------------------------------------------------
bank 5
base $8000
org {bank5_freeSpaceCode}
	practiceRoutine:
	// saving the state of the x register for when we return from the hijack
		txa 
		pha	
		jsr mainPracticeMenu		
		
		
	// restore the state from before the hijack	
		ldy #$00
		pla 
		tax 
		rts

incsrc "src/menu/menu_main.asm"
incsrc "src/menu/menu_submenu.asm"
incsrc "src/menu/menu_actions.asm"
incsrc "src/utility.asm"
