
TYPE
	HERNON_Inspect_Timers_typ : 	STRUCT 
		Timer_Inspection_Trigger_DO_High : TON;
		Timer_Inspection_Illum_DO_High : TON;
		Timer_Inspection_Results_Wait : TON;
		Timer_Inspection_Trigger_Wait : TON;
		Timer_Max_Insp_Busy_Signal : TON;
	END_STRUCT;
	HERNON_Inspect_App_typ : 	STRUCT 
		VBlock_At_Inspect_Unit : UDINT;
		Flag_Inspect_Trigger_Now : BOOL;
		Status : HERNON_Inspect_Enum;
		ii_VC_Trend_idx : UDINT;
		Timer : HERNON_Inspect_Timers_typ;
		VBlock_Fract_Pos : REAL;
	END_STRUCT;
END_TYPE
