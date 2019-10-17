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
MacroID=7c44ff3a-eefc-4c56-a998-e9aec6d464a7
Description=BuyRawFibers_自动备份
Enable=1
AutoRun=0
[Repeat]
Type=0
Number=400
[SetupUI]
Type=2
QUI=
[Relative]
SetupOCXFile=
[Comment]

[Script]
// Loading Memory
Dim DX1, DX2, DX3, DX4, DY1, DY2, DY3, DY4
hwnd0 = 10423212
hwnd1 = 66352
hwnd2 = 134600
hwnd3 = 134628
hwnd4 = 134644
ehwnd = 68610

TraderID_A = 25167514
PorterID_A = 25167515

TraderID_B = 25167208
PorterID_B = 25167207

sick_state = 2
sick_state_2 = 1
mouse_state = 8
fire_state = 16


// Loading memory for food exchange
Water_add = &H0111FF5A
Food_add = &H0111FF5C
Day_add = &H011240E4

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
// -------------------------


//--------Test-------------------
//--------End of Test-------------

// ------- Start of Prog----------
cond = Check_Arrival(DX1, DY1)
While cond(0) = - 1  or cond(1) = - 1  or cond(2) = - 1 
    cond = Check_Arrival(DX1, DY1)
    Call CheckOnline_onsea(moveDirection)
    exist = Check_Windows_Exist(hwnd0)
    day_num = Int(Plugin.Memory.Read32Bit(hwnd1, Day_add))
    
	If day_num > 3 or Check_Windows_Alive(hwnd0) = -1 or exist=0 Then 
		SendAlert ("It get sucked on sea")
		Call StopNavi
		Call Move_Click_v2(hwnd1,782,585)
		Call Disconnect(hwnd1)
		
		Call ExitScript
	End If

    counter = counter + 1
    Delay 1000
Wend

Delay 2500
Call EnterPort_LA(TraderID_A, 470,154)
Delay 800


Call SupplyMP(hwnd1, 440, 158)
Delay 3000

Call Leaving(hwnd1, 416, 234, PorterID_A)
Delay 4000



TracePrint Cstr(Time) + " Going to B"

Call Supply(DX1, DY1, hwnd1)
// Call Supply(DX2, DY2, hwnd2)
Delay 1500
Call SailOut
Delay 5500
Call Choose_Navi_Path("To_RawFiber_B")
moveDirection = "B"
Call StartNavi
Delay 1000
Activate_Skill(hwnd1)


cond = Check_Arrival(DX1, DY1)
counter = 0
While cond(0) = - 1  or cond(1) = - 1  or cond(2) = - 1 
	cond = Check_Arrival(DX1, DY1)
	Call CheckOnline_onsea(moveDirection)
	Check_Windows_Exist(hwnd0)
	day_num = Plugin.Memory.Read32Bit(hwnd1, Day_add)
	
	If day_num > 3 or Check_Windows_Alive(hwnd0) = - 1  Then 
	
		SendAlert ("It get sucked on sea")
		Call StopNavi
		Call Move_Click_v2(hwnd1,782,585)
		Call Disconnect(hwnd1)
		
		Call ExitScript
	End If	
	
//	If counter = 10 Then 
//		Delay 1000
//		// Produce_FOOD (hwnd)
//		Call SupplyMP(hwnd1)
//	End If
	
	If counter = 250 Then 
		SendAlert("Stuck inside city")
	End If
	counter = counter + 1
	Delay 1000
Wend

Call EnterPort_LB(TraderID_B, 583,159)
Delay 800


Call Leaving(hwnd1, 532, 251, PorterID_B)
Delay 4000


Call Supply(DX1, DY1, hwnd1)
Delay 2000
Call SailOut
Delay 1500
TracePrint Cstr(Time) + " Going back to A"
moveDirection = "A"
Call Choose_Navi_Path("To_RawFiber_A")
Call StartNavi
Activate_Skill(hwnd1)
//Call reconnect



