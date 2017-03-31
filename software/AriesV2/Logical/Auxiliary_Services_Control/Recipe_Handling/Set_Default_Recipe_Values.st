FUNCTION Set_Default_Recipe_Values
	
	pRec.Control.N_Targets_On_Dial := 18;
	
	FOR ii_dispense_units := 0 TO MAX_IDX_VALVES BY 1 DO
		pRec.Dispense[ii_dispense_units].Enable := 0;
		pRec.Dispense[ii_dispense_units].Disp_Valve_Edgemode_Pulse_TO_ms := 25;
		pRec.Dispense[ii_dispense_units].Extra_Shots_Per_VBlock := 0;
		pRec.Dispense[ii_dispense_units].Time_Offset_Additional_Shots := 0.1;
		pRec.Dispense[ii_dispense_units].Target_Offset := 3 + 2*ii_dispense_units;
	END_FOR;
	
	Set_Default_Recipe_Values := 0;
END_FUNCTION