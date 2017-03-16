
PROGRAM _INIT
	Data_Log_Control.MpLink := ADR(Data_Log_MpLink);
	Data_Log_Control.Enable := TRUE;
	Data_Log_Control.Header := ADR(Data_Log_Header);
	Data_Log_Control.DeviceName := ADR('Data_Log');
//	Data_Log_Control.RecordMode := mpDATA_RECORD_MODE_TRIGGER;
	Data_Log_Control.RecordMode := mpDATA_RECORD_MODE_TIME;
	Data_Log_Control.Record := TRUE;
	Data_Log_Control();
//	
	Data_Table_Control.MpLink := ADR(Data_Log_MpLink);
	Data_Table_Control.Enable := TRUE;
	Data_Table_Control.UISetup.ValueListSize := 10;
	Data_Table_Control.UISetup.ValueListScrollWindow := 1;
	Data_Table_Control.UISetup.PVListSize := 5;
	Data_Table_Control.UISetup.PVListScrollWindow := 1;
	Data_Table_Control.UIConnect := ADR(Data_Table_UIConnect);
	Data_Table_Control();
	Data_Table_UIConnect;
	 
END_PROGRAM

PROGRAM _CYCLIC
	Data_Log_Control.Record := TRUE;
//	Data_Log_Control.SamplingTime := Tms(gRecCfg.active.Cfg.Mechanics.T_Record_Data_S);
//	Data_Log_Control.SamplingTime := Tms(600); //TODO: Change back
	
	Data_Log_Config;
	Data_Log_Config_Struct;
	Data_Log_Control;
	Data_Log_Header;
	Data_Log_RegPar;
	
	Data_Log_Control.Trigger := FALSE;
	
	Data_Table_Control();
	Data_Table_UIConnect;
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

