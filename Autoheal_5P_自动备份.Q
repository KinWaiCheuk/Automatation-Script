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
MacroID=8c519e09-eaf4-49eb-bcf8-875bc1e0a948
Description=Autoheal_5P_�Զ�����
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
// -----------Parameters
hwnd0 = 262952
hwnd1 = 328680
hwnd2 = 197548
hwnd3 = 263098
hwnd4 = 330568
hwnd5 = 592636
ehwnd = 330482

num_players = 5

watchdog = hwnd1
healer = hwnd2
// ----------End of Parameters


sick_state = 2
sick_state_2 = 1
mouse_state = 8
fire_state = 16
sinking = 64
rebel_state = 4
fight_state = 64

// Loading memory for food exchange
Water_add = &H0111FF5A
Food_add = &H0111FF5C

Dim PlayerID(4)
PlayerID(0) = 6031955
PlayerID(1) = 6033147
PlayerID(2) = 6034843
PlayerID(3) = 6221865
PlayerID(4) = 12789283


Dim PlayerHWND(4)
PlayerHWND(0) = hwnd1
PlayerHWND (1) = hwnd2
PlayerHWND (2) = hwnd3
PlayerHWND(3) = hwnd4
PlayerHWND(4) = hwnd5

Dim player_state_value(4)

state_add = &H0111FEA4
satate_add_2 = &H0111FEA6
Water_add = &H0111FF5A
Food_add = &H0111FF5C
TargetID_add = &H0111AEA4

// Test Area

// End of Test Area


// Supplying Food
For i = 0 To (num_players - 1)
	If i = 0 Then 
		Call Supply(PlayerHWND(i), "saved")
	Else Call Supply(PlayerHWND(i), "max")
	End If
		
	
Next

// Player 1 sail out
Call SailOut
Delay 3000

// Activating skills
Call Plugin.Bkgnd.KeyPress(watchdog, 121)
Delay 1000
Call Plugin.Bkgnd.KeyPress(watchdog, 113)


cond = Check_Arrival
loopcounter = 0
While cond(0) = - 1  or cond(1) = - 1  or cond(2) = - 1  or cond(3) = - 1 
    TracePrint loopcounter
    Autohealv3 
    cond = Check_Arrival
	If loopcounter = 30 or loopcounter = 60 Then 
		TracePrint "Checking Food"
		Call Dist_Resources	
	End If
	
	
    If loopcounter = 120 Then 
    	TracePrint "Checking Food"
    	Call Dist_Resources	
        Call Refresh_Nav
        Call BringWinOnTop(hwnd1)
        // Keep player 2,3,4 active
        //Call Plugin.Bkgnd.KeyPress(hwnd2, 121)//Press F10 
        //Call Plugin.Bkgnd.KeyPress(hwnd2, 121)//Press F10
		
        Call Plugin.Bkgnd.KeyPress(hwnd3, 121)//Press F10 
        Call Plugin.Bkgnd.KeyPress(hwnd3, 121)//Press F10	
		
        Call Plugin.Bkgnd.KeyPress(hwnd4, 121)//Press F10 
        Call Plugin.Bkgnd.KeyPress(hwnd4, 121)//Press F10
        
        Call Plugin.Bkgnd.KeyPress(hwnd5, 121)//Press F10 
        Call Plugin.Bkgnd.KeyPress(hwnd5, 121)//Press F10
        loopcounter = 0
		
    End If
    Delay 1000
    loopcounter = loopcounter+1
Wend
Call SendAlert("Arrived")



Function Check_Arrival
    Dim cond(3)
    color1 = Plugin.BkgndColor.GetPixelColor(hwnd1,629,330)
    color2 = Plugin.BkgndColor.GetPixelColor(hwnd1, 641, 332)
    color3 = Plugin.BkgndColor.GetPixelColor(hwnd1, 654, 334)
    color4 = Plugin.BkgndColor.GetPixelColor(hwnd1, 648, 364)
	
    If Hex(color1) = "FFFFFF" Then 
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
    
    If color4 = "1586034" Then 
        TracePrint "True!!"
    	cond(3) = 0
    Else 
    	cond(3) = -1
    End If
		
    Check_Arrival = cond
End Function


Sub UPDATE_PLAYER_STATE(state_add)
	For i = 0 To (num_players - 1)
		player_state_value(i) = Int(Plugin.Memory.Read8Bit(PlayerHWND(i), state_add))
		// TracePrint player_state_value(i)
	Next
//    Player1_state_value = Int(Plugin.Memory.Read8Bit(hwnd1, state_add))
//    Player2_state_value = Int(Plugin.Memory.Read8Bit(hwnd2, state_add))
//    Player3_state_value = Int(Plugin.Memory.Read8Bit(hwnd3, state_add))
//    Player4_state_value = Int(Plugin.Memory.Read8Bit(hwnd4, state_add))
//    Player5_state_value = Int(Plugin.Memory.Read8Bit(hwnd5, state_add))
End Sub



