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
MacroID=5f6df135-76ff-4175-8357-56f5d08f0980
Description=mining
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
//HwndEx = Plugin.Window.SearchEx("Greate Voyages Online Game MainFrame","大航海時代 Online",1)
//Hwnd0 = Plugin.Window.Find("Afx:00400000:b:00010003:00000006:00240439","athrun200 - 神聖導航")
//dim MyArray
//MyArray = Split(HwndEx, "|")
//TracePrint MyArray(0)
//TracePrint MyArray(1)
//TracePrint MyArray(2)
//TracePrint MyArray(3)

hwnd0 = 460720
hwnd1 = 132686
hwnd2 = 198646
hwnd3 = 591542
hwnd4 = 263828
ehwnd = 134132

sick_state = 2
mouse_state = 8
fire_state = 16

s0 = Plugin.Window.GetClientRect(hwnd0)
s1 = Plugin.Window.GetClientRect(hwnd1)
s2 = Plugin.Window.GetClientRect(hwnd2)
s3 = Plugin.Window.GetClientRect(hwnd3)
s4 = Plugin.Window.GetClientRect(hwnd4)
es = Plugin.Window.GetClientRect(ehwnd)
MyArray0 = Split(s0, "|", -1, 1)
MyArray1 = Split(s1, "|", -1, 1)
MyArray2 = Split(s2, "|", -1, 1)
MyArray3 = Split(s3, "|", -1, 1)
MyArray4 = Split(s4, "|", - 1 , 1)
MyArraye = Split(es, "|", - 1 , 1)

DX0 = MyArray0(0)
DY0 = MyArray0(1)

DX1 = MyArray1(0)
DY1 = MyArray1(1)

DX2 = MyArray2(0)
DY2 = MyArray2(1)

DX3 = MyArray3(0)
DY3 = MyArray3(1)

DX4 = MyArray4(0)
DY4 = MyArray4(1)



Remove_Rubbish(hwnd1)
Remove_Rubbish (hwnd3)
Remove_Rubbish(hwnd4)




Sub Move_Click_v2(hwnd, X, Y)
	s = Plugin.Window.GetClientRect(hwnd)
	MyArray = Split(s, "|", -1, 1)
	DX = MyArray(0)
	DY = MyArray(1)
	
    MoveTo DX + X, DY + Y//Move to supply button
    Delay 250
    LeftClick 1
End Sub

//Player1_state_value = 16 // Debugging
Sub BringWinOnTop(hwnd)
	Call Plugin.Window.Active(hwnd)
	Call Plugin.Window.Restore(hwnd)
End Sub

Sub Remove_Rubbish(hwnd)
	Call Plugin.Bkgnd.KeyPress(hwnd, 118)// F7: Open cargo meun
	Delay 1000
	Call Plugin.Bkgnd.LeftClick(hwnd, 433, 379)
	
	
	
	rubbish_list = Array("E:\Raven\Desktop\HolyNavi_145c\gamescript\grass.bmp", "E:\Raven\Desktop\HolyNavi_145c\gamescript\sand.bmp", "E:\Raven\Desktop\HolyNavi_145c\gamescript\stone.bmp")
	For Each rubbish In rubbish_list
		BringWinOnTop(hwnd)
		XY = Plugin.Bkgnd.FindMultiPicEx(hwnd, 85, 120, 370, 343, rubbish, 0, 0.5)
		If XY = "-1,-1" Then 
			TracePrint "Pic not found"
			Goto Pic_not_found	
		End If
	
	
	
		
		
		
		// Breaking X and Y coordinates
    	iZB = InStr(XY, ",")
    	X = CLng(Left(XY, iZB - 1))
    	Y = CLng(Right(XY, Len(XY) - iZB))
    	
    	// Click and remove the rubbish
    	Call Move_Click_v2(hwnd, X + 20, Y + 20) // Click rubbish
    	Delay 250
    	Call Plugin.Bkgnd.KeyPress(hwnd, 107) // Select max quantity "+"
    	Delay 100
		Call Plugin.Bkgnd.KeyPress(hwnd, 13) // Press Enter
	
	
		Rem Pic_not_found
	
	Next
	
	Call Plugin.Bkgnd.LeftClick(hwnd, 614, 403)
	Delay 1000
	Call Plugin.Bkgnd.KeyPress(hwnd, 27)
	Call Plugin.Bkgnd.KeyPress(hwnd, 27)
End Sub
