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
// keep this updated if adding new menu entries
define PRACTICEMENU_MenuEntryCountForUpPressUnderflow #$0D

// keep these updated when adding new menu options that uses text selection
define INDEX_BinaryEnableTextMasterTableIndex #$00
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

define SFX_OrbGrab #$48
define SFX_OrbGrabDracula #$48
define SFX_GameOverTrack #$4E

define MEMORYWATCHMENU_DisabledIndex #$00
define MEMORYWATCHMENU_TotalLagFrameCounterIndex #$01 // TODO: is this right? double check
define MEMORYWATCHMENU_SimonXHighByteIndex #$02
define MEMORYWATCHMENU_SimonYIndex #$03
define MEMORYWATCHMENU_WhipAnimationTimerIndex #$04

define SCROLLGLITCHDIAGNOSTIC_MaxHudCursorValue #$20
define SCROLLGLITCHDIAGNOSTIC_TimerMaxValue #23 // decimal!

// keep these updated when adding a new tool
define TOOLS_ToolCount #$08

define TOOLS_TimerToolBitSet #$80
define TOOLS_MemoryWatch00ToolBitSet #$40
define TOOLS_MemoryWatch01ToolBitSet #$20
define TOOLS_MemoryWatch02ToolBitSet #$10
define TOOLS_ScrollGlitchDiagnosticToolBitSet #$08
define TOOLS_ScrollGlitchDeathToolBitSet #$04
define TOOLS_InputDisplayToolBitSet #$02
define TOOLS_DraculaDiagnosisToolBitSet #$01

define TOOLS_TimerToolBitUnSet #$7F
define TOOLS_MemoryWatch00ToolBitUnSet #$BF
define TOOLS_MemoryWatch01ToolBitUnSet #$DF
define TOOLS_MemoryWatch02ToolBitUnSet #$EF
define TOOLS_ScrollGlitchDiagnosticToolBitUnSet #$F7
define TOOLS_ScrollGlitchDeathToolBitUnSet #$FB
define TOOLS_InputDisplayToolBitUnSet #$FD
define TOOLS_DraculaDiagnosisToolBitUnSet #$FE

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

define rightBookendColumn $35
define leftBookendColumn $36

// if Simon is moving right, bit 0 is set
// if Simon is moving left, bit 1 is set
// if Simon is idle, both bits 0 and 1 are unset
// if Simon is at the edge of a room (no scrolling), bit 2 is set
define simonMovementState $3C

define simonY $3F
define simonXHighByte $40
define simonXLowByte $41

define currentPlayerDisplayHealth $44
define currentPlayerHealth $45

define currentSubStage $46

// this address is responsible for the demo music glitch
define musicContinuity $4A

define currentSubweaponMultiplier $64

define RNG $6F

define currentWhipLevel $70

define currentHeartCount $71

define musicSquare1Track $82
define musicSquare1Volume $85
define musicSquare2Volume $95
define musicTriangleLinearCounter $A5
define noiseTrack $B2
define noiseNoteAddressHigh $B3
define noiseNoteAddressLow $B4
define noiseVolume $B7
define audioTrack $E5

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

define draculaToolPauseBufferFrameCount $10C
define draculaToolJumpWhipStaggerFrameCount $10D

define disableMusic $10E

define activeTools $110
define toolsCountForMenuDeconstruction $111

define consecutiveLagFramesCounter $112

define totalLagFrameCounter $113

define memorywatch00Pointer $114 // 2 bytes

define memorywatch01Pointer $116 // 2 bytes

define memorywatch02Pointer $118 // 2 bytes

define memorywatch03Pointer $11A // 2 bytes

define timerLevelTimerMinutes $11C
define timerLevelTimerSeconds $11D
define timerLevelTimerFrames $11E
define timerRoomTimerCurrentMinutes $11F
define timerRoomTimerCurrentSeconds $120
define timerRoomTimerCurrentFrames $121
define timerRoomTimerPreviousMinutes $122
define timerRoomTimerPreviousSeconds $123
define timerRoomTimerPreviousFrames $124

define timerPreviousFrameStage $125
define timerPreviousFrameSubStage $126
define timerAlreadyRanUpdatesFlag $127

define scrollGlitchDiagnosticTimer $128
// 0x01 on "first movement right", 0x02 on "first movement left", 0x00 on "idle", 0x03 on "scroll glitch movement right", 0x04 on "scroll glitch movement left"
define scrollGlitchDiagnosticPhaseCounter $129
define scrollGlitchDiagnosticSimonPreviousX $12A
define scrollGlitchDiagnosticHudCursor $12B
define scrollGlitchDiagnosticHudClearPhase $12C

define toolsToRunPointerList $12E

define currentBossHealth $1A9

define sprite0ForOAM $200

define subweaponFrameSprite1ForOAM $21C

define subweaponSprite1ForOAM $23C
define subweaponSprite2ForOAM $240

// if left then 0x01, else 0x00
define isSimonFacingLeft $0450

define attackState $530

define whipAnimationTimer $568

define levelTileData $5A0

define PPUBuffer $700
// -- ROM Addresses -------------------------------------------------

// this is where the Z character in the HUD is originally stored at
define bank3_LetterOffset_Z $BE98

// natural free space in both the us and jp version. not much in bank 7!
define bank7_naturalFreeSpace $FF2A

define bank0_freeSpace $BB10