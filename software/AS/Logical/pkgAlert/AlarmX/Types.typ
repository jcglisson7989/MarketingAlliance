
TYPE
	MachineAlarm_typ : 	STRUCT 
		str : {REDUND_UNREPLICABLE} STRING[80];
		active : {REDUND_UNREPLICABLE} BOOL;
	END_STRUCT;
	MachineReaction_typ : 	STRUCT 
		str : {REDUND_UNREPLICABLE} STRING[80];
		active : {REDUND_UNREPLICABLE} BOOL;
	END_STRUCT;
	AlarmX_Local_TmpVar_typ : 	STRUCT 
		val_float : {REDUND_UNREPLICABLE} REAL;
		ExampleAlarm : {REDUND_UNREPLICABLE} MachineAlarm_typ;
		ExampleReaction : {REDUND_UNREPLICABLE} MachineReaction_typ;
	END_STRUCT;
END_TYPE
