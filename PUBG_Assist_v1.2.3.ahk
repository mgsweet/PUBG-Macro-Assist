; Assist for PUBG based on Wampa v2.7 and FxOxAxD's work
; mgsweet's edition.
;---------------------------------------
; Script Settings
;---------------------------------------
	
	#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
	#SingleInstance force ; Forces the script to only run one at a time.
	;SetTitleMatchMode, 2 ; Sets mode for ifwinactive window.
	;ifwinactive, 绝地求生
	;'#IfWinActive, ahk_exe TslGame.exe; Ensures Autofire only works in PUBG.
	
;---------------------------------------
; Variables
;---------------------------------------
	wantsRbeforeL := 1 ; If wants to be aiming before autofire or compensation.

	comp := 8 ; Value for auto fire compensation.

	tbs := 11 ;  value of Time between shot

	SCAL_TBS := 12 ; Time between shot of SCAL
	SCAL_COMP := 8 ; Compensation for SCAL

	AK_TBS := 13 ; Time between shot of AK
	AK_COMP := 8 ; Compensation for AK

	M4_TBS := 11 ; Time between shot of M4
	M4_COMP := 8 ; Compensation for M4

	GROZA_TBS := 10 ; Time between shot of GROZA
	GROZA_COMP := 5 ; Compensation for GROZA

	UMP_TBS := 12 ; Time between shot of UMP
	UMP_COMP := 7 ; Compensation for UMP
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
		if (isMouseShown() == 1) {
			Suspend On
		}
		else {
			Suspend Off
		}
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
; Autofire Setup
;---------------------------------------
	; ~$*NumPad1::(ADS = 0 ? (ADS := 1,ToolTip("ADS ON")) : (ADS := 0,ToolTip("ADS OFF")))

	; ~$*NumPad2::(V_AutoFire = 0 ? (V_AutoFire := 1, useOldMode := 1, strongComp := comp, comp := weakComp,ToolTip("Old Mode AUTOFIRE ON")) : (V_AutoFire := 0, useOldMode := 0,weakComp := comp,comp := strongComp,ToolTip("Old Mode AUTOFIRE OFF")))

	; ~$*NumPad3::(useOldMode = 0 ? (strongComp := comp, comp := weakComp,ToolTip(comp)) : (useOldMode := 0,weakComp := comp, comp := strongComp,ToolTip(comp)))

	; SCAL_TBS := 96 ; Time between shot of SCAL
	; AK_TBS := 100 ; Time between shot of AK
	; M4_TBS := 86 ; Time between shot of M4
	; GROZA_TBS := 80 ; Time between shot of GROZA

	~$*Numpad4::	
		tbs := M4_TBS	; M4 
		comp := M4_COMP
		ToolTip("M4")
	return

	~$*Numpad5::	
		tbs := UMP_TBS	; UMP 
		comp := UMP_COMP
		ToolTip("UMP")
	return

	~$*Numpad6::	
		tbs := SCAL_TBS	; SCAL
		comp := SCAL_COMP
		ToolTip("SCAL")
	return

	~$*Numpad7::	
		tbs := AK_TBS	; AK
		comp := AK_COMP
		ToolTip("AK")
	return

	~$*Numpad9::	
		tbs := GROZA_TBS	; AK
		comp := GROZA_COMP
		ToolTip("GROZA")
	return

	; Resets compensation value to 0
	~$*Numpad0::
		comp := 0
		ToolTip("no compensation")
	Return	

	; Resets compensation value to 8
	~$*Numpad8::	
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

	~$*NumpadEnter::(wantsRbeforeL = 0 ? (wantsRbeforeL := 1,ToolTip("Better grenades ON")) : (wantsRbeforeL := 0,ToolTip("Better grenades OFF")))

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
	~$*LButton::
		if (GetKeyState("RButton")  ||  wantsRbeforeL = 0) {	;  so while you throw grenades the com will not work;
            			Loop
			{
				GetKeyState, LButton, LButton, P
				if LButton = U 
					Break
				Random, random, tbs - 1, tbs + 1
				Sleep %random%

				Random, ramCom, - 2.0, 0.0
				;ToolTip(comp + ramCom)
                			mouseXY(0, comp + ramCom) ;If active, call to Compensation.
                		}
		}
	Return


;---------------------------------------
; Fast Aiming
;---------------------------------------
	; $*RButton:: ;Fast Aiming [default: Right Button]
	; 	if ADS = 1
	; 	{
	; 	 	;If active, clicks once and clicks again when button is released.
 ;  			SendInput, {RButton}
 ;  			SendInput {RButton Down}
 ;  			KeyWait, RButton
 ;  			SendInput {RButton Up}
	; 	} else {
	; 		;If not, just keeps holding until button is released.
 ;  			SendInput {RButton Down}
 ;  			KeyWait, RButton
 ;  			SendInput {RButton Up}
	; 	}
	; Return


;---------------------------------------
; Tooltips and Timers
;---------------------------------------	
	RandomSleep:			; Random timing between Autofire shots
		Random, random, 19, 25
		Sleep %random%-5
	Return
	
	RemoveToolTip:			; Used to remove tooltips.
	   SetTimer, RemoveToolTip, Off
	   tooltip
	Return

	ToolTip(label) ;Function to show a tooltip when activating, deactivating or changing values.
	{
		; activeMonitorInfo(Width, Height) ;
		; xPos := Width / 2 - 30
 		; yPos := Height / 2 + (Height / 10)

  		ToolTip, %label%, 930, 650 ;Tooltips are shown under crosshair for FullHD monitors.
  		SetTimer, RemoveToolTip, 1300 ;Removes tooltip after 1.3 seconds.
  		Return
	}

;---------------------------------------
; Get Width and Height
;---------------------------------------

	; activeMonitorInfo(ByRef Width,  ByRef  Height)
	; { ; Retrieves the size of the monitor, the mouse is on
	; 	CoordMode, Mouse, Screen
	; 	MouseGetPos, mouseX , mouseY
	; 	SysGet, monCount, MonitorCount
	; 	Loop %monCount%
 ;   		{
 ;   			SysGet, curMon, Monitor, %a_index%
 ;       	 		if ( mouseX >= curMonLeft and mouseX <= curMonRight and mouseY >= curMonTop and mouseY <= curMonBottom ) {
	; 			Height := curMonBottom - curMonTop
	; 			Width  := curMonRight  - curMonLeft
	; 			return
	; 		}
 ;   		}
	; }
