// -- Constants -----------------------------------------------------

define INPUT_Right #$01
define INPUT_Left #$02
define INPUT_Down #$04
define INPUT_Up #$08
define INPUT_Start #$10
define INPUT_Select #$20
define INPUT_B #$40
define INPUT_A #$80

define MULTIPLEINPUT_UpOrDown #$0C
define MULTIPLEINPUT_StartOrSelect #$30

define FALSE #$00
define TRUE #$01

define PRACTICEMENU_DeconstructMenu00PhaseIndex #$08
define PRACTICEMENU_MenuActionPhaseIndex #$0E
define PRACTICEMENU_LastPhaseIndex #$10

define SYSTEMSTATE_Respawning #$06

// -- RAM Addresses -------------------------------------------------

define practiceMenuTextPointer $00	// dw 

define systemState $18

define introTimer $1D
define frameCounter $1A

define tileDataPointer $20

// 0x1 if the game is paused, 0x0 if not
define pauseFlag $22

define currentStage $28

define currentLifeCount $2A

define currentSubweaponMultiplier $64

define currentWhipLevel $70

define currentHeartCount $71

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
define practiceShouldKeepPlayerStatsOnDeathFlag $108

define backupCurrentWhipLevel $109
define backupCurrentSubweapon $10A
define backupCurrentSubweaponMultiplier $10B
define backupCurrentHeartCount $10C

define sprite0ForOAM $200

define subweaponFrameSprite1ForOAM $21C

define subweaponSprite1ForOAM $23C
define subweaponSprite2ForOAM $240

define PPUBuffer $700
// -- ROM Addresses -------------------------------------------------

// there is EXTREMELY little free space left in bank 7, but it's just enough to do a bank switch.
define bank7_freeSpace $FF2D