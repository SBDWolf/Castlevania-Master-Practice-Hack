arch nes.cpu
header

banksize $4000

table "src/cv1TitleUS.tbl"

incsrc "src/defines/SHARED-defines.asm"
incsrc "src/defines/USPRG1-defines.asm"

incsrc "src/title_screen/title_screen_us.asm"

// clear all the encoding used for the title screen
cleartable
table "src/cv1Game.tbl"

incsrc "src/demos/demos_us.asm"

incsrc "src/main_full.asm"