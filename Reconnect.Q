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
MacroID=223928ce-359c-4160-937e-52eed5462997
Description=Reconnect
Enable=1
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
hwnd0 = 328388
hwnd1 = 5376750
hwnd2 = 66418
hwnd3 = 328942
hwnd4 = 68620
ehwnd = 134132

sick_state = 2
mouse_state = 8
fire_state = 16
//Call Plugin.Window.Move(hwnd1, 100, 100)
VBS state_add=&H0111FEA4
MP_add = &H0111FF48
OLstatus3_add = &H0112412C
OLstatus1_add = &H0111FDEC

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

DXe = MyArraye(0)
DYe = MyArraye(1)

Call reconnect

Sub reconnect
	Call UPDATE_PLAYER_OL_STATE(OLstatus1_add)
	If Player1_ol_value = 0 Then 
		Call Login(hwnd1, 0)
		SendAlert
		TracePrint "Player1 reconnected"
		StartNavi
	End If
	
	If Player2_ol_value = 0 Then 
		Call Login(hwnd2, 1)
		SendAlert
		TracePrint "Player2 reconnected"
	End If
	
	If Player3_ol_value = 0 Then 
		Call Login(hwnd3, 1)
		SendAlert
		TracePrint "Player3 reconnected"
	End If
	
	If Player4_ol_value = 0 Then 
		Call Login(hwnd4, 1)
		SendAlert
		TracePrint "Player4 reconnected"
	End If	
End Sub

Sub UPDATE_PLAYER_OL_STATE(state_add)
	Player1_ol_value = Int(Plugin.Memory.Read32Bit(hwnd1, state_add))
	Player2_ol_value = Int(Plugin.Memory.Read32Bit(hwnd2, state_add))
	Player3_ol_value = Int(Plugin.Memory.Read32Bit(hwnd3, state_add))
	Player4_ol_value = Int(Plugin.Memory.Read32Bit(hwnd4, state_add))
End Sub

Sub Login(hwnd, pass)
	Call Plugin.Bkgnd.KeyPress(hwnd, 13) // Confirm disconnect
	Delay 300
	Call Plugin.Bkgnd.KeyPress(hwnd, 13) // Confirm replay
	Delay 3800
	Call Plugin.Bkgnd.KeyPress(hwnd, 13) // Start login page
	Delay 500	
	Call Plugin.Bkgnd.LeftClick(hwnd, 401, 375)
	Delay 3500
	Call Plugin.Bkgnd.LeftClick(hwnd, 422, 484)
	Delay 500
	Call Plugin.Bkgnd.KeyPress(hwnd, 13)
	Delay 500
	Call Plugin.Bkgnd.KeyPress(hwnd, 9)
	Delay 200
	If pass = 0 Then 
		Call Plugin.Bkgnd.KeyPress(hwnd, 50)
		Call Plugin.Bkgnd.KeyPress(hwnd, 56)
		Call Plugin.Bkgnd.KeyPress(hwnd, 57)
		Call Plugin.Bkgnd.KeyPress(hwnd, 53)
		Call Plugin.Bkgnd.KeyPress(hwnd, 53)
		Call Plugin.Bkgnd.KeyPress(hwnd, 49)
		Call Plugin.Bkgnd.KeyPress(hwnd, 52)
		Call Plugin.Bkgnd.KeyPress(hwnd, 57)
	End If
	
	If pass = 1 Then 
		Call Plugin.Bkgnd.KeyPress(hwnd, 51)
		Call Plugin.Bkgnd.KeyPress(hwnd, 53)
		Call Plugin.Bkgnd.KeyPress(hwnd, 50)
		Call Plugin.Bkgnd.KeyPress(hwnd, 56)
		Call Plugin.Bkgnd.KeyPress(hwnd, 50)
		Call Plugin.Bkgnd.KeyPress(hwnd, 51)
		Call Plugin.Bkgnd.KeyPress(hwnd, 54)
		Call Plugin.Bkgnd.KeyPress(hwnd, 50)
	End If
	
	Call Plugin.Bkgnd.KeyPress(hwnd, 13) // Semd Password
	Delay 100
	Call Plugin.Bkgnd.LeftClick(hwnd, 668, 556) // Agree terms
	Delay 100
	Call Plugin.Bkgnd.KeyPress(hwnd, 13) //Select servers
	Delay 3500
	Call Plugin.Bkgnd.KeyPress(hwnd, 13) // Select character

End Sub
