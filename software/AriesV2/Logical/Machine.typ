
TYPE
	CreaserPrcsState_Enum : 
		(
		PRCS_STATE_INIT := 0,
		PRCS_STATE_READY := 1,
		PRCS_STATE_FEED_BOARD := 2,
		PRCS_STATE_MOVE_CREASE := 3,
		PRCS_STATE_CREASE := 4,
		PRCS_STATE_MOVE_CREASE_WIDTH := 5,
		PRCS_STATE_ERROR := 6,
		PRCS_STATE_EJECT_FINISHED_BOARD := 7,
		PRCS_STATE_SOFT_STOP := 8
		);
	AriesMachineState_Enum : 
		(
		MACHINE_STATE_INIT := 0,
		MACHINE_STATE_IDLE := 1,
		MACHINE_STATE_RUNNING := 2,
		MACHINE_STATE_ERROR := 3,
		MACHINE_STATE_HARDWARE_INIT := 4,
		MACHINE_STATE_AXIS_POWER := 5,
		MACHINE_STATE_AXIS_HOME := 6
		);
END_TYPE

(*Insert your comment here.*)

TYPE
	CreaserConfig_typ : 	STRUCT 
		FeedAxisAccel : REAL;
		FeedAxisDecel : REAL;
	END_STRUCT;
	AriesCreaserParams_typ : 	STRUCT 
		CreaseDistance_mm : ARRAY[0..MAX_IDX_CREASES]OF REAL;
		CreaseWidth_mm : REAL;
		CreaseCount : UDINT;
		ShaftSensorEdge : UDINT;
		CreaserDirection : UDINT;
		CreaserMotorIdxLag_S : REAL;
	END_STRUCT;
END_TYPE

(*Insert your comment here.*)

TYPE
	AriesIOPoints_typ : 	STRUCT 
		oCreaserCCWRotation : BOOL;
		oCreaserCWRotation : BOOL;
		oBoardFeedingLight : BOOL;
		oUIIndicatorLight : BOOL;
		iSafeMachineState : BOOL;
		iCreaserShaftSensor : BOOL;
		iFiberOpticSensor : BOOL;
		iSM1Disabled : BOOL;
	END_STRUCT;
END_TYPE

(*Insert your comment here.*)

TYPE
	Machine_Alarms_typ : 	STRUCT 
		SM1_Disabled : BOOL;
		Unsafe_Machine_State : BOOL;
		Fiber_Optic_Blocked_RunCmd : BOOL;
		Creaser_Shaft_Edge_Timeout : BOOL;
		Error_State_Unsafe_Machine : BOOL;
		Error_State_SM1_Power : BOOL;
		Feed_Axis_Motor_Error : BOOL;
		Crease_Count_Greater_Max : BOOL;
		Error_State_Process_Error : BOOL;
	END_STRUCT;
	Global_Statistics_typ : 	STRUCT 
		total_runtime : UDINT;
		runtime_h : UDINT;
		runtime_m : UDINT;
		runtime_s : UDINT;
		total_processed : UDINT;
		Reset : BOOL;
		total_creases : UDINT;
		Sum_Board_Travel_Lengths : REAL;
		Avg_Board_Length : REAL;
	END_STRUCT;
END_TYPE
