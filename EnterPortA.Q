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
MacroID=f4b569b8-dbbe-495a-9439-e5d4447f86e2
Description=EnterPortA
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
Dim DX1, DX2, DX3, DX4, DY1, DY2, DY3, DY4

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

DX2 = MyArray2(0)
DY2 = MyArray2(1)

DX3 = MyArray3(0)
DY3 = MyArray3(1)

DX4 = MyArray4(0)
DY4 = MyArray4(1)

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
Delay 12000 // Need to walk for a very long distance


Call FindTrader(DX1, DY1, hwnd1)
Call SellItems(DX1, DY1, hwnd1)
Delay 500
Call BuyItems(DX1, DY1, hwnd1)
Delay 500

Call OpenMap
Delay 500
Call Move_Click(DX, DY, 500, 293) // Click the PortOfficer Location

Call FindPortOfficer(DX1, DY1, hwnd)
Call Move_Click(DX, DY, 646, 363)




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
        		TracePrint "Cond1 Pass"
            	IfColor DX + 643, DY + 330, "ffffff", 0 Then
            		TracePrint "Cond2 Pass"
                	IfColor DX + 678, DY + 330, "ffffff", 0 Then
                		TracePrint "Cond3 Pass"
                    	IfColor DX + 690, DY + 339, "ffffff", 0 Then
                    		TracePrint "Cond4 Pass"
                        	IfColor DX + 700, DY + 330, "ffffff", 0 Then
                        		TracePrint "Cond5 Pass"
                            	IfColor DX + 700, DY + 341, "ffffff", 0 Then
                            		TracePrint "Cond6 Pass"
                                	IfColor DX + 652, DY + 331, "ffffff", 0 Then
                                		TracePrint "Cond7 Pass"
                                    	IfColor DX + 656, DY + 342, "ffffff", 0 Then
                                    		TracePrint "Cond8 Pass"
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
    
    
Sub SellItems(DX,DY,hwnd)
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

Sub BuyItems(DX, DY, hwnd)
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
        		TracePrint "Cond1 Pass"
            	IfColor DX + 631, DY + 331, "ffffff", 0 Then
            		TracePrint "Cond2 Pass"
                	IfColor DX + 638, DY + 332, "ffffff", 0 Then
                		TracePrint "Cond3 Pass"
                    	IfColor DX + 648, DY + 329, "ffffff", 0 Then
                    		TracePrint "Cond4 Pass"
                        	IfColor DX + 655, DY + 337, "ffffff", 0 Then
                        		TracePrint "Cond5 Pass"
                            	IfColor DX + 672, DY + 333, "ffffff", 0 Then
                            		TracePrint "Cond6 Pass"
                                	IfColor DX + 672, DY + 342, "ffffff", 0 Then
                                		TracePrint "Cond7 Pass"
                                    	IfColor DX + 684, DY + 334, "ffffff", 0 Then
                                    		TracePrint "Cond8 Pass"
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
