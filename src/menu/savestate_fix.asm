lda {refreshPaletteTimer}
bmi savestate_fix_check_inputs
dec {refreshPaletteTimer}
// refresh sprites when timer hits #$00, then background when timer hits #$FF
lda {refreshPaletteTimer}
beq update_sprites_palettes
cmp #$FF
beq update_backgrounds_palettes
jmp savestate_fix_end


update_sprites_palettes:
lda #$06
jsr {bank7_pushPaletteUpdate}
jmp savestate_fix_end


update_backgrounds_palettes:
ldx {currentStage}
lda {bank7_stagePaletteTable},x
jsr {bank7_pushPaletteUpdate}
jmp savestate_fix_end


savestate_fix_check_inputs:
// any hotkey that is made up of select + any dpad button is considered a valid savestate key
lda {previousInput}
cmp #$21
bcc savestate_fix_end
cmp #$30
bcs savestate_fix_end

lda {currentInputHeld}
cmp {previousInput}
beq savestate_fix_end

// this timer can be adjusted to be longer or shorter depending on savestate timing
lda #$02
sta {refreshPaletteTimer}

savestate_fix_end:
lda {currentInputHeld}
sta {previousInput}
