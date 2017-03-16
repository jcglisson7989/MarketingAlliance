
TYPE
	HERNON_Prcs_Stats_typ : 	STRUCT 
		Num_Passed : UDINT;
		Num_Failed : UDINT;
		Num_Err : UDINT;
		Num_Unanswered : UDINT;
	END_STRUCT;
	HERNON_Insp_Stats_typ : 	STRUCT 
		Total_Failed : UDINT;
		Total_Passed : UDINT;
		Total_Unknown : UDINT;
		Total_Unanswered : UDINT;
		InspUnit : ARRAY[0..MAX_IDX_INSPECT_UNITS]OF HERNON_Prcs_Stats_typ;
	END_STRUCT;
	HERNON_Stat_typ : 	STRUCT 
		Avg_Denom_Int : UDINT;
		Avg_Numerator_Int : UDINT;
		Avg_Denom_Float : REAL;
		Avg_Numerator_Float : REAL;
		Val_Int : UDINT;
		Val_Float : REAL;
	END_STRUCT;
	HERNON_LineStats_Breakdown_typ : 	STRUCT 
		PiPPos : HERNON_Stat_typ;
		PiPNeg : HERNON_Stat_typ;
		PiPDiff : HERNON_Stat_typ;
		GTSEncCts : HERNON_Stat_typ;
		GTSErr : HERNON_Stat_typ;
	END_STRUCT;
	HERNON_Line_Stats_typ : 	STRUCT 
		LastReading : HERNON_LineStats_Breakdown_typ;
		LineRev : HERNON_LineStats_Breakdown_typ;
		SinceReset : HERNON_LineStats_Breakdown_typ;
	END_STRUCT;
	Hernon_Line_Stats_typ : 	STRUCT 
		VBlocks_Currently_Loaded : UDINT;
		VBlocks_Currently_Empty : UDINT;
		Efficiency : REAL;
		PPM : REAL;
	END_STRUCT;
	Global_Statistics_typ : 	STRUCT 
		Momentary : Hernon_Line_Stats_typ;
		Total : Hernon_Line_Stats_typ;
		Counter_60s : Hernon_Line_Stats_typ;
		Latch_60s : Hernon_Line_Stats_typ;
		total_runtime : UDINT;
		runtime_h : UDINT;
		runtime_m : UDINT;
		runtime_s : UDINT;
		total_processed : UDINT;
		Inspection : HERNON_Insp_Stats_typ;
		Line : HERNON_Line_Stats_typ;
		PiP_Pos_Margin_Warning : UDINT;
		PiP_Pos_Margin_Error : UDINT;
		PiP_Neg_Margin_Warning : UDINT;
		PiP_Neg_Margin_Error : UDINT;
		PiP_Neg_Invalid : UDINT;
		PiP_Pos_Invalid : UDINT;
		Pct_VBlocks_Loaded : REAL;
	END_STRUCT;
END_TYPE
