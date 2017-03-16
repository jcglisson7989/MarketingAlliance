(*Insert your comment here.*)

TYPE
	Global_Rec_Cfg_typ : 	STRUCT 
		Rec : Global_Rec_typ;
		Cfg : Global_Cfg_typ;
	END_STRUCT;
END_TYPE

(*Insert your comment here.*)

TYPE
	Global_RecCfg_Public_In_typ : 	STRUCT 
		Copy_save_to_active : USINT;
		Copy_active_to_save : USINT;
		FileName : STRING[255];
	END_STRUCT;
	Global_RecCfg_Public_Out_typ : 	STRUCT 
		save_differs_from_active : USINT;
	END_STRUCT;
	Global_Rec_Cfg_Info_typ : 	STRUCT 
		O : Global_RecCfg_Public_Out_typ;
		I : Global_RecCfg_Public_In_typ;
	END_STRUCT;
	Global_Rec_Cfg_IO_typ : 	STRUCT 
		Rec : Global_Rec_Cfg_Info_typ;
		Cfg : Global_Rec_Cfg_Info_typ;
	END_STRUCT;
END_TYPE

(*Insert your comment here.*)

TYPE
	Global_Par_typ : 	STRUCT 
		save : Global_Rec_Cfg_typ;
		active : Global_Rec_Cfg_typ;
		IO : Global_Rec_Cfg_IO_typ;
	END_STRUCT;
END_TYPE