Sub Autohealv3
	// Check if anyone is sick
	Call UPDATE_PLAYER_STATE(state_add)
	counter = 0
	For i = 0 To num_players - 1
		If player_state_value(i) = sick_state or player_state_value(i) = sick_state_2 Then 
			counter = counter + 1
		End If
		
	Next
	If counter > 0 Then 
		Call Plugin.Bkgnd.KeyPress(healer, 121)//Press F10 		
		For j = 0 To counter*4
    		// Mutliple heal if more than 1 player is sick
    		Delay 500
    		Call Plugin.Bkgnd.KeyPress(healer, 114)//Press F3
		Next
		Call Plugin.Bkgnd.KeyPress(healer, 121) //Press F10 again to cancael meun	
		// End checking sick	
//		TracePrint "Someone is sick"
//		Call sendAlert("Someone is sick")	
	End If

	
	
	// Check if anyone has mouse
	Call UPDATE_PLAYER_STATE(state_add)
	counter = 0		
	For i = 0 To num_players - 1
		If player_state_value(i) = mouse_state Then 
			counter = counter + 1
		End If		
	Next
	
	If counter > 0 Then 
		Call Plugin.Bkgnd.KeyPress(healer, 121)//Press F10 		
		For j = 0 To counter*4
    		// Mutliple heal if more than 1 player is sick
        	Delay 500
    		Call Plugin.Bkgnd.KeyPress(healer, 113)//Press F2
		Next
		Call Plugin.Bkgnd.KeyPress(healer, 121)//Press F10 again to cancael meun		
//		TracePrint "Someone has mouse"
//		Call sendAlert("Someone has mouse")
	End If
	
	// No one has mouse
	
	
	
	// Check if anyone is on fire
	Call UPDATE_PLAYER_STATE(state_add)
	counter = 0
	For i = 0 To num_players - 1
		If player_state_value(i) = fire_state Then 
			counter = counter +1
		End If	
	Next

	If counter > 0 Then 
		Call Plugin.Bkgnd.KeyPress(healer, 121)//Press F10 	
		For j = 0 To counter * 4
        	Delay 500
    		Call Plugin.Bkgnd.KeyPress(healer, 116)//Press F5		
		Next
		Call Plugin.Bkgnd.KeyPress(healer, 121) //Press F10 again to cancael meun	
//		TracePrint "Someone is on fire"
//		Call sendAlert("Someone is on fire")
	End If

	Call UPDATE_PLAYER_STATE(state_add)
	counter = 0
	For i = 0 To num_players - 1
		If player_state_value(i) = rebel_state Then 
			TracePrint player_state_value(i)
			counter = counter +1
		End If	
	Next

	If counter > 0 Then 
		Call Plugin.Bkgnd.KeyPress(healer, 121)//Press F10 	
		For j = 0 To counter * 4
        	Delay 500
    		Call Plugin.Bkgnd.KeyPress(healer, 115)//Press F4		
		Next
		Call Plugin.Bkgnd.KeyPress(healer, 121) //Press F10 again to cancael meun	
//		TracePrint "Someone is rebelling"
//		Call sendAlert("Someone is rebelling")		
	End If	
		
	
	Call UPDATE_PLAYER_STATE(state_add_2)
//	TracePrint player_state_value(0)
//	TracePrint player_state_value(1)
//	TracePrint player_state_value(2)
//	TracePrint player_state_value(3)
//	TracePrint player_state_value(4)
	counter = 0
	For i = 0 To num_players - 1
		If player_state_value(i) = fight_state or player_state_value(i) = rebel_state Then 
			TracePrint player_state_value(i)
			counter = counter +1
		End If	
	Next

	If counter > 0 Then 
		Call Plugin.Bkgnd.KeyPress(healer, 121)//Press F10 	
		For j = 0 To counter * 4
        	Delay 500
    		Call Plugin.Bkgnd.KeyPress(healer, 115)//Press F4		
		Next
		Call Plugin.Bkgnd.KeyPress(healer, 121) //Press F10 again to cancael meun	
//		TracePrint "Someone is fighting"
//		Call sendAlert("Someone is fighting")		
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
    Dim player_array(4)
    
    For i = 0 To (num_players - 1)
		player_array(i) = Int(Plugin.Memory.Read16Bit(PlayerHWND(i), address))
	Next
    
    
//    player_array(0) = Int(Plugin.Memory.Read16Bit(hwnd1, address))
//    player_array(1) = Int(Plugin.Memory.Read16Bit(hwnd2, address))
//    player_array(2) = Int(Plugin.Memory.Read16Bit(hwnd3, address))
//    player_array(3) = Int(Plugin.Memory.Read16Bit(hwnd4, address))
//    player_array(4) = Int(Plugin.Memory.Read16Bit(hwnd5, address))
	
    UPDATE_PLAYER_16Bit = player_array
End Function


