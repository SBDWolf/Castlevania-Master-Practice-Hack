    tool_scrollGlitchDiagnostic:
        // backup tool index onto the stack
        txa 
        pha 


        // we use a table that contains all the pointers to the scroll glitch code for the current stage. we read from this table, then jump to that pointer
        ldy {currentStage}
        tya 
        asl 
        tay 
        lda pointerTable_scrollGlitchDiagnosticStageCode,y
        sta $00
        lda pointerTable_scrollGlitchDiagnosticStageCode+1,y
        sta $01
        jmp ($0000)

    scrollGlitchDiagnostic_stage00:
    scrollGlitchDiagnostic_stage01:
    scrollGlitchDiagnostic_stage02:
    scrollGlitchDiagnostic_stage03:
    scrollGlitchDiagnostic_stage04:
    scrollGlitchDiagnostic_stage08:
    scrollGlitchDiagnostic_stage09:
    scrollGlitchDiagnostic_stage10:
    scrollGlitchDiagnostic_stage11:
    scrollGlitchDiagnostic_stage12:
    scrollGlitchDiagnostic_stage15:
    scrollGlitchDiagnostic_stage16:
    scrollGlitchDiagnostic_stage18:
    scrollGlitchDiagnostic_stage19Placeholder:
	scrollGlitchDiagnostic_stageMap:
        jmp scrollGlitchDiagnostic_exitTool

    scrollGlitchDiagnostic_stage05:
        incsrc "src/tools/scroll_glitch/diagnostic/tool_scroll_glitch_diagnostic_stage05.asm"
    scrollGlitchDiagnostic_stage06:
        incsrc "src/tools/scroll_glitch/diagnostic/tool_scroll_glitch_diagnostic_stage06.asm"
    scrollGlitchDiagnostic_stage07:
        incsrc "src/tools/scroll_glitch/diagnostic/tool_scroll_glitch_diagnostic_stage07.asm"
    scrollGlitchDiagnostic_stage13:
        incsrc "src/tools/scroll_glitch/diagnostic/tool_scroll_glitch_diagnostic_stage13.asm"
    scrollGlitchDiagnostic_stage14:
        incsrc "src/tools/scroll_glitch/diagnostic/tool_scroll_glitch_diagnostic_stage14.asm"
    scrollGlitchDiagnostic_stage17:
        incsrc "src/tools/scroll_glitch/diagnostic/tool_scroll_glitch_diagnostic_stage17.asm"


        incsrc "src/tools/scroll_glitch/diagnostic/tool_scroll_glitch_diagnostic_logic.asm"
        incsrc "src/tools/scroll_glitch/diagnostic/tool_scroll_glitch_diagnostic_print_movement.asm"
        incsrc "src/tools/scroll_glitch/diagnostic/tool_scroll_glitch_diagnostic_clear_hud.asm"
        incsrc "src/tools/scroll_glitch/diagnostic/tool_scroll_glitch_diagnostic_print_scroll_glitch_fail.asm"


    scrollGlitchDiagnostic_exitTool:
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