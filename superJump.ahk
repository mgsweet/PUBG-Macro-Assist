; Assist for PUBG based on Wampa v2.7 and FxOxAxD's work
; mgsweet's edition.
;---------------------------------------
; Script Settings
;---------------------------------------
	
	#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
	#SingleInstance force ; Forces the script to only run one at a time.
	SetTitleMatchMode, 2 ; Sets mode for ifwinactive window.
	#ifwinactive, PLAYERUNKNOWN'S BATTLEGROUNDS ; Ensures Autofire only works in PUBG.

;---------------------------------------   
; Crouch Jumping
;---------------------------------------

 	*$space::
		Random,delay,450,525
		SendInput, {Space Down}{c down}
		Sleep, %delay%
		SendInput, {c up}
		SendInput, {Space}  ; To fix keep crouching.
		SendInput, {Space down} ; To fix swim bug.
		KeyWait, Space
		SendInput, {Space up}
	Return
