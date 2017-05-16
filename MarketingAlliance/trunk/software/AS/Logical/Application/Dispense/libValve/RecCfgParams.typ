(*Insert your comment here.*)

TYPE
	HERNON_Cfg_Dispense_typ : 	STRUCT 
		Disable : UDINT;
	END_STRUCT;
	HERNON_Rec_Dispense_typ : 	STRUCT 
		Enable : UDINT;
		Disp_Valve_Edgemode_Pulse_TO_ms : REAL;
		Fractional_Position_Offset : REAL;
		Extra_Shots_Per_VBlock : UDINT;
		Time_Offset_Additional_Shots : REAL;
		Target_Offset : UDINT;
	END_STRUCT;
END_TYPE

(*Insert your comment here.*)
