
TYPE
	HERNON_DISP_REASONS_ENUM : 
		(
		DISPENSE_SINGLE_SHOT := 0,
		DISPENSE_PURGE := 1
		);
	HERNON_Dispense_Unit_ID_Enum : 
		(
		DISPENSE_PRIMER := 0,
		DISPENSE_MOUTH := 1
		);
	HERNON_Disp_AppTimers_typ : 	STRUCT 
		Max_Valve_NotRdy_NegEdge : TON;
		Max_Time_Disp_Output_NegEdge : TON;
		Max_Valve_Rdy_Reset : TON;
		Max_Dispense_Output_High : TON;
	END_STRUCT;
	HERNON_Dispense_App_typ : 	STRUCT 
		VBlock_At_Dispense_Unit : UDINT;
		VBlock_Fract_Pos : REAL;
		Flag_Dispense_Purge_Now : BOOL;
		Flag_Dispense_Trigger_Now : BOOL;
		DispState : HERNON_Dispense_Enum;
		ii_Trend_Idx_DP : UDINT;
		Disp_Single_Shot_Or_Purge : HERNON_DISP_REASONS_ENUM;
		Edge_Reading_At_Disp_Trigger : DINT;
		Timer : HERNON_Disp_AppTimers_typ;
		ii_shot_counter : UDINT;
	END_STRUCT;
END_TYPE