// ---------------End of Prog


Sub EnterPort_LA(TraderID, X, Y)
    BringWinOnTop (hwnd1)
    Delay 500
    Call Plugin.Bkgnd.LeftClick(hwnd1, 647, 383) //Click Enter

    Delay 1900
    For 10
        IfColor DX1+641,DY1+385,"000000)",0 Then
            Delay 1000
        Else    
            Goto Loaded_City
        End If
    Next
	
    Rem Loaded_City
    Delay 2500
    Call OpenMap
    Delay 800
    //Call Move_Click(DX1, DY1, 511, 172) // Click port near trader
    Call Plugin.Bkgnd.LeftClick(hwnd1, X, Y)
    Delay 8600
	
    Call TradingA(DX1, DY1, hwnd1, TraderID)
    MoveTo DX1+ 361, DY1 + 100
    Delay 2000
//    RightClick 1
//    Delay 800
//    RightClick 1
//    KeyDown "Up", 1
//    Delay 800
//    KeyUp "Up", 1
    


End Sub

Sub EnterPort_LB(TraderID, X, Y)
    BringWinOnTop (hwnd1)
    Delay 1000
    Call Plugin.Bkgnd.LeftClick(hwnd1, 647, 389) //Click Enter

    Delay 1900
    For 10
        IfColor DX1+641,DY1+385,"000000)",0 Then
            Delay 1000
        Else    
            Goto Loaded_City
        End If
    Next
	
    Rem Loaded_City
    Delay 2500
    Call OpenMap
    Delay 800
    //Call Move_Click(DX1, DY1, 511, 172) // Click port near trader
    Call Plugin.Bkgnd.LeftClick(hwnd1, X, Y)
    Delay 12600
	
    Call TradingB(DX1, DY1, hwnd1, TraderID)
    MoveTo DX1+ 361, DY1 + 100
    Delay 1000
//    RightClick 1
//    Delay 800
//    RightClick 1
//    KeyDown "Up", 1
//    Delay 800
//    KeyUp "Up", 1
    


End Sub

Sub BringWinOnTop(hwnd)
    Call Plugin.Window.Active(hwnd)
    Call Plugin.Window.Restore(hwnd)
End Sub

Sub OpenMap
    Call Plugin.Bkgnd.KeyPress(hwnd1, 112)
End Sub

Sub TradingA(DX, DY, hwnd, TraderID)
    Call FindTrader(hwnd, TraderID)
    TracePrint "Item bought" 
    Delay 800
    Call BuyCast(DX, DY, hwnd)
    Delay 800
	
	// Call Plugin.Bkgnd.KeyPress(hwnd, 121) // Cancel Skill

End Sub

Sub TradingB(DX, DY, hwnd, TraderID)
	Call FindTrader(hwnd1, TraderID)
	Delay 1500
	Call Sell_Extra(hwnd)
	TracePrint "Item sold"
	Delay 800
	// Call Plugin.Bkgnd.KeyPress(hwnd, 121) // Cancel Skill
End Sub

Sub FindTrader(hwnd, target_ID)
	TargetID = Int(Plugin.Memory.Read32Bit(hwnd, TargetID_add))
	If TargetID = target_ID Then 
        Goto Found
    End If
    KeyDown "Esc", 1

    For 10// This loop is for rotating 90deg for 3 times
    
        BringWinOnTop(hwnd)
        For 12
            KeyPress 9, 1
            TargetID = Int(Plugin.Memory.Read32Bit(hwnd, TargetID_add))
            Delay 100
            If TargetID = target_ID Then 
                Goto Found
            End If
//            TracePrint "TargetID " + Cstr(TargetID)
//            TracePrint "target_ID " + Cstr(target_ID)
        Next
        SendAlert("Cannot find the target")
        Delay 500
        KeyDown 17,1
        KeyDown 39,1
        Delay 1500
        KeyUp 39,1
        KeyUp 17,1
        Delay 500
    	
    Next
    Rem Found
    TracePrint "Found" + Cstr(TargetID)
    KeyUp "Esc", 1
	Delay 200  
    KeyPress "Enter", 1 // Enter

