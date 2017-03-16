
TYPE
	HTML_Alert_typ : 	STRUCT 
		numAlarms : DINT;
		numWarnings : DINT;
		idxImage : DINT;
		cycle : DINT;
	END_STRUCT;
	HMTLMotionPVs_typ : 	STRUCT 
		indexAxis : DINT;
		FBK_Read_Error : MC_ReadAxisError;
		ErrText : STRING[STRLEN_AXIS_ERROR];
	END_STRUCT;
	HTML_ExampleTrend_typ : 	STRUCT 
		New_Member2 : USINT;
		New_Member1 : USINT;
		New_Member : USINT;
	END_STRUCT;
	HTMLVis_typ : 	STRUCT 
		Motion : HMTLMotionPVs_typ;
		Alert : HTML_Alert_typ;
		Trend : HTML_ExampleTrend_typ;
		New_Member2 : USINT;
		New_Member1 : USINT;
		New_Member : USINT;
	END_STRUCT;
END_TYPE
