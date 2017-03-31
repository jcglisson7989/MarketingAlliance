
ACTION Action_HMI_Commands_Handler: 
	//Command from HMI to reset home position to encoder "0" position->
	IF CMD_Set_Home_Pos_0 THEN
		CMD_Set_Home_Pos_0 := FALSE;
		gRecCfg.active.Cfg.Control.Encoder_Position_Home := 0;
	END_IF;
	
	//Command from HMI to set home position as current encoder position->
	IF CMD_Set_Current_Pos_As_Home THEN
		CMD_Set_Current_Pos_As_Home := FALSE;
		gRecCfg.active.Cfg.Control.Encoder_Position_Home := Position.Single_Turn_Absolute;
	END_IF;
	
	//Command from HMI to reset stats counters->
	IF CMD_Reset_Statistics THEN
		CMD_Reset_Statistics := FALSE;
		brsmemset(ADR(gStatistics), 0, SIZEOF(AS3500HS_Stats_typ));
	END_IF;
END_ACTION
