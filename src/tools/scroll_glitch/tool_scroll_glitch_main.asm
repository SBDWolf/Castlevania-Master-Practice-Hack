    tool_scrollGlitch:
        // backup tool index onto the stack
        txa 
        pha 

        // we use a table that contains all the pointers to the scroll glitch code for the current stage. we read from this table, then jump to that pointer
        ldy {currentStage}
        tya 
        asl 
        tay 
        lda pointerTable_scrollGlitchStageCode,y
        sta $00
        lda pointerTable_scrollGlitchStageCode+1,y
        sta $01
        jmp ($0000)

    scrollGlitch_stage00:
    scrollGlitch_stage01:
    scrollGlitch_stage02:
    scrollGlitch_stage03:
    scrollGlitch_stage04:
    scrollGlitch_stage07:
    scrollGlitch_stage08:
    scrollGlitch_stage09:
    scrollGlitch_stage10:
    scrollGlitch_stage11:
    scrollGlitch_stage12:
    scrollGlitch_stage15:
    scrollGlitch_stage16:
    scrollGlitch_stage18:
        jmp scrollGlitch_exitTool

    scrollGlitch_stage05:
        incsrc "src/tools/scroll_glitch/tool_scroll_glitch_stage05.asm"
    scrollGlitch_stage06:
        incsrc "src/tools/scroll_glitch/tool_scroll_glitch_stage06.asm"
        jmp scrollGlitch_exitTool
    scrollGlitch_stage13:
        incsrc "src/tools/scroll_glitch/tool_scroll_glitch_stage13.asm"
        jmp scrollGlitch_exitTool
    scrollGlitch_stage14:
        incsrc "src/tools/scroll_glitch/tool_scroll_glitch_stage14.asm"
        jmp scrollGlitch_exitTool
    scrollGlitch_stage17:
        incsrc "src/tools/scroll_glitch/tool_scroll_glitch_stage17.asm"
        jmp scrollGlitch_exitTool

    
    killSimon:
		lda #$00
		sta {currentPlayerHealth}	
		rts 
        
    scrollGlitch_exitTool:
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