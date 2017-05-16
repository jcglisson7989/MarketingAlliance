
FUNCTION_BLOCK FBK_Hernon_SureShot (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Name : STRING[80];
		iReset : BOOL;
		iFlagDispenseNow : BOOL;
		iFlagPurgeNow : BOOL;
		iFlagDispenseOnFractionOffset : BOOL;
		iVBlockFractionalPosition : REAL;
		iX2XNettime : DINT;
		pCounterValveNotRdy : REFERENCE TO DINT;
		pCyclesCounter : REFERENCE TO DINT;
		Alarms : REFERENCE TO HERNON_Alarm_Dispense_typ;
		Recipe : REFERENCE TO HERNON_Rec_Dispense_typ;
		Config : REFERENCE TO HERNON_Cfg_Dispense_typ;
		IO : REFERENCE TO HERNON_Valve_IOPoint_typ;
	END_VAR
	VAR_OUTPUT
		oState : HERNON_Dispense_Enum;
		oDispenseMode : HERNON_DISP_REASONS_ENUM;
		oEdge_Reading_At_Disp_Trigger : DINT;
		oHMIColorDP : HERNON_AS_Prcs_HMI_Colors_Enum;
	END_VAR
	VAR
		Timers : {REDUND_UNREPLICABLE} HERNON_Disp_AppTimers_typ;
		ii_shot_counter : {REDUND_UNREPLICABLE} UDINT;
		iVBlockFractionalPosition_old : REAL;
	END_VAR
END_FUNCTION_BLOCK
