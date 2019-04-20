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
MacroID=0c930922-1b57-4044-bc4a-3a0e51f63989
Description=NavigateB
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
hwnd0 = Plugin.Window.Find("Afx:00400000:b:00010003:00000006:00240439", "athrun200 - ÉñÂ}Œ§º½")
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
TracePrint DX1
TracePrint DY1

MoveTo DX1 + 629, DY1 + 330

	
cond = Check_Arrival(DX1,DY1)
TracePrint cond(0)
TracePrint cond(1)
TracePrint cond(2)

Choose_Navi_Path ("ToB.path")
Delay 800
Call SailOut
Delay 2000
Call StartNavi



Sub BringWinOnTop(hwnd)
	Call Plugin.Window.Active(hwnd)
	Call Plugin.Window.Restore(hwnd)
End Sub

Sub Choose_Navi_Path(path)
	BringWinOnTop(hwnd0)
	Call Plugin.Bkgnd.KeyPress(hwnd0, 116)//Press F5
	Delay 500
	SayString path
	KeyPress "Enter", 1
End Sub

Sub SailOut
	Call Move_Click(DX1, DY1, 640, 360)
	Delay 600
	Call Move_Click(DX1,DY1, 549, 398)
End Sub

Sub Move_Click(DX,DY, X,Y)
    Moveto DX+X, DY+Y //Move to supply button
    Delay 300 
    LeftClick 1
End Sub

Sub StartNavi
	Call Plugin.Window.Active(hwnd0)
	Delay 300
	Call Plugin.Bkgnd.KeyPress(hwnd0, 121)//F10
	Delay 300
	Call Plugin.Bkgnd.KeyPress(hwnd0, 83)//S
	Delay 300
	Call Plugin.Bkgnd.KeyPress(hwnd0, 82)//R
Delay 500
End Sub

Function Check_Arrival(DX1, DY1)
	Dim cond(3)
	IfColor DX1 + 629, DY1 + 330, "ffffff", 0 Then
		cond(0) = True
	End If
		cond(0) = False
		
	IfColor DX1 + 641, DY1 + 332, "ffffff", 0 Then
		cond(1) = True
	End If
		cond(1) = False
		
	IfColor DX1 + 654, DY1 + 334, "ffffff", 0 Then
		cond(2) = True
	End If
		cond(2) = False
		
	Check_Arrival = cond
End Function
