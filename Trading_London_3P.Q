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
MacroID=fc1b842c-cff9-41a8-bacd-c7b4d7fdd0dc
Description=Trading_London_3P
Enable=0
AutoRun=0
[Repeat]
Type=2
Number=86460
[SetupUI]
Type=2
QUI=
[Relative]
SetupOCXFile=
[Comment]

[Script]
Dim DX1, DX2, DX3, DX4, DY1, DY2, DY3, DY4
hwnd0 = 328336
hwnd1 = 132040
hwnd2 = 199128
hwnd3 = 68620
hwnd4 = 124603
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
// --------------Testing
TracePrint DXe
TracePrint DYe

reconnect

//Sub reconnect
//	Call CheckOnline_onport 
//	If Player1_ol_value = 0 Then 
//		Call Login(hwnd1,0) 
//	End If
//	
//	If Player2_ol_value = 0 Then 
//		Call Login(hwnd2,1) 
//	End If
//	
//	If Player3_ol_value = 0 Then 
//		Call Login(hwnd3,1) 
//	End If
//	
//	If Player4_ol_value = 0 Then 
//		Call Login(hwnd4,1) 
//	End If	
//End Sub

//---------------------------  Beginning

Call Supply(DX1,DY1,hwnd1) 
//Call Supply(DX2, DY2, hwnd2)
Call Supply(DX3, DY3, hwnd3)
Call Supply(DX4, DY4, hwnd4)
Delay 900

// Player 1 sail out
Call SailOut

Call Choose_Navi_Path ("To_LA.path")
Delay 8000
// Activate skills
Call Plugin.Bkgnd.KeyPress(hwnd1, 121)//Press F10
Delay 1800
Call Plugin.Bkgnd.KeyPress(hwnd1, 113)//Press F3
Call StartNavi

cond = Check_Arrival(DX1, DY1)
counter = 0
While cond(0) = - 1  or cond(1) = - 1  or cond(2) = - 1 
	cond = Check_Arrival(DX1, DY1)
	Call CheckOnline_onsea
	counter = counter+1
Wend
Call reconnect

Call EnterPort_LA


Call UPDATE_PLAYER_MP_STATE(hwnd1, MP_add)

If Player1_mp_value < 400 Then 
	Call EatinBar(442,190)
End If
Delay 5000

Call Leaving(457,229) //Leave Dover
Delay 4500


Call UPDATE_PLAYER_MP_STATE(hwnd1, MP_add)

If Player1_mp_value < 400 Then 
	Call EatinBar(442,190)
End If
Delay 5000

Call reconnect
// Supplying Food and Water
Call Supply(DX1, DY1,hwnd1) 
//Call Supply(DX2, DY2, hwnd2)
Call Supply(DX3, DY3, hwnd3)
Call Supply(DX4, DY4, hwnd4)
Delay 900

// Player 1 sail out
Call SailOut

Call Choose_Navi_Path ("To_LB.path")
Delay 8000
// Activate skills
Call Plugin.Bkgnd.KeyPress(hwnd1, 121)//Press F10
Delay 1800
Call Plugin.Bkgnd.KeyPress(hwnd1, 113)//Press F3

Call StartNavi

cond = Check_Arrival(DX1, DY1)

While cond(0) = - 1  or cond(1) = - 1  or cond(2) = - 1 
	cond = Check_Arrival(DX1, DY1)
	Call CheckOnline_onsea

	counter = counter+1
Wend


Call reconnect
Call EnterPort_LB


Call Leaving(655,247)
Delay 4500


//-------------------Endof Prog---------------------

// Function
// --------------Functions for Food Drink Supply --------------
Sub Supply(DX,DY, hwnd)
	Call BringWinOnTop(hwnd)
	Call Move_Click(DX, DY, 682, 360)// Supply button
	Delay 800 // Wait for supply meun to pop up	
	Call Move_Click(DX, DY, 194, 360)// Supply to saved value
	Delay 300
	Call Move_Click(DX, DY, 597, 404)// Click confirm button
	// Need to becareful for this step, if it is full, the button is not clickable
	
End Sub

Sub SailOut
	Call BringWinOnTop(hwnd1)
	Call Move_Click(DX1, DY1, 640, 360)
	Delay 1000
	Call Move_Click(DX1, DY1, 549, 398)
	Delay 500
End Sub


Sub Move_Click(DX,DY, X,Y)
    MoveTo DX + X, DY + Y//Move to supply button
    Delay 250
    LeftClick 1
