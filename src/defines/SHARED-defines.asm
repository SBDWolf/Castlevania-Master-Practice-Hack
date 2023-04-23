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
define MULTIPLEINPUT_AOrB #$C0

define FALSE #$00
define TRUE #$01

// keep these updated if ever adding new menu phases
define PRACTICEMENU_DeconstructMenu00PhaseIndex #$08
define PRACTICEMENU_MenuActionPhaseIndex #$0E
define PRACTICEMENU_LastPhaseIndex #$10

// keep this updated when adding new menu options that uses text selection :)
define ABOUT_MasterTableIndex 2

define SYSTEMSTATE_InGame #$05
define SYSTEMSTATE_Respawning #$06
define SYSTEMSTAGE_Win #$0C

define SPRITE0_MenuMovedPosition #$2F
define SPRITE0_OriginalPosition #$25

// -- RAM Addresses -------------------------------------------------

define practiceMenuTextPointer $00	// dw 

define systemState $18
define systemSubState $19

define introTimer $1D
define frameCounter $1A

define isLagging $1B

define tileDataPointer $20

// 0x1 if the game is paused, 0x0 if not
define pauseFlag $22

define currentStage $28
define previousStage $29

define currentLifeCount $2A

define currentGameLoop $2B

define currentSubweaponMultiplier $64

define currentWhipLevel $70

define currentHeartCount $71

define currentInputOneFrame $F5

define currentSubweapon $15B

define practiceMenuPhaseIndex $100		// (NEW!) used to determine in what phase of the menu drawing we're currently on
define practiceMenuCursor $101
define practiceTextPos $102
define practiceText_Dest $103		// word-sized
define practiceSubMenuCursor $105
define practiceSubMenuCursorMaxValue $106
define practiceSubMenuShouldExecuteMenuActionFlag $107
define practiceShouldKeepPlayerStatsOnDeathFlag $108

define practiceAboutPrintPhase $109

define backupCurrentWhipLevel $10A
define backupCurrentSubweapon $10B
define backupCurrentSubweaponMultiplier $10C
define backupCurrentHeartCount $10D

// currentGameSpeed: the higher the value, the slower it is.
define currentGameSpeed $110
define slowDownCounter $111

define sprite0ForOAM $200

define subweaponFrameSprite1ForOAM $21C

define subweaponSprite1ForOAM $23C
define subweaponSprite2ForOAM $240

define PPUBuffer $700
// -- ROM Addresses -------------------------------------------------

// there is EXTREMELY little free space left in bank 7, but it's just enough to do a bank switch.
define bank7_freeSpace $FF2D