#Requires AutoHotkey v2.0
#Include BasicChecks.ahk

; ==========================
; CONFIG
; ==========================
spreadsheetId := "1z1P2ouvYhe2pryWoF0kIQE7QichYpJt1GaPPos-e-aw"
gid := "0"  ; Sheet/tab ID

global startingRow := 11
global skullColumn := 6
global trophyColumn := 10

; ==========================
; GLOBALS
; ==========================
global skullCommands := ""
global trophyCommands := ""
; ==========================
; Build CSV export URL
; ==========================
csvUrl := "https://docs.google.com/spreadsheets/d/" spreadsheetId "/export?format=csv&gid=" gid

; ==========================
; Fetch CSV using WinHttpRequest
; ==========================
req := ComObject("WinHttp.WinHttpRequest.5.1")
req.Open("GET", csvUrl, false)  ; synchronous request
req.Send()

if (req.Status != 200) {
    MsgBox "Failed to fetch CSV. Status: " req.Status
    ExitApp
}

; Store CSV content in a variable
csvContent := req.ResponseText
rows := StrSplit(csvContent, "`n") 

; ==========================
; SET COMMANDS
; ==========================
skullCommands := FetchCommands(skullColumn)
trophyCommands := FetchCommands(trophyColumn)




; ==========================
; FUNCTIONS
; ==========================
ExecuteWeeklyCommands(commandsArray) {
    for index, command in commandsArray {
        WinActivate(WinTitle)
        Click("L",WeeklyButton%command%X, WeeklyButton%command%Y)
        Sleep(300)
    }
}






CleanCommands(String) {
    CleanedString := RegExReplace(String, "\s|\(FR\)|-", "")  ; Remove newlines
    return Trim(CleanedString)
}

FetchCommands(column) {
    targetArray := ""
    currentCell := "temp"
    currentRowNum := startingRow
    while currentCell != "" {
        currentRow := StrSplit(rows[currentRowNum++], ",")
        currentCell := CleanCommands(currentRow[column])
        if (currentCell != "")
            targetArray .= currentCell
    }
    returnstring := StrSplit(targetArray, "")
    return returnstring
}
GetSkullCommands() {
    return skullCommands
}
GetTrophyCommands() {
    return trophyCommands
}