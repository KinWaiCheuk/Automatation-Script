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
MacroID=018f6f7a-9435-4fb5-9324-938f4727f253
Description=WQM-һ������
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
//
UserVar diange="katy perry" "�������"
Delay 200
//��ȡ���������ID
Call Plugin.Web.Bind("WQM.exe")
//��ת��ҳ
Call Plugin.Web.Go("http://mp3.baidu.com/")
Delay 500
//����ҳ��ѯ�����������
Call Plugin.Web.HtmlInput(diange,"id:ww")
Delay 500
//�������
Call Plugin.Web.HtmlClick("tag:INPUT&value:�ٶ�һ��")
Delay 1500
//�������
Call Plugin.Web.HtmlClick("tag:A&txt:����&index:0")
Call Plugin.Web.Tips("���ֲ����У������ͣ�")

