
TYPE
	hmiTableRecCfgTrigger_typ : 	STRUCT 
		Dispense : BOOL := FALSE;
		Inspect : BOOL := FALSE;
	END_STRUCT;
	hmiTableTrigger_typ : 	STRUCT 
		Rec : hmiTableRecCfgTrigger_typ;
		Cfg : hmiTableRecCfgTrigger_typ;
	END_STRUCT;
	hmiTableLoad_typ : 	STRUCT 
		Trigger : BOOL;
	END_STRUCT;
	hmiTables_typ : 	STRUCT 
		Trigger : hmiTableTrigger_typ;
		Load : hmiTableLoad_typ;
	END_STRUCT;
	HMITableControlLocal_typ : 	STRUCT 
		tables : hmiTables_typ;
	END_STRUCT;
END_TYPE
