arch nes.cpu
header

banksize $4000

table "src/cv1Game.tbl"
table "src/cv1TitleUS.tbl"

incsrc "src/defines/USPRG1-defines.asm"

incsrc "src/title_screen/title_screen_us.asm"

incsrc "src/main_full.asm"