
TYPE
	Debounce_Config_Struct : 	STRUCT 
		Timer_On : REAL;
		Timer_Off : REAL;
	END_STRUCT;
	cfgCompileVersionInfo_typ : 	STRUCT 
		projVersion : STRING[63];
		AR_Version : STRING[15];
		AS_config : STRING[63];
		date : STRING[31];
		AS_version : STRING[63];
		user : STRING[63];
		company : STRING[63];
		info : STRING[63];
		Revision : STRING[63];
		Modified : STRING[63];
		Date : STRING[63];
		TimeNow : STRING[63];
		RevRange : STRING[63];
		Mixed : STRING[63];
		IsTagged : STRING[63];
		URL : STRING[255];
		isInSVN : STRING[63];
		lockdate : STRING[63];
		Rev_Number : STRING[63];
	END_STRUCT;
END_TYPE
