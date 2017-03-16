
(* TODO: Add your comment here *)
FUNCTION_BLOCK HernonDispValve
	
	DispVar.VBlock_At_Dispense_Unit := (Current_VBlock_At_PiP_Sensor + (pMechanics.N_VBlocks_Belt_Total - pDispCfg.VBlock_Offset_From_PiP_Sensor)) MOD (pMechanics.N_VBlocks_Belt_Total);
	DispVar.VBlock_Fract_Pos := VBlock_Fractional_Position;
	
	IF pDispRec.Enable = 1 AND DispVar.VBlock_At_Dispense_Unit <> DispVar_LastCycle.VBlock_At_Dispense_Unit AND pDispVBlock.VBlock_Is_Occupied THEN
		DispVar.Flag_Dispense_Trigger_Now := TRUE;
		pDispVBlock.Dispense[idx_disp_unit].Dispense_Has_Been_Triggered[DispVar.ii_shot_counter] := TRUE;
	END_IF;
	
	//TODO: Return SM to INIT here on Stop/Reset Requested?
	
	IF NOT pDispenseIO.EdgeGen.iEdgeGenWarning THEN
		pDispenseIO.EdgeGen.oQuitEdgeGenWarning := FALSE;
	END_IF;
	
	IF NOT pDispenseIO.EdgeGen.iEdgeGenError THEN
		pDispenseIO.EdgeGen.oQuitEdgeGenError := FALSE;
	END_IF;
	
	
	CASE DispVar.DispState OF
		DISPENSE_STATE_INIT:
			pDispenseIO.oDispTrigger := FALSE;
			DispVar.Flag_Dispense_Trigger_Now := FALSE;
			DispVar.ii_shot_counter := 0;
			pDispenseIO.EdgeGen.oEnableEdgeGen := TRUE;
				
			IF pDispenseIO.EdgeGen.iEdgeGenError AND pDispenseIO.EdgeGen.oQuitEdgeGenError THEN
				pDispenseIO.EdgeGen.oQuitEdgeGenError := TRUE;
			ELSE
				pDispenseIO.EdgeGen.oQuitEdgeGenError := FALSE;
			END_IF;
				
			IF pDispenseIO.EdgeGen.iEdgeGenWarning AND pDispenseIO.EdgeGen.oQuitEdgeGenWarning THEN
				pDispenseIO.EdgeGen.oQuitEdgeGenWarning := TRUE;
			ELSE
				pDispenseIO.EdgeGen.oQuitEdgeGenWarning := FALSE;
			END_IF;

			IF pDispRec.Enable = 0 THEN
				DispVar.DispState := DISPENSE_STATE_DISABLED;
			ELSIF (pDispenseIO.iValveReady AND NOT pDispenseIO.EdgeGen.iEdgeGenError) THEN
				DispVar.DispState := DISPENSE_STATE_READY;
			END_IF;
			
		DISPENSE_STATE_READY:
			IF (NOT pDispenseIO.iValveReady OR pDispenseIO.EdgeGen.iEdgeGenError) AND (MachineState = gSTATE_START_REQUESTED OR MachineState = gSTATE_RUNNING) THEN
//				pDispVBlock.Error.DispenseValveError := TRUE;
				Alarms.Valve_Error_1 := TRUE;
					
				DispVar.DispState := DISPENSE_STATE_ERROR;
			ELSIF DispVar.Flag_Dispense_Trigger_Now THEN
				//Reset HMI trend datapoints