End Sub

Sub BuyCast(DX, DY, hwnd)
    Call BringWinOnTop(hwnd)
    Call Plugin.Bkgnd.LeftClick(hwnd, 640, 357) // Option = Buy
	' 1st -> 125
	' 2nd -> 190
	' 3rd -> 255
	' 4th -> 300

    Delay 2500
	
	
    // Wheel down
    Call Bk_WheelDown(hwnd, 343,321, 4)
  	
	
    Call Move_Click_v2(hwnd, 165, 125)// Buy the 2st target product
    Delay 200
    Call Plugin.Bkgnd.KeyPress(hwnd, 107)
    Delay 200
    Call Plugin.Bkgnd.KeyPress(hwnd, 13)
    Delay 300
    
    Call Move_Click_v2(hwnd, 165, 190)// Buy the 3st target product
    Delay 200
    Call Plugin.Bkgnd.KeyPress(hwnd, 107)
    Delay 200
    Call Plugin.Bkgnd.KeyPress(hwnd, 13)
    Delay 300

    Call Move_Click_v2(hwnd, 165, 225)// Buy the 4st target product
    Delay 200
    Call Plugin.Bkgnd.KeyPress(hwnd, 107)
    Delay 200
    Call Plugin.Bkgnd.KeyPress(hwnd, 13)
    Delay 300
    
    Call Move_Click_v2(hwnd, 165, 300)// Buy the 4st target product
    Delay 200
    Call Plugin.Bkgnd.KeyPress(hwnd, 107)
    Delay 200
    Call Plugin.Bkgnd.KeyPress(hwnd, 13)
    Delay 300	
	
    Call Plugin.Bkgnd.LeftClick(hwnd, 428, 304)// Bargain
    Delay 1000
    Call Plugin.Bkgnd.LeftClick(hwnd, 647, 423)// Confirm	
    Delay 400

	
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


Sub Produce_FOOD(hwnd)
	Call Plugin.Bkgnd.KeyPress(hwnd, 121)

	// Convert wheat to powder
	Delay 1000
	Call Plugin.Bkgnd.KeyPress(hwnd, 115)// Open book
	Delay 1350
	Call Plugin.Bkgnd.KeyPress(hwnd, 13) // Enter
	Delay 1000
	
	Call Plugin.Bkgnd.LeftClick(hwnd, 457, 374) // Click Production
	Delay 1000
	Call Plugin.Bkgnd.KeyPress(hwnd, 107) // Produce MAX
	Delay 200
	Call Plugin.Bkgnd.KeyPress(hwnd, 13) // Enter
	Delay 200
	Call Plugin.Bkgnd.KeyPress(hwnd, 13)// Removing Prompt
	Delay 200
	Call Plugin.Bkgnd.KeyPress(hwnd, 13)// Removing Prompt
	Delay 200
	
	TracePrint "First Esc"
	Call Plugin.Bkgnd.KeyPress(hwnd, 27)// Exit Meun
	Delay 1000
	TracePrint "Second Esc"
	Call Plugin.Bkgnd.KeyPress(hwnd, 27)// Exit Meun
	Delay 1000
	TracePrint "Third Esc"
	Call Plugin.Bkgnd.KeyPress(hwnd, 27)// Exit Meun
	Delay 1000
	TracePrint "Fourth Esc"
	Call Plugin.Bkgnd.KeyPress(hwnd, 27) // Exit Meun
End Sub


