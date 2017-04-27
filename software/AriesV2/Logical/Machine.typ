
TYPE
	CreaserPrcsState_Enum : 
		( (*Make sure the indices entered below line up with the VC texts displayed on the UI*)
		PRCS_STATE_INIT := 0,
		PRCS_STATE_READY := 1,
		PRCS_STATE_FEED_BOARD := 2,
		PRCS_STATE_MOVE_CREASE := 3,
		PRCS_STATE_CREASE := 4,
		PRCS_STATE_MOVE_CREASE_WIDTH := 5,
		PRCS_STATE_ERROR := 6,
		PRCS_STATE_EJECT_FINISHED_BOARD := 7,
		PRCS_STATE_SOFT_STOP := 8,
		PRCS_STATE_MOVE_PHOTOEYE_OFFSET := 9
		);
	AriesMachineState_Enum : 
		( (*Make sure the indices entered below line up with the VC texts displayed on the UI*)
		MACHINE_STATE_INIT := 0,
		MACHINE_STATE_IDLE := 1,
		MACHINE_STATE_RUNNING := 2,
		MACHINE_STATE_ERROR := 3,
		MACHINE_STATE_HARDWARE_INIT := 4,
		MACHINE_STATE_AXIS_POWER := 5,
		MACHINE_STATE_AXIS_HOME := 6,
		MACHINE_STATE_MANUAL_EJECT := 7
		);
END_TYPE

(*Insert your comment here.*)

TYPE
	CreaserConfig_typ : 	STRUCT 
		FeedAxisAccel : REAL;
		FeedAxisDecel : REAL;
		PhotoEyeOffset : REAL;
		PreInsertSpeed : REAL;
		BoardLengthTolerance : REAL;
		CreaseInfeedDelay : REAL;
		BypassBoardLengthError : UDINT;
	END_STRUCT;
	AriesCreaserParams_typ : 	STRUCT 
		CreaseDistance_mm : ARRAY[0..MAX_IDX_CREASES]OF REAL;
		CreaseWidth_mm : REAL;
		CreaseCount : UDINT;
		ShaftSensorEdge : UDINT;
		CreaserDirection : UDINT;
		CreaserMotorIdxLag_S : REAL;
		TotalBoardLength : REAL;
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
	Machine_Alarms_typ : 	STRUCT  (*Did something fancy here- structure is copied into array for VC error texts, make sure the following numbers line up with the VC error text indices!*)
		SM1_Disabled : BOOL; (*0*)
		Unsafe_Machine_State : BOOL; (*1*)
		Fiber_Optic_Blocked_RunCmd : BOOL; (*2*)
		Creaser_Shaft_Edge_Timeout : BOOL; (*3*)
		Error_State_Unsafe_Machine : BOOL; (*4*)
		Error_State_SM1_Power : BOOL; (*5*)
		Feed_Axis_Motor_Error : BOOL; (*6*)
		Crease_Count_Greater_Max : BOOL; (*7*)
		Error_State_Process_Error : BOOL; (*8*)
		Load_Recipe : BOOL; (*9*)
		Manual_Home_Creaser_Blade : BOOL; (*10*)
		Board_Length_GT_Confgd_Amount : BOOL; (*11*)
		Board_Length_LT_Confgd_Amount : BOOL; (*12*)
		Measured_Length_GT_Configured : BOOL; (*13*)
		Measured_Length_LT_Configured : BOOL; (*14*)
		Unsaved_Recipe_Params : BOOL; (*15*)
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
