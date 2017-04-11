
ACTION Action_Tally_Board_L: 
	
	RollerPos_ThisCycle := LREAL_TO_REAL(AxisControl.Position);
	
	IF delta_Board_Position < -1 THEN
		delta_Board_Position := RollerPos_ThisCycle + DEFINE_MM_ROLLER_REV - RollerPos_LastCycle;
	ELSE
		delta_Board_Position := RollerPos_ThisCycle - RollerPos_LastCycle;
	END_IF;
	
	
	Current_Board_Position := Current_Board_Position + delta_Board_Position;
	
	RollerPos_LastCycle := RollerPos_ThisCycle;
END_ACTION
