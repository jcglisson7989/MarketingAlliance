
TYPE
	HERNON_Inline_Belt_typ : 	STRUCT 
		Mailbox : ARRAY[0..MAX_IDX_VBLOCKS]OF VBlock_Object_typ;
		Dispense : ARRAY[0..MAX_IDX_DISPENSE_UNITS]OF HERNON_Belt_Disp_typ;
		Current_VBlock_At_PiP : UDINT;
		VBlock_Fractional_Position : REAL;
	END_STRUCT;
END_TYPE
