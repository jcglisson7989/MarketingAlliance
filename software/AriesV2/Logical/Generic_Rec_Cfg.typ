
TYPE
	HMIConfig_typ : 	STRUCT 
		passwordSetup : STRING[15];
		passwordEngineer : STRING[15];
		passwordFactory : STRING[15];
		MachineLang : UDINT;
	END_STRUCT;
END_TYPE

(*Insert your comment here.*)

TYPE
	Global_Rec_typ : 	STRUCT 
		MagicPrefix : UDINT;
		FeedVelocity : REAL;
		Crease : AriesCreaserParams_typ;
		MagicSuffix : UDINT;
	END_STRUCT;
	Global_Cfg_typ : 	STRUCT 
		MagicPrefix : UDINT;
		Creaser : CreaserConfig_typ;
		HMI : HMIConfig_typ;
		wbrMemService : wbrMemService_typ;
		cfgCompile : cfgCompileVersionInfo_typ;
		MagicSuffix : UDINT;
	END_STRUCT;
END_TYPE

(*Insert your comment here.*)

TYPE
	Global_Rec_Cfg_typ : 	STRUCT 
		Rec : Global_Rec_typ;
		Cfg : Global_Cfg_typ;
	END_STRUCT;
	Global_RecCfg_Public_In_typ : 	STRUCT 
		Copy_default_to_save : USINT;
		Copy_default_to_active : USINT;
		Copy_save_to_active : USINT;
		Copy_save_to_default : USINT;
		Copy_active_to_save : USINT;
		Copy_active_to_default : USINT;
		Copy_internal_to_default : USINT;
		FileName : STRING[255];
	END_STRUCT;
	Global_RecCfg_Public_Out_typ : 	STRUCT 
		save_differs_from_active : USINT;
		default_differs_from_save : USINT;
		active_differs_from_default : USINT;
	END_STRUCT;
	Global_Rec_Cfg_Info_typ : 	STRUCT 
		O : Global_RecCfg_Public_Out_typ;
		I : Global_RecCfg_Public_In_typ;
	END_STRUCT;
	Global_Rec_Cfg_IO_typ : 	STRUCT 
		Rec : Global_Rec_Cfg_Info_typ;
		Cfg : Global_Rec_Cfg_Info_typ;
	END_STRUCT;
	Global_Par_typ : 	STRUCT 
		save : Global_Rec_Cfg_typ;
		active : Global_Rec_Cfg_typ;
		defaultvals : Global_Rec_Cfg_typ;
		IO : Global_Rec_Cfg_IO_typ;
	END_STRUCT;
END_TYPE

(*Insert your comment here.*)
