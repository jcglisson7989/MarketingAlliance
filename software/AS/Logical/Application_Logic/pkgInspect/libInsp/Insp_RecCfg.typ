
TYPE
	HERNON_Rec_Inspect_typ : 	STRUCT 
		Enable : UDINT;
		Insp_Trigger_ON_TO_S : REAL;
		Insp_VBlock_Displacement : REAL;
		Sequential_Fails_Stop_Line : UDINT;
	END_STRUCT;
	HERNON_Cfg_Inspect_typ : 	STRUCT 
		VBlock_Offset_From_PiP_Sensor : UDINT;
		Inspection_Max_Busy_TO_S : REAL;
		Insp_Results_Wait_TO_S : REAL;
		Insp_Trigger_Wait_TO_S : REAL;
		Insp_Illum_ON_TO_S : REAL;
	END_STRUCT;
END_TYPE
