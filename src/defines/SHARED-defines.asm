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
define PRACTICEMENU_MenuEntryCount #$0E

// keep these updated when adding new menu options that uses text selection :)
define INDEX_TimerTextMasterTableIndex #$00
define INDEX_ScrollGlitchTextMasterTableIndex #$02
define INDEX_MemoryWatchTextMasterTableIndex #$04
define INDEX_SubweaponTextMasterTableIndex #$06
define INDEX_AboutTextMasterTableIndex 8

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

define MEMORYWATCHMENU_DisabledIndex #$00
define MEMORYWATCHMENU_TotalLagFrameCounterIndex #$01
define MEMORYWATCHMENU_SimonXHighByteIndex #$02
define MEMORYWATCHMENU_SimonYIndex #$03
define MEMORYWATCHMENU_WhipAnimationTimerIndex #$04


// keep these updated when adding a new tool
define TOOLS_ToolCount #$07

define TOOLS_TimerToolBitSet #$80
define TOOLS_MemoryWatch00ToolBitSet #$40
define TOOLS_MemoryWatch01ToolBitSet #$20
define TOOLS_MemoryWatch02ToolBitSet #$10
define TOOLS_MemoryWatch03ToolBitSet #$08
define TOOLS_ScrollGlitchToolBitSet #$04

define TOOLS_TimerToolBitUnSet #$7F
define TOOLS_MemoryWatch00ToolBitUnSet #$BF
define TOOLS_MemoryWatch01ToolBitUnSet #$DF
define TOOLS_MemoryWatch02ToolBitUnSet #$EF
define TOOLS_MemoryWatch03ToolBitUnSet #$F7
define TOOLS_ScrollGlitchToolBitUnSet #$FB

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

define blockCounter $30

define simonY $3F
define simonXHighByte $40
define simonXLowByte $41

define currentPlayerHealth $45

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

define consecutiveLagFramesCounter $112

define totalLagFrameCounter $113

define memorywatch00Pointer $114 // 2 bytes

define memorywatch01Pointer $116 // 2 bytes

define memorywatch02Pointer $118 // 2 bytes

define memorywatch03Pointer $11A // 2 bytes

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

define currentBossHealth $1A9

define sprite0ForOAM $200

define subweaponFrameSprite1ForOAM $21C

define subweaponSprite1ForOAM $23C
define subweaponSprite2ForOAM $240

// if left then 0x01, else 0x00
define isSimonFacingLeft $0450

define whipAnimationTimer $568

define levelTileData $5A0

define PPUBuffer $700
// -- ROM Addresses -------------------------------------------------

// extremely tight on free space here, particularly on the US version
define bank7_freeSpaceforMenu $FF2A
define bank7_freeSpaceforTools $FF38