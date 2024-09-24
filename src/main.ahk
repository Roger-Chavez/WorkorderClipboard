#Requires AutoHotkey v2.0

global current_edit := 0

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

global size := Format("x{1} y{2} w{3} h{4}", X, Y, W, H)
MyGui.Show(size)


SET_CURRENT(*) {
    global current_edit
    current_edit := ddl.Value
}


^e:: {
    WinWait "ahk_class AutoHotkeyGUI"
    WinActivate
}

^h:: {
    MyGui.Hide()

    Hotkey("!c", "off")
    Hotkey("!v", "off")
    Hotkey("!1", "off")
    Hotkey("!2", "off")
    Hotkey("!3", "off")
    Hotkey("!4", "off")
    Hotkey("!5", "off")
    Hotkey("!6", "off")
    Hotkey("^e", "off")
}

!c:: {
    Switch current_edit
    {
        Case 1:
            global Part_Number := get_Value()
        Case 2:
            global Revision := get_Value()
        Case 3:
            global Lot_Number := get_Value()
        Case 4:
            global Description := get_Value()
        Case 5:
            global Quantity := get_Value()
        Case 6:
            global Supplier := get_Value()
    }
}

!v:: {
    Switch current_edit
    {
        Case 1:
            global Part_Number
            set_Value(Part_Number)
        Case 2:
            global Revision
            set_Value(Revision)
        Case 3:
            global Lot_Number
            set_Value(Lot_Number)
        Case 4:
            global Description
            set_Value(Description)
        Case 5:
            global Quantity
            set_Value(Quantity)
        Case 6:
            global Supplier
            set_Value(Supplier)
    }
}

!1:: {
    global Part_Number := get_Value()
}
!2:: {
    global Revision := get_Value()
}
!3:: {
    global Lot_Number := get_Value()
}
!4:: {
    global Description := get_Value()
}
!5:: {
    global Quantity := get_Value()
}
!6:: {
    global Supplier := get_Value()
}

^Numpad1:: {
    global Part_Number
    set_Value(Part_Number)
}
^Numpad2:: {
    global Revision
    set_Value(Revision)
}
^Numpad3:: {
    global Lot_Number
    set_Value(Lot_Number)
}
^Numpad4:: {
    global Description
    set_Value(Description)
}
^Numpad5:: {
    global Quantity
    set_Value(Quantity)
}
^Numpad6:: {
    global Supplier
    set_Value(Supplier)
}


get_Value() {
    A_Clipboard := ""  ; Start off empty to allow ClipWait to detect when the text has arrived.
    Send "^c"
    ClipWait
    return A_Clipboard
}

set_Value(str) {
    A_Clipboard := str
    ClipWait
    Send "^v"
}

;todo: when focused on the drop down list, record focused item -- copy value into selected item
;todo: hotkeys also work to copy directly without needing to edit the ddl
;todo: outside of edit mode it's not possible to edit values, done to prevent accidental changes
;todo: lock values once confident all the values have been found, focusing on ddl can be prevented
;      and hotkeys to record to specific slots can be disabled
;TODO: when Locked hide ddl
;TODO: Toggle showing values
;TODO: Data Dump in case I need to make an email

esc:: ExitApp