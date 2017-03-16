
TYPE
	Generic_Cfg_HMI_typ : 	STRUCT 
		passwordSetup : STRING[15];
		passwordEngineer : STRING[15];
		passwordFactory : STRING[15];
		Disp_Trend_SampleCount : UDINT;
		MuteSwitchBypassTO : REAL;
		Access_Level_Cfg : UDINT;
		Access_Level_Recipe : UDINT;
		Access_Level_ForceIO : UDINT;
		Access_Level_HomeForce : UDINT;
		Access_Level_FileIO : UDINT;
		Admin_Limit_Run_Velocity : REAL;
		LoginTO_S : REAL;
		MachineLang : UDINT;
	END_STRUCT;
	HERNON_Cfg_Mechanics_typ : 	STRUCT 
		I_Motor_Sprocket_Gear_Ratio : UDINT;
		N_Sprocket_Teeth : UDINT;
		N_VBlocks_Belt_Total : UDINT;
	END_STRUCT;
	Global_Rec_typ : 	STRUCT 
		MagicPrefix : UDINT;
		Dispense : ARRAY[0..MAX_IDX_DISPENSE_UNITS]OF HERNON_Rec_Dispense_typ;
		Inspect : ARRAY[0..MAX_IDX_INSPECT_UNITS]OF HERNON_Rec_Inspect_typ;
		MagicSuffix : UDINT;
	END_STRUCT;
	Global_Cfg_typ : 	STRUCT 
		MagicPrefix : UDINT;
		Dispense : ARRAY[0..MAX_IDX_DISPENSE_UNITS]OF HERNON_Cfg_Dispense_typ;
		Inspect : ARRAY[0..MAX_IDX_INSPECT_UNITS]OF HERNON_Cfg_Inspect_typ;
		Mechanics : HERNON_Cfg_Mechanics_typ;
		HMI : {REDUND_UNREPLICABLE} Generic_Cfg_HMI_typ;
		MagicSuffix : UDINT;
	END_STRUCT;
END_TYPE
