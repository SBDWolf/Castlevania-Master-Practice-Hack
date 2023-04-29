arch nes.cpu
header

banksize $4000

incsrc "src/defines/SHARED-defines.asm"

// uncomment the defines file corresponding to the version you want to build, then comment out the other
//incsrc "src/defines/USPRG1-defines.asm"
incsrc "src/defines/JP1993-defines.asm"

// -- Text Table in levels ---------------------------------------------
table "src/cv1Game.tbl"

incsrc "src/hijacks.asm"
incsrc "src/tables.asm"
incsrc "src/mirror_code.asm"


bank 5
base $8000
org {bank5_freeSpaceCode}
incsrc "src/menu/menu_main.asm"
incsrc "src/menu/menu_submenu.asm"
incsrc "src/menu/menu_actions.asm"

incsrc "src/tools/tools_main.asm"

incsrc "src/utility.asm"

warnpc $C000