Sub Produce_Cannon(hwnd)
	// You don't need this one, since you are already on sea with skill activated
	 // Call Plugin.Bkgnd.KeyPress(hwnd, 121)

	// Convert wheat to powder
	Delay 1000
	Call Plugin.Bkgnd.KeyPress(hwnd, 114)// Open book
	Delay 1350
	Call Plugin.Bkgnd.KeyPress(hwnd, 40)
	Call Plugin.Bkgnd.KeyPress(hwnd, 40)
	Call Plugin.Bkgnd.KeyPress(hwnd, 40)
	Call Plugin.Bkgnd.KeyPress(hwnd, 40)
	Call Plugin.Bkgnd.KeyPress(hwnd, 40)
	Call Plugin.Bkgnd.KeyPress(hwnd, 13)
	Delay 1000
	
	Call Plugin.Bkgnd.LeftClick(hwnd, 457, 374) // Click Production
	Delay 1000
	Call Plugin.Bkgnd.KeyPress(hwnd, 107) // Produce MAX
	Delay 200
	Call Plugin.Bkgnd.KeyPress(hwnd, 13)
	Delay 200
	TracePrint "First Esc"
	Call Plugin.Bkgnd.KeyPress(hwnd, 27)// Exit Meun
	Delay 1000
	TracePrint "Second Esc"
	Call Plugin.Bkgnd.KeyPress(hwnd, 27)// Exit Meun
	Delay 1000
	TracePrint "Third Esc"
	Call Plugin.Bkgnd.KeyPress(hwnd, 27)// Exit Meun
	Delay 1000
	TracePrint "Fourth Esc"
	Call Plugin.Bkgnd.KeyPress(hwnd, 27)// Exit Meun
	Delay 1000
	TracePrint "Fifth Esc"
	Call Plugin.Bkgnd.KeyPress(hwnd, 27) // Exit Meun
End Sub


Sub Sell_Extra(hwnd)
	// Sell suplus Food
	Call Plugin.Bkgnd.LeftClick(hwnd, 684, 365)
	Delay 1500
	
//	// Wheel down
//	rubbish = "C:\Users\RavenCheuk\Desktop\HolyNavi_145c\Pictures\Cannon.bmp"
//	XY = Plugin.Bkgnd.FindMultiPicEx(hwnd, 69, 103, 122, 274, rubbish, 0, 0.5)
//	If XY = "-1,-1" Then 
//		TracePrint "Pic not found"
//		Goto Pic_not_found	
//	End If
//	
//	// Breaking X and Y coordinates
//	iZB = InStr(XY, ",")
//	X = CLng(Left(XY, iZB - 1))
//	Y = CLng(Right(XY, Len(XY) - iZB))
	

	Call BringWinOnTop(hwnd)
	Call Plugin.Bkgnd.LeftClick(hwnd, 304, 81) // Click all
	Delay 400
	Call Plugin.Bkgnd.LeftClick(hwnd, 465, 334) // Bargain
	Delay 1000
	Call Plugin.Bkgnd.LeftClick(hwnd, 657, 421)// Confirm
	Delay 400
	TracePrint "Confirm"

End Sub

Sub SupplyMP(hwnd, X, Y)
	MP_val = Plugin.Memory.Read32Bit(hwnd, MP_add)
	TracePrint "MP_val =" + Cstr(MP_val)
//	Call Plugin.Bkgnd.KeyPress(hwnd, 121)
	
	
	While MP_val < 100
		// Convert wheat to powder
//		Delay 500
//		Call Plugin.Bkgnd.KeyPress(hwnd, 112)// Eat Food
		Call EatinBar(X, Y)
		MP_val = Plugin.Memory.Read32Bit(hwnd, MP_add)
        

	Wend	
End Sub

Sub Leaving(hwnd, X, Y, PorterID)
	Call OpenMap
	Delay 800
	// Call Move_Click_v2(hwnd, X, Y)
	Call Plugin.Bkgnd.LeftClick(hwnd, X, Y) // Click the PortOfficer Location
//	TracePrint "Clicked"
	Delay 6000
	Call FindTrader(hwnd, PorterID)
	Delay 2000
	Call Plugin.Bkgnd.LeftClick(hwnd, 646,363)
		
