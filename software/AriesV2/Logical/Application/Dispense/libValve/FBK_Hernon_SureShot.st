
(* TODO: Add your comment here *)
FUNCTION_BLOCK FBK_Hernon_SureShot
	
	IF iReset THEN
		iReset := FALSE;
		brsmemset(ADR(Alarms), 0, SIZEOF(HERNON_Alarm_Dispense_typ));
		oState := DISPENSE_STATE_INIT;
	END_IF;
	
//The following shows the archetypal logic for what happens when the valve BECOMES disabled/deactivated-
//	IF (Config.Disable = 1) AND NOT (oState = DISPENSE_STATE DISABLED OR oState = DISPENSE_STATE_INIT) THEN
//		//Valve was disabled
//	ELSIF (Config.Disable = 0 AND Recipe.Enable = 0) AND NOT (oState = DISPENSE_STATE INACTIVE OR oState = DISPENSE_STATE_INIT) THEN
//		//Valve was deactivated
//	END_IF;
		
	IF NOT IO.EdgeGen.iEdgeGenError THEN
		IO.EdgeGen.oQuitEdgeGenError := FALSE;
	END_IF;
	
	IF NOT IO.EdgeGen.iEdgeGenWarning THEN
		IO.EdgeGen.oQuitEdgeGenWarning := FALSE;
	END_IF;
	
	Alarms.EdgeGenError := IO.EdgeGen.iEdgeGenError;
	
	IO.EdgeGen.oEdgeGenOffset := Tms(Recipe.Disp_Valve_Edgemode_Pulse_TO_ms);

	CASE oState OF
		DISPENSE_STATE_INIT:
			oHMIColorDP := HMI_PRCS_COLOR_DISABLED;
			
			IO.oDispTrigger := FALSE;
			iFlagDispenseNow := FALSE;
			ii_shot_counter := 0;
			IO.EdgeGen.oEnableEdgeGen := TRUE;
		
			//Following conditionals are for the X20DS4389 unit to ACK the error bit on the IO modules if it is set (only in INIT state of the valve)
			IF IO.EdgeGen.iEdgeGenError AND IO.EdgeGen.oQuitEdgeGenError THEN
				IO.EdgeGen.oQuitEdgeGenError := TRUE;
			ELSE
				IO.EdgeGen.oQuitEdgeGenError := FALSE;
			END_IF;
			
			IF IO.EdgeGen.iEdgeGenWarning AND IO.EdgeGen.oQuitEdgeGenWarning THEN
				IO.EdgeGen.oQuitEdgeGenWarning := TRUE;
			ELSE
				IO.EdgeGen.oQuitEdgeGenWarning := FALSE;
			END_IF;
			
			(*IF Config.Disable = 1 THEN*)
				IF Recipe.Enable = 0 THEN
					oState := DISPENSE_STATE_INACTIVE;
				ELSIF (IO.iValveReady AND NOT IO.EdgeGen.iEdgeGenError) THEN
					oState := DISPENSE_STATE_READY;
				END_IF;
//			ELSIF (IO.iValveReady AND NOT IO.EdgeGen.iEdgeGenError) THEN
//				oState := DISPENSE_STATE_READY;
//			END_IF;
		
		DISPENSE_STATE_READY:
			oHMIColorDP := HMI_PRCS_COLOR_IDLE;
			
			IF Recipe.Enable = 0 THEN
				oState := DISPENSE_STATE_INACTIVE;
			ELSIF (NOT IO.iValveReady OR IO.EdgeGen.iEdgeGenError) THEN
				//				pDispVBlock.Error.DispenseValveError := TRUE;
				//				gAlarms.Dispense.Valve_Error_1[ii_dispense_units] := TRUE;
				
				Alarms.Valve_Not_Ready := TRUE;
				
				oState := DISPENSE_STATE_ERROR;
			ELSIF iFlagDispenseNow THEN
				ii_shot_counter := 0;
				IO.oDispTrigger := TRUE;
				
				IO.EdgeGen.oEdgeGenTimestamp := iX2XNettime + DEFINE_TK_CYCLE_OFFSET;//Immediately give the DS card the timestamp to turn the valve off
				IO.EdgeGen.oEdgeGenSequence := IO.EdgeGen.oEdgeGenSequence + 1;//Incrementing the edge gen sequence number is what causes the new timestamp to take hold (otherwise, it would trigger every time the clock rolls over)
				
				iFlagDispenseNow := FALSE;
				iFlagDispenseOnFractionOffset := FALSE;
				oDispenseMode := DISPENSE_SINGLE_SHOT;
				oState := DISPENSE_STATE_DISPENSING;
			ELSIF iFlagPurgeNow THEN
				IO.oDispTrigger := TRUE;

				bgTimerStart(Timers.Max_Dispense_Output_High, PURGE_SOFTWARE_TIME_LIMIT);