End Sub

Function Check_Arrival(DX, DY)
	Dim cond(3)
	
	IfColor DX + 629, DY + 330, "ffffff", 0 Then
//		TracePrint "True!!"
		cond(0) = 0
	Else
		cond(0) = -1
	End If
	
	IfColor DX + 641, DY + 332, "ffffff", 0 Then
		cond(1) = 0
	Else
		cond(1) = -1
	End If
	
	IfColor DX + 654, DY + 334, "ffffff", 0 Then
	
		cond(2) = 0
	Else
		cond(2) = -1 
	End If
		
	Check_Arrival = cond
End Function

Sub EnterPort_LA
	BringWinOnTop (hwnd1)
	Delay 1500
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
	Delay 2000
	Call OpenMap
	Delay 800
	Call Move_Click(DX1, DY1, 560, 131)
	Delay 12000// Need to walk for a very long distance

	Call TradingA(DX1, DY1, hwnd1)
	MoveTo DX1+ 361, DY1 + 100
	Delay 1000
	RightClick 1
	Delay 800
	RightClick 1
	KeyDown "Up", 1
	Delay 800
	KeyUp "Up", 1
	//Call TradingA(DX2, DY2, hwnd2)
	Call TradingA(DX3, DY3, hwnd3)
	Call TradingA(DX4, DY4, hwnd4)
End Sub

Sub EnterPort_LB
	BringWinOnTop (hwnd1)
	Delay 1500
	Call Move_Click(DX1,DY1,644,382) //Click Enter
	Delay 1900
	For 10
		IfColor DX1+641,DY1+385,"000000)",0 Then
			Delay 1000
		Else    
    		Goto Loaded_City
		End If
	Next
	
	Rem Loaded_City
	Delay 6000
	Call OpenMap
	Delay 800
	Call Move_Click(DX1, DY1, 511, 172) // Click port near trader
	
	Delay 6000
	Call OpenMap
	Delay 800
	Call Move_Click(DX1, DY1, 528, 170) // Click trader on Map
	Delay 5000// Need to walk for a very long distance

	Call TradingB(DX1, DY1, hwnd1)
	MoveTo DX1+ 361, DY1 + 100
	Delay 1000
	RightClick 1
	Delay 800
	RightClick 1
	KeyDown "Up", 1
	Delay 800
	KeyUp "Up", 1
	//Call TradingB(DX2, DY2, hwnd2)
	Call TradingB(DX3, DY3, hwnd3)
	Call TradingB(DX4, DY4, hwnd4)
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

Sub TradingA(DX, DY, hwnd)
	Call FindTrader(DX, DY, hwnd)
	Delay 300
	Call SellItemsA(DX, DY, hwnd)
	Delay 800
	Call BuyItemsA_Food(DX, DY, hwnd)
	Delay 800
	Call BuyItemsA_Snack(DX, DY, hwnd)
	Delay 800
	Call BuyItemsA_Seasoning(DX, DY, hwnd)
	Delay 800
	
End Sub

Sub TradingB(DX, DY, hwnd)
	Call FindTrader(DX, DY, hwnd)
	Delay 300
	Call SellItemsA(DX, DY, hwnd)
	Delay 800
	Call BuyItemsB_Beer1(DX, DY, hwnd)
	Delay 800
	Call BuyItemsB_Beer2(DX, DY, hwnd)
	Delay 800
	Call BuyItemsB_Seasoning(DX, DY, hwnd)
	Delay 800
	
End Sub

Sub FindTrader(DX,DY,hwnd)
	For 3 // This loop is for rotating 90deg for 3 times
    	Call BringWinOnTop(hwnd)
    	Delay 10
    	For 195
    		KeyDown 27, 1
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
                                        	KeyUp 27, 1
                                        	Goto FoundTrader
                                    	End if 
                                	End if 
                            	End if 
                        	End if 
                    	End if 
                	End if 
            	End if 
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
	Delay 800
	
	
	Call Move_Click(DX, DY, 456, 341)// Bargain
	Delay 900
	
	Call Move_Click(DX, DY, 647, 423)// Confirm
End Sub