End Sub

Sub Choose_Navi_Path(path)
	BringWinOnTop(hwnd0)
	Call Plugin.Bkgnd.KeyPress(hwnd0, 116)//Press F5
	Delay 500
	SayString path
	KeyPress "Enter", 1
End Sub

Sub StopNavi

	Call Plugin.Window.Active(hwnd0)
	Delay 300
	Call Plugin.Bkgnd.KeyPress(hwnd0, 121)//F10
	Delay 300
	Call Plugin.Bkgnd.KeyPress(hwnd0, 83)//S
	Delay 300
	Call Plugin.Bkgnd.KeyPress(hwnd0, 80)//R
	Delay 500

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
	Delay 500
	
	Call Plugin.Bkgnd.LeftClick(hwnd1, 640, 360) // Select sailout
	Delay 1500
	
	Call Plugin.Bkgnd.LeftClick(hwnd1, 549, 398) // confirm
	Delay 800
End Sub

// Anti offline code 

Sub reconnect
	Call UPDATE_PLAYER_OL_STATE(OLstatus1_add)
	If Player1_ol_value = 0 Then 
		SendAlert("Player disconnected")
		Call Login(hwnd1, 0)
		TracePrint "Player1 reconnected"
	End If
	

End Sub

Sub UPDATE_PLAYER_OL_STATE(state_add)
	Player1_ol_value = Int(Plugin.Memory.Read32Bit(hwnd1, state_add))
End Sub

Sub CheckOnline_onsea(moveDirection)
	Call UPDATE_PLAYER_OL_STATE(OLstatus1_add)
	If Player1_ol_value = 0 Then
		Call reconnect
		Call UPDATE_PLAYER_OL_STATE(OLstatus1_add)
		Delay 1000
		If moveDirection = "A" Then 
			Call Choose_Navi_Path("To_RawFiber_A")
			SendAlert ("Reactivate the destination to A")
			Delay 500
			Call StartNavi
		ElseIf moveDirection = "B" Then
			Call Choose_Navi_Path("To_RawFiber_B")
			SendAlert ("Reactivate the destination to B")
			Delay 500
			Call StartNavi
		End If
		
		
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
	Delay 5000
	Call Plugin.Bkgnd.KeyPress(hwnd, 13) // Select character

End Sub

Sub Activate_Skill(hwnd)
	// F2 = 113
	// F4 = 115
	// F8 = 119
	Call Plugin.Bkgnd.KeyPress(hwnd, 121)
	Delay 1000
	Call Plugin.Bkgnd.KeyPress(hwnd, 113) 
	Call Plugin.Bkgnd.KeyPress(hwnd, 121)
End Sub

Sub Disconnect(hwnd)
	// Stop Ship
	Call Plugin.Bkgnd.LeftClick(hwnd, 781, 580)
		
	Call Plugin.Bkgnd.LeftClick(hwnd, 767, 18)
	Delay 500
	Call Move_Click_v2(hwnd, 732, 135)
	Delay 200
	Call Plugin.Bkgnd.KeyPress(hwnd, 13)

End Sub

Function Check_Windows_Alive(hwnd)
sWindow = Plugin.Window.GetWindowState(hwnd, 6)
If sWindow = -1 Then 
	Check_Windows_Alive = -1// Windows dead
	SendAlert ("Holy Navi is dead")
ElseIf sWindow = 0 Then
	Check_Windows_Alive = 0 // Windows fine
End If
End Function

Function Check_Windows_Exist(hwnd)
	sWindow = Plugin.Window.GetWindowState(hwnd, 0)
	If sWindow = 0 Then 
		Check_Windows_Exist = 0// Windows dead
		SendAlert ("Holy Navi doesn't exist")
	ElseIf sWindow = -1 Then
		Check_Windows_Exist = -1 // Windows fine
	End If
