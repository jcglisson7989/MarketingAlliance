
TYPE
	Recipe_Cmd_local_typ : 	STRUCT 
		Copy_default_to_save : BOOL;
		Copy_default_to_active : BOOL;
		Copy_save_to_active : BOOL;
		Copy_save_to_default : BOOL;
		Copy_active_to_save : BOOL;
		Copy_active_to_default : BOOL;
		Copy_internal_to_default : BOOL;
	END_STRUCT;
	Recipe_Status_local_typ : 	STRUCT 
		save_differs_from_active : USINT;
		default_differs_from_save : USINT;
		active_differs_from_default : USINT;
	END_STRUCT;
	HMI_Rec_Command_Button_typ : 	STRUCT 
		DP : USINT;
		Status : USINT;
		Lock : USINT;
	END_STRUCT;
	Recipe_HMI_Command_typ : 	STRUCT 
		Refresh : HMI_Rec_Command_Button_typ;
		Save : HMI_Rec_Command_Button_typ;
		Load : HMI_Rec_Command_Button_typ;
		Delete : HMI_Rec_Command_Button_typ;
		Overwrite : HMI_Rec_Command_Button_typ;
		Copy : HMI_Rec_Command_Button_typ;
	END_STRUCT;
	Recipe_Config_local_struct : 	STRUCT 
		cmd : Recipe_Cmd_local_typ;
		status : Recipe_Status_local_typ;
		HMI : Recipe_HMI_Command_typ;
	END_STRUCT;
	Recipe_loc_typ : 	STRUCT 
		Cfg : Recipe_Config_local_struct;
		Rec : Recipe_Config_local_struct;
	END_STRUCT;
END_TYPE
