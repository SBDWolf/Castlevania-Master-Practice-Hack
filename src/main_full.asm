incsrc "src/hijacks.asm"
incsrc "src/tables.asm"
incsrc "src/mirror_code.asm"


bank 5
base $8000
org {bank5_freeSpaceCode}
incsrc "src/menu/menu_main.asm"
incsrc "src/menu/menu_submenu.asm"
incsrc "src/menu/menu_actions.asm"
incsrc "src/menu/menu_utility_common.asm"

incsrc "src/tools/tools_main.asm"

incsrc "src/utility.asm"

warnpc $C000