End Function


// -------------------MP Restore
Sub FindBarEntrance(DX,DY,hwnd)
	For 3 // This loop is for rotating 90deg for 3 times
    	Call BringWinOnTop(hwnd)
    	Delay 10
    	For 10
        	KeyPress 9,1
        	Delay 200
        	IfColor DX + 636, DY + 330, "ffffff", 0 Then
//        		TracePrint "Cond1 Pass"
            	IfColor DX + 667, DY + 329, "ffffff", 0 Then
//            		TracePrint "Cond2 Pass"
                	IfColor DX + 683, DY + 330, "ffffff", 0 Then
//                		TracePrint "Cond3 Pass"
                    	IfColor DX + 689, DY + 341, "ffffff", 0 Then
//                    		TracePrint "Cond4 Pass"
                        	IfColor DX + 655, DY + 328, "ffffff", 0 Then
//                        		TracePrint "Cond5 Pass"
                            	IfColor DX + 646, DY + 339, "ffffff", 0 Then
//                            		TracePrint "Cond6 Pass"
                                	IfColor DX + 654, DY + 336, "ffffff", 0 Then
//                                		TracePrint "Cond7 Pass"
                                    	IfColor DX + 635, DY + 339, "ffffff", 0 Then
//                                    		TracePrint "Cond8 Pass"
                                        	Delay 200
                                        	Goto Found
                                    	End if 
                                	End if 
                            	End if 
                        	End if 
                    	End if 
                	End if 
            	End if 
        	End if 
    	Next
    	Delay 500
    	KeyDown 17,1
    	KeyDown 39,1
    	Delay 1500
    	KeyUp 39,1
    	KeyUp 17,1
    	Delay 500
    	
	Next
	Rem Found
	KeyPress 13,1 // Talk to Trader
	Delay 800 // Wait for talk options
End Sub

Sub FindBarOwner(DX, DY, hwnd)

	Delay 500
    KeyDown 17,1
    KeyDown 37,1
    Delay 500
    KeyUp 37,1
    KeyUp 17,1
    Delay 500

	For 3 // This loop is for rotating 90deg for 3 times
    	Call BringWinOnTop(hwnd)
    	Delay 10
    	For 10
        	KeyPress 9,1
        	Delay 200
        	IfColor DX + 636, DY + 331, "ffffff", 0 Then
//        		TracePrint "Cond1 Pass"
            	IfColor DX + 633, DY + 333, "ffffff", 0 Then
//            		TracePrint "Cond2 Pass"
                	IfColor DX + 654, DY + 330, "ffffff", 0 Then
//                		TracePrint "Cond3 Pass"
                    	IfColor DX + 667, DY + 330, "ffffff", 0 Then
//                    		TracePrint "Cond4 Pass"
                        	IfColor DX + 685, DY + 330, "ffffff", 0 Then
//                        		TracePrint "Cond5 Pass"
                            	IfColor DX + 682, DY + 339, "ffffff", 0 Then
//                            		TracePrint "Cond6 Pass"
                                	IfColor DX + 666, DY + 339, "ffffff", 0 Then
//                                		TracePrint "Cond7 Pass"
                                    	IfColor DX + 638, DY + 339, "ffffff", 0 Then
//                                    		TracePrint "Cond8 Pass"
                                        	Delay 200
                                        	Goto Found
                                    	End if 
                                	End if 
                            	End if 
                        	End if 
                    	End if 
                	End if 
            	End if 
        	End if 
    	Next
    	Delay 500
    	KeyDown 17,1
    	KeyDown 37,1
    	Delay 1500
    	KeyUp 37,1
    	KeyUp 17,1
    	Delay 500
    	
	Next
	Rem Found
	KeyPress 13,1 // Approach BarOwner
	Delay 3500// Getting near
	KeyPress 13,1 // Talk
End Sub

