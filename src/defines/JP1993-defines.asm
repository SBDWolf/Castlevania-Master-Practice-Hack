// -- RAM Addresses -------------------------------------------------

define currentInputHeld $F6

// -- ROM Addresses -------------------------------------------------

define bank7_scorePrintHijack $CC6F

define bank7_pauseCheckHijack $CF46

define bank7_pauseCheck $CF7B

define bank7_deathHijack $C2BE

define bank7_sprite0Hijack $C165
define bank7_sprite0LocalOAMTable $C161

define bank7_mainJumpTable $C211
define bank7_originalIntroGameStatePointer $B708

define bank7_endOfNMIHijack $C0DF
define bank7_tableThatGetsOverwritten $CDFA

define bank6_hudPrintHijack $A192

define bank6_scoreCheckHijack $A096

define bank6_hijackedJsr $CC65

define bank6_subweaponPrintHijack $A118

// a lot of bank 5 is free space. i am defining my own arbitrary free space ranges to be used by my own code.
define bank5_freeSpaceData $9A40

define bank5_freeSpaceCode $A000

// contain some duplicate code originally in bank 6.
// the game expects bank 6 to be loaded when calling some subroutines that i, in turn, call from my own code.
// since bank 5 is loaded instead, i mirror that code there.
define bank5_mirrorCodeToBank6 $A366

// there is an ok amount of free space in bank 6 on the us version, but not so much on the jp version.
// i only use this in a couple bank 6 hijacks

define bank6_freeSpace $BF60

define someBank7GenericPrintSubRoutine1 $CC80

define someBank7GenericPrintSubRoutine2 $CC53

define someBank7GenericPrintSubRoutine3 $CC4A