// -- Constants -----------------------------------------------------

define input_Right #$01
define input_Left #$02
define input_Down #$04
define input_Up #$08
define input_Start #$10
define input_Select #$20
define input_B #$40
define input_A #$80

define multipleInput_UpOrDown #$0C
define multipleInput_StartOrSelect #$30

define false #$00
define true #$01

define practiceMenuDeconstructMenu00PhaseIndex #$08
define practiceMenuMenuActionPhaseIndex #$0E
define practiceMenuLastPhaseIndex #$10

// -- RAM Addresses -------------------------------------------------

define practiceMenuTextPointer $00	// dw 

define introTimer $1D
define frameCounter $1A
// 0x1 if the game is paused, 0x0 if not
define pauseFlag $22

define currentStage $28

define currentWhipLevel $70

define heartCount $71

define currentInputOneFrame $F5
define currentInputHeld $F7

define currentSubweapon $15B

define practiceMenuIndex $100		// (NEW!) used to determine in what phase of the menu drawing we're currently on
define practiceMenuCursor $101
define practiceTextPos $102
define practiceText_Dest $103		// word-sized
define practiceSubMenuCursor $105
define practiceSubMenuCursorMaxValue $106
define practiceSubMenuShouldExecuteMenuActionFlag $107

define subweaponFrameSprite1ForOAM $21C

define subweaponSprite1ForOAM $23C
define subweaponSprite2ForOAM $240
// -- ROM Addresses -------------------------------------------------

// there is EXTREMELY little free space left in bank 7, but it's just enough to do a bank switch.
define bank7_freeSpace $FF2D