Sub ChooseFood(DX, DY, hwnd)
	// 1st 138
	// 2nd 186
	// 3rd 243
	// 4th 291
	// 5th 366



	Call Plugin.Bkgnd.LeftClick(hwnd1, 646, 360) // Click Eat

	Delay 1000
	Call Plugin.Bkgnd.LeftClick(hwnd1, 446, 284) // Click Set Meal
	Delay 1000
	
	Call Bk_WheelDown(hwnd1, 366,383, 5)
	
	Call Move_Click_v2(hwnd1, 190, 138) // Choose Drink 1
	Delay 500
	
	Call Move_Click_v2(hwnd1, 224, 243)//Choose Food 1
	Delay 500
	
	Call Move_Click_v2(hwnd1, 224, 243)//Choose Food 2
	Delay 500
	
	Call Move_Click_v2(hwnd1, 224, 243)//Choose Food 3
	Delay 500
	
	Call Move_Click_v2(hwnd1, 219, 138) //Choose Drink 2
	Delay 500
	
	Call Move_Click_v2(hwnd1,609,415) // Confirm
End Sub

Sub FindBarExit(DX,DY,hwnd)
	For 3 // This loop is for rotating 90deg for 3 times
    	Call BringWinOnTop(hwnd)
    	Delay 10
    	For 195
        	KeyPress 9,1
        	Delay 200
        	IfColor DX + 630, DY + 334, "ffffff", 0 Then
            	IfColor DX + 640, DY + 334, "ffffff", 0 Then
                	IfColor DX + 646, DY + 334, "ffffff", 0 Then
                    	IfColor DX + 657, DY + 334, "ffffff", 0 Then
                        	IfColor DX + 629, DY + 342, "ffffff", 0 Then
                            	IfColor DX + 637, DY + 342, "ffffff", 0 Then
                                	IfColor DX + 646, DY + 342, "ffffff", 0 Then
                                    	IfColor DX + 657, DY + 342, "ffffff", 0 Then
                                        	Delay 200
                                        	Goto Found
                                    	End if 
                                	End if 
                            	End if 
                        	End if 
                    	End if 
                	End if 
            	End if 
        	End if 
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
	KeyPress 13, 1// Open the door
	Delay 1000
End Sub

Sub EatinBar(X,Y)
	BringWinOnTop(hwnd1)
	OpenMap 
	Delay 300
	Call Plugin.Bkgnd.LeftClick(hwnd1, X, Y)
	
	Delay 5000
	
	Call FindBarEntrance(DX1, DY1, hwnd1)
	Delay 1500
	
	Call FindBarOwner(DX1, DY1, hwnd1)
	Delay 1000
	Call ChooseFood(DX1, DY1, hwnd1)
	
	//Call FindBarOwner(DX2,DY2,hwnd2)
	//Call ChooseFood(DX2, DY2, hwnd2)
//	
//	Call FindBarOwner(DX3,DY3,hwnd3)
//	Call ChooseFood(DX3, DY3, hwnd3)
//	
//	Call FindBarOwner(DX4,DY4,hwnd4)
//	Call ChooseFood(DX4, DY4, hwnd4)
//	
	Call WalktoBarExit(hwnd1)
	Call FindBarExit(DX1,DY1,hwnd1)	
End Sub

Sub WalktoBarExit(hwnd)
	
	BringWinOnTop (hwnd)
//	Call Move_Click_v2(hwnd, 598, 554)
	Delay 500
	KeyDown "Down", 1
	Delay 3000
	KeyUp "Down", 1
End Sub
// End of MP restore

Sub Bk_WheelDown(hwnd, X, Y, i)

	For counter = 1 to i
//    Call Plugin.Bkgnd.LeftDown(hwnd, 343, 321)
	Call Plugin.Bkgnd.LeftDown(hwnd, X, Y)
    Delay 50
    Call Plugin.Bkgnd.LeftUp(hwnd, X, Y)
    Delay 100
	Next
End Sub
