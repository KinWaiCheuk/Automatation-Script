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
MacroID=f49da9b2-772b-499b-8650-d9e113107436
Description=Sandbox
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

hwnd = 197874
hwnd3  = 68702

counter = 0
refresh = 0
While refresh < 5
	TracePrint "Do me every step"
	If counter = 5 Then 
		TracePrint "Refresh me"
		counter = 0
		refresh = refresh+1
	End If
	counter = counter+1
Wend

s1 = Plugin.Window.GetClientRect(hwnd)

MyArray1 = Split(s1, "|", -1, 1)


DX1 = MyArray1(0)
DY1 = MyArray1(1)

TracePrint DX
TracePrint DY


MoveTo DX1 + 629, DY1 + 330
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
	cond(2) = - 1 
End If

TracePrint cond(0)
TracePrint cond(1)
TracePrint cond(2)

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
