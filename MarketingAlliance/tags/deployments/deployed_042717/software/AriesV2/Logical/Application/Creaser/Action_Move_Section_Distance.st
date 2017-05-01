
ACTION Action_Move_Section_Distance: 
	
	AxisControl.MoveAbsolute := FALSE;
	AxisControl.MoveAdditive := FALSE;
	AxisControl.MoveVelocity := FALSE;
	AxisControl.Stop := FALSE;
	AxisControl();
	
//	AxisPar.Direction := mpAXIS_DIR_EXCEED_PERIOD;
	
	Current_Crease_Section_Length := gRecCfg.active.Rec.Crease.CreaseDistance_mm[ii_crease_count];
	
	AxisPar.Acceleration := gRecCfg.active.Cfg.Creaser.FeedAxisAccel;
	AxisPar.Deceleration := gRecCfg.active.Cfg.Creaser.FeedAxisDecel;
	AxisPar.Distance := gRecCfg.active.Rec.Crease.CreaseDistance_mm[ii_crease_count];
	AxisPar.Velocity := gRecCfg.active.Rec.FeedVelocity;
	
	AxisControl.MoveAdditive := TRUE;
	AxisControl();

END_ACTION
