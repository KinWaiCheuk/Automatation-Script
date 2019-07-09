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
MacroID=e6c57f63-8a42-485a-bce7-4bb04c586890
Description=ÎÒµÄ½Å±¾1
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
VBS Dim DX,DY
s1 = Plugin.Window.GetClientRect(197874)
s2 = Plugin.Window.GetClientRect(134180)
s3 = Plugin.Window.GetClientRect(68702)
s4 = Plugin.Window.GetClientRect(hwnd4)

TracePrint s1

MyArray = Split(s1, "|", - 1 , 1)

DX = MyArray(0)
DY = MyArray(1)

TracePrint DX
TracePrint DY

MoveTo DX+597,DY+404
