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
; Variables
;---------------------------------------

	ADS := 1 ; Value for fast aiming.
	isAimming := 0
	isMouseShown() ; Value for suspending when mouse is visible.

;---------------------------------------   
; Suspend if mouse is visible
;---------------------------------------   

	isMouseShown()			; Suspends the script when mouse is visible ie: inventory, menu, map.
	{
		StructSize := A_PtrSize + 16
		VarSetCapacity(InfoStruct, StructSize)
		NumPut(StructSize, InfoStruct)
		DllCall("GetCursorInfo", UInt, &InfoStruct)
		Result := NumGet(InfoStruct, 8)

	if Result > 1
     		 Return 1
	else
      		Return 0
	}
	Loop
	{
		if isMouseShown() == 1
			Suspend On
		else
			Suspend Off
		Sleep 1
	}

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

;---------------------------------------
; Fast Aiming
;---------------------------------------
	$*RButton:: ;Fast Aiming [default: Right Button]
		if ADS = 1
		{
		 	;If active, clicks once and clicks again when button is released.
  			SendInput, {RButton}
  			SendInput {RButton Down}
  			KeyWait, RButton
  			SendInput {RButton Up}
		} else {
			;If not, just keeps holding until button is released.
  			SendInput {RButton Down}
  			KeyWait, RButton
  			SendInput {RButton Up}
		}
	Return

	~$*NumPad1::(ADS = 0 ? (ADS := 1,ToolTip("ADS ON")) : (ADS := 0,ToolTip("ADS OFF")))

;---------------------------------------
; Tooltips and Timers
;---------------------------------------	
	RandomSleep:			; Random timing between Autofire shots
		Random, random, 14, 25
		Sleep %random%-5
	Return
	
	RemoveToolTip:			; Used to remove tooltips.
	   SetTimer, RemoveToolTip, Off
	   tooltip
	Return

	ToolTip(label) ;Function to show a tooltip when activating, deactivating or changing values.
	{
  		ToolTip, %label%, 930, 650 ;Tooltips are shown under crosshair for FullHD monitors.
  		SetTimer, RemoveToolTip, 1300 ;Removes tooltip after 1.3 seconds.
  		Return
	}

