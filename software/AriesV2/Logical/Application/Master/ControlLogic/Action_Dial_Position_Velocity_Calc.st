
ACTION Action_Dial_Position_Velocity_Calc: 
	
	IF gRecCfg.active.Cfg.Control.Sim_Encoder = 1 THEN
		Dashboard_Hide_Encoder_Sim := STATUS_LIGHT_FLASH.bFlashOut;
		ii_cycles := ii_cycles + 1;
		IF ii_cycles >= gRecCfg.active.Cfg.Control.Sim_Encoder_Cycles THEN
			ii_cycles := 0;
			sim_encoder := sim_encoder + UDINT_TO_UINT(gRecCfg.active.Cfg.Control.Sim_Encoder_Counts);
		
			IF sim_encoder > 4095 THEN
				sim_encoder := 0;
			END_IF;
		END_IF;
		
		gAlarms.Control.Encoder_Sim_Active := TRUE;
		
		PositionValue := sim_encoder;
	ELSE
		gAlarms.Control.Encoder_Sim_Active := FALSE;
		Dashboard_Hide_Encoder_Sim := 1;
		PositionValue := ControlIO.iEncoderValue;
	END_IF;
	
	ShiftBits := 16 - UDINT_TO_UINT(gRecCfg.active.Cfg.Control.N_Encoder_Bits_SingleTurn);
	
	//Shift bits left to take advantage of natural 16-bit rollover.  Effectively this is the same as multiplying by 8 for a 12 bit encoder, but it accomodates multiple bit counts (up to 16) and multiturn encoders (shifts multiturn bits "off the end")
	Position_SHL.Single_Turn_Absolute := 		SHL(PositionValue, ShiftBits);
	Position_SHL.Home_Position := 				SHL(UDINT_TO_UINT(gRecCfg.active.Cfg.Control.Encoder_Position_Home), ShiftBits);
	Position_SHL.Single_Turn_Rel_Home := 		Position_SHL.Single_Turn_Absolute - Position_SHL.Home_Position;
	Position_SHL.Ticks_Per_Target := 			REAL_TO_UINT((2**16) / UDINT_TO_REAL(gRecCfg.active.Rec.Control.N_Targets_On_Dial)); //This operation MUST be done like this such that it rounds instead of "floors" which causes swamping drift (where floor is the effective operation when dividing integers!)
	Position_SHL.Current_Target := 				Position_SHL.Single_Turn_Rel_Home / Position_SHL.Ticks_Per_Target;
	Position_SHL.Ticks_Within_Current_Target := Position_SHL.Single_Turn_Rel_Home MOD Position_SHL.Ticks_Per_Target;
	
	//Shift bits back right
	Position.Single_Turn_Absolute 			:= 		SHR(Position_SHL.Single_Turn_Absolute, ShiftBits);
	Position.Home_Position 					:= 		SHR(Position_SHL.Home_Position, ShiftBits);
	Position.Single_Turn_Rel_Home 			:= 		SHR(Position_SHL.Single_Turn_Rel_Home, ShiftBits);
	Position.Ticks_Per_Target 				:= 		SHR(Position_SHL.Ticks_Per_Target, ShiftBits);
	Position.Current_Target 				:= 		Position_SHL.Current_Target;
	Position.Ticks_Within_Current_Target 	:= 		SHR(Position_SHL.Ticks_Within_Current_Target, ShiftBits);
	Position.Degrees_Absolute				:=		360 * (UINT_TO_REAL(Position.Single_Turn_Absolute) / (2**gRecCfg.active.Cfg.Control.N_Encoder_Bits_SingleTurn));
	Position.Home_Position_Degrees			:=		360 * (UINT_TO_REAL(Position.Home_Position) / (2**gRecCfg.active.Cfg.Control.N_Encoder_Bits_SingleTurn));
	Position.Degrees_Rel_Home				:=		360 * (UINT_TO_REAL(Position.Single_Turn_Rel_Home) / (2**gRecCfg.active.Cfg.Control.N_Encoder_Bits_SingleTurn));
	Position.Target_Fractional_Position_Pct :=		100 * (UINT_TO_REAL(Position.Ticks_Within_Current_Target) / UINT_TO_REAL(Position.Ticks_Per_Target));


	encoder_diff_counts := (SHR((UINT_TO_INT(Position_SHL.Single_Turn_Absolute) - UINT_TO_INT(Position_SHL_LastCycle.Single_Turn_Absolute)), ShiftBits));
	
	Multiturn_Absolute_Position := Multiturn_Absolute_Position + encoder_diff_counts;
	
	VelCalc_DT_Element.In := DINT_TO_REAL(Multiturn_Absolute_Position);
	VelCalc_DT_Element();
	
	Dial_Vel.Encoder_Counts_Per_Second := VelCalc_DT_Element.Out;
	Dial_Vel.Rev_Per_S := Dial_Vel.Encoder_Counts_Per_Second / (2**gRecCfg.active.Cfg.Control.N_Encoder_Bits_SingleTurn);
	Dial_Vel.Targ_Per_S := Dial_Vel.Rev_Per_S * UDINT_TO_REAL(gRecCfg.active.Rec.Control.N_Targets_On_Dial);
	Dial_Vel.Deg_Per_S := Dial_Vel.Rev_Per_S * 360;
	Dial_Vel.RPM := 60 * Dial_Vel.Rev_Per_S;

END_ACTION