Sub Supply(hwnd, mode)
	Call BringWinOnTop(hwnd)
	//Call Move_Click_v2(hwnd, 682, 360)// Supply button
	Call Plugin.Bkgnd.LeftClick(hwnd, 682, 360)
	
	Delay 800// Wait for supply meun to pop up	
	
	If mode = "saved" Then 
		Call Plugin.Bkgnd.LeftClick(hwnd, 194, 360)// Supply to saved value
	ElseIf mode = "max" Then 
		Call Plugin.Bkgnd.LeftClick(hwnd, 308, 363)// Supply to max
	Else 
		TracePrint "Invalid mode"
	End If
	
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
    
    If array(4) > largest Then 
    	largest = array(4)
    	arg_max = 4
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
    
    If array(4) < smallest Then 
        smallest = array(4)
        arg_min = 4
    End If
    output(0) = smallest
    output(1) = arg_min
	
    MIN = output
End Function


Sub Dist_WATER
    Call FindLow_Player(PlayerHWND(WATER_MAX(1)), PlayerID(WATER_MIN(1)))
    Delay 500
    Call TradeWater
End Sub

Sub Dist_FOOD
    Call FindLow_Player(PlayerHWND(FOOD_MAX(1)), PlayerID(FOOD_MIN(1)))
    Delay 500
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
	For 10 // This loop is for rotating 90deg for 3 times
    	BringWinOnTop (hwnd)
    	Delay 200 
    	For 10
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
	
	If FOOD_MAX(0) > 80 Then
    	If FOOD_MIN(0) < 20 Then 
        	Call Dist_FOOD
    	End If
	End If
	
	If WATER_MAX(0) > 80 Then
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

Sub reconnect
	Call UPDATE_PLAYER_OL_STATE(OLstatus1_add)
	If Player1_ol_value = 0 Then 
		SendAlert("Player1 reconnected")
		Call Login(hwnd1, 0)
		TracePrint "Player1 reconnected"
		Delay 500
		StartNavi
	End If
	
	Call UPDATE_PLAYER_OL_STATE(OLstatus1_add)
	If Player2_ol_value = 0 Then 
		SendAlert( "Player2,3,4,5 reconnected")
		Call Login(hwnd2, 1)
		TracePrint "Player2,3,4,5 reconnected"
		Delay 500
		StartNavi
	End If
	
	Call UPDATE_PLAYER_OL_STATE(OLstatus1_add)
	If  Player3_ol_value = 0 Then 
		SendAlert( "Player2,3,4,5 reconnected")
		Call Login(hwnd3, 1)
		TracePrint "Player2,3,4,5 reconnected"
		Delay 500
		StartNavi
	End If
	
	Call UPDATE_PLAYER_OL_STATE(OLstatus1_add)
	If  Player4_ol_value = 0 Then 
		SendAlert( "Player2,3,4,5 reconnected")
		Call Login(hwnd4, 1)
		TracePrint "Player2,3,4,5 reconnected"
		Delay 500
		StartNavi
	End If		

	Call UPDATE_PLAYER_OL_STATE(OLstatus1_add)
	If  Player5_ol_value = 0 Then 
		SendAlert( "Player2,3,4,5 reconnected")
		Call Login(hwnd5, 1)
		TracePrint "Player2,3,4,5 reconnected"
		Delay 500
		StartNavi
	End If		

End Sub

Sub UPDATE_PLAYER_OL_STATE(state_add)
	Player1_ol_value = Int(Plugin.Memory.Read32Bit(hwnd1, state_add))
	Player2_ol_value = Int(Plugin.Memory.Read32Bit(hwnd2, state_add))
	Player3_ol_value = Int(Plugin.Memory.Read32Bit(hwnd3, state_add))
	Player4_ol_value = Int(Plugin.Memory.Read32Bit(hwnd4, state_add))
	Player5_ol_value = Int(Plugin.Memory.Read32Bit(hwnd5, state_add))
End Sub

Sub CheckOnline_onsea
	Call UPDATE_PLAYER_OL_STATE(OLstatus1_add)
	If Player1_ol_value = 0 or Player2_ol_value = 0 or Player3_ol_value = 0 or Player4_ol_value = 0 or Player5_ol_value = 0 Then
		Call reconnect
		Call UPDATE_PLAYER_OL_STATE(OLstatus1_add)
		
	End If
	
End Sub

Sub SendAlert(str)
	//BringWinOnTop (ehwnd)
	//Call Move_Click(DXe, DYe, 74, 222)// Create a new email
	Call Plugin.Bkgnd.LeftClick(ehwnd, 455, 884)
	Delay 500
	Call Plugin.Bkgnd.SendString(ehwnd, str)
	Call Plugin.Bkgnd.KeyPress(ehwnd, 13) // Send Message

	//MoveTo DXe + 469, DYe + 1003
	//LeftClick 1
	//ExitScript
End Sub

Sub Login(hwnd, pass)
	Call Plugin.Bkgnd.KeyPress(hwnd, 13) // Confirm disconnect
	Delay 300
	Call Plugin.Bkgnd.KeyPress(hwnd, 13) // Confirm replay
	Delay 4000
	Call Plugin.Bkgnd.KeyPress(hwnd, 13) // Start login page
	Delay 500	
	Call Plugin.Bkgnd.LeftClick(hwnd, 401, 375)
	Delay 4000
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