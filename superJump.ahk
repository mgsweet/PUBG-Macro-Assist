;---------------------------------------
; Script Settings
;---------------------------------------
#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance force ; Forces the script to only run one at a time.
SetTitleMatchMode, 2 ; Sets mode for ifwinactive window.

;---------------------------------------   
; Crouch Jumping
;---------------------------------------
~$*space::
	Random,delay,400,600
	SendInput, {Space Down}{c down}{Space up}
	Sleep, %delay%
	SendInput, {c up}
Return
