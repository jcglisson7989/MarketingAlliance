

PROGRAM _INIT
	Com_Logger_UI.Enable := TRUE;
	
//	Com_Logger_UI.MpLink := ADR(mpCOM_MAIN);
	
	Com_Logger_UI.Scope := mpCOM_CONFIG_SCOPE_BRANCH;

	Com_Logger_UI.UISetup.LoggerListSize := 8;
	Com_Logger_UI.UISetup.LoggerScrollWindow := 1;

	Com_Logger_UI.UIConnect := ADR(Com_Logger_UIConnect);
	
	Com_Logger_UI;
	Com_Logger_UIConnect;
END_PROGRAM