    tool_draculaDiagnosis:
        // check if current screen is dracula's stage and only run the tool if it is
        lda {currentStage}
        cmp {STAGE_DraculaStage}
        beq + 
        jmp tool_exitdraculaDiagnosis
+;      lda {currentSubStage}
        cmp {STAGE_DraculaSubStage}
        beq +
        jmp tool_exitdraculaDiagnosis

        // backup tool index onto the stack
+;      txa 
        pha 

        clv 

        incsrc "src/tools/dracula_diagnosis/tool_dracula_diagnosis_pause_buffer.asm"

        incsrc "src/tools/dracula_diagnosis/tool_dracula_diagnosis_jump_whip_stagger.asm"
        
        
        // restore tool index
        pla 
        tax 

    tool_exitdraculaDiagnosis:
        // execute next tool
        inx 
        inx 
        lda ({toolsToRunPointerList}),x
        sta $00
        lda ({toolsToRunPointerList})+1,x
        sta $01

        jmp ($0000)
