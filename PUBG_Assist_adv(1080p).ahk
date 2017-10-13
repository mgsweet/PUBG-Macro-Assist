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

	vAutoFire := 1 ; Value for Autofire being on and off.
	isMouseShown() ; Value for suspending when mouse is visible.
	comp := 0 ; Value for compensation.

	gunID := 0 ; Value for the gun you are using. 0:default, 4:M4,SCAL, 5: UMP, 6: M16, 7:AK
	isX4used  := 0 ; Value for whether you have x4 telescope 

	gunComArr := Array() ;
	gunComArr[0] := Array(7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 9, 9, 9, 9, 8.9, 8.9, 8.9, 8.9, 8.9, 8.9, 8.9) ;AK
	gunComArr[1] := Array(20,20,20,20,20,20,20,20,20,20,37,37,37,37,28,28,28,28,28,28,28) ;AK with x4
	gunComArr[2] := Array(5,5,5,5,5,5,5,7,7,7,7,7,7,7,7,7,7,6,6,6,6,6) ;M4,SCAL
	gunComArr[3] := Array(26,26,26,26,26,26,26,45,45,45,45,29,29,29,29,29,29,29,29,29,29,29) ; M4, SCAL with x4
	gunComArr[4] := Array(5.5,5.5,5.5,5.5,5.5,5.5,5.5,6.9,6.9,6.9,6.9,7.1,7.1,7.1,7.1,7.1,7.1,7.1,7.1,7,7,7) ; ump9
	gunComArr[5] := Array(25,25,25,25,25,25,25,35,35,35,35,28,28,28,28,28,28,28,28,28,28,28) ; ump9 with x4
	gunComArr[6] := Array(7,7,7,7,7,7,7,13.6,13.6,13.6,13.6,10.2,10.2,10.2,10.2,10.2,10.2,10.2,10.2,8,8,8) ; M16
	gunComArr[7] := Array(26,26,26,26,26,26,26,45,45,45,45,29,29,29,29,29,29,29,29,29,29,29) ; M16 with x4


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
		if vAutoFire = 0
		{
			vAutoFire = 1 
			ToolTip("AutoFire ON")
		}
		else
		{
			vAutoFire = 0 
			ToolTip("AutoFire OFF")
		}
	Return

	~$*Numpad0::			; Resets compensation and gunID to 0
		gunID := 0
		comp := 0
		ToolTip(comp)
	Return	

	~$*NumPad1::(ADS = 0 ? (ADS := 1,ToolTip("ADS ON")) : (ADS := 0,ToolTip("ADS OFF")))

	~$*NumPad2::(V_AutoFir = 0 ? (V_AutoFir := 1,ToolTip("AutoFire ON")) : (V_AutoFir := 0,ToolTip("AutoFire OFF")))

	~$*Numpad3::(isX4used = 0 ? (isX4used := 1,ToolTip("x4 ON")) : (isX4used := 0,ToolTip("AutoFire OFF")))

	~$*Numpad4::			; Sets compensation value for M4
		gunID := 4
		ToolTip("M4")
	Return	

	~$*Numpad5::			; Sets compensation value for UMP
		gunID := 5
		ToolTip("UMP")
	Return	

	~$*Numpad6::			; Sets compensation value for M16
		gunID := 6
		ToolTip("M16")
	Return	

	~$*Numpad7::			; Sets compensation value for AKM
		gunID := 7
		ToolTip("AKM")
	Return	

	~$*Numpad8::			; Resets compensation value to 0
		gunID := 0
		comp := 8
		ToolTip(comp)
	Return	
	
	~$*NumpadAdd::			; Adds compensation value
		gunID := 0
		comp := comp + 1
		ToolTip(comp)
	Return
   
	~$*NumpadSub::			; Subtracts compenstooltipation value
		gunID := 0
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
		if vAutoFire = 1
		{
			step := 0
			Loop
			{
				GetKeyState, LButton, LButton, P
				if LButton = U
					Break
				MouseClick, Left,,, 1
				Gosub, RandomSleep

				if (Compensation = 1)
					if (gunID = 0)
   						mouseXY(0, comp) ;If active, call to Compensation.
   					else {
   						;0:default, 4:M4,SCAL, 5: UMP, 6: M16, 7:AK
   						if (gunID = 4) {
   							com_temp := isX4used ?  3 : 2
   							mouseXY(0, gunComArr[com_temp][step])
   							step := (step = gunComArr[com_temp].Length() ? step : step + 1)
   						}
   						else if (gunID = 5) {
   							com_temp := isX4used ?  5 : 4
   							mouseXY(0, gunComArr[com_temp][step])
   							step := (step = gunComArr[com_temp].Length()? step : step + 1)
   						}
   						else if (gunID = 6) {
   							com_temp := isX4used ?  7 : 6
   							mouseXY(0, gunComArr[com_temp][step])
   							step := (step = gunComArr[com_temp].Length()? step : step + 1)
   						}
   						else if (gunID = 7) {
   							com_temp := isX4used ?  1 : 0
   							mouseXY(0, gunComArr[com_temp][step])
   							step := (step = gunComArr[com_temp].Length()? step : step + 1)
   						}
   					}
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
  		SetTimer, RemoveToolTip, 1000 ;Removes tooltip after 1.3 seconds.
  		Return
	}
