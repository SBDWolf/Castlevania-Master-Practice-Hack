        lda {currentSubStage}
        beq stage14Pass

        lda {simonXLowByte}
        cmp #$04
        beq .on14Top

        cmp #$03
        beq .on14Standard

        cmp #$02
        beq .on14AdvancedOrRace

        cmp #$01
        beq .on14Race

        bvc stage14Pass


        .on14Top:
            lda {simonXHighByte}
            cmp #$18
            bcc stage14Pass
            cmp #$68
            bcs stage14Pass
            jmp logic_start

        .on14Standard:
            lda {simonXHighByte}
            cmp #$48
            bcs stage14Pass
            jmp logic_start

        .on14AdvancedOrRace:
            lda {simonXHighByte}
            // 5 pixels of leeway for this one, because RTA runners tend to turn around at roughly $B9 so i can't extend this to $B8 here
            cmp #$BB
            bcs executeLogic
            cmp #$28
            bcs stage14Pass
            jmp logic_start

        .on14Race:
            lda {simonXHighByte}
            cmp #$F8
            bcc stage14Pass
            jmp logic_start


    stage14Pass:
        lda #$00
        sta {scrollGlitchDiagnosticTimer}
        sta {scrollGlitchDiagnosticHudCursor}
        sta {scrollGlitchDiagnosticHudClearPhase}
        lda {simonMovementState}
        and #$03
        sta {scrollGlitchDiagnosticPhaseCounter}
        jmp scrollGlitchDiagnostic_exitTool

    executeLogic:
        jmp logic_start