//				oEdge_Reading_At_Disp_Trigger := IO.EdgeGen.iEdgeMasterTime;

				oDispenseMode := DISPENSE_PURGE;
				oState := DISPENSE_STATE_DISPENSING;
			ELSIF iFlagDispenseOnFractionOffset THEN
				iFlagDispenseNow := FALSE;
				iFlagDispenseOnFractionOffset := FALSE;
				bgTimerStart(Timers.Max_Fractional_Offset_Wait, MAX_TIME_WAIT_FRACTION_OFFSET);
				oState := STATE_WAIT_FRACTION_OFFSET;
			END_IF;
		
		STATE_WAIT_FRACTION_OFFSET:
			oHMIColorDP := HMI_PRCS_COLOR_ACTIVE;
		
			IF (iVBlockFractionalPosition > Recipe.Fractional_Position_Offset AND iVBlockFractionalPosition_old < Recipe.Fractional_Position_Offset) OR Recipe.Fractional_Position_Offset < 0.01 THEN
				ii_shot_counter := 0;
				IO.oDispTrigger := TRUE;

				IO.EdgeGen.oEdgeGenTimestamp := iX2XNettime + DEFINE_TK_CYCLE_OFFSET;//Immediately give the DS card the timestamp to turn the valve off
				IO.EdgeGen.oEdgeGenSequence := IO.EdgeGen.oEdgeGenSequence + 1;//Incrementing the edge gen sequence number is what causes the new timestamp to take hold (otherwise, it would trigger every time the clock rolls over)
				
				oDispenseMode := DISPENSE_SINGLE_SHOT;
				oState := DISPENSE_STATE_DISPENSING;
			ELSIF bgTimerIsTimeOut(Timers.Max_Fractional_Offset_Wait) THEN
				Alarms.Max_Time_Fractional_Offset := TRUE;
				oState := DISPENSE_STATE_ERROR;
			END_IF;
		
//		DISPENSE_STATE_WAIT_VALVE:
//			oHMIColorDP := HMI_PRCS_COLOR_ACTIVE;
//				
//			IF IO.EdgeGen.iEdgeMasterTime <> oEdge_Reading_At_Disp_Trigger THEN
//				IO.oDispTrigger := FALSE;
//					
//				IO.EdgeGen.oEdgeGenTimestamp := IO.EdgeGen.iEdgeMasterTime + Tms(Recipe.Disp_Valve_Edgemode_Pulse_TO_ms);//Tms normally converts S->mS, but here it does ms->us
//				IO.EdgeGen.oEdgeGenSequence := IO.EdgeGen.oEdgeGenSequence + 1;//Incrementing the edge gen sequence number is what causes the new timestamp to take hold (otherwise, it would trigger every time the clock rolls over)
//					
////				bgTimerStart(Timers.Max_Time_Disp_Output_NegEdge, REAL_TO_UDINT(Recipe.Disp_Valve_Edgemode_Pulse_TO_ms) + NEG_EDGE_MARGIN);//Timer for maximum amount of time to wait before throwing an error, since the DO is reset via the edge generator and not the IO BOOL datapoint itself
//
//				oState := DISPENSE_STATE_DISPENSING;
//			ELSIF (bgTimerIsTimeOut(Timers.Max_Valve_NotRdy_NegEdge)) AND IO.iValveReady THEN
//				IO.oDispTrigger := FALSE;
//				
//					
//				IO.EdgeGen.oEdgeGenTimestamp := iX2XNettime + 10000;//
//				IO.EdgeGen.oEdgeGenSequence := IO.EdgeGen.oEdgeGenSequence + 1;//Incrementing the edge gen sequence number is what causes the new timestamp to take hold (otherwise, it would trigger every time the clock rolls over)
//					
//				//					gAlarms.Dispense.Dispense_ValveRdy_NegEdge_Err[ii_dispense_units] := TRUE;
//				Alarms.Valve_Ready_Neg_Edge_Error := TRUE;
//				oState := DISPENSE_STATE_ERROR;
//			END_IF;
			
		DISPENSE_STATE_DISPENSING:
			
			oHMIColorDP := HMI_PRCS_COLOR_ACTIVE;
			
			CASE oDispenseMode OF
				DISPENSE_SINGLE_SHOT:
				IF NOT IO.EdgeGen.iReadOutputStatus THEN
					IF ii_shot_counter < Recipe.Extra_Shots_Per_VBlock THEN
						bgTimerStart(Timers.Pause_Additional_Shots, Tms(Recipe.Time_Offset_Additional_Shots));
					END_IF;						
					bgTimerStart(Timers.Min_Valve_Rdy_Reset, MIN_SIGNAL_RESET_TO);
					bgTimerStart(Timers.Max_Valve_Rdy_Reset, MAX_SIGNAL_RESET_TO);
					oState := DISPENSE_STATE_WAIT_RESET;
				END_IF;		
			DISPENSE_PURGE:
				IO.oDispTrigger := FALSE;
				IF (NOT iFlagPurgeNow) OR bgTimerIsTimeOut(Timers.Max_Dispense_Output_High) THEN
					IO.EdgeGen.oEdgeGenTimestamp := iX2XNettime + 10000;
						IO.EdgeGen.oEdgeGenSequence := IO.EdgeGen.oEdgeGenSequence + 1;
						
					bgTimerStart(Timers.Min_Valve_Rdy_Reset, MIN_SIGNAL_RESET_TO);
					bgTimerStart(Timers.Max_Valve_Rdy_Reset, MAX_SIGNAL_RESET_TO);
					oState := DISPENSE_STATE_WAIT_RESET;
				END_IF;
			END_CASE;
