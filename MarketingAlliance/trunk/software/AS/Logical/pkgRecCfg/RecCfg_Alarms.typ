
TYPE
	HERNON_Alarm_RecCfg_typ : 	STRUCT 
		Belt_Length_Configuration_Error : BOOL; (*0*)
		Line_Scaling_Error : BOOL; (*1*)
		ACP_VCtrl_Scale_Error : BOOL; (*2*)
		App_SSI_Encoder_Config_Error : BOOL; (*3*)
		Invalid_Par_StartRequest : BOOL; (*4*)
		Invalid_Config_DispenseStart : BOOL; (*5*)
		Invalid_Config_InspectStart : BOOL; (*6*)
		Mechanics_Restart_Required : BOOL; (*7*)
		Default_Cfg_Set : BOOL; (*8*)
		Default_Rec_Set : BOOL; (*9*)
	END_STRUCT;
END_TYPE
