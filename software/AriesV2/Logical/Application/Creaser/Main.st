
PROGRAM _INIT
	//Initialize the axis control FBK
	AxisControl.MpLink := ADR(FeedAxis_MpLink); //Pointer to the MAPP Axis Configuration
	AxisControl.Enable := TRUE; //Enables FBK "AxisControl" to hold/retain control of the axis object
	AxisControl.Parameters := ADR(AxisPar); //Pointer to the movement parameters
	AxisControl.Axis := ADR(Axis1); //Pointer to the ACP10 object which is mapped to the drive
	AxisControl(); //Call FBK once during INIT section to ensure it initializes without the cyclic task class time restraints!

	MachineState := MACHINE_STATE_INIT;
	
	Pulse_Slow.PT := DEFINE_SLOW_PULSE_PERIOD;
	Pulse_Fast.PT := DEFINE_FAST_PULSE_PERIOD;
	
END_PROGRAM

PROGRAM _CYCLIC
	
	//Set alarm values based on IO points->
	gAlarms.SM1_Disabled := IO.iSM1Disabled; //SM1 supplies power to the IO from the 24VAC->24VDC power supply
	gAlarms.Unsafe_Machine_State := NOT IO.iSafeMachineState; //DP reads whether the E-stop has been pressed
	
	gAlarms.Crease_Count_Greater_Max := gRecCfg.active.Rec.Crease.CreaseCount > MAX_IDX_CREASES;
	
	IF (MachineState <> MACHINE_STATE_ERROR AND MachineState <> MACHINE_STATE_INIT) THEN
		IF (NOT IO.iSafeMachineState) THEN
			gAlarms.Error_State_Unsafe_Machine := TRUE;
			MachineState := MACHINE_STATE_ERROR;
		ELSIF gAlarms.SM1_Disabled THEN
			gAlarms.Error_State_SM1_Power := TRUE;
			MachineState := MACHINE_STATE_ERROR;
		ELSIF AxisControl.Error THEN
			gAlarms.Feed_Axis_Motor_Error := TRUE;
			MachineState := MACHINE_STATE_ERROR;
		END_IF;
	END_IF;
	
	IF AxisControl.Error THEN
		IO.oBoardFeedingLight := Pulse_Fast.Q;
	ELSIF AxisControl.InVelocity THEN
		IO.oBoardFeedingLight := Pulse_Slow.Q;
	ELSIF AxisControl.MoveActive THEN
		IO.oBoardFeedingLight := TRUE;//Set the green indicator light on the UI to the "movement active" status of the axis FBK.
	ELSE
		IO.oBoardFeedingLight := FALSE;
	END_IF;


	
	CASE MachineState OF
		MACHINE_STATE_INIT:
			IO.oUIIndicatorLight := FALSE;
			AxisControl.Power := FALSE;
		
			MachineState := MACHINE_STATE_HARDWARE_INIT;
		
		MACHINE_STATE_HARDWARE_INIT:
			IO.oUIIndicatorLight := FALSE;
			
			IF AxisControl.Info.ReadyToPowerOn THEN
				AxisControl.Power := TRUE;
				MachineState := MACHINE_STATE_AXIS_POWER;
			END_IF;
		
		MACHINE_STATE_AXIS_POWER:
			IO.oUIIndicatorLight := FALSE;
			
			IF AxisControl.PowerOn THEN
				MachineState := MACHINE_STATE_IDLE;
			END_IF;
		
		MACHINE_STATE_IDLE:
			IO.oUIIndicatorLight := Pulse_Slow.Q;
		
			IF EDGEPOS(iStartCommand) THEN
				IF IO.iFiberOpticSensor THEN
					gAlarms.Fiber_Optic_Blocked_RunCmd := TRUE;
					MachineState := MACHINE_STATE_ERROR;
				ELSE
					setflagCreaserIndexCommand := TRUE;
					ii_crease_count := 0;
					Action_Start_Feeder;
					ProcessState := PRCS_STATE_INIT;
					MachineState := MACHINE_STATE_RUNNING;
				END_IF;
			END_IF;
		
		MACHINE_STATE_RUNNING:
			Action_Manage_Update_Total_Runtime;
		
			CASE ProcessState OF
				PRCS_STATE_INIT:
					IF setFlagCreaserIdxFinished THEN
						ProcessState := PRCS_STATE_READY;
					END_IF;					
				
				PRCS_STATE_READY:
					
					IF AxisControl.InVelocity THEN
						ProcessState := PRCS_STATE_FEED_BOARD;
					END_IF;
					
				
				PRCS_STATE_FEED_BOARD:
					
					IF IO.iFiberOpticSensor AND NOT IO_LastCycle.iFiberOpticSensor THEN
						Action_Move_Section_Distance;
						
						ProcessState := PRCS_STATE_MOVE_CREASE;
					END_IF;
				
				PRCS_STATE_MOVE_CREASE:
				
					IF AxisControl.InPosition THEN
						setflagCreaserIndexCommand := TRUE;
						ProcessState := PRCS_STATE_CREASE;
					END_IF;
				
				PRCS_STATE_CREASE:
					IF setFlagCreaserIdxFinished THEN //Wait for flag set by creaser that it has indexed and is at the "ready" position to move board
						ii_crease_count := ii_crease_count + 1; //Increment crease counter
						
						IF ii_crease_count = (gRecCfg.active.Rec.Crease.CreaseCount) THEN
							Action_Start_Feeder;
							ProcessState := PRCS_STATE_EJECT_FINISHED_BOARD;
						ELSE
							Action_Move_Crease_Width;
							ProcessState := PRCS_STATE_MOVE_CREASE_WIDTH;
						END_IF;
					END_IF;
				
				PRCS_STATE_MOVE_CREASE_WIDTH:
				
					IF AxisControl.InPosition THEN
						
						
					END_IF;
				
				PRCS_STATE_EJECT_FINISHED_BOARD:
				
				PRCS_STATE_ERROR:
				
			END_CASE;
		
		
		MACHINE_STATE_ERROR:
			IO.oUIIndicatorLight := Pulse_Fast.Q AND Pulse_Slow.Q;
		
			IF iMachineErrorReset THEN
				MachineState := MACHINE_STATE_INIT;
			END_IF;
		
	END_CASE;
	
	Action_Creaser_Idx;
	Action_AxisControl_Mgmt;

	IO_LastCycle := IO;
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

