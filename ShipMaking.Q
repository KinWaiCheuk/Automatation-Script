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
MacroID=a8e9bbf9-1c5d-42be-9ed7-9d8e312016b3
Description=ShipMaking
Enable=1
AutoRun=0
[Repeat]
Type=0
Number=100
[SetupUI]
Type=2
QUI=
[Relative]
SetupOCXFile=
[Comment]

[Script]
Dim DX1, DX2, DX3, DX4, DY1, DY2, DY3, DY4
hwnd0 = 394054
hwnd1 = 5376750
hwnd2 = 2624966
hwnd3 = 328942
hwnd4 = 68620
ehwnd = 134132

sick_state = 2
mouse_state = 8
fire_state = 16
//Call Plugin.Window.Move(hwnd1, 100, 100)
VBS state_add=&H0111FEA4
MP_add = &H0111FF48
OLstatus3_add = &H0112412C
OLstatus1_add = &H0111FDEC
TargetID_add = &H0111AEA4
Day_add = &H011240E4
Money_add = &H0111FF50

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

//-----------------Start of Prog-------------------

Day_count = Plugin.Memory.Read32Bit(hwnd2, Day_add)
While True
    Call Check_day
    Delay 10000
Wend


Rem Done
Delay 4000

Call EnterCity(hwnd2, DX2, DY2)
Delay 15000

Call FindShipMaker(hwnd2)
Delay 1000

Call SellShip
Call MakeShip
Delay 1000

Money = Plugin.Memory.Read32Bit(hwnd2, Money_add)
If Money < 200000 Then 
	GotoBank
	Call FindBanker(hwnd2)
	Delay 1000
	Call Withdraw_money
End If

Delay 1200


Call Leaving
Delay 4000
Call Supply
Delay 500
Call SailOut






// -------------------Functions----------------

Sub SailOut
	Call Plugin.Bkgnd.LeftClick(hwnd2, 645, 355) // Open sail meun
	Delay 800
	Call Plugin.Bkgnd.LeftClick(hwnd2, 564, 402)// Sail out
End Sub


Sub Move_Click(DX,DY, X,Y)
    MoveTo DX + X, DY + Y//Move to supply button
    Delay 250
    LeftClick 1
End Sub


Sub EnterCity(hwnd, DX,DY)
	//BringWinOnTop (hwnd)
	Delay 1500
	//Call Move_Click(DX, DY, 644, 382)//Click Enter
	Call Plugin.Bkgnd.LeftClick(hwnd,644,382)

	Delay 5000
	Call OpenMap(hwnd2)
	Delay 800
	//Call Move_Click(DX, DY, 662, 190)// Click port near trader
	Call Plugin.Bkgnd.LeftClick(hwnd,662,190)
	

End Sub

Sub BringWinOnTop(hwnd)
	Call Plugin.Window.Active(hwnd)
	Call Plugin.Window.Restore(hwnd)
End Sub

Sub OpenMap(hwnd)
	//BringWinOnTop(hwnd)
	Call Plugin.Bkgnd.KeyPress(hwnd, 112)
	
End Sub


Sub FindShipMaker(hwnd)
	BringWinOnTop(hwnd)
    For 195
    	KeyPress 9, 1
    	TargetID = Int(Plugin.Memory.Read32Bit(hwnd2, TargetID_add))
        Delay 100
		If TargetID = 25170001 Then 
			TracePrint "Found"
			Goto Found
		End If
		Next
	Rem Found
	KeyPress 13,1 //Talk
End Sub

Sub FindPortOfficer(hwnd)
	BringWinOnTop(hwnd)
    For 195
    	KeyPress 9, 1
    	TargetID = Int(Plugin.Memory.Read32Bit(hwnd2, TargetID_add))
		TracePrint "Finding port officer"
        Delay 100
		If TargetID = 25170000 Then 
			Goto Found
		End If
		Next
	Rem Found
	KeyPress 13,1 //Talk
End Sub

Sub FindBanker(hwnd)
	BringWinOnTop(hwnd)
    For 195
    	KeyPress 9, 1
    	TargetID = Int(Plugin.Memory.Read32Bit(hwnd2, TargetID_add))

        Delay 100
		If TargetID = 25170034 Then 
			Goto Found
		End If
		Next
	Rem Found
	KeyPress 13,1 //Talk
