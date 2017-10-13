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
	Compensation := 1 ; Value for compensation when autofiring.

	V_AutoFire := 0 ; Value for Autofire being on and off.
	isMouseShown() ; Value for suspending when mouse is visible.
	comp := 0 ; Value for compensation.
	isAimming := 0;
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
; Disable Mouse Wheel
;---------------------------------------

	;WheelUp::Return 			; Disables Mouse Wheel Up.
	;~$*WheelUp::Return 			; Disables Mouse Wheel Up.
	;WheelDown::Return 			; Disables Mouse Wheel Up.
	;~$*WheelDown::Return 		; Disables Mouse Wheel Down.

;---------------------------------------   
; Crouch Jumping
;---------------------------------------

 	~$*space::
		Random,delay,400,600
		SendInput, {Space Down}{c down}{Space up}
		Sleep, %delay%
		SendInput, {c up}
	Return
   
;---------------------------------------
; Autofire Setup
;---------------------------------------
	~$*b::					; Swaps the state of Autofire with the press of "B".
		if V_AutoFire = 0
		{
			V_AutoFire = 1 
			ToolTip("AutoFire ON")
		}
		else
		{
			V_AutoFire = 0 
			ToolTip("AutoFire OFF")
		}
	Return

	~$*NumPad1::(ADS = 0 ? (ADS := 1,ToolTip("ADS ON")) : (ADS := 0,ToolTip("ADS OFF")))

	~$*NumPad2::(V_AutoFir = 0 ? (V_AutoFir := 1,ToolTip("AutoFire ON")) : (V_AutoFir := 0,ToolTip("AutoFire OFF")))

	~$*Numpad0::			; Resets compensation value to 0
		comp := 0
		ToolTip(comp)
	Return	

	~$*Numpad8::			; Resets compensation value to 0
		comp := 8
		ToolTip(comp)
	Return	
	
	~$*NumpadAdd::			; Adds compensation value
		comp := comp + 1
		ToolTip(comp)
	Return
   
	~$*NumpadSub::			; Subtracts compenstooltipation value
		comp := comp - 1
		ToolTip(comp)
	Return

	~$*NumpadEnter::		; Displays compensation value
	 	ToolTip(comp)
	Return	

;---------------------------------------
;Compensation
;---------------------------------------

	mouseXY(x,y) ;Moves the mouse down to compensate recoil (value in compVal var).
	{
  		DllCall("mouse_event",uint,1,int,x,int,y,uint,0,int,0)
	}
   
;---------------------------------------
; Auto Firing
;---------------------------------------
	~$*LButton::			; Fires Automaticly when Autofire is on.
		if V_AutoFire = 1
		{
			Loop
			{
				GetKeyState, LButton, LButton, P
				if LButton = U
					Break
				MouseClick, Left,,, 1
				Gosub, RandomSleep

				if Compensation = 1
   					mouseXY(0, comp) ;If active, call to Compensation.
			}
		}
	Return 


;---------------------------------------
; Fast Aiming
;---------------------------------------
	$*RButton:: ;Fast Aiming [default: Right Button]
		if ADS = 1
		{
		 	;If active, clicks once and clicks again when button is released.
  			SendInput {RButton Down}
  			SendInput {RButton Up}
  			KeyWait, RButton
  			SendInput {RButton Down}
  			SendInput {RButton Up}
		} else {
			;If not, just keeps holding until button is released.
  			SendInput {RButton Down}
  			KeyWait, RButton
  			SendInput {RButton Up}
		}
	Return


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
