
TYPE
	HERNON_Machine_Types_Enum : 
		(
		AS5200 := 0,
		AS5215A_HS_BD := 1,
		AS5215B_HS := 2
		);
	Global_State_Enum : 
		(
		gSTATE_INIT := 0,
		gSTATE_POWER_AXES := 1,
		gSTATE_HOME_AXES := 2,
		gSTATE_WAIT := 3,
		gSTATE_START_REQUESTED := 4,
		gSTATE_RUNNING := 5,
		gSTATE_MANUAL := 6,
		gSTATE_STOPPED := 7,
		gSTATE_EMERGENCY_STOP := 8,
		gSTATE_WAIT_RESET := 9,
		gSTATE_WAIT_MOTOR_POWERON_RDY := 10,
		gSTATE_POWERON_AXES := 11,
		gSTATE_MOTION_START := 12,
		gSTATE_MOTION_ERROR := 13,
		gSTATE_COUPLE_AXES := 14,
		MAX_IDX_GSTATE
		);
	HERNON_Inline_Machine_typ : 	STRUCT 
		Belt : HERNON_Inline_Belt_typ;
		IO : HERNON_Inline_IO_typ;
		oState : Global_State_Enum;
	END_STRUCT;
END_TYPE
