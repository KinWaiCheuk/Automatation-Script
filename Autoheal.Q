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
MacroID=bf63f486-513c-4ddd-b3e7-9e02069722dc
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

hwnd0 = 198432
hwnd1 = 13762808
hwnd2 = 27791202
hwnd3 = 132956
hwnd4 = 10818044
ehwnd = 134132

sick_state = 2
sick_state_2 = 1
mouse_state = 8
fire_state = 16


// Loading memory for food exchange
Water_add = &H0111FF5A
Food_add = &H0111FF5C

Dim PlayerID(3)
PlayerID(0) = 6031955
PlayerID(1) = 6033147
PlayerID(2) = 6034843
PlayerID(3) = 6221865

Dim PlayerHWND(3)
PlayerHWND(0) = hwnd1
PlayerHWND (1) = hwnd2
PlayerHWND (2) = hwnd3
PlayerHWND(3) = hwnd4

//Call Plugin.Window.Move(Hwnd1, 100, 100)

state_add = &H0111FEA4
Water_add = &H0111FF5A
Food_add = &H0111FF5C
TargetID_add = &H0111AEA4

//Goto Sail

Call Supply(DX1,DY1,hwnd1) 
Call Supply(DX2, DY2, hwnd2)
Call Supply(DX3, DY3, hwnd3)
Call Supply(DX4, DY4, hwnd4)
//
// Player 1 sail out
Call SailOut
Delay 3000

Call Plugin.Bkgnd.KeyPress(hwnd1, 121)
Delay 1000
Call Plugin.Bkgnd.KeyPress(hwnd1, 113)

// Beginning of autosail
Rem Sail
cond = Check_Arrival(DX1, DY1)
counter = 0
While cond(0) = - 1  or cond(1) = - 1  or cond(2) = - 1 
    TracePrint counter
    Autoheal 
    cond = Check_Arrival(DX1, DY1)

	Call Dist_Resources
	
    If counter = 120 Then 
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
    Delay 1000
    counter = counter+1
Wend


Function Check_Arrival(DX1, DY1)
    Dim cond(3)
    color1 = Plugin.BkgndColor.GetPixelColor(hwnd1,629,330)
    color2 = Plugin.BkgndColor.GetPixelColor(hwnd1, 641, 332)
    color3 = Plugin.BkgndColor.GetPixelColor(hwnd1, 654, 334)
	
    If Hex(color1) = "FFFFFF" Then 
        TracePrint "True!!"
        cond(0) = 0
    Else 
        cond(0) = -1
    End If

    If Hex(color2) = "FFFFFF" Then 
        cond(1) = 0
    Else 
        cond(1) = -1
    End If

    If Hex(color3) = "FFFFFF" Then 
        cond(2) = 0
    Else 
        cond(2) = -1
    End If

	
	
    //	IfColor DX1 + 629, DY1 + 330, "ffffff", 0 Then
    //		TracePrint "True!!"
    //		cond(0) = 0
    //	Else
    //		cond(0) = -1
    //	End If
    //	
    //	IfColor DX1 + 641, DY1 + 332, "ffffff", 0 Then
    //		cond(1) = 0
    //	Else
    //		cond(1) = -1
    //	End If
    //	
    //	IfColor DX1 + 654, DY1 + 334, "ffffff", 0 Then
    //	
    //		cond(2) = 0
    //	Else
    //		cond(2) = -1 
    //	End If
		
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
	
    If Player1_state_value=sick_state_2 or Player2_state_value=sick_state_2 or Player3_state_value=sick_state_2 or Player4_state_value=sick_state_2
        TracePrint "Someone is sick_state_2"
	
        Call Plugin.Bkgnd.KeyPress(hwnd2, 121)//Press F10 	
        // Mutliple heal if more than 1 player is sick
        While Player1_state_value=sick_state_2 or Player2_state_value=sick_state_2 or Player3_state_value=sick_state_2 or Player4_state_value=sick_state_2
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


