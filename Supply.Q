[General]
SyntaxVersion=2
BeginHotkey=121
BeginHotkeyMod=0
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=20b765d5-9ceb-4a35-9f9f-6556353442e8
Description=Supply
Enable=0
AutoRun=0
[Repeat]
Type=0
Number=1
[SetupUI]
Type=2
QUI=
[Relative]
SetupOCXFile=
[Comment]

[Script]
Dim DX1, DX2, DX3, DX4, DY1, DY2, DY3, DY4

hwnd1 = 197874
hwnd2 = 134180
hwnd3 = 68702
hwnd4 = 68714

s1 = Plugin.Window.GetClientRect(hwnd1)
s2 = Plugin.Window.GetClientRect(hwnd2)
s3 = Plugin.Window.GetClientRect(hwnd3)
s4 = Plugin.Window.GetClientRect(hwnd4)
MyArray1 = Split(s1, "|", -1, 1)
MyArray2 = Split(s2, "|", -1, 1)
MyArray3 = Split(s3, "|", -1, 1)
MyArray4 = Split(s4, "|", -1, 1)

DX1 = MyArray1(0)
DY1 = MyArray1(1)

DX2 = MyArray2(0)
DY2 = MyArray2(1)

DX3 = MyArray3(0)
DY3 = MyArray3(1)

DX4 = MyArray4(0)
DY4 = MyArray4(1)

// Supplying Food and Water
Call Supply(DX1,DY1,hwnd1) 
Call Supply(DX2, DY2, hwnd2)
Call Supply(DX3, DY3, hwnd3)
Call Supply(DX4, DY4, hwnd4)


// Player 1 sail out
Call SailOut

Sub Move_Click(DX,DY, X,Y)
    Moveto DX+X, DY+Y //Move to supply button
    Delay 300 
    LeftClick 1
End Sub

Sub Supply(DX,DY, hwnd)
	Call Plugin.Window.Top(hwnd, 0)
	Call Move_Click(DX, DY, 682, 360)// Supply button
	Delay 600 // Wait for supply meun to pop up	
	Call Move_Click(DX, DY, 194, 360) // Supply to saved value
	Call Move_Click(DX, DY, 597, 404)// Click confirm button
	// Need to becareful for this step, if it is full, the button is not clickable
	Call Plugin.Window.Top(hwnd, 1) 
End Sub

Sub SailOut
	Call Move_Click(DX1, DY1, 640, 360)
	Delay 600
	Call Move_Click(DX1,DY1, 549, 398)
End Sub

