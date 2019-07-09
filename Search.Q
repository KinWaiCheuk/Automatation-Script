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
MacroID=620616c7-6722-4a14-ae99-dca9d093cecd
Description=Search
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
hwnd1 = 328680
hwnd2 = 197548
hwnd3 = 263098
hwnd4 = 330568
hwnd5 = 525146




//While i < 50
//	Call Plugin.Bkgnd.KeyPress(132392,112)
//	Delay 4000
//Wend


While i < 1
//	Call Plugin.Bkgnd.KeyPress(hwnd1,13)
//	Call Plugin.Bkgnd.KeyPress(hwnd2, 13)
//	Call Plugin.Bkgnd.KeyPress(hwnd3, 13)
//	Call Plugin.Bkgnd.KeyPress(hwnd4, 13)
//	Call Plugin.Bkgnd.KeyPress(hwnd5, 13)
//	
//	Call Plugin.Bkgnd.LeftClick(hwnd1, 400 ,267)
//	Call Plugin.Bkgnd.LeftClick(hwnd2, 400 ,267)
//	Call Plugin.Bkgnd.LeftClick(hwnd3, 400 ,267)
//	Call Plugin.Bkgnd.LeftClick(hwnd4, 400 ,267)
	Call Plugin.Bkgnd.LeftClick(hwnd5, 400 ,267)
//	
	i = i + 1
	Delay 300
Wend