Function UPDATE_PLAYER_16Bit(address)
    Dim player_array(3)
    player_array(0) = Int(Plugin.Memory.Read16Bit(hwnd1, address))
    player_array(1) = Int(Plugin.Memory.Read16Bit(hwnd2, address))
    player_array(2) = Int(Plugin.Memory.Read16Bit(hwnd3, address))
    player_array(3) = Int(Plugin.Memory.Read16Bit(hwnd4, address))
	
    UPDATE_PLAYER_16Bit = player_array
End Function


Sub Supply(DX,DY, hwnd)
	Call BringWinOnTop(hwnd)
	//Call Move_Click_v2(hwnd, 682, 360)// Supply button
	Call Plugin.Bkgnd.LeftClick(hwnd, 682, 360)
	
	Delay 800 // Wait for supply meun to pop up	
	//Call Move_Click_v2(hwnd, 194, 360)// Supply to saved value
	Call Plugin.Bkgnd.LeftClick(hwnd, 194, 360)
	
	Delay 300
	//Call Move_Click_v2(hwnd, 597, 404)// Click confirm button
	Call Plugin.Bkgnd.LeftClick(hwnd, 597, 404)
	// Need to becareful for this step, if it is full, the button is not clickable
	
End Sub

Sub SailOut
	Call BringWinOnTop(hwnd1)
	Call Plugin.Bkgnd.KeyPress(hwnd1, 27)
	//Call Move_Click_v2(hwnd1, 640, 360)
	Call Plugin.Bkgnd.LeftClick(hwnd1, 640, 360)
	Delay 1000
	
	//Call Move_Click_v2(hwnd1, 549, 398)
	Call Plugin.Bkgnd.LeftClick(hwnd1, 549, 398)
	Delay 500
End Sub


// Functions for food exchange
Function MAX(array)
    Dim output(1)
    largest = 0
    If array(0) > largest Then 
        largest = array(0)
        arg_max = 0
    End If
    If array(1) > largest Then 
        largest = array(1)
        arg_max = 1
    End If
    If array(2) > largest Then 
        largest = array(2)
        arg_max = 2
    End If
    If array(3) > largest Then 
        largest = array(3)
        arg_max = 3
    End If
		
    output(0) = largest
    output(1) = arg_max
	
    MAX = output
End Function




Function MIN(array)
    Dim output(1)
    smallest = array(0)
    arg_min = 0
    If array(1) < smallest Then 
        smallest = array(1)
        arg_min = 1
    End If
    If array(2) < smallest Then 
        smallest = array(2)
        arg_min = 2
    End If
    If array(3) < smallest Then 
        smallest = array(3)
        arg_min = 3
    End If
    output(0) = smallest
    output(1) = arg_min
	
    MIN = output
End Function


Sub Dist_WATER
    Call FindLow_Player(PlayerHWND(WATER_MAX(1)), PlayerID(WATER_MIN(1)))
    Call TradeWater
End Sub

Sub Dist_FOOD
    Call FindLow_Player(PlayerHWND(FOOD_MAX(1)), PlayerID(FOOD_MIN(1)))
    Call TradeFood
End Sub


Sub TradeWater
    Delay 1000
    Call Plugin.Bkgnd.LeftClick(PlayerHWND(WATER_MAX(1)), 647, 410)// Invite Trade
    Delay 1000
    Call Plugin.Bkgnd.LeftClick(PlayerHWND(WATER_MIN(1)), 520, 21)// Accept Trade
    Call Plugin.Bkgnd.KeyPress(PlayerHWND(WATER_MIN(1)), 13)
	
    Delay 1000
    // Click Water
    Call Move_Click_v2(PlayerHWND(WATER_MAX(1)), 170, 174)
    Delay 500
    Call Plugin.Bkgnd.KeyPress(PlayerHWND(WATER_MAX(1)), 101)
    Call Plugin.Bkgnd.KeyPress(PlayerHWND(WATER_MAX(1)), 96)
    Call Plugin.Bkgnd.KeyPress(PlayerHWND(WATER_MAX(1)), 13)
	
    Call Plugin.Bkgnd.LeftClick(PlayerHWND(WATER_MAX(1)), 579, 426)// Max Confirm
    Delay 800
    Call Plugin.Bkgnd.LeftClick(PlayerHWND(WATER_MIN(1)), 579, 426)// Min Confirm
    Delay 800
    Call Plugin.Bkgnd.LeftClick(PlayerHWND(WATER_MAX(1)), 579, 426)// Max Confirm
    Delay 800
    Call Plugin.Bkgnd.LeftClick(PlayerHWND(WATER_MIN(1)), 579, 426)// Min Confirm
    Delay 800		