Sub BuyItemsA_Food(DX, DY, hwnd)
	Call BringWinOnTop(hwnd)
	Call Move_Click(DX, DY, 640, 357) // Option = Buy
	Delay 800
	
	Call Move_Click(DX, DY, 235, 200)// Buy the 1st target product
	Delay 200
	KeyPress 107, 1
	Delay 200
	KeyPress 13, 1
	Delay 200
	
	Call Move_Click(DX, DY, 201, 250)// Buy the 2nd target product
	Delay 200
	KeyPress 107, 1
	Delay 200
	KeyPress 13, 1
	Delay 200
	
	
	Call Move_Click(DX, DY, 428, 304)// Bargain
	Delay 900
	
	Call Move_Click(DX, DY, 647, 423)// Confirm	
End Sub

Sub BuyItemsA_Snack(DX, DY, hwnd)
	Call BringWinOnTop(hwnd)
	Call Move_Click(DX, DY, 640, 357) // Option = Buy
	Delay 800
	
	Call Move_Click(DX, DY, 235, 130)// Buy the 1st target product
	Delay 200
	KeyPress 107, 1
	Delay 200
	KeyPress 13, 1
	Delay 200

	
	
	Call Move_Click(DX, DY, 428, 304)// Bargain
	Delay 900
	
	Call Move_Click(DX, DY, 647, 423)// Confirm	
End Sub

Sub BuyItemsA_Seasoning(DX, DY, hwnd)
	Call BringWinOnTop(hwnd)
	Call Move_Click(DX, DY, 640, 357) // Option = Buy
	Delay 800
	
	Call Move_Click(DX, DY, 193, 307)// Buy the 1st target product
	Delay 200
	KeyPress 107, 1
	Delay 200
	KeyPress 13, 1
	Delay 200

	
	
	Call Move_Click(DX, DY, 428, 304)// Bargain
	Delay 900
	
	Call Move_Click(DX, DY, 647, 423)// Confirm	
End Sub

Sub BuyItemsB_Beer1(DX, DY, hwnd)
	Call BringWinOnTop(hwnd)
	Call Move_Click(DX, DY, 640, 357) // Option = Buy
	Delay 800
	
	Call Move_Click(DX, DY, 235, 131)// Buy the 1st target product
	Delay 200
	KeyPress 107, 1
	Delay 200
	KeyPress 13, 1
	Delay 200
	
	
	Call Move_Click(DX, DY, 428, 304)// Bargain
	Delay 900
	
	Call Move_Click(DX, DY, 647, 423)// Confirm	
End Sub

Sub BuyItemsB_Beer2(DX, DY, hwnd)
	Call BringWinOnTop(hwnd)
	Call Move_Click(DX, DY, 640, 357) // Option = Buy
	Delay 800
	
	Call Move_Click(DX, DY, 235, 200)// Buy the 1st target product
	Delay 200
	KeyPress 107, 1
	Delay 200
	KeyPress 13, 1
	Delay 200
	
	
	Call Move_Click(DX, DY, 428, 304)// Bargain
	Delay 900
	
	Call Move_Click(DX, DY, 647, 423)// Confirm	
End Sub

Sub BuyItemsB_Seasoning(DX, DY, hwnd)
	Call BringWinOnTop(hwnd)
	Call Move_Click(DX, DY, 640, 357) // Option = Buy
	Delay 800
	
	Call Move_Click(DX, DY, 163, 255)// Buy the 1st target product
	Delay 200
	KeyPress 107, 1
	Delay 200
	KeyPress 13, 1
	Delay 200
	
	Call Move_Click(DX, DY, 428, 304)// Bargain
	Delay 900
	
	Call Move_Click(DX, DY, 647, 423)// Confirm	
End Sub
Sub Leaving(X,Y)
	Call OpenMap
	Delay 800
	Call Move_Click(DX1, DY1, X, Y)// Click the PortOfficer Location
//	TracePrint "Clicked"
	Delay 3000
	Call FindPortOfficer(DX1, DY1, hwnd1)
	Call Move_Click(DX1, DY1, 646, 363)		
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
	Delay 2000// Getting near
	KeyPress 13,1 // Talk
End Sub