//
		DISPENSE_STATE_WAIT_RESET://Wait for dispense valve ready to read back TRUE before the SM can go back into ready state, otherwise the rest of the code could trigger it too soon.
			
			oHMIColorDP := HMI_PRCS_COLOR_ACTIVE;
				
			IF bgTimerIsTimeOut(Timers.Min_Valve_Rdy_Reset) AND IO.iValveReady AND NOT iFlagPurgeNow THEN
				ii_shot_counter := ii_shot_counter + 1;				
				
				IF ii_shot_counter > Recipe.Extra_Shots_Per_VBlock THEN
					pCyclesCounter := pCyclesCounter + 1;
					oState := DISPENSE_STATE_READY;
				ELSE
					oState := DISPENSE_STATE_WAIT_ADDITIONAL;
				END_IF;
			
			ELSIF bgTimerIsTimeOut(Timers.Max_Valve_Rdy_Reset) THEN
				Alarms.Valve_Not_Ready := TRUE;
				pCounterValveNotRdy := pCounterValveNotRdy + 1;
				oState := DISPENSE_STATE_READY;
			END_IF;
			
		DISPENSE_STATE_WAIT_ADDITIONAL:
			oHMIColorDP := HMI_PRCS_COLOR_ACTIVE;
		
			IF bgTimerIsTimeOut(Timers.Pause_Additional_Shots) THEN
				IO.oDispTrigger := TRUE;
				
//				oEdge_Reading_At_Disp_Trigger := IO.EdgeGen.iEdgeMasterTime;//Nearly lost my mind to this one, need to document edge reading immediately before triggering output, as the high-speed edge detector has no debounce and it can possibly be a "dirty switch"
				iFlagDispenseNow := FALSE;
				oDispenseMode := DISPENSE_SINGLE_SHOT;
				
				IO.EdgeGen.oEdgeGenTimestamp := iX2XNettime + DEFINE_TK_CYCLE_OFFSET;//Immediately give the DS card the timestamp to turn the valve off
				IO.EdgeGen.oEdgeGenSequence := IO.EdgeGen.oEdgeGenSequence + 1;//Incrementing the edge gen sequence number is what causes the new timestamp to take hold (otherwise, it would trigger every time the clock rolls over)
				
				oState := DISPENSE_STATE_DISPENSING;
			END_IF;
		
		DISPENSE_STATE_INACTIVE:
			oHMIColorDP := HMI_PRCS_COLOR_DISABLED;
				
			IF Recipe.Enable = 1 THEN
				oState := DISPENSE_STATE_INIT;
			END_IF;
		
		DISPENSE_STATE_DISABLED:
			oHMIColorDP := HMI_PRCS_COLOR_DISABLED;
		
			IF Config.Disable = 0 THEN
				oState := DISPENSE_STATE_INIT;
			END_IF;
		
		DISPENSE_STATE_ERROR://State is exited via the event handler directly above state machine!
			oHMIColorDP := HMI_PRCS_COLOR_FAULT;
	END_CASE;
	
	iVBlockFractionalPosition_old := iVBlockFractionalPosition;

	//Timer cyclic calls
	bgTimerCyclic(Timers.Max_Valve_Rdy_Reset);
	bgTimerCyclic(Timers.Min_Valve_Rdy_Reset);
	bgTimerCyclic(Timers.Max_Dispense_Output_High);
	bgTimerCyclic(Timers.Pause_Additional_Shots);
	bgTimerCyclic(Timers.Max_Fractional_Offset_Wait);

END_FUNCTION_BLOCK
