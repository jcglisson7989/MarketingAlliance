
ACTION Action_Eval_ErrorState_Statuses: 
	
		//Set status alarm values based on IO points->
	gAlarms.SM1_Disabled := IO.iSM1Disabled; //SM1 supplies power to the IO from the 24VAC->24VDC power supply
	gAlarms.Unsafe_Machine_State := NOT IO.iSafeMachineState; //DP reads whether the E-stop has been pressed
	
	IF (MachineState <> MACHINE_STATE_ERROR AND MachineState <> MACHINE_STATE_INIT) THEN
		IF (NOT IO.iSafeMachineState) THEN //E-stop pressed
			gAlarms.Error_State_Unsafe_Machine := TRUE;
			MachineState := MACHINE_STATE_ERROR;
		ELSIF gAlarms.SM1_Disabled THEN //IO power disabled
			gAlarms.Error_State_SM1_Power := TRUE;
			MachineState := MACHINE_STATE_ERROR;
		ELSIF AxisControl.Error THEN //Servo Drive error
			gAlarms.Feed_Axis_Motor_Error := TRUE;
			MachineState := MACHINE_STATE_ERROR;
		ELSIF ProcessState = PRCS_STATE_ERROR THEN //Process Error
			gAlarms.Error_State_Process_Error := TRUE;
			MachineState := MACHINE_STATE_ERROR;
		ELSIF gRecCfg.active.Rec.Crease.CreaseCount > MAX_IDX_CREASES THEN //Configured crease amount error (shouldn't ever happen! PV tables shouldn't allow this, redundant here)
			gAlarms.Crease_Count_Greater_Max := TRUE;
			MachineState := MACHINE_STATE_ERROR;
		ELSIF NOT (gRecCfg.IO.Rec.O.Initial_Load = 1) THEN //Don't allow machine to run until you've loaded an inital recipe!
			gAlarms.Load_Recipe := TRUE;
			MachineState := MACHINE_STATE_ERROR;
		END_IF;
	END_IF;

END_ACTION
