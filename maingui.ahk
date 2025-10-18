#Requires AutoHotkey v2.0
#Include BasicChecks.ahk
#Include weeklyboss.ahk


MyGui := Gui(,"Idleon Helper")
Tab := MyGui.Add("Tab2",, ["First Tab", "N\A", "N\A"])

Tab.UseTab(1)
MyGui.Add("Radio", "vWeeklyStrategy", "💀 5 skull").Value := 1
MyGui.Add("Radio",, "🏆 max trophy/misc")
WeeklyBossbutton := MyGui.Add("Button", "default w80", "Start Weekly Bosss")
WeeklyBossbutton.OnEvent("Click", StartWeeklyBoss)

Tab.UseTab(2)


Tab.UseTab(3)
MyGui.Add("Edit", "vMyEdit r5")  ; r5 means 5 rows tall.

Tab.UseTab()  ; i.e. subsequently-added controls will not belong to the tab control.

Btn := MyGui.Add("Button", "default xm", "OK")  ; xm puts it at the bottom left corner.

Btn.OnEvent("Click", ProcessUserInput)
MyGui.OnEvent("Close", ProcessUserInput)
MyGui.OnEvent("Escape", ProcessUserInput)
MyGui.Show()


StartWeeklyBoss(*) {
    Saved := MyGui.Submit(false)
    result := Saved.WeeklyStrategy = 1 ? ExecuteWeeklyCommands(skullCommands) : ExecuteWeeklyCommands(trophyCommands)
    MsgBox("Weekly Boss Routine Completed!", "Idleon Helper", 0x40)
    MyGui.Show()
}
CommandsAsString(commandsArray) {
    returnString := ""
    for index, command in commandsArray {
        returnString .= command " "
    }
    return returnString
}
ProcessUserInput(*)
{
    MyGui.Destroy()
    ExitApp
}
F1::{
    MsgBox("Script Paused/Resumed. Press F1 to toggle again.", "Idleon Helper", 0x2040)
    ;Suspend -1
    Pause -1
    return
}