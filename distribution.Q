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
MacroID=c314e9a2-15f1-4f03-8a30-b29500c5ab2f
Description=distribution
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
hwnd0 = 263976
hwnd1 = 132770
hwnd2 = 132942
hwnd3 = 133118
hwnd4 = 329232
ehwnd = 134132

sick_state = 2
sick_state_2 = 1
mouse_state = 8
fire_state = 16

Dim PlayerID(3)
PlayerID(0) = 6031955
PlayerID(1) = 6033147
PlayerID(2) = 6034843
PlayerID(3) = 6221865

Dim PlayerHWND(3)
PlayerHWND(0) = 132770
PlayerHWND (1) = 132942
PlayerHWND (2) = 133118
PlayerHWND(3) = 329232

//Call Plugin.Window.Move(Hwnd1, 100, 100)

state_add = &H0111FEA4
Water_add = &H0111FF5A
Food_add = &H0111FF5C
TargetID_add = &H0111AEA4


WATER = UPDATE_PLAYER_16Bit(Water_add)
FOOD = UPDATE_PLAYER_16Bit(Food_add)
WATER_MAX = MAX(WATER)
WATER_MIN = MIN(WATER)
FOOD_MAX = MAX(FOOD)
FOOD_MIN = MIN(FOOD)

If FOOD_MIN(0) < 20 Then 
	Call Dist_FOOD
End If

If WATER_MIN(0) < 20 Then 
	Call Dist_WATER
End If




