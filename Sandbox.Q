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
MacroID=55eeb3ab-87ee-4820-996b-2e929eeba54b
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
//hwnd0 = Plugin.Window.Find("Afx:00400000:b:00010003:00000006:00240439", "athrun200 - ÉñÂ}Œ§º½")
//TracePrint hwnd0

Dim DX1, DX2, DX3, DX4, DY1, DY2, DY3, DY4

hwnd = 133474
hwnd2 = 134180
hwnd3 = 68702
hwnd4 = 68714

BringWinOnTop(hwnd)
Call Plugin.Bkgnd.LeftDown(hwnd,173,131)

Call Plugin.Bkgnd.LeftClick(hwnd, 173,131)
//Call FindTrader(DX, DY, hwnd)
Delay 300
Call SellItemsA(DX, DY, hwnd)
Delay 800
Call BuyItemsA(DX, DY, hwnd)
Delay 800


Sub SellItemsA(DX,DY,hwnd)
	Call BringWinOnTop(hwnd)
	KeyPress 13,1 // Talk to Trader
	Delay 800 // Wait for talk options
	
	//Call Move_Click(DX, DY, 680, 359)// Option = Sell
	Call Plugin.Bkgnd.LeftClick(hwnd, 680,359)
	Delay 800
	
	//Call Move_Click(DX, DY, 286, 89)// Sell all
	Call Plugin.Bkgnd.LeftClick(hwnd, 286,89)
	Delay 800
	
	
	//Call Move_Click(DX, DY, 456, 341)// Bargain
	Call Plugin.Bkgnd.LeftClick(hwnd, 456,341)
	Delay 800
	
	//Call Move_Click(DX, DY, 647, 423)// Confirm
	Call Plugin.Bkgnd.LeftClick(hwnd, 647,423)
End Sub

Sub BringWinOnTop(hwnd)
	Call Plugin.Window.Active(hwnd)
	Call Plugin.Window.Restore(hwnd)
End Sub


Sub BuyItemsA(DX, DY, hwnd)
	Call BringWinOnTop(hwnd)
	Call Plugin.Bkgnd.LeftClick(hwnd, 640,357)
	//Call Move_Click(DX, DY, 640, 357) // Option = Buy
	Delay 800
	
	//Call Move_Click(DX, DY, 235, 261)// Buy the 1st target product
	Call Plugin.Bkgnd.LeftClick(hwnd, 235,261)
	Delay 200
	//KeyPress 107, 1
	Call Plugin.Bkgnd.KeyPress(hwnd, 107)

	Delay 200
	//KeyPress 13, 1
	Call Plugin.Bkgnd.KeyPress(hwnd, 13)
	Delay 200
	
	MouseWheel -6
	
	//Call Move_Click(DX, DY, 201, 195)// Buy the 2nd target product
	Call Plugin.Bkgnd.LeftClick(hwnd, 201,195)
	Delay 200
	//KeyPress 107, 1
	Call Plugin.Bkgnd.KeyPress(hwnd, 107)
	Delay 200
	//KeyPress 13, 1
	Call Plugin.Bkgnd.KeyPress(hwnd, 13)
	Delay 200
	
	//Call Move_Click(DX, DY, 235, 261)// Buy the 3rd target product
	Call Plugin.Bkgnd.LeftClick(hwnd, 235,261)
	Delay 200
	//KeyPress 107, 1
	Call Plugin.Bkgnd.KeyPress(hwnd, 107)
	Delay 200
	//KeyPress 13, 1
	Call Plugin.Bkgnd.KeyPress(hwnd, 13)
	Delay 200
	
	//Call Move_Click(DX, DY, 235, 300)// Buy the 3rd target product
	Call Plugin.Bkgnd.LeftClick(hwnd, 235,300)
	Delay 200
	//KeyPress 107, 1
	Call Plugin.Bkgnd.KeyPress(hwnd, 107)
	Delay 200
	//KeyPress 13, 1
	Call Plugin.Bkgnd.KeyPress(hwnd, 13)
	Delay 200
	
	//Call Move_Click(DX, DY, 428, 304)// Bargain
	Call Plugin.Bkgnd.LeftClick(hwnd, 428,304)
	Delay 500
	
	//Call Move_Click(DX, DY, 647, 423)// Confirm	
	Call Plugin.Bkgnd.LeftClick(hwnd, 647,423)
End Sub
