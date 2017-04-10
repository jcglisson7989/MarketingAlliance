
ACTION Action_Tally_Board_L: 
	
	RollerPos_ThisCycle := LREAL_TO_REAL(AxisControl.Position);
	
//	IF LREAL_TO_REAL(AxisControl.Position) > LREAL_TO_REAL(AxisControl_LastCycle.Position) THEN
//		delta_Board_Position := LREAL_TO_REAL(AxisControl.Position) - LREAL_TO_REAL(AxisControl_LastCycle.Position);
//	ELSE
//		IF (LREAL_TO_REAL(AxisControl_LastCycle.Position) > (0.99 * DEFINE_MM_ROLLER_REV)) AND (LREAL_TO_REAL(AxisControl.Position) < (1.01 * DEFINE_MM_ROLLER_REV)) THEN //Rollover
//			delta_Board_Position := (DEFINE_MM_ROLLER_REV - LREAL_TO_REAL(AxisControl_LastCycle.Position)) + LREAL_TO_REAL(AxisControl.Position);
//		ELSE
//			delta_Board_Position := LREAL_TO_REAL(AxisControl.Position) - LREAL_TO_REAL(AxisControl_LastCycle.Position);
//		END_IF;
	//	END_IF;
	delta_Board_Position := RollerPos_ThisCycle - RollerPos_LastCycle;
	
	
	Current_Board_Position := Current_Board_Position + delta_Board_Position;
	
	RollerPos_LastCycle := RollerPos_ThisCycle;
END_ACTION
