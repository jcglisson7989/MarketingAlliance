
TYPE
	HERNON_VBlock_Inspection_typ : 	STRUCT 
		Item_Inspection_Status : HERNON_Inspection_Outcome_Enum;
		Inspection_Time : UDINT;
	END_STRUCT;
	HERNON_VBlock_Dispense_typ : 	STRUCT 
		Dispense_Has_Been_Triggered : ARRAY[0..MAX_IDX_MULTIPLE_DISPENSE_SHOTS]OF BOOL;
	END_STRUCT;
	HERNON_VBlock_Eject_Status_typ : 	STRUCT 
		Accept_Triggered : BOOL;
		Reject_Triggered : BOOL;
	END_STRUCT;
	VBlock_Object_typ : 	STRUCT 
		VBlock_Is_Occupied : BOOL;
		Line_Position_At_PiP_Neg_Edge : REAL;
		Line_Position_At_PiP_Pos_Edge : REAL;
		Dispense : ARRAY[0..MAX_IDX_DISPENSE_UNITS]OF HERNON_VBlock_Dispense_typ;
		Inspection : ARRAY[0..MAX_IDX_INSPECT_UNITS]OF HERNON_VBlock_Inspection_typ;
		Process_Item_ID : UDINT;
		VBlock_Index : UDINT;
		Eject : HERNON_VBlock_Eject_Status_typ;
		BlankDispActivated : BOOL;
	END_STRUCT;
END_TYPE
