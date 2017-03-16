
PROGRAM _INIT
	Energy_Control.MpLink := ADR(Energy_MpLink);
	Energy_Control.Enable := TRUE;
	Energy_Control.DeviceName := ADR('Energy');
	Energy_Control();
	Energy_UI.MpLink := ADR(Energy_MpLink);
	Energy_UI.Enable := TRUE;
	Energy_UI.UISetup.ModuleListSize := 5;
	Energy_UI.UISetup.ModuleScrollWindow := 10;
	Energy_UI.UIConnect := ADR(Energy_UIConnect);
	Energy_UI();
	Energy_UIConnect;
END_PROGRAM

PROGRAM _CYCLIC
	Energy_Control();
	Energy_UI();
	Energy_UIConnect;
END_PROGRAM

PROGRAM _EXIT
	
	 
END_PROGRAM

