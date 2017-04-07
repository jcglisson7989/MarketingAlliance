
PROGRAM _INIT
	AxisControl.MpLink := ADR(FeedAxis_MpLink);
	AxisControl.Enable := TRUE;
	AxisControl.Parameters := ADR(AxisPar);
	AxisControl.Axis := ADR(Axis1);
	AxisControl;

	MachineState := MACHINE_STATE_INIT;
	
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	setFlagCreaserIndexed := FALSE;
	
	//Set alarm values based on IO points->
	gAlarms.SM1_Disabled := IO.iSM1Disabled;
	gAlarms.Unsafe_Machine_State := NOT IO.iSafeMachineState;
	
	IF (NOT IO.iSafeMachineState) AND (MachineState <> MACHINE_STATE_ERROR) THEN
		MachineState := MACHINE_STATE_ERROR;
	END_IF;
	
	CASE MachineState OF
		MACHINE_STATE_INIT:
			IO.oCreaserCCWRotation := FALSE;
			IO.oCreaserCWRotation := FALSE;
			IO.oBoardFeedingLight := FALSE;
			IO.oUIIndicatorLight := FALSE;
		
		MACHINE_STATE_HARDWARE_INIT:
		
		MACHINE_STATE_AXIS_POWER:
			IF AxisControl.PowerOn THEN
				MachineState := MACHINE_STATE_IDLE;
			END_IF;
		
		MACHINE_STATE_IDLE:
			IO.oCreaserCCWRotation := FALSE;
			IO.oCreaserCWRotation := FALSE;
			IO.oBoardFeedingLight := FALSE;
			IO.oUIIndicatorLight := FALSE;
		
			IF EDGEPOS(setStartCommandFlag) THEN
				IF IO.iFiberOpticSensor THEN
					//Error: Fiber Optic sensor must not be active at this time
				ELSE
					setflagCreaserIndexCommand := TRUE;
					MachineState := MACHINE_STATE_RUNNING;
				END_IF;
				
				
				
			END_IF;
		
		MACHINE_STATE_RUNNING:
			Action_Manage_Update_Total_Runtime;
		
			CASE ProcessState OF
				PRCS_STATE_INIT:
				
				PRCS_STATE_READY:
				
					IF tmp_bool THEN
						Action_Start_Feeder;
						ProcessState := PRCS_STATE_FEED_BOARD;
					END_IF;
				
				PRCS_STATE_FEED_BOARD:
					
					IF IO.iFiberOpticSensor AND NOT IO_LastCycle.iFiberOpticSensor THEN
						
						Action_Transition_Feed_Vel_Additive;
						ProcessState := PRCS_STATE_MOVE_CREASE;
					END_IF;
				
				PRCS_STATE_MOVE_CREASE:
				
				PRCS_STATE_CREASE:
				
				PRCS_STATE_MOVE_CREASE_WIDTH:
				
				PRCS_STATE_ERROR:
				
			END_CASE;
		
		
		MACHINE_STATE_ERROR:
			IO.oCreaserCCWRotation := FALSE;
			IO.oCreaserCWRotation := FALSE;
			IO.oBoardFeedingLight := FALSE;
//			IO.oUIIndicatorLight := FBK_Pulse_Indicator;
		
	END_CASE;
	
	Action_Creaser_Idx;
	

	
	Axis1;
	AxisControl;
	
	
	
	IO_LastCycle := IO;
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

