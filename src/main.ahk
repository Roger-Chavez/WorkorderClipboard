#Requires AutoHotkey v2.0

global Part_Number := ""
global Revision := ""
global Lot_Number := ""
global Description := ""
global Quantity := ""
global Supplier := ""

W := 120
H := 20
X := A_ScreenWidth - W
Y := 0

MyGui := Gui()
MyGui.Opt("+AlwaysOnTop -Caption +ToolWindow")
MyGui.MarginX := 0
MyGui.Marginy := 0
; MyGui.SetFont("cRed s15 bold", "Arial")
global ddl := MyGui.AddDropDownList("vChoice", ["Part Number", "Revision", "Lot Number", "Description", "Quantity", "Supplier"])
ddl.OnEvent("Change", FOO_BAR, 1)
; WinSetTransColor(MyGui.BackColor " 165", MyGui)
global size := Format("x{1} y{2} w{3} h{4}", X, Y, W, H)
MyGui.Show(size)


FOO_BAR(*) {
    MsgBox ddl.Value
}

;todo: edit mode is essentially focused on the drop down list
;todo: when focused on the drop down list, record focused item -- copy value into selected item
;todo: hotkeys also work to copy directly without needing to edit the ddl
;todo: outside of edit mode it's not possible to edit values, done to prevent accidental changes
;todo: lock values once confident all the values have been found, focusing on ddl can be prevented
;      and hotkeys to record to specific slots can be disabled

esc:: ExitApp