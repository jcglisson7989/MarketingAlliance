
ACTION Action_Test_PiP_Trigger: 
//	//TEST PIP trigger output to sync the encoder position to PIP sensor so I can capture traces on O-Scope RDH
	IF Position.Target_Fractional_Position_Pct > 1 AND Position.Target_Fractional_Position_Pct < 25 THEN
		ControlIO.Inspection.oInspectionGood := 1;
	ELSE
		ControlIO.Inspection.oInspectionGood := 0;
	END_IF
	
	IF Position.Target_Fractional_Position_Pct > 50 AND Position.Target_Fractional_Position_Pct < 75 THEN
		ControlIO.Inspection.oInspectionValid := 1;
	ELSE
		ControlIO.Inspection.oInspectionValid := 0;
	END_IF
END_ACTION
