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
MacroID=9d8d6639-71ef-40e9-9c34-8d4ee640491a
Description=Autoheal
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

hwnd0 = 328388
hwnd1 = 5376750
hwnd2 = 66418
hwnd3 = 328942
hwnd4 = 68620
ehwnd = 134132

sick_state = 2
mouse_state = 8
fire_state = 16

//Call Plugin.Window.Move(Hwnd1, 100, 100)

VBS state_add=&H0111FEA4


//Player1_state_value = 16 // Debugging

cond = Check_Arrival(DX1, DY1)
TracePrint cond(0)
TracePrint cond(1)
TracePrint cond(2)

counter = 0
While cond(0) = - 1  or cond(1) = - 1  or cond(2) = - 1 
	Autoheal 
	cond = Check_Arrival(DX1, DY1)
	TracePrint cond(0)
	TracePrint cond(1)
	TracePrint cond(2)
	If counter = 1000 Then 
		Call Refresh_Nav
		Call BringWinOnTop(hwnd1)
		// Keep player 2,3,4 active
		//Call Plugin.Bkgnd.KeyPress(hwnd2, 121)//Press F10 
		//Call Plugin.Bkgnd.KeyPress(hwnd2, 121)//Press F10
		
		Call Plugin.Bkgnd.KeyPress(hwnd3, 121)//Press F10 
		Call Plugin.Bkgnd.KeyPress(hwnd3, 121)//Press F10	
		
		Call Plugin.Bkgnd.KeyPress(hwnd4, 121)//Press F10 
		Call Plugin.Bkgnd.KeyPress(hwnd4, 121)//Press F10
		counter = 0
	End If
	counter = counter+1
Wend


Function Check_Arrival(DX1, DY1)
	Dim cond(3)
	
	IfColor DX1 + 629, DY1 + 330, "ffffff", 0 Then
		TracePrint "True!!"
		cond(0) = 0
	Else
		cond(0) = -1
	End If
	
	IfColor DX1 + 641, DY1 + 332, "ffffff", 0 Then
		cond(1) = 0
	Else
		cond(1) = -1
	End If
	
	IfColor DX1 + 654, DY1 + 334, "ffffff", 0 Then
	
		cond(2) = 0
	Else
		cond(2) = -1 
	End If
		
	Check_Arrival = cond
End Function


Sub UPDATE_PLAYER_STATE
	Player1_state_value = Int(Plugin.Memory.Read8Bit(hwnd1, state_add))
	Player2_state_value = Int(Plugin.Memory.Read8Bit(hwnd2, state_add))
	Player3_state_value = Int(Plugin.Memory.Read8Bit(hwnd3, state_add))
	Player4_state_value = Int(Plugin.Memory.Read8Bit(hwnd4, state_add))
End Sub


Sub Autoheal
	Call UPDATE_PLAYER_STATE
	 
	// Checking if anyone is sick
	If Player1_state_value=sick_state or Player2_state_value=sick_state or Player3_state_value=sick_state or Player4_state_value=sick_state
		TracePrint "Someone is sick"
		
		Call Plugin.Bkgnd.KeyPress(hwnd2, 121)//Press F10 	
		// Mutliple heal if more than 1 player is sick
		While Player1_state_value=sick_state or Player2_state_value=sick_state or Player3_state_value=sick_state or Player4_state_value=sick_state
			Delay 1000
			Call Plugin.Bkgnd.KeyPress(hwnd2, 114)//Press F3
			Call UPDATE_PLAYER_STATE
		Wend
		Call Plugin.Bkgnd.KeyPress(hwnd2, 121) //Press F10 again to cancael meun
	End If
	
	// Checking if anyone is Mouse
	If Player1_state_value=mouse_state or Player2_state_value=mouse_state or Player3_state_value=mouse_state or Player4_state_value=mouse_state
		TracePrint "Someone has Mouse"
		Call Plugin.Bkgnd.KeyPress(hwnd2, 121)//Press F10 
		// Mutliple heal if more than 1 player has mouse
		While Player1_state_value=mouse_state or Player2_state_value=mouse_state or Player3_state_value=mouse_state or Player4_state_value=mouse_state
			Delay 800
			Call Plugin.Bkgnd.KeyPress(hwnd2, 113)//Press F3
			Call UPDATE_PLAYER_STATE
		Wend
		Call Plugin.Bkgnd.KeyPress(hwnd2, 121) //Press F10 again to cancael meun
	End If
	
	// Checking if anyone is on Fire
	If Player1_state_value=fire_state or Player2_state_value=fire_state or Player3_state_value=fire_state or Player4_state_value=fire_state
		TracePrint "Someone has Mouse"
		Call Plugin.Bkgnd.KeyPress(hwnd2, 121)//Press F10 
		
		// Mutliple heal if more than 1 player has mouse
		While Player1_state_value=fire_state or Player2_state_value=fire_state or Player3_state_value=fire_state or Player4_state_value=fire_state
			Delay 800
			Call Plugin.Bkgnd.KeyPress(hwnd2, 116)//Press F3
			Call UPDATE_PLAYER_STATE
		Wend
		Call Plugin.Bkgnd.KeyPress(hwnd2, 121) //Press F10 again to cancael meun
	End If

	
End Sub

Sub Refresh_Nav
	// Keep auto-nagviation activated
	Call Plugin.Window.Active(hwnd0)
	Delay 300
	Call Plugin.Bkgnd.KeyPress(hwnd0, 121)//F10
	Delay 300
	Call Plugin.Bkgnd.KeyPress(hwnd0, 83)//S
	Delay 300
	Call Plugin.Bkgnd.KeyPress(hwnd0, 80)//R

	Delay 300
	Call Plugin.Bkgnd.KeyPress(hwnd0, 121)//F10
	Delay 300
	Call Plugin.Bkgnd.KeyPress(hwnd0, 83)//S
	Delay 300
	Call Plugin.Bkgnd.KeyPress(hwnd0, 82)//R
	Delay 500
End Sub

Sub BringWinOnTop(hwnd)
	Call Plugin.Window.Active(hwnd)
	Call Plugin.Window.Restore(hwnd)
End Sub