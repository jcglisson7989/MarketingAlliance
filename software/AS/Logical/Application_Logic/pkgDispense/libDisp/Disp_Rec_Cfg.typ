
TYPE
	HERNON_Rec_Dispense_typ : 	STRUCT 
		Enable : UDINT;
		Disp_Valve_Edgemode_Pulse_TO_ms : REAL;
		Enable_Cure : UDINT;
		Extra_Shots_Per_VBlock : UDINT;
		Vblock_Offset_Additional_Shots : ARRAY[0..MAX_IDX_MULTIPLE_DISPENSE_SHOTS]OF REAL;
	END_STRUCT;
	HERNON_Cfg_Dispense_typ : 	STRUCT 
		VBlock_Offset_From_PiP_Sensor : UDINT;
		Disp_Valve_Max_Output_High_TO_S : REAL;
		Disp_Signal_Reset_MaxTO_S : REAL;
		Disp_Valve_Max_RDY_NegEdge_S : REAL;
		Disp_Output_NegEdge_Margin_S : REAL;
	END_STRUCT;
END_TYPE
