#Requires AutoHotkey v2.0

global current_edit := 0
global editable := true
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

global ddl := MyGui.AddDropDownList("vChoice", ["Part Number", "Revision", "Lot Number", "Description", "Quantity", "Supplier"])
ddl.OnEvent("Change", SET_CURRENT, 1)
ddl.OnEvent("Focus", SET_EDIT_ON, 1)
ddl.OnEvent("LoseFocus", SET_EDIT_OFF, 1)
global size := Format("x{1} y{2} w{3} h{4}", X, Y, W, H)
MyGui.Show(size)


SET_CURRENT(*) {
    global current_edit
    current_edit := ddl.Value
}

SET_EDIT_ON(*) {
    global editable
    editable := true
}

SET_EDIT_OFF(*) {
    global editable
    editable := true
}

if editable {
    !c:: {
        Switch current_edit
        {
            Case 1:
                global Part_Number := get_ClipBoard()
            Case 2:
                global Revision := get_ClipBoard()
            Case 3:
                global Lot_Number := get_ClipBoard()
            Case 4:
                global Description := get_ClipBoard()
            Case 5:
                global Quantity := get_ClipBoard()
            Case 6:
                global Supplier := get_ClipBoard()
        }
    }

    !v:: {
        Switch current_edit
        {
            Case 1:
                global Part_Number
                set_Clipboard(Part_Number)
            Case 2:
                global Revision
                set_Clipboard(Revision)
            Case 3:
                global Lot_Number
                set_Clipboard(Lot_Number)
            Case 4:
                global Description
                set_Clipboard(Description)
            Case 5:
                global Quantity
                set_Clipboard(Quantity)
            Case 6:
                global Supplier
                set_Clipboard(Supplier)
        }
    }
}

^e:: {
    ddl.Focus()
}

get_ClipBoard() {
    A_Clipboard := ""  ; Start off empty to allow ClipWait to detect when the text has arrived.
    Send "^c"
    ClipWait
    return A_Clipboard
}

set_Clipboard(str) {
    A_Clipboard := str
    ClipWait
    Send "^v"
}


;todo: edit mode is essentially focused on the drop down list
;todo: when focused on the drop down list, record focused item -- copy value into selected item
;todo: hotkeys also work to copy directly without needing to edit the ddl
;todo: outside of edit mode it's not possible to edit values, done to prevent accidental changes
;todo: lock values once confident all the values have been found, focusing on ddl can be prevented
;      and hotkeys to record to specific slots can be disabled
;TODO: when Locked hide ddl
;TODO: Toggle showing values
;TODO: Data Dump in case I need to make an email

esc:: ExitApp