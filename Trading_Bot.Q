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
MacroID=52e7ed7a-1951-4dc0-ad8e-ca86eabd6ddd
Description=Trading_Bot
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
hwnd0 = Plugin.Window.Find("Afx:00400000:b:00010003:00000006:00240439", "athrun200 - ÉñÂ}Œ§º½")
hwnd1 = 197874
hwnd2 = 134180
hwnd3 = 68702
hwnd4 = 68714

sick_state = 2
mouse_state = 8
fire_state = 16
//Call Plugin.Window.Move(hwnd1, 100, 100)
VBS state_add=&H0111FEA4

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


Call EnterPortA
Call LeavingA
Delay 3000
// Supplying Food and Water
Call Supply(DX1, DY1,hwnd1) 
Call Supply(DX2, DY2, hwnd2)
Call Supply(DX3, DY3, hwnd3)
Call Supply(DX4, DY4, hwnd4)


// Player 1 sail out
Call SailOut

Call Choose_Navi_Path ("ToB.path")
Delay 8000
// Activate skills
Call Plugin.Bkgnd.KeyPress(hwnd1, 121)//Press F10
Delay 1800
Call Plugin.Bkgnd.KeyPress(hwnd1, 113)//Press F3

Call StartNavi

cond = Check_Arrival(DX1, DY1)
TracePrint cond(0)
TracePrint cond(1)
TracePrint cond(2)

counter = 0
While cond(0) = - 1  or cond(1) = - 1  or cond(2) = - 1 
	Call BringWinOnTop(hwnd1)
	Autoheal 
	cond = Check_Arrival(DX1, DY1)
	TracePrint cond(0)
	TracePrint cond(1)
	TracePrint cond(2)
	If counter = 500 Then 
		Call Refresh_Nav	
	End If
	counter = counter+1
Wend

Call EnterPortB
Call LeavingB
Delay 3000



Call Supply(DX1,DY1,hwnd1) 
Call Supply(DX2, DY2, hwnd2)
Call Supply(DX3, DY3, hwnd3)
Call Supply(DX4, DY4, hwnd4)

// Player 1 sail out
Call SailOut

Call Choose_Navi_Path ("ToA.path")
Delay 8000
// Activate skills
Call Plugin.Bkgnd.KeyPress(hwnd1, 121)//Press F10
Delay 1800
Call Plugin.Bkgnd.KeyPress(hwnd1, 113)//Press F3
Call StartNavi


cond = Check_Arrival(DX1, DY1)
TracePrint cond(0)
TracePrint cond(1)
TracePrint cond(2)
counter = 0
While cond(0) = - 1  or cond(1) = - 1  or cond(2) = - 1 
	Call BringWinOnTop(hwnd1)
	Autoheal 
	cond = Check_Arrival(DX1, DY1)
	TracePrint cond(0)
	TracePrint cond(1)
	TracePrint cond(2)
	If counter = 500 Then 
		Call Refresh_Nav	
	End If
	counter = counter+1
Wend

Sub EnterPortA
	BringWinOnTop(hwnd1)
	Call Move_Click(DX1,DY1,641,385) //Click Enter
	Delay 1900
	For 10
		IfColor DX1+641,DY1+385,"000000)",0 Then
			Delay 1000
		Else    
    		Goto Loaded_City
		End If
	Next
	
	Rem Loaded_City
	Call OpenMap
	Delay 800
	Call Move_Click(DX1, DY1, 590, 190)
	Delay 12000// Need to walk for a very long distance

	Call TradingA(DX1, DY1, hwnd1)
	RightClick 2
	Delay 800
	KeyDown "Up", 1
	Delay 800
	KeyUp "Up", 1
	Call TradingA(DX2, DY2, hwnd2)
	Call TradingA(DX3, DY3, hwnd3)
	Call TradingA(DX4, DY4, hwnd4)
End Sub

Sub EnterPortB
	BringWinOnTop(hwnd1)
	Call Move_Click(DX1,DY1,641,385) //Click Enter
	Delay 1900
	For 10
		IfColor DX1+641,DY1+385,"000000)",0 Then
			Delay 1000
		Else    
    		Goto Loaded_City
		End If
	Next
	
	Rem Loaded_City
	Call OpenMap
	Delay 800
	Call Move_Click(DX1, DY1, 579, 215) //Click the Trading point for City B
	Delay 12000// Need to walk for a very long distance
	
	Call TradingB(DX1, DY1, hwnd1)
	RightClick 2
	Delay 800
	KeyDown "Up", 1
	Delay 800
	KeyUp "Up", 1
	Call TradingB(DX2, DY2, hwnd2)
	Call TradingB(DX3, DY3, hwnd3)
	Call TradingB(DX4, DY4, hwnd4)
