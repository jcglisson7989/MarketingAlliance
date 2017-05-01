
PROGRAM _INIT
	
	Action_Init_Infeed_Axis; //Set pointer values/initialize servo drive FBK MpAxisBasic instance
	
	MachineState := MACHINE_STATE_INIT;
	
	Pulse_Slow.TimeOn := DEFINE_SLOW_PULSE_PERIOD;
	Pulse_Slow.TimeOff := DEFINE_SLOW_PULSE_PERIOD;
	
	Pulse_Fast.TimeOn := DEFINE_FAST_PULSE_PERIOD;
	Pulse_Fast.TimeOff := DEFINE_FAST_PULSE_PERIOD;
	
	StdDevCalc.Enable := TRUE;
	
END_PROGRAM

PROGRAM _CYCLIC
	
	IF gStatistics.Reset THEN //Reset all statistics
		brsmemset(ADR(gStatistics), 0, SIZEOF(Global_Statistics_typ)); //Kind of a weird way to do this- essentially just writes 0's to the entirety of the memory the structure occupies (thus "zeroing-out" the counters)
		StdDevCalc.Enable := TRUE;
		StdDevCalc.Reset := FALSE;
		StdDevCalc();
		StdDevCalc.Reset := TRUE;
		StdDevCalc();
		StdDevCalc.Reset := FALSE;
	END_IF;
	
	Action_Eval_ErrorState_Statuses; //Evaluate the conditions that put machine into ERR state

	//Eval conditions that would send the machine into ERR state if the machine isn't already in ERR or INIT state->

	IF EDGEPOS(IO.iSafeMachineState) OR iMachineErrorReset THEN
		ProcessState := PRCS_STATE_INIT;
		gAlarmResetRequested := TRUE;
		//		gStatistics.Reset := TRUE;
		MachineState := MACHINE_STATE_INIT;
	END_IF;
	
	IF EDGEPOS(MachineState = MACHINE_STATE_ERROR) THEN
		AxisControl.MoveVelocity := FALSE;
		AxisControl.MoveAbsolute := FALSE;
		AxisControl.MoveAdditive := FALSE;
		AxisControl.Stop := TRUE;
		AxisControl();
	END_IF;
	
	BoardEjectUIButton_Hide := BOOL_TO_USINT(NOT ((MachineState = MACHINE_STATE_IDLE OR MachineState = MACHINE_STATE_MANUAL_EJECT) AND IO.iFiberOpticSensor));
	
	StartUIButton_Hide := NOT (MachineState = MACHINE_STATE_IDLE);
	StopUIButton_Hide := NOT (MachineState = MACHINE_STATE_RUNNING);
	
	Action_Tally_Board_L;

	CASE MachineState OF
		MACHINE_STATE_INIT:
			IO.oBoardFeedingLight := FALSE;
			IO.oUIIndicatorLight := FALSE;
			AxisControl.Power := FALSE;
		
			MachineState := MACHINE_STATE_HARDWARE_INIT;
		
		MACHINE_STATE_HARDWARE_INIT:
			IO.oBoardFeedingLight := FALSE;
			IO.oUIIndicatorLight := FALSE;
			
			IF AxisControl.Info.ReadyToPowerOn THEN
				AxisControl.Power := TRUE;
				MachineState := MACHINE_STATE_AXIS_POWER;
			END_IF;
		
		MACHINE_STATE_AXIS_POWER:
			IO.oBoardFeedingLight := FALSE;
			IO.oUIIndicatorLight := FALSE;
			
			IF AxisControl.PowerOn THEN
				Action_Stop_Feeder;
				MachineState := MACHINE_STATE_IDLE;
			END_IF;
		
		MACHINE_STATE_IDLE:
			IO.oBoardFeedingLight := FALSE;
			IO.oUIIndicatorLight := Pulse_Slow.bFlashOut;
			
			IF EDGEPOS(iManualBoardEject) THEN
				
				AxisControl.MoveVelocity := FALSE;
				AxisControl.MoveAbsolute := FALSE;
				AxisControl.MoveAdditive := FALSE;
				AxisControl.Stop := FALSE;
				AxisControl();
	
				AxisPar.Velocity := gRecCfg.active.Rec.FeedVelocity;
				AxisPar.Acceleration := gRecCfg.active.Cfg.Creaser.FeedAxisAccel;
				AxisPar.Deceleration := gRecCfg.active.Cfg.Creaser.FeedAxisDecel;
	
				AxisControl.MoveVelocity := TRUE;
				AxisControl();
				
				MachineState := MACHINE_STATE_MANUAL_EJECT;
			END_IF;

			IF EDGEPOS(iStartCommand) THEN
				IF IO.iFiberOpticSensor THEN
					gAlarms.Fiber_Optic_Blocked_RunCmd := TRUE;
					MachineState := MACHINE_STATE_ERROR;
				ELSIF NOT IO.iCreaserShaftSensor THEN
					gAlarms.Manual_Home_Creaser_Blade := TRUE;
					MachineState := MACHINE_STATE_ERROR;
				ELSE
					//					setflagCreaserIndexCommand := TRUE;
					iSoftStopCommand := FALSE;
					Action_Start_Feeder;
					ProcessState := PRCS_STATE_INIT;
					MachineState := MACHINE_STATE_RUNNING;
				END_IF;
			END_IF;
		
		MACHINE_STATE_MANUAL_EJECT:
			IO.oBoardFeedingLight := TRUE;
			IO.oUIIndicatorLight := Pulse_Slow.bFlashOut;
			
			IF (NOT IO.iFiberOpticSensor AND IO_LastCycle.iFiberOpticSensor) OR NOT iManualBoardEject THEN
				Action_Stop_Feeder;
				MachineState := MACHINE_STATE_IDLE;
			END_IF;
			
		
		MACHINE_STATE_RUNNING:
			IO.oUIIndicatorLight := TRUE;
			
			Action_Manage_Update_Total_Runtime;
			
			
			
			IF iSoftStopCommand THEN
				
				IF NOT (ProcessState = PRCS_STATE_SOFT_STOP) THEN
					Action_Stop_Feeder;
				END_IF;
				
				ProcessState := PRCS_STATE_SOFT_STOP;
			END_IF;
			
			Action_CreaserProcess_SM; //Crease motor <-> movement cycle <-> FiOS state machine 

		MACHINE_STATE_ERROR: //ERROR state.  Note that this state is exited via the logic ABOVE the state machine.
			IO.oBoardFeedingLight := FALSE;
			IO.oUIIndicatorLight := Pulse_Fast.bFlashOut AND Pulse_Slow.bFlashOut;
			
			Current_Crease_Section_Length := 0;

			ProcessState := PRCS_STATE_INIT;
			
	END_CASE;
	
	Pulse_Slow;
	Pulse_Fast;
	
	Action_Creaser_Idx; //Reads/sets flag variables indicating current state of the creasing motor
	Action_AxisControl_Mgmt; //Calls Infeed Axis Control FBK, sets/resets drive errors

	IO_LastCycle := IO; //Latch previous cycle IO values (since EDGEPOS() has some weird caveats)
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

