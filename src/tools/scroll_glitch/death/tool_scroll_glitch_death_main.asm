    tool_scrollGlitchDeath:
        // backup tool index onto the stack
        txa 
        pha 

        
        // we use a table that contains all the pointers to the scroll glitch code for the current stage. we read from this table, then jump to that pointer
        ldy {currentStage}
        tya 
        asl 
        tay 
        lda pointerTable_scrollGlitchDeathStageCode,y
        sta $00
        lda pointerTable_scrollGlitchDeathStageCode+1,y
        sta $01
        jmp ($0000)

    scrollGlitchDeath_stage00:
    scrollGlitchDeath_stage01:
    scrollGlitchDeath_stage02:
    scrollGlitchDeath_stage03:
    scrollGlitchDeath_stage04:
    scrollGlitchDeath_stage08:
    scrollGlitchDeath_stage09:
    scrollGlitchDeath_stage11:
    scrollGlitchDeath_stage15:
    scrollGlitchDeath_stage16:
    scrollGlitchDeath_stage18:
    scrollGlitchDeath_stage19Placeholder:
	scrollGlitchDeath_stageMap:
        jmp scrollGlitchDeath_exitTool

    scrollGlitchDeath_stage05:
        incsrc "src/tools/scroll_glitch/death/tool_scroll_glitch_death_stage05.asm"
    scrollGlitchDeath_stage06:
        incsrc "src/tools/scroll_glitch/death/tool_scroll_glitch_death_stage06.asm"
    scrollGlitchDeath_stage07:
        incsrc "src/tools/scroll_glitch/death/tool_scroll_glitch_death_stage07.asm"
    scrollGlitchDeath_stage10:
        incsrc "src/tools/scroll_glitch/death/tool_scroll_glitch_death_stage10.asm"
    scrollGlitchDeath_stage12:
        incsrc "src/tools/scroll_glitch/death/tool_scroll_glitch_death_stage12.asm"
    scrollGlitchDeath_stage13:
        incsrc "src/tools/scroll_glitch/death/tool_scroll_glitch_death_stage13.asm"
    scrollGlitchDeath_stage14:
        incsrc "src/tools/scroll_glitch/death/tool_scroll_glitch_death_stage14.asm"
    scrollGlitchDeath_stage17:
        incsrc "src/tools/scroll_glitch/death/tool_scroll_glitch_death_stage17.asm"


    incsrc "src/tools/scroll_glitch/death/tool_scroll_glitch_death_kill_simon.asm"

    scrollGlitchDeath_exitTool:
        // restore tool index
        pla 
        tax 



        // execute next tool
+;      inx 
        inx 
        lda ({toolsToRunPointerList}),x
        sta $00
        lda ({toolsToRunPointerList})+1,x
        sta $01

        jmp ($0000)