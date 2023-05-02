bank 1
base $8000
org {bank1_titleScreenPatternTableNumberEdits}
db $00,$00,$00,$00,$00,$00,$00,$00,$1C,$36,$63,$63,$63,$36,$1C,00
db $00,$00,$00,$00,$00,$00,$00,$00,$3E,$63,$07,$1E,$3C,$70,$7F,00
db $00,$00,$00,$00,$00,$00,$00,$00,$3F,$06,$0C,$1E,$03,$63,$3E,00
db $00,$00,$00,$00,$00,$00,$00,$00,$0E,$1E,$36,$66,$7F,$06,$06,00
db $00,$00,$00,$00,$00,$00,$00,$00,$7E,$60,$7E,$03,$03,$63,$3E,00
db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,00
db $00,$00,$00,$00,$00,$00,$00,$00,$1E,$30,$60,$7E,$63,$63,$3E,00

org {bank1_titleScreenPatternTableLetterEdits}
db $00,$00,$00,$00,$00,$00,$00,$00,$63,$63,$63,$77,$3E,$1C,$08,$00

// the format for this title screen text is the following:
// - a line is made up of 32 characters.
// - the D4 byte is a compact way of printing multiple space bytes, and is followed by a byte that determines how many times it should be printed
// - i don't know what the third 00 byte is :)

bank 6
base $8000
// i am filling in just enough space with manual $00 bytes so that the length of this binary format is the same as in the original ROM
org {bank6_titleScreenTextRow1}
db $D4,$08,$00,"CV1 PRACTICE HACK",$D4,$07,$00
db $D4,$06,$00,"PAUSE AND HIT SELECT",$D4,$06,$00
db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$D4,$05,$00
db $D4,$0B,$00,"VERSION 0.4",$D4,$0A,$00
// end title screen printing
//db $00,$00,$00,$00,$00,$00
//db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
//db $00,$00,$00,$D9
