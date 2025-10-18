#Requires AutoHotkey v2.0
; ==========================
; WINDOW POSITION CONSTANTS
; ==========================
defaultWinX := 960
defaultWinY := 572

WeeklyButton1X := 614
WeeklyButton1Y := 337

WeeklyButton2X := 614
WeeklyButton2Y := 398

WeeklyButton3X := 614
WeeklyButton3Y := 459

; ==========================
; OTHER CONSTANTS
; ==========================

WinTitle := "Legends Of Idleon"

; ==========================
; WINDOW CHECKS & COMMANDS
; ==========================
CoordMode "Mouse", "Window"

if (!WinExist(WinTitle)) {
        MsgBox("Please make sure Legends Of Idleon is running and active before starting the script.", "Idleon Helper", 0x10 )
        ExitApp
        return
    }
winpos := WinGetPos(,,&OutX,&OutY,WinTitle)
if (OutX != defaultWinX || OutY != defaultWinY) {
        MsgBox("Idleon window size was detected to be different than default.`nPlease restart Idleon, otherwise this may cause errors.", "Idleon Helper", 0x30 )
    }
    
    