End Sub



Sub MakeShip
	Delay 1000
	Call Plugin.Bkgnd.LeftClick(hwnd2,651,386) // Choose make new ship option
	Delay 2500
	TracePrint "Confirm"
	Call Plugin.Bkgnd.KeyPress(hwnd2, 13)// Confirm Make new ship
	Delay 2000
	For 7
		Call Plugin.Bkgnd.KeyPress(hwnd2, 40) //Pick the right ship
	Next
	Delay 300
	Call Plugin.Bkgnd.KeyPress(hwnd2, 13)// Choose wood
	Delay 300
	Call Plugin.Bkgnd.KeyPress(hwnd2, 13)// Change size
	
	Call Plugin.Bkgnd.LeftClick(hwnd2, 654, 440)//next step
	Delay 300
	Call Plugin.Bkgnd.KeyPress(hwnd2, 65)// Give name
	Delay 100
	Call Plugin.Bkgnd.LeftClick(hwnd2, 670, 434)//next step	
End Sub

Sub SellShip
	Call Plugin.Bkgnd.LeftClick(hwnd2,685,359) // Cancel popup	
	Delay 2000
	TracePrint "Cancel popup"
	Call Plugin.Bkgnd.LeftClick(hwnd2,642,359) // Cancel unknown meun	
	Delay 1000
	Call Plugin.Bkgnd.LeftClick(hwnd2,688,358) // Choose Sell ship option
	TracePrint "Open sell ship meun"
	Delay 2000
	Call Plugin.Bkgnd.KeyPress(hwnd2, 40)//Select second ship
	TracePrint "Select second ship"
	Delay 200
	Call Plugin.Bkgnd.KeyPress(hwnd2, 13)
	Delay 200
	Call Plugin.Bkgnd.KeyPress(hwnd2, 13)// Confirm Sell ship
End Sub

Sub Check_day
Day_count = Plugin.Memory.Read32Bit(hwnd2, Day_add)

	If Day_count > 5 Then 
		Call EnterPort
		Goto Done
	End If
End Sub


Sub EnterPort
	BringWinOnTop(hwnd0)
	Call Plugin.Bkgnd.KeyPress(hwnd0, 116)//Press F5
	Delay 500
	SayString "back"
	KeyPress "Enter", 1
	Delay 300
	
	Call Plugin.Window.Active(hwnd0)
	Delay 300
	Call Plugin.Bkgnd.KeyPress(hwnd0, 121)//F10
	Delay 300
	Call Plugin.Bkgnd.KeyPress(hwnd0, 83)//S
	Delay 300
	Call Plugin.Bkgnd.KeyPress(hwnd0, 82)//R	
	
End Sub

Sub Leaving
	Call OpenMap(hwnd2)
	Delay 500
	Call Plugin.Bkgnd.LeftClick(hwnd2, 567, 272) // Click Port
	Delay 4000
	FindPortOfficer (hwnd2)
	Delay 1500
	Call Plugin.Bkgnd.LeftClick(hwnd2, 649, 355) // Go to shi[	
End Sub

Sub Supply
	Call Plugin.Bkgnd.LeftClick(hwnd2, 686, 355) // Open food meun
	Delay 1000
	Call Plugin.Bkgnd.LeftClick(hwnd2, 211, 362) // Add food
	Delay 500
	Call Plugin.Bkgnd.LeftClick(hwnd2, 596, 402) // confirm
	Delay 500	
End Sub



// Withdrawing money
Sub Withdraw_money
	Call Plugin.Bkgnd.LeftClick(hwnd2, 679, 355) // Click withdraw
	Delay 1000
	
	//Enter 500,000
	Call Plugin.Bkgnd.KeyPress(hwnd2, 101)
	Call Plugin.Bkgnd.KeyPress(hwnd2, 96)
	Call Plugin.Bkgnd.KeyPress(hwnd2, 96)
	Call Plugin.Bkgnd.LeftClick(hwnd2, 506, 341)	
End Sub

Sub GotoBank
	OpenMap (hwnd2)
	Delay 500
	Call Plugin.Bkgnd.LeftClick(hwnd2, 599, 129)
	Delay 12000
End Sub	