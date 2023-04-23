bank 5
base $8000
org {bank5_mirrorCodeToBank6}
        sta $0700,x
        inx 
        rts 