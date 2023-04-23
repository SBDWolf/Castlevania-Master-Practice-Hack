arch nes.cpu
header

banksize $4000

incsrc "src/defines/SHARED-defines.asm"

// uncomment the defines corresponding to the version you want to build, then comment out the rest
incsrc "src/defines/USPRG1-defines.asm"
//incsrc "src/defines/JP1993-defines.asm"

// -- text Table in levels ---------------------------------------------
// NOTE: i am not confident at the moment that the space character in this table is getting read correctly (it probably is)
table "src/cv1Game.tbl"

incsrc "src/hijacks.asm"
incsrc "src/tables.asm"
incsrc "src/mirror_code.asm"
incsrc "src/new_code_main.asm"
