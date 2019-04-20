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
MacroID=841b5124-aae3-45c1-8e31-060c0b45fd6d
Description=BuyBargain
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


s1 = Plugin.Window.GetClientRect(hwnd1)

MyArray1 = Split(s1, "|", -1, 1)


DX = MyArray1(0)
DY = MyArray1(1)

TracePrint DX
TracePrint DY


Call Move_Click(DX, DY, 640, 357) // Option = Buy
Delay 800

Call Move_Click(DX, DY, 235, 261)// Buy the 1st target product
Delay 200
KeyPress 107, 1
Delay 200
KeyPress 13, 1
Delay 200

MouseWheel -6

Call Move_Click(DX, DY, 201, 195)// Buy the 2nd target product
Delay 200
KeyPress 107, 1
Delay 200
KeyPress 13, 1
Delay 200

Call Move_Click(DX, DY, 235, 261)// Buy the 3rd target product
Delay 200
KeyPress 107, 1
Delay 200
KeyPress 13, 1
Delay 200

Call Move_Click(DX, DY, 235, 300)// Buy the 3rd target product
Delay 200
KeyPress 107, 1
Delay 200
KeyPress 13, 1
Delay 200

Call Move_Click(DX, DY, 428, 304)// Bargain
Delay 500

Call Move_Click(DX, DY, 647, 423)// Confirm

Sub Move_Click(DX,DY, X,Y)
    Moveto DX+X, DY+Y //Move to supply button
    Delay 300 
    LeftClick 1
End Sub


Sub BringWinOnTop(hwnd)
	Call Plugin.Window.Active(hwnd)
	Call Plugin.Window.Restore(hwnd)
End Sub


