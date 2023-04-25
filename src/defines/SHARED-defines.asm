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

// keep these updated when adding new menu options that uses text selection :)
define INDEX_TimerTextMasterTableIndex #$00
define INDEX_SubweaponTextMasterTableIndex #$02
define INDEX_AboutTextMasterTableIndex 4

define SYSTEMSTATE_TitleScreen #$02
define SYSTEMSTATE_InGame #$05
define SYSTEMSTATE_Respawning #$06
define SYSTEMSTATE_DoorTransition #$08
define SYSTEMSTATE_AutoWalk #$09
define SYSTEMSTATE_EnteringCastle #$0A
define SYSTEMSTATE_AutoClimb #$0B
define SYSTEMSTATE_Win #$0C
define SYSTEMSTATE_Falling #$0E

define CREDITS_Ending #$0A

define STAGE_MapScreen #$14
define STAGE_DraculaStage #$12
define STAGE_DraculaSubStage #$01

define SPRITE0_MenuMovedPosition #$2F
define SPRITE0_OriginalPosition #$25

// keep these updated when adding a new tool
define TOOLS_ToolCount #$02
define TOOLS_TestToolBitSet #$80
define TOOLS_TimerToolBitSet #$40
define TOOLS_TestToolBitUnSet #$7F
define TOOLS_TimerToolBitUnSet #$BF

// -- RAM Addresses -------------------------------------------------

define practiceMenuTextPointer $00	// dw 

define systemState $18
define systemSubState $19

define generalTimer $1D
define frameCounter $1A

define isLagging $1B

define tileDataPointer $20

// 0x1 if the game is paused, 0x0 if not
define pauseFlag $22

define currentStage $28
define previousStage $29

define currentLifeCount $2A

define currentGameLoop $2B

define currentSubStage $46

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
define practiceShouldKeepPlayerStatsOnDeathFlag $106

define practiceAboutPrintPhase $107

define backupCurrentWhipLevel $108
define backupCurrentSubweapon $109
define backupCurrentSubweaponMultiplier $10A
define backupCurrentHeartCount $10B

define activeTools $110
define toolsCountForMenuDeconstruction $111

define timerLevelTimerMinutes $120
define timerLevelTimerSeconds $121
define timerLevelTimerFrames $122
define timerRoomTimerCurrentMinutes $123
define timerRoomTimerCurrentSeconds $124
define timerRoomTimerCurrentFrames $125
define timerRoomTimerPreviousMinutes $126
define timerRoomTimerPreviousSeconds $127
define timerRoomTimerPreviousFrames $128

define timerPreviousFrameStage $129
define timerPreviousFrameSubStage $12A
define timerAlreadyRanUpdatesFlag $12B

define toolsToRunPointerList $130

define sprite0ForOAM $200

define subweaponFrameSprite1ForOAM $21C

define subweaponSprite1ForOAM $23C
define subweaponSprite2ForOAM $240

define PPUBuffer $700
// -- ROM Addresses -------------------------------------------------

// extremely tight on free space here, particularly on the US version
define bank7_freeSpaceforMenu $FF2A
define bank7_freeSpaceforTools $FF38