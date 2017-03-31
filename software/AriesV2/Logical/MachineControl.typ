
TYPE
	AS3500HS_SM_States_Enum : 
		(
		STATE_INIT := 0,
		STATE_IDLE := 1,
		STATE_RUNNING := 2,
		STATE_ERROR := 3
		);
	AS3500HS_ColorBar_Enum : 
		(
		COLOR_NONE := 0,
		COLOR_GREEN_FLASH := 1,
		COLOR_GREEN := 2,
		COLOR_GREEN_BLUE_ALTERNATE := 3,
		COLOR_RED := 4,
		COLOR_GREEN_RED_ALTERNATE := 5
		);
END_TYPE

(*Insert your comment here.*)

TYPE
	Dispense_Control_Var_typ : 	STRUCT 
		Current_Target_At_Dispense_Unit : UDINT;
		Target_Fractional_Position_Pct : REAL;
	END_STRUCT;
	AS3500HS_Control_Var_typ : 	STRUCT 
		Dispense : ARRAY[0..MAX_IDX_VALVES]OF Dispense_Control_Var_typ;
	END_STRUCT;
	AS3500HS_Control_Alarms_typ : 	STRUCT 
		Invalid_Par : USINT;
		Valve_Not_Ready : USINT;
		Encoder_Sim_Active : USINT;
	END_STRUCT;
	HERNON_Alarms_typ : 	STRUCT 
		Control : AS3500HS_Control_Alarms_typ;
		Sureshot3500 : ARRAY[0..MAX_IDX_VALVES]OF HERNON_Alarm_Dispense_typ;
	END_STRUCT;
	AS3500HS_Position_Var_typ : 	STRUCT 
		Home_Position : UINT;
		Ticks_Per_Target : UINT;
		Single_Turn_Rel_Home : UINT;
		Single_Turn_Absolute : UINT;
		Current_Target : UINT;
		Ticks_Within_Current_Target : UINT;
		Degrees_Absolute : REAL;
		Degrees_Rel_Home : REAL;
		Home_Position_Degrees : REAL;
		Target_Fractional_Position_Pct : REAL;
	END_STRUCT;
	AS3500HS_Dial_Vel_Calc : 	STRUCT 
		Encoder_Counts_Per_Second : REAL;
		Deg_Per_S : REAL;
		RPM : REAL;
		Rev_Per_S : REAL;
		Targ_Per_S : REAL;
	END_STRUCT;
	Target_typ : 	STRUCT 
		VBlock_Occupied : BOOL;
		VBlock_Dispensed : ARRAY[0..MAX_IDX_VALVES]OF BOOL;
	END_STRUCT;
	AS3500HS_Disp_Debug_Items_typ : 	STRUCT 
		Count : DINT;
		Latch_Position : AS3500HS_Position_Var_typ;
	END_STRUCT;
	AS3500_Disp_Debug_typ : 	STRUCT 
		Disp_Trigger_Count : ARRAY[0..MAX_IDX_VALVES]OF AS3500HS_Disp_Debug_Items_typ;
		Disp_Cycle_Count : ARRAY[0..MAX_IDX_VALVES]OF AS3500HS_Disp_Debug_Items_typ;
		Disp_Flag_Twice : ARRAY[0..MAX_IDX_VALVES]OF AS3500HS_Disp_Debug_Items_typ;
		Valve_Not_Rdy : ARRAY[0..MAX_IDX_VALVES]OF AS3500HS_Disp_Debug_Items_typ;
	END_STRUCT;
	AS3500HS_Stats_typ : 	STRUCT 
		total_runtime : UDINT;
		runtime_h : UDINT;
		runtime_m : UDINT;
		runtime_s : UDINT;
		Total_Num_Targets : UDINT;
		VBlock_Fraction_Pos_Last_Edge : REAL;
		Debug : AS3500_Disp_Debug_typ;
		Count_PiP_Twice_Single_Targ : AS3500HS_Disp_Debug_Items_typ;
		Dispense_Discrepancy : DINT;
	END_STRUCT;
END_TYPE