//				brsmemset(ADR(pDispVCTrend.iValveReady[0]), 0, MAX_IDX_DISPENSE_VC_ARRAY + 1);
//				brsmemset(ADR(pDispVCTrend.oDispTrigger[0]), 0, MAX_IDX_DISPENSE_VC_ARRAY + 1);
//				brsmemset(ADR(pDispVCTrend.iReadOutputStatus[0]), 0, MAX_IDX_DISPENSE_VC_ARRAY + 1);
				DispVar.ii_Trend_Idx_DP := 0;
				//
				DispVar.ii_shot_counter := 0;
				pDispenseIO.oDispTrigger := TRUE;
				bgTimerStart(DispVar.Timer.Max_Valve_NotRdy_NegEdge, Tms(pDispCfg.Disp_Valve_Max_RDY_NegEdge_S));
					
				DispVar.Edge_Reading_At_Disp_Trigger := pDispenseIO.EdgeGen.iEdgeMasterTime;//Nearly lost my mind to this one, need to document edge reading immediately before triggering output, as the high-speed edge detector has no debounce and it can possibly be a "dirty switch"
				DispVar.Flag_Dispense_Trigger_Now := FALSE;
				DispVar.Disp_Single_Shot_Or_Purge := DISPENSE_SINGLE_SHOT;
				DispVar.DispState := DISPENSE_STATE_WAIT_VALVE;
			ELSIF DispVar.Flag_Dispense_Purge_Now THEN
				pDispenseIO.oDispTrigger := TRUE;

				bgTimerStart(DispVar.Timer.Max_Dispense_Output_High, Tms(pDispCfg.Disp_Valve_Max_Output_High_TO_S));
				DispVar.Edge_Reading_At_Disp_Trigger := pDispenseIO.EdgeGen.iEdgeMasterTime;

				DispVar.Disp_Single_Shot_Or_Purge := DISPENSE_PURGE;
				DispVar.DispState := DISPENSE_STATE_DISPENSING;
			END_IF;
			
		DISPENSE_STATE_WAIT_VALVE:
			IF pDispenseIO.EdgeGen.iEdgeMasterTime <> DispVar.Edge_Reading_At_Disp_Trigger THEN
				pDispenseIO.oDispTrigger := FALSE;
				//Incrementing the edge gen sequence number is what causes the new timestamp to take hold (otherwise, it would trigger every time the clock rolls over)
				pDispenseIO.EdgeGen.oEdgeGenTimestamp := pDispenseIO.EdgeGen.iEdgeMasterTime + Tms(pDispRec.Disp_Valve_Edgemode_Pulse_TO_ms);//Yeah, this looks wrong, but it's probably right.
				pDispenseIO.EdgeGen.oEdgeGenSequence := pDispenseIO.EdgeGen.oEdgeGenSequence + 1;
				//Timer for maximum amount of time to wait before throwing an error, since the DO is reset via the edge generator and not the IO BOOL datapoint itself
				bgTimerStart(DispVar.Timer.Max_Time_Disp_Output_NegEdge, REAL_TO_UDINT(pDispRec.Disp_Valve_Edgemode_Pulse_TO_ms) + Tms(pDispCfg.Disp_Output_NegEdge_Margin_S));
				//
				DispVar.DispState := DISPENSE_STATE_DISPENSING;
			ELSIF (bgTimerIsTimeOut(DispVar.Timer.Max_Valve_NotRdy_NegEdge)) AND pDispenseIO.iValveReady THEN
				pDispenseIO.oDispTrigger := FALSE;
					
				pDispenseIO.EdgeGen.oEdgeGenTimestamp := iNettime + 10000;//Yeah, this looks wrong, but it's probably right.
				pDispenseIO.EdgeGen.oEdgeGenSequence := pDispenseIO.EdgeGen.oEdgeGenSequence + 1;//Incrementing the edge gen sequence number is what causes the new timestamp to take hold (otherwise, it would trigger every time the clock rolls over)
					
				Alarms.Dispense_ValveRdy_NegEdge_Err := TRUE;
				DispVar.DispState := DISPENSE_STATE_ERROR;
			END_IF;
			
		DISPENSE_STATE_DISPENSING:
			CASE DispVar.Disp_Single_Shot_Or_Purge OF
				DISPENSE_SINGLE_SHOT:
					IF NOT pDispenseIO.EdgeGen.iReadOutputStatus THEN
						bgTimerStart(DispVar.Timer.Max_Valve_Rdy_Reset, Tms(pDispCfg.Disp_Signal_Reset_MaxTO_S));
						DispVar.DispState := DISPENSE_STATE_WAIT_RESET;
					ELSIF bgTimerIsTimeOut(DispVar.Timer.Max_Time_Disp_Output_NegEdge) THEN
						Alarms.Disp_Output_Not_Reset := TRUE;
						DispVar.DispState := DISPENSE_STATE_ERROR;
					END_IF;		
				DISPENSE_PURGE:
					pDispenseIO.oDispTrigger := FALSE;
					IF NOT DispVar.Flag_Dispense_Purge_Now THEN
						pDispenseIO.EdgeGen.oEdgeGenTimestamp := iNettime + 10000;//Yeah, this looks wrong, but it's probably right.
						pDispenseIO.EdgeGen.oEdgeGenSequence := pDispenseIO.EdgeGen.oEdgeGenSequence + 1;
							
						bgTimerStart(DispVar.Timer.Max_Valve_Rdy_Reset, Tms(pDispCfg.Disp_Signal_Reset_MaxTO_S));
						DispVar.DispState := DISPENSE_STATE_WAIT_RESET;
					ELSIF bgTimerIsTimeOut(DispVar.Timer.Max_Dispense_Output_High) THEN
						pDispenseIO.EdgeGen.oEdgeGenTimestamp := iNettime + 10000;//Yeah, this looks wrong, but it's probably right.
						pDispenseIO.EdgeGen.oEdgeGenSequence := pDispenseIO.EdgeGen.oEdgeGenSequence + 1;
							
						bgTimerStart(DispVar.Timer.Max_Valve_Rdy_Reset, Tms(pDispCfg.Disp_Signal_Reset_MaxTO_S));
						DispVar.DispState := DISPENSE_STATE_WAIT_RESET;
					END_IF;
			END_CASE;

		DISPENSE_STATE_WAIT_RESET://Wait for dispense valve ready to read back TRUE before the SM can go back into ready state, otherwise the rest of the code could trigger it too soon.
			IF pDispenseIO.iValveReady AND NOT DispVar.Flag_Dispense_Purge_Now THEN
				DispVar.ii_shot_counter := DispVar.ii_shot_counter + 1;
					
				IF DispVar.ii_shot_counter > pDispRec.Extra_Shots_Per_VBlock (*pDispCfg.Extra_Shots_Per_VBlock*) THEN
					DispVar.DispState := DISPENSE_STATE_READY;
				ELSE
					IF DispVar.VBlock_Fract_Pos < pDispRec.Vblock_Offset_Additional_Shots[DispVar.ii_shot_counter - 1] THEN
						DispVar.DispState := DISPENSE_STATE_WAIT_ADDITIONAL;
					ELSE
						Alarms.VBlock_Offset_Invalid := TRUE;
						DispVar.DispState := DISPENSE_STATE_ERROR;
					END_IF;
				END_IF;
			ELSIF bgTimerIsTimeOut(DispVar.Timer.Max_Valve_Rdy_Reset) AND (MachineState = gSTATE_START_REQUESTED OR MachineState = gSTATE_RUNNING) THEN
				Alarms.ValveRdy_Not_Reset := TRUE;
				DispVar.DispState := DISPENSE_STATE_ERROR;
			END_IF;
			
		DISPENSE_STATE_WAIT_ADDITIONAL:
			IF DispVar.VBlock_Fract_Pos > pDispRec.Vblock_Offset_Additional_Shots[DispVar.ii_shot_counter - 1] THEN
				pDispenseIO.oDispTrigger := TRUE;
				bgTimerStart(DispVar.Timer.Max_Valve_NotRdy_NegEdge, Tms(pDispCfg.Disp_Valve_Max_RDY_NegEdge_S));
				DispVar.Edge_Reading_At_Disp_Trigger := pDispenseIO.EdgeGen.iEdgeMasterTime;
				DispVar.Flag_Dispense_Trigger_Now := FALSE;
				DispVar.Disp_Single_Shot_Or_Purge := DISPENSE_SINGLE_SHOT;
				DispVar.DispState := DISPENSE_STATE_WAIT_VALVE;
			ELSIF DispVar.VBlock_At_Dispense_Unit <> DispVar_LastCycle.VBlock_At_Dispense_Unit THEN
				Alarms.VBlock_idx_during_shot_wait := TRUE;
				DispVar.DispState := DISPENSE_STATE_ERROR;
			END_IF;
			
		DISPENSE_STATE_DISABLED:
			IF pDispRec.Enable = 1 THEN
				DispVar.DispState := DISPENSE_STATE_INIT;
			END_IF;
			
		DISPENSE_STATE_ERROR:
		//State is exited via the event handler directly above state machine!
	END_CASE;
	
	bgTimerCyclic(DispVar.Timer.Max_Valve_NotRdy_NegEdge);
	bgTimerCyclic(DispVar.Timer.Max_Time_Disp_Output_NegEdge);
	bgTimerCyclic(DispVar.Timer.Max_Valve_Rdy_Reset);
	bgTimerCyclic(DispVar.Timer.Max_Dispense_Output_High);
	
	DispVar_LastCycle := DispVar;
	
END_FUNCTION_BLOCK
