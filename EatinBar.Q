[General]
MacroID=5c9b0209-e9b6-40e5-ad3f-5fa67a483dcb
SyntaxVersion=2
BeginHotkey=121
BeginHotkeyMod=0
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=1
EnableWindow=
Description=EatinBar
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

hwnd = 197874
hwnd2 = 134180
hwnd3 = 68702
hwnd4 = 68714



s1 = Plugin.Window.GetClientRect(hwnd)
s2 = Plugin.Window.GetClientRect(hwnd2)
s3 = Plugin.Window.GetClientRect(hwnd3)
s4 = Plugin.Window.GetClientRect(hwnd4)
MyArray1 = Split(s1, "|", -1, 1)
MyArray2 = Split(s2, "|", -1, 1)
MyArray3 = Split(s3, "|", -1, 1)
MyArray4 = Split(s4, "|", -1, 1)

DX = MyArray1(0)
DY = MyArray1(1)

DX2 = MyArray2(0)
DY2 = MyArray2(1)

DX3 = MyArray3(0)
DY3 = MyArray3(1)

DX4 = MyArray4(0)
DY4 = MyArray4(1)

TracePrint DX
TracePrint DY

Call FindBarEntrance(DX, DY, hwnd)
Delay 1500
Call FindBarOwner(DX, DY, hwnd)
Delay 500

Call WalktoBarExit(hwnd)
Call FindBarExit(DX,DY,hwnd)

Sub WalktoBarExit(hwnd)
	BringWinOnTop(hwnd)
	KeyDown "Down", 1
	Delay 3000
	KeyUp "Down", 1
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

Sub FindBarEntrance(DX,DY,hwnd)
	For 3 // This loop is for rotating 90deg for 3 times
    	Call BringWinOnTop(hwnd)
    	Delay 10
    	For 195
        	KeyPress 9,1
        	Delay 200
        	IfColor DX + 636, DY + 330, "ffffff", 0 Then
        		TracePrint "Cond1 Pass"
            	IfColor DX + 667, DY + 329, "ffffff", 0 Then
            		TracePrint "Cond2 Pass"
                	IfColor DX + 683, DY + 330, "ffffff", 0 Then
                		TracePrint "Cond3 Pass"
                    	IfColor DX + 689, DY + 341, "ffffff", 0 Then
                    		TracePrint "Cond4 Pass"
                        	IfColor DX + 655, DY + 328, "ffffff", 0 Then
                        		TracePrint "Cond5 Pass"
                            	IfColor DX + 646, DY + 339, "ffffff", 0 Then
                            		TracePrint "Cond6 Pass"
                                	IfColor DX + 654, DY + 336, "ffffff", 0 Then
                                		TracePrint "Cond7 Pass"
                                    	IfColor DX + 635, DY + 339, "ffffff", 0 Then
                                    		TracePrint "Cond8 Pass"
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
	KeyPress 13,1 // Talk to Trader
	Delay 800 // Wait for talk options
End Sub


Sub FindBarOwner(DX,DY,hwnd)
	For 3 // This loop is for rotating 90deg for 3 times
    	Call BringWinOnTop(hwnd)
    	Delay 10
    	For 195
        	KeyPress 9,1
        	Delay 200
        	IfColor DX + 636, DY + 331, "ffffff", 0 Then
        		TracePrint "Cond1 Pass"
            	IfColor DX + 633, DY + 333, "ffffff", 0 Then
            		TracePrint "Cond2 Pass"
                	IfColor DX + 654, DY + 330, "ffffff", 0 Then
                		TracePrint "Cond3 Pass"
                    	IfColor DX + 667, DY + 330, "ffffff", 0 Then
                    		TracePrint "Cond4 Pass"
                        	IfColor DX + 685, DY + 330, "ffffff", 0 Then
                        		TracePrint "Cond5 Pass"
                            	IfColor DX + 682, DY + 339, "ffffff", 0 Then
                            		TracePrint "Cond6 Pass"
                                	IfColor DX + 666, DY + 339, "ffffff", 0 Then
                                		TracePrint "Cond7 Pass"
                                    	IfColor DX + 638, DY + 339, "ffffff", 0 Then
                                    		TracePrint "Cond8 Pass"
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
	KeyPress 13,1 // Approach BarOwner
	Delay 2000// Getting near
	KeyPress 13,1 // Talk
End Sub

Sub ChooseFood(DX, DY, hwnd)
	Call Move_Click(DX, DY, 646, 360) // Click Eat
	Delay 1000
	Call Move_Click(DX, DY, 446, 284) // Click Set Meal
	Delay 1000
	
	Call Move_Click(DX, DY, 219, 130) // Choose Drink 1
	Delay 500
	
	MouseWheel -6 
	
	Call Move_Click(DX, DY, 224, 186)//Choose Food 1
	Delay 500
	
	Call Move_Click(DX, DY, 224, 243)//Choose Food 2
	Delay 500
	
	Call Move_Click(DX, DY, 224, 302)//Choose Food 3
	Delay 500
	
	Call Move_Click(DX, DY, 219, 130)//Choose Drink 2
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
        		TracePrint "Cond1 Pass"
            	IfColor DX + 640, DY + 334, "ffffff", 0 Then
            		TracePrint "Cond2 Pass"
                	IfColor DX + 646, DY + 334, "ffffff", 0 Then
                		TracePrint "Cond3 Pass"
                    	IfColor DX + 657, DY + 334, "ffffff", 0 Then
                    		TracePrint "Cond4 Pass"
                        	IfColor DX + 629, DY + 342, "ffffff", 0 Then
                        		TracePrint "Cond5 Pass"
                            	IfColor DX + 637, DY + 342, "ffffff", 0 Then
                            		TracePrint "Cond6 Pass"
                                	IfColor DX + 646, DY + 342, "ffffff", 0 Then
                                		TracePrint "Cond7 Pass"
                                    	IfColor DX + 657, DY + 342, "ffffff", 0 Then
                                    		TracePrint "Cond8 Pass"
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