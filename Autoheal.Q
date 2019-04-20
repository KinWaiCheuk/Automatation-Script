[General]
SyntaxVersion=2
BeginHotkey=145
BeginHotkeyMod=0
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=19
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
HwndEx = Plugin.Window.SearchEx("Greate Voyages Online Game MainFrame","大航海時代 Online",1)
Hwnd0 = Plugin.Window.Find("Afx:00400000:b:00010003:00000006:00240439","athrun200 - 神聖導航")
//dim MyArray
//MyArray = Split(HwndEx, "|")
//TracePrint MyArray(0)
//TracePrint MyArray(1)
//TracePrint MyArray(2)
//TracePrint MyArray(3)

//Hwnd0 = 1902722
Hwnd1 = 197874
Hwnd2 = 134180
Hwnd3 = 68702
Hwnd4 = 68714

sick_state = 2
mouse_state = 8
fire_state = 16

//Call Plugin.Window.Move(Hwnd1, 100, 100)

VBS state_add=&H0111FEA4


//Player1_state_value = 16 // Debugging

// Sailing out
Call Plugin.Window.Active(Hwnd0)
Delay 300
Call Plugin.Bkgnd.KeyPress(Hwnd0, 83)//S
Delay 300
Call Plugin.Bkgnd.KeyPress(Hwnd0, 82)//R
Delay 500

// Activate skills
Call Plugin.Bkgnd.KeyPress(Hwnd1, 121)//Press F10
Delay 1800
Call Plugin.Bkgnd.KeyPress(Hwnd1, 113)//Press F3

Call Plugin.Window.Top(Hwnd1,1)


While True
	Call UPDATE_PLAYER_STATE

	//Player4_state_value = 8

	TracePrint "Loop Start"
	TracePrint Player1_state_value
	TracePrint Player2_state_value
	TracePrint Player3_state_value
	TracePrint Player4_state_value
	TracePrint "Mouse value is  "
	TracePrint mouse_state
	TracePrint "Logic result is "
	TracePrint Player4_state_value = mouse_state
	 
	// Checking if anyone is sick
	If Player1_state_value=sick_state or Player2_state_value=sick_state or Player3_state_value=sick_state or Player4_state_value=sick_state
		TracePrint "Someone is sick"
		
		Call Plugin.Bkgnd.KeyPress(Hwnd2, 121)//Press F10 	
		// Mutliple heal if more than 1 player is sick
		While Player1_state_value=sick_state or Player2_state_value=sick_state or Player3_state_value=sick_state or Player4_state_value=sick_state
			Delay 1000
			Call Plugin.Bkgnd.KeyPress(Hwnd2, 114)//Press F3
			Call UPDATE_PLAYER_STATE
		Wend
		Call Plugin.Bkgnd.KeyPress(Hwnd2, 121) //Press F10 again to cancael meun
	End If
	
	// Checking if anyone is Mouse
	If Player1_state_value=mouse_state or Player2_state_value=mouse_state or Player3_state_value=mouse_state or Player4_state_value=mouse_state
		TracePrint "Someone has Mouse"
		Call Plugin.Bkgnd.KeyPress(Hwnd2, 121)//Press F10 
		// Mutliple heal if more than 1 player has mouse
		While Player1_state_value=mouse_state or Player2_state_value=mouse_state or Player3_state_value=mouse_state or Player4_state_value=mouse_state
			Delay 800
			Call Plugin.Bkgnd.KeyPress(Hwnd2, 113)//Press F3
			Call UPDATE_PLAYER_STATE
		Wend
		Call Plugin.Bkgnd.KeyPress(Hwnd2, 121) //Press F10 again to cancael meun
	End If
	
	// Checking if anyone is on Fire
	If Player1_state_value=fire_state or Player2_state_value=fire_state or Player3_state_value=fire_state or Player4_state_value=fire_state
		TracePrint "Someone has Mouse"
		Call Plugin.Bkgnd.KeyPress(Hwnd2, 121)//Press F10 
		
		// Mutliple heal if more than 1 player has mouse
		While Player1_state_value=fire_state or Player2_state_value=fire_state or Player3_state_value=fire_state or Player4_state_value=fire_state
			Delay 800
			Call Plugin.Bkgnd.KeyPress(Hwnd2, 116)//Press F3
			Call UPDATE_PLAYER_STATE
		Wend
		Call Plugin.Bkgnd.KeyPress(Hwnd2, 121) //Press F10 again to cancael meun
	End If
	
	
	
	// Keep player 2,3,4 active
	//Call Plugin.Bkgnd.KeyPress(Hwnd2, 121)//Press F10 
	//Call Plugin.Bkgnd.KeyPress(Hwnd2, 121)//Press F10
	
	Call Plugin.Bkgnd.KeyPress(Hwnd3, 121)//Press F10 
	Call Plugin.Bkgnd.KeyPress(Hwnd3, 121)//Press F10	
	
	Call Plugin.Bkgnd.KeyPress(Hwnd4, 121)//Press F10 
	Call Plugin.Bkgnd.KeyPress(Hwnd4, 121)//Press F10
	
	// Keep auto-nagviation activated
	Call Plugin.Window.Active(Hwnd0)
	Delay 300
	Call Plugin.Bkgnd.KeyPress(Hwnd0, 121)//F10
	Delay 300
	Call Plugin.Bkgnd.KeyPress(Hwnd0, 83)//S
	Delay 300
	Call Plugin.Bkgnd.KeyPress(Hwnd0, 80)//R

	Delay 300
	Call Plugin.Bkgnd.KeyPress(Hwnd0, 121)//F10
	Delay 300
	Call Plugin.Bkgnd.KeyPress(Hwnd0, 83)//S
	Delay 300
	Call Plugin.Bkgnd.KeyPress(Hwnd0, 82)//R
	Delay 500

TracePrint "Epoch finish"
Wend

Sub UPDATE_PLAYER_STATE
	Player1_state_value = Int(Plugin.Memory.Read8Bit(Hwnd1, state_add))
	Player2_state_value = Int(Plugin.Memory.Read8Bit(Hwnd2, state_add))
	Player3_state_value = Int(Plugin.Memory.Read8Bit(Hwnd3, state_add))
	Player4_state_value = Int(Plugin.Memory.Read8Bit(Hwnd4, state_add))
End Sub
