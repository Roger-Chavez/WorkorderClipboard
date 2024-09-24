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

global ddl := MyGui.AddDropDownList("vChoice",)

global size := Format("x{1} y{2} w{3} h{4}", X, Y, W, H)
MyGui.Show(size)

;Focus on gui ctrl + e
^e:: {
    WinWait "ahk_class AutoHotkeyGUI"
    WinActivate
}

;Hide gui and turn off edit keys ctrl + h
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

;Copy one item at a time, based off of selected item on drop down list alt + c
!c:: {
    Switch ddl.Value
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

;Paste one item at a time, based off of selected item on drop down list alt + v
!v:: {
    Switch ddl.Value
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

; Copy values directly alt + 1-6
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

; Paste values directly ctrl + numpad1-numpad6
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

;Function to reset clipboard, copy ctrl + c, then return clipboard contents
get_Value() {
    A_Clipboard := ""  ; Start off empty to allow ClipWait to detect when the text has arrived.
    Send "^c"
    ClipWait
    return A_Clipboard
}

;Function to set clipboard then envoke paste ctrl + v
set_Value(str) {
    A_Clipboard := str
    ClipWait
    Send "^v"
}

;TODO: Toggle showing values
;TODO: Data Dump in case I need to make an email

esc:: ExitApp