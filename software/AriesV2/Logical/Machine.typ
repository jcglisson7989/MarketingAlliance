
TYPE
	AriesCreaserParams_typ : 	STRUCT 
		CreaseDistance_mm : ARRAY[0..MAX_IDX_CREASES]OF REAL;
		CreaseWidth_mm : REAL;
		CreaseCount : UDINT;
	END_STRUCT;
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
	Machine_Alarms_typ : 	STRUCT 
		SM1_Disabled : BOOL;
		Unsafe_Machine_State : BOOL;
		Fiber_Optic_Blocked_RunCmd : BOOL;
		Creaser_Shaft_Edge_Timeout : BOOL;
	END_STRUCT;
	AriesMachineState_Enum : 
		(
		MACHINE_STATE_INIT,
		MACHINE_STATE_IDLE,
		MACHINE_STATE_RUNNING,
		MACHINE_STATE_ERROR,
		New_Member1,
		New_Member
		);
	Global_Statistics_typ : 	STRUCT 
		total_runtime : UDINT;
		runtime_h : UDINT;
		runtime_m : UDINT;
		runtime_s : UDINT;
		total_processed : UDINT;
	END_STRUCT;
END_TYPE
