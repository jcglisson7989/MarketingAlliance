
TYPE
	HERNON_Inline_Inspect_Item_typ : 	STRUCT 
		iInspectionGood : BOOL;
		iInspectionBusy : BOOL;
		iInspectionError : BOOL;
		iInspectionRunning : BOOL;
		oInspectionTrigger : BOOL;
		oIlluminationTrigger : BOOL;
		oClearError : BOOL;
		oInspAndIllTrigger : BOOL;
	END_STRUCT;
	HERNON_Inline_Inspection_IO_typ : 	STRUCT 
		Projectile : HERNON_Inline_Inspect_Item_typ;
		Primer : HERNON_Inline_Inspect_Item_typ;
		oSelectBits : ARRAY[0..MAX_IDX_INSPECTION_SEL_BITS]OF BOOL;
	END_STRUCT;
END_TYPE
