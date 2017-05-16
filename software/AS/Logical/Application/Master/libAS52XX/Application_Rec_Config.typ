(*Insert your comment here.*)
(*Insert your comment here.*)

TYPE
	HMI_Trend_Limit_Par_typ : 	STRUCT 
		Min : REAL;
		Max : REAL;
	END_STRUCT;
	Generic_Cfg_HMI_typ : 	STRUCT 
		passwordSetup : STRING[15];
		passwordEngineer : STRING[15];
		passwordFactory : STRING[15];
		LoginTO_S : REAL;
		MachineLang : UDINT;
	END_STRUCT;
END_TYPE

(*Insert your comment here.*)
