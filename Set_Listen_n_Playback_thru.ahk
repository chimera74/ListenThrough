;this script sets "Listen to this device/playback through this device" to selected devices
;usage example: Set_Listen_n_Playback_thru.ahk "Spk (Logitech G35 Headset)"
#NoEnv
#SingleInstance force

if A_Args.Length() < 2
{
	MsgBox % "This script requires 2 parameters but it only received " A_Args.Length() "."
    ExitApp
}

Run, "mmsys.cpl"

WinWait,Звук
;Recording tab:
ControlSend,SysTabControl321,{Right}
sleep 100

;"Spk (Logitech G35 Headset)"
;"Spk (ASUS XONAR PHOEBUS"

Set_Listen_n_Playback_thru(A_Args[1],A_Args[2])

WinWait,Звук
ControlClick,Button4
ExitApp


Set_Listen_n_Playback_thru(_a, _n)
{
    local s, r, p, n:=_n
    ;MsgBox %n%

    WinWait,Звук
    ControlSend,SysListView321,{Home}
    
    ControlGet, s, List, , SysListView321
    Loop Parse, s, `n  ;Rows r delimited by linefeeds (`n)
    {
        r:=A_Index
        Loop Parse, A_LoopField, %A_Tab%  ;Fields (columns) in each row r delimited by tabs (A_Tab)
        {
            if (A_LoopField=n)
            {
                p:=r-1
            ;MsgBox "Row #%r% Col #%A_Index% is %A_LoopField%."
            }
        }
    }

    ControlSend,SysListView321,{Down %p%}
    ControlClick,Button3

    WinWait,Свойства
    ControlSend,SysTabControl321,{Right}
    sleep 100

    ;Button1 = Listen to this device:
    ControlGet, s, Checked, , Button1
    if (!s)
        ControlClick,Button1

    ;Button3 = Continue running when on battery power:
    ControlGet, s, Checked, , Button3
    if (!s)
        ControlClick,Button3

    ;ComboBox1 = playback through this device:
    ControlGet, s, List, , ComboBox1
    ;MsgBox %s%
    Loop Parse, s, `n
    {
        if (A_LoopField=_a)
            p:=A_Index-1
    }
    ;MsgBox %p%
    
    ControlSend,ComboBox1,{Home}
    ControlSend,ComboBox1,{Down %p%}
    ControlClick,Button7
    ControlClick,Button5
    return
}
