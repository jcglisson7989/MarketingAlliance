
TYPE
	AS3500HS_Control_Rec_typ : 	STRUCT 
		N_Targets_On_Dial : UDINT;
		Enable_Cure : ARRAY[0..1]OF UDINT;
	END_STRUCT;
	AS3500HS_Control_Cfg_typ : 	STRUCT 
		N_Encoder_Bits_SingleTurn : UDINT;
		Encoder_Position_Home : UDINT;
		Debounce_PiP : Debounce_Config_Struct;
		Threshold_AccelDecel_Trans_RPM : REAL;
		T_Exit_Decel_Automatically : REAL;
		Sim_Encoder : UDINT;
		Sim_Encoder_Cycles : UDINT;
		Sim_Encoder_Counts : UDINT;
		Target_Present_Pulse_Time_S : REAL;
	END_STRUCT;
END_TYPE
