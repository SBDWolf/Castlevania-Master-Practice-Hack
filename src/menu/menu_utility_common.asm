    resetTimerVariables:
        lda #$00
		sta {timerLevelTimerMinutes}
		sta {timerLevelTimerSeconds}
		sta {timerLevelTimerFrames}
		sta {timerRoomTimerCurrentMinutes}
		sta {timerRoomTimerCurrentSeconds}
		sta {timerRoomTimerCurrentFrames}
		sta {timerRoomTimerPreviousMinutes}
		sta {timerRoomTimerPreviousSeconds}
		sta {timerRoomTimerPreviousFrames}
		sta {timerPreviousFrameStage}
		sta {timerPreviousFrameSubStage}
		sta {timerAlreadyRanUpdatesFlag}
        sta {totalLagFrameCounter}
        rts 

    genericMenuPrint_selectBetweenNumericalValue:
		jsr printSubMenuCursor
		jsr printCurrentNumericalValue
		rts 

	genericMenuPrint_selectBetweenTextValues:
		// needs x register as a parameter to determine the index of the text master table to be used to print menu options
		jsr printSubMenuCursor
      	jsr printCurrentTextValue
		rts 