Sub ChooseFood(DX, DY, hwnd)
	Call Move_Click(DX, DY, 646, 360) // Click Eat
	Delay 1000
	Call Move_Click(DX, DY, 446, 284) // Click Set Meal
	Delay 1000
	
	MouseWheel - 6 
	
	Call Move_Click(DX, DY, 190, 198) // Choose Drink 1
	Delay 500
	
	Call Move_Click(DX, DY, 224, 362)//Choose Food 1
	Delay 500
	
	Call Move_Click(DX, DY, 224, 362)//Choose Food 2
	Delay 500
	
	Call Move_Click(DX, DY, 224, 362)//Choose Food 3
	Delay 500
	
	Call Move_Click(DX, DY, 219, 198)//Choose Drink 2
	Delay 500
	
	Call Move_Click(DX,DY,609,415) // Confirm
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
	Call Move_Click(DX1, DY1, X, Y)
	
	Delay 15000
	
	Call FindBarEntrance(DX1, DY1, hwnd1)
	Delay 1500
	
	Call FindBarOwner(DX1, DY1, hwnd1)
	Delay 1000
	Call ChooseFood(DX1, DY1, hwnd1)
	
	//Call FindBarOwner(DX2,DY2,hwnd2)
	//Call ChooseFood(DX2, DY2, hwnd2)
	
	Call FindBarOwner(DX3,DY3,hwnd3)
	Call ChooseFood(DX3, DY3, hwnd3)
	
	Call FindBarOwner(DX4,DY4,hwnd4)
	Call ChooseFood(DX4, DY4, hwnd4)
	
	Call WalktoBarExit(hwnd1)
	Call FindBarExit(DX1,DY1,hwnd1)	
End Sub

Sub WalktoBarExit(hwnd)
	BringWinOnTop(hwnd)
	KeyDown "Down", 1
	Delay 3000
	KeyUp "Down", 1
End Sub


Sub UPDATE_PLAYER_MP_STATE(hwnd,state_add)
	Player1_mp_value = Int(Plugin.Memory.Read16Bit(hwnd, state_add))
End Sub

// Check Login and auto login

Sub Stopmoving
	// Stop Navi
	BringWinOnTop(hwnd0)
	Call Plugin.Bkgnd.KeyPress(hwnd0, 121)
	Call Plugin.Bkgnd.KeyPress(hwnd0, 83)
	Call Plugin.Bkgnd.KeyPress(hwnd0, 80)
	// Stop Players
	Call Plugin.Bkgnd.LeftClick(hwnd1, 782, 581)
	Call Plugin.Bkgnd.LeftClick(hwnd2, 782, 581)
	Call Plugin.Bkgnd.LeftClick(hwnd3, 782, 581)
	Call Plugin.Bkgnd.LeftClick(hwnd4, 782, 581)
	
End Sub

Sub CheckOnline_onsea
	Call UPDATE_PLAYER_OL_STATE(OLstatus1_add)
	If Player1_ol_value = 0 or Player2_ol_value = 0 or Player3_ol_value = 0 or Player4_ol_value = 0 Then 
		Call reconnect
		Call UPDATE_PLAYER_OL_STATE(OLstatus1_add)
		If Player1_ol_value = 0 Then 
			Call Stopmoving
			ExitScript
		End If
		
	End If
End Sub

Sub CheckOnline_onport
	Call UPDATE_PLAYER_OL_STATE(OLstatus1_add)
	If Player1_ol_value = 0 or Player2_ol_value = 0 or Player3_ol_value = 0 or Player4_ol_value = 0 Then 
		Call reconnect
		Call UPDATE_PLAYER_OL_STATE(OLstatus1_add)
		If Player1_ol_value = 0 Then 
			ExitScript
		End If
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

Sub reconnect
	Call UPDATE_PLAYER_OL_STATE(OLstatus1_add)
	If Player1_ol_value = 0 Then 
		Call Login(hwnd1, 0)
		SendAlert
		TracePrint "Player1 reconnected"
		StartNavi
	End If
	
//	If Player2_ol_value = 0 Then 
//		Call Login(hwnd2, 1)
//		SendAlert
//		TracePrint "Player2 reconnected"
//	End If
	
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

Sub SendAlert
	//BringWinOnTop (ehwnd)
	//Call Move_Click(DXe, DYe, 74, 222)// Create a new email
	Call Plugin.Bkgnd.LeftClick(ehwnd, 74, 222)
	Delay 500
	Call Plugin.Bkgnd.SendString(ehwnd, "u3500684@connect.hku.hk")
	Call Plugin.Bkgnd.KeyPress(ehwnd, 13) // confirm address
	Delay 150
	Call Plugin.Bkgnd.KeyPress(ehwnd, 9)// move to title filed
	Delay 100
	Call Plugin.Bkgnd.SendString(ehwnd, "Disconnected")

	Call Plugin.Bkgnd.LeftClick(ehwnd, 469, 1003) // Send out email
	//MoveTo DXe + 469, DYe + 1003
	//LeftClick 1
	//ExitScript
End Sub