End Sub

Sub TradeFood
    Delay 1000
    Call Plugin.Bkgnd.LeftClick(PlayerHWND(FOOD_MAX(1)), 647, 410)// Invite Trade
    Delay 1000
    Call Plugin.Bkgnd.LeftClick(PlayerHWND(FOOD_MIN(1)), 520, 21)// Accept Trade
    Call Plugin.Bkgnd.KeyPress(PlayerHWND(FOOD_MIN(1)), 13)
	
    Delay 1000
	
    // Click Food
    Call Move_Click_v2(PlayerHWND(FOOD_MAX(1)), 220, 174)
    Delay 500
    Call Plugin.Bkgnd.KeyPress(PlayerHWND(FOOD_MAX(1)), 101)
    Call Plugin.Bkgnd.KeyPress(PlayerHWND(FOOD_MAX(1)), 96)
    Call Plugin.Bkgnd.KeyPress(PlayerHWND(FOOD_MAX(1)), 13)
	
    Call Plugin.Bkgnd.LeftClick(PlayerHWND(FOOD_MAX(1)), 579, 426)// Max Confirm
    Delay 800
    Call Plugin.Bkgnd.LeftClick(PlayerHWND(FOOD_MIN(1)), 579, 426)// Min Confirm
    Delay 800
    Call Plugin.Bkgnd.LeftClick(PlayerHWND(FOOD_MAX(1)), 579, 426)// Max Confirm
    Delay 800
    Call Plugin.Bkgnd.LeftClick(PlayerHWND(FOOD_MIN(1)), 579, 426)// Min Confirm
    Delay 800	
End Sub

Sub FindLow_Player(hwnd, target_ID)
	For 4 // This loop is for rotating 90deg for 3 times
    	BringWinOnTop(hwnd)
    	For 5
        	KeyPress 9, 1
        	TargetID = Int(Plugin.Memory.Read32Bit(hwnd, TargetID_add))
        	TracePrint "Finding Low Food Player"
        	TracePrint TargetID

        	TracePrint target_ID
        	Delay 100
        	If TargetID = target_ID Then 
            	Goto Found
        	End If
        Next
    	KeyPress 13,1
    	Delay 500
    	KeyDown 17,1
    	KeyDown 39,1
    	Delay 1500
    	KeyUp 39,1
    	KeyUp 17,1
    	Delay 500
    	
    Next
    Rem Found
    KeyPress 13, 1//Talk
End Sub

Sub Dist_Resources
	WATER = UPDATE_PLAYER_16Bit(Water_add)
	FOOD = UPDATE_PLAYER_16Bit(Food_add)
	WATER_MAX = MAX(WATER)
	WATER_MIN = MIN(WATER)
	FOOD_MAX = MAX(FOOD)
	FOOD_MIN = MIN(FOOD)
	TracePrint "Food num = "
	TracePrint FOOD_MIN(0)
	
	TracePrint "Water Num = "
	TracePrint WATER_MIN(0)
	
	If FOOD_MAX(0) > 80 Then
    	If FOOD_MIN(0) < 20 Then 
        	Call Dist_FOOD
    	End If
		
    	If WATER_MIN(0) < 20 Then 
        	Call Dist_WATER
    	End If
    End If
End Sub


Sub Move_Click_v2(hwnd, X, Y)
    s = Plugin.Window.GetClientRect(hwnd)
    MyArray = Split(s, "|", -1, 1)
    DX = MyArray(0)
    DY = MyArray(1)
	
    MoveTo DX + X, DY + Y//Move to supply button
    Delay 250
    LeftClick 1
End Sub

