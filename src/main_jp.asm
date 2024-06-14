arch nes.cpu
header

banksize $4000

table "src/cv1Game.tbl"

incsrc "src/defines/SHARED-defines.asm"
incsrc "src/defines/JP1993-defines.asm"

incsrc "src/title_screen/title_screen_jp.asm"

incsrc "src/demos/demos_jp.asm"

incsrc "src/main_full.asm"