End Sub

Sub TradingA(DX, DY, hwnd)
	Call FindTrader(DX, DY, hwnd)
	Delay 300
	Call SellItemsA(DX, DY, hwnd)
	Delay 800
	Call BuyItemsA(DX, DY, hwnd)
	Delay 800
	
End Sub

Sub LeavingA
	Call OpenMap
	Delay 800
	Call Move_Click(DX1, DY1, 500, 293) // Click the PortOfficer Location
	Delay 1800
	Call FindPortOfficer(DX1, DY1, hwnd1)
	Call Move_Click(DX1, DY1, 646, 363)		
End Sub

Sub TradingB(DX, DY, hwnd)
	Call FindTrader(DX, DY, hwnd)
	Delay 300
	Call SellItemsB(DX, DY, hwnd)
	Delay 800
	Call BuyItemsB(DX, DY, hwnd)
	Delay 800
End Sub

Sub LeavingB
	Call OpenMap
	Delay 800
	Call Move_Click(DX1, DY1, 550, 294) // Click the PortOfficer Location
	Delay 1800
	Call FindPortOfficer(DX1, DY1, hwnd)
	Call Move_Click(DX1, DY1, 646, 363)	
End Sub


Sub Move_Click(DX,DY, X,Y)
    Moveto DX+X, DY+Y //Move to supply button
    Delay 300 
    LeftClick 1
End Sub

Sub BringWinOnTop(hwnd)
	Call Plugin.Window.Active(hwnd)
	Call Plugin.Window.Restore(hwnd)
End Sub

Sub OpenMap
	BringWinOnTop(hwnd1)
	KeyDown "Ctrl", 1
	KeyPress "F1", 1
	KeyUp "Ctrl", 1
End Sub

Sub FindTrader(DX,DY,hwnd)
	For 3 // This loop is for rotating 90deg for 3 times
    	Call BringWinOnTop(hwnd)
    	Delay 10
    	For 195
        	KeyPress 9,1
        	Delay 200
        	IfColor DX + 629, DY + 330, "ffffff", 0 Then
        		//TracePrint "Cond1 Pass"
            	IfColor DX + 643, DY + 330, "ffffff", 0 Then
            		//TracePrint "Cond2 Pass"
                	IfColor DX + 678, DY + 330, "ffffff", 0 Then
                		//TracePrint "Cond3 Pass"
                    	IfColor DX + 690, DY + 339, "ffffff", 0 Then
                    		//TracePrint "Cond4 Pass"
                        	IfColor DX + 700, DY + 330, "ffffff", 0 Then
                        		//TracePrint "Cond5 Pass"
                            	IfColor DX + 700, DY + 341, "ffffff", 0 Then
                            		//TracePrint "Cond6 Pass"
                                	IfColor DX + 652, DY + 331, "ffffff", 0 Then
                                		//TracePrint "Cond7 Pass"
                                    	IfColor DX + 656, DY + 342, "ffffff", 0 Then
                                    		//TracePrint "Cond8 Pass"
                                        	Delay 200
                                        	Goto FoundTrader
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
	Rem FoundTrader
	KeyPress 13,1 // Talk to Trader
	Delay 800 // Wait for talk options
End Sub
    
    
Sub SellItemsA(DX,DY,hwnd)
	Call BringWinOnTop(hwnd)
	KeyPress 13,1 // Talk to Trader
	Delay 800 // Wait for talk options
	
	Call Move_Click(DX, DY, 680, 359) // Option = Sell
	Delay 800
	
	Call Move_Click(DX, DY, 286, 89)// Sell all
	Delay 300
	
	
	Call Move_Click(DX, DY, 456, 341)// Bargain
	Delay 500
	
	Call Move_Click(DX, DY, 647, 423)// Confirm
End Sub

Sub BuyItemsA(DX, DY, hwnd)
	Call BringWinOnTop(hwnd)
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
End Sub
    
