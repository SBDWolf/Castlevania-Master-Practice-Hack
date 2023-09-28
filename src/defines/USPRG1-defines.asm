// -- RAM Addresses -------------------------------------------------

define currentInputHeld $F7

// -- ROM Addresses -------------------------------------------------

define bank7_scorePrintHijack $CC84

define bank7_pauseCheckHijack $CEF3

define bank7_mainGameLoopHijack $C1E4

define bank7_pauseCheck $CF28

define bank7_deathHijack $C29F

define bank7_stageTimerPPUDestination $CD6D

define bank7_sprite0Hijack $C13F
define bank7_sprite0LocalOAMTable $C13B

define bank7_NMIHijack $C0C0

define bank7_mainJumpTable $C1F4
define bank7_originalIntroGameStatePointer $B911
define bank7_originalTitleScreenGameStatePointer $B823
define bank7_originalCreditsGameStatePointer $8B4B

define bank7_stagePropertyTableReadingHijack $D027

define bank7_switchToBank_Bank6 $C1D4

define bank6_stageTimerPrintHijack $A0D7

define bank6_hudPrintHijack $A18D

define bank6_scoreCheckHijack $A091

define bank6_hijackedJsr $CC7A

define bank6_subweaponPrintHijack $A113

define bank1_titleScreenPatternTableNumberEdits $8CF0
define bank1_titleScreenPatternTableLetterEdits $8FA0
define bank6_titleScreenTextRow1 $B063
define bank6_titleScreenTextRow2 $B079
define bank6_titleScreenTextRow3 $BA97
define bank6_titleScreenTextRow4 $BAA8

// a lot of bank 5 is free space. i am defining my own arbitrary free space ranges to be used by my own code.
define bank5_freeSpaceData $9E50

define bank5_freeSpaceCode $A400

// contain some duplicate code originally in bank 6.
// the game expects bank 6 to be loaded when calling some subroutines that i, in turn, call from my own code.
// since bank 5 is loaded instead, i mirror that code there.
define bank5_mirrorCodeToBank6 $A357

// there is an ok amount of free space in bank 6 on the us version, but not so much on the jp version.
// i only use this in a couple bank 6 hijacks

define bank6_freeSpace $BA40

define bank7_freedUpSpaceFromReroutedTable $FBC3

define someBank7GenericPrintSubRoutine1 $CC95

define someBank7GenericPrintSubRoutine2 $CC68

define someBank7GenericPrintSubRoutine3 $CC5F

define bank7_printStageTimerFirstDigit $CC68

define bank7_printStageTimerSecondDigit $CC73