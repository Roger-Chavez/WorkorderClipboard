#Requires AutoHotkey v2.0

global showGUI := true
global partNumber := ""
global Revision := ""
global lotNumber := ""
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

global labels := ["Part Number: ", "Revision: ", "Lot Number: ", "Description: ", "Quantity: ", "Supplier: "]

global ddl := MyGui.AddDropDownList("vChoice", labels)

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
            global partNumber := getValue()
        Case 2:
            global Revision := getValue()
        Case 3:
            global lotNumber := getValue()
        Case 4:
            global Description := getValue()
        Case 5:
            global Quantity := getValue()
        Case 6:
            global Supplier := getValue()
    }
}

;Paste one item at a time, based off of selected item on drop down list alt + v
!v:: {
    Switch ddl.Value
    {
        Case 1:
            global partNumber
            setValue(partNumber)
        Case 2:
            global Revision
            setValue(Revision)
        Case 3:
            global lotNumber
            setValue(lotNumber)
        Case 4:
            global Description
            setValue(Description)
        Case 5:
            global Quantity
            setValue(Quantity)
        Case 6:
            global Supplier
            setValue(Supplier)
    }
}

; Copy values directly alt + 1-6
!1:: {
    global partNumber := getValue()
}
!2:: {
    global Revision := getValue()
}
!3:: {
    global lotNumber := getValue()
}
!4:: {
    global Description := getValue()
}
!5:: {
    global Quantity := getValue()
}
!6:: {
    global Supplier := getValue()
}

; Paste values directly ctrl + 1-6
^1:: {
    global partNumber
    setValue(partNumber)
}
^2:: {
    global Revision
    setValue(Revision)
}
^3:: {
    global lotNumber
    setValue(lotNumber)
}
^4:: {
    global Description
    setValue(Description)
}
^5:: {
    global Quantity
    setValue(Quantity)
}
^6:: {
    global Supplier
    setValue(Supplier)
}

;Function to reset clipboard, copy ctrl + c, then return clipboard contents
getValue() {
    A_Clipboard := ""  ; Start off empty to allow ClipWait to detect when the text has arrived.
    Send "^c"
    ClipWait
    return A_Clipboard
}

;Function to set clipboard then envoke paste ctrl + v
setValue(str) {
    A_Clipboard := str
    ClipWait
    Send "^v"
}

;Make a concatenated string of all the values
printData() {
    data := labels[1] . partNumber . "`n" . labels[2] . Revision . "`n" . labels[3] . lotNumber . "`n" . labels[4] . Description . "`n" . labels[5] . Quantity . "`n" . labels[6] . Supplier . "`n"
    A_Clipboard := data
    ClipWait
    Send "^v"
}

; Function to parse data dump and assign to variables
parseData() {
    A_Clipboard := "" ; Empty then copy data dump
    Send "^c"
    ClipWait
    dump := A_Clipboard

    global labels

    ; Split the data dump into lines
    lines := StrSplit(dump, "`n")

    if lines.Length < 6
    {
        MsgBox "Wrong format"
        return
    }

    ; Loop through the lines and assign the data based on the labels
    Loop 6 {
        ; Remove the label from the line to extract only the data
        lineData := StrReplace(lines[A_Index], labels[A_Index])
        ; Assign the data to the corresponding variable
        Switch A_Index
        {
            Case 1:
                global partNumber := lineData
            Case 2:
                global Revision := lineData
            Case 3:
                global lotNumber := lineData
            Case 4:
                global Description := lineData
            Case 5:
                global Quantity := lineData
            Case 6:
                global Supplier := lineData
        }
    }
}

^PrintScreen:: parseData()

;Print all the values when PrintScreen is pressed
!PrintScreen:: printData()

;TODO: Toggle showing values

;Exit app by pressing ctrl + End
^End:: ExitApp