Sub FindPortOfficer(DX,DY,hwnd)
	For 3 // This loop is for rotating 90deg for 3 times
    	Call BringWinOnTop(hwnd)
    	Delay 10
    	For 195
        	KeyPress 9,1
        	Delay 200
        	IfColor DX + 640, DY + 340, "ffffff", 0 Then
        		//TracePrint "Cond1 Pass"
            	IfColor DX + 631, DY + 331, "ffffff", 0 Then
            		//TracePrint "Cond2 Pass"
                	IfColor DX + 638, DY + 332, "ffffff", 0 Then
                		//TracePrint "Cond3 Pass"
                    	IfColor DX + 648, DY + 329, "ffffff", 0 Then
                    		//TracePrint "Cond4 Pass"
                        	IfColor DX + 655, DY + 337, "ffffff", 0 Then
                        		//TracePrint "Cond5 Pass"
                            	IfColor DX + 672, DY + 333, "ffffff", 0 Then
                            		//TracePrint "Cond6 Pass"
                                	IfColor DX + 672, DY + 342, "ffffff", 0 Then
                                		//TracePrint "Cond7 Pass"
                                    	IfColor DX + 684, DY + 334, "ffffff", 0 Then
                                    		//TracePrint "Cond8 Pass"
                                        	Delay 200
                                        	Goto FoundPortOfficer
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
	Rem FoundPortOfficer
	KeyPress 13,1 // Talk to Trader
	Delay 800 // Wait for talk options
End Sub


// --------------Functions for Food Drink Supply --------------
Sub Supply(DX,DY, hwnd)
	Call BringWinOnTop(hwnd)
	Call Move_Click(DX, DY, 682, 360)// Supply button
	Delay 800 // Wait for supply meun to pop up	
	Call Move_Click(DX, DY, 194, 360) // Supply to saved value
	Call Move_Click(DX, DY, 597, 404)// Click confirm button
	// Need to becareful for this step, if it is full, the button is not clickable
	
End Sub

Sub SailOut
	Call Move_Click(DX1, DY1, 640, 360)
	Delay 600
	Call Move_Click(DX1,DY1, 549, 398)
End Sub
// --------------End of Food Drink Supply --------------

// --------------Navigation to Port B  --------------

Sub Choose_Navi_Path(path)
	BringWinOnTop(hwnd0)
	Call Plugin.Bkgnd.KeyPress(hwnd0, 116)//Press F5
	Delay 500
	SayString path
	KeyPress "Enter", 1
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

// -------------- End of Navigation to Port B

Sub SellItemsB(DX,DY,hwnd)
	Call BringWinOnTop(hwnd)
	KeyPress 13,1 // Talk to Trader
	Delay 1000 // Wait for talk options
	
	Call Move_Click(DX, DY, 680, 359) // Option = Sell
	Delay 1000
	
	Call Move_Click(DX, DY, 286, 89)// Sell all
	Delay 300
	
	
	Call Move_Click(DX, DY, 456, 341)// Bargain
	Delay 500
	
	Call Move_Click(DX, DY, 647, 423)// Confirm
End Sub

Sub BuyItemsB(DX, DY, hwnd)
	Call BringWinOnTop(hwnd)
	Call Move_Click(DX, DY, 640, 357) // Option = Buy
	Delay 800
	
	Call Move_Click(DX, DY, 235, 261)// Buy the 1st target product
	Delay 200
	KeyPress 107, 1
	Delay 200
	KeyPress 13, 1
	Delay 200
	
	Call Move_Click(DX, DY, 230, 307)// Buy the 2nd target product
	Delay 200
	KeyPress 107, 1
	Delay 200
	KeyPress 13, 1
	Delay 200
	
	Call Move_Click(DX, DY, 428, 304)// Bargain
	Delay 500
	
	Call Move_Click(DX, DY, 647, 423)// Confirm	
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
	
	// Keep player 2,3,4 active
	//Call Plugin.Bkgnd.KeyPress(hwnd2, 121)//Press F10 
	//Call Plugin.Bkgnd.KeyPress(hwnd2, 121)//Press F10
	
	Call Plugin.Bkgnd.KeyPress(hwnd3, 121)//Press F10 
	Call Plugin.Bkgnd.KeyPress(hwnd3, 121)//Press F10	
	
	Call Plugin.Bkgnd.KeyPress(hwnd4, 121)//Press F10 
	Call Plugin.Bkgnd.KeyPress(hwnd4, 121)//Press F10	
	
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

Sub UPDATE_PLAYER_STATE
	Player1_state_value = Int(Plugin.Memory.Read8Bit(Hwnd1, state_add))
	Player2_state_value = Int(Plugin.Memory.Read8Bit(Hwnd2, state_add))
	Player3_state_value = Int(Plugin.Memory.Read8Bit(Hwnd3, state_add))
	Player4_state_value = Int(Plugin.Memory.Read8Bit(Hwnd4, state_add))
End Sub
