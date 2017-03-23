
TYPE
	CMA_CreaseInfo : 	STRUCT 
		LeadingEdgeDistance_mm : REAL;
	END_STRUCT;
	CMA_CreaseParams_typ : 	STRUCT 
		MaterialLength_mm : REAL;
		ScoreWidth_mm : REAL;
		CreaseCount : UDINT;
		CreaseInfo : ARRAY[0..MAX_IDX_CREASES]OF CMA_CreaseInfo;
	END_STRUCT;
	Global_Rec_typ : 	STRUCT 
		MagicPrefix : UDINT;
		CreaseParams : CMA_CreaseParams_typ;
		MagicSuffix : UDINT;
	END_STRUCT;
	Global_Cfg_typ : 	STRUCT 
		MagicPrefix : UDINT;
		New_Member : USINT;
		MagicSuffix : UDINT;
	END_STRUCT;
END_TYPE
