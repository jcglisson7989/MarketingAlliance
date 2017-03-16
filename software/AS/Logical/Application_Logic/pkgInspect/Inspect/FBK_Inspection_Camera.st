
(* TODO: Add your comment here *)
FUNCTION_BLOCK Hernon_Inspection_Camera
	
	InspVar.VBlock_At_Inspect_Unit := (Current_VBlock_At_PiP_Sensor + (pMechanics.N_VBlocks_Belt_Total - pInspCfg.VBlock_Offset_From_PiP_Sensor)) MOD (pMechanics.N_VBlocks_Belt_Total);
	InspVar.VBlock_Fract_Pos := VBlock_Fractional_Position;

	CASE InspVar.Status OF
		INSPECT_STATE_INIT:
			pInspectionIO.oInspectionTrigger := FALSE;
			pInspectionIO.oIlluminationTrigger := FALSE;
				
			InspVar.Status := INSPECT_STATE_READY;
				
		INSPECT_STATE_READY:
			IF pInspRec.Enable = 1 THEN //If inspection is enabled:
				IF (InspVar.VBlock_At_Inspect_Unit <> InspVar_LastCycle.VBlock_At_Inspect_Unit) THEN //Inspection VBlock index
					IF (pInspVBlock.VBlock_Is_Occupied AND pInspVBlock.Inspection[idx_inspect_unit].Item_Inspection_Status = INSPECTION_RESULTS_NONESOFAR) THEN //Current vblock in front of inspection after index is occupied and hasn't been inspected yet
						//Handle resetting the VC object array datapoints to restart recording
//						brsmemset(ADR(pInspVCTrend.iInspectionGood[0]), 0, MAX_IDX_DISPENSE_VC_ARRAY + 1);
//						brsmemset(ADR(pInspVCTrend.iInspectionBad[0]), 0, MAX_IDX_DISPENSE_VC_ARRAY + 1);
//						brsmemset(ADR(pInspVCTrend.iInspectionError[0]), 0, MAX_IDX_DISPENSE_VC_ARRAY + 1);
//						brsmemset(ADR(pInspVCTrend.oInspectionTrigger[0]), 0, MAX_IDX_DISPENSE_VC_ARRAY + 1);
//						brsmemset(ADR(pInspVCTrend.oIlluminationTrigger[0]), 0, MAX_IDX_DISPENSE_VC_ARRAY + 1);
						InspVar.ii_VC_Trend_idx := 0;
							
						InspVar.Status := INSPECT_STATE_WAIT_VBLOCK_DISP;
							
					ELSIF pInspVBlock.VBlock_Is_Occupied AND pInspVBlock.Inspection[idx_inspect_unit].Item_Inspection_Status <> INSPECTION_RESULTS_NONESOFAR THEN 
//						pInspVBlock.Error.Inspection_Error_1 := TRUE;
						Alarms.Inspection_Error_1 := TRUE;
//						pInspVBlock.Inspection[ii_inspect_units].Item_Inspection_Status := INSPECTION_ERROR_ALREADY_DONE;
						InspVar.Status := INSPECT_STATE_ERROR;
					END_IF;
				ELSIF InspVar.Flag_Inspect_Trigger_Now THEN //Force inspection to occur, i.e. manual trigger
//					//Handle resetting the VC object array datapoints to restart recording
//					brsmemset(ADR(pInspVCTrend.iInspectionGood[0]), 0, MAX_IDX_DISPENSE_VC_ARRAY + 1);
//					brsmemset(ADR(pInspVCTrend.iInspectionBad[0]), 0, MAX_IDX_DISPENSE_VC_ARRAY + 1);
//					brsmemset(ADR(pInspVCTrend.iInspectionError[0]), 0, MAX_IDX_DISPENSE_VC_ARRAY + 1);
//					brsmemset(ADR(pInspVCTrend.oInspectionTrigger[0]), 0, MAX_IDX_DISPENSE_VC_ARRAY + 1);
//					brsmemset(ADR(pInspVCTrend.oIlluminationTrigger[0]), 0, MAX_IDX_DISPENSE_VC_ARRAY + 1);
					InspVar.ii_VC_Trend_idx := 0;
						
					InspVar.Flag_Inspect_Trigger_Now := FALSE;
						
					bgTimerStart(InspVar.Timer.Timer_Inspection_Illum_DO_High, Tms(pInspCfg.Insp_Illum_ON_TO_S));
					bgTimerStart(InspVar.Timer.Timer_Inspection_Trigger_Wait, Tms(pInspCfg.Insp_Trigger_Wait_TO_S));
							
					InspVar.Status := INSPECT_STATE_WAIT_TRIG; //When triggering insp. manually, skip straight to waiting for the triggers rather than waiting for the vblock fractional displacement.
				ELSIF pInspectionIO.iInspectionBusy THEN //Shouldn't get a busy signal when not expecting it
					Alarms.Inspection_Busy_Without_Signal := TRUE;
					InspVar.Status := INSPECT_STATE_ERROR;
				ELSIF NOT pInspectionIO.iInspectionRunning THEN //Should always see DI corresponding to "running" state
					Alarms.Inspection_Not_Running := TRUE;
					InspVar.Status := INSPECT_STATE_ERROR;
				END_IF;
			ELSE//Inspection is disabled:
				InspVar.Status := INSPECT_STATE_DISABLED;
			END_IF;

		INSPECT_STATE_WAIT_VBLOCK_DISP:
			pInspectionIO.oInspectionTrigger := FALSE;
			pInspectionIO.oIlluminationTrigger := FALSE;
				
			IF InspVar.VBlock_Fract_Pos > pInspRec.Insp_VBlock_Displacement  THEN
				bgTimerStart(InspVar.Timer.Timer_Inspection_Illum_DO_High, Tms(pInspCfg.Insp_Illum_ON_TO_S));
				bgTimerStart(InspVar.Timer.Timer_Inspection_Trigger_Wait, Tms(pInspCfg.Insp_Trigger_Wait_TO_S));
				InspVar.Status := INSPECT_STATE_WAIT_TRIG;
			END_IF;
			
		INSPECT_STATE_WAIT_TRIG:
			pInspectionIO.oInspectionTrigger := FALSE;
			pInspectionIO.oIlluminationTrigger := NOT bgTimerIsTimeOut(InspVar.Timer.Timer_Inspection_Illum_DO_High);
			
			IF bgTimerIsTimeOut(InspVar.Timer.Timer_Inspection_Trigger_Wait) THEN
				bgTimerStart(InspVar.Timer.Timer_Inspection_Trigger_DO_High, Tms(pInspRec.Insp_Trigger_ON_TO_S));
				bgTimerStart(InspVar.Timer.Timer_Max_Insp_Busy_Signal, Tms(pInspCfg.Inspection_Max_Busy_TO_S));
				//
				InspVar.Status := INSPECT_STATE_WAIT_BUSY;
			ELSIF InspVar.VBlock_At_Inspect_Unit <> InspVar_LastCycle.VBlock_At_Inspect_Unit THEN
				Alarms.Inspection_VBlock_Idx_Waiting := TRUE;
				InspVar.Status := INSPECT_STATE_ERROR;
			END_IF;
				
		INSPECT_STATE_WAIT_BUSY:
			pInspectionIO.oInspectionTrigger := NOT bgTimerIsTimeOut(InspVar.Timer.Timer_Inspection_Trigger_DO_High);
			pInspectionIO.oIlluminationTrigger := NOT bgTimerIsTimeOut(InspVar.Timer.Timer_Inspection_Illum_DO_High);
				
			IF pInspectionIO.iInspectionBusy THEN
				bgTimerStart(InspVar.Timer.Timer_Inspection_Results_Wait, Tms(pInspCfg.Insp_Results_Wait_TO_S));
				InspVar.Status := INSPECT_STATE_WAIT_RESULTS;
			ELSIF bgTimerIsTimeOut(InspVar.Timer.Timer_Max_Insp_Busy_Signal) THEN
				Alarms.Insp_Err_Max_Busy_TO := TRUE;
				InspVar.Status := INSPECT_STATE_ERROR;
			ELSIF InspVar.VBlock_At_Inspect_Unit <> InspVar_LastCycle.VBlock_At_Inspect_Unit THEN
				Alarms.Inspection_VBlock_Idx_Waiting := TRUE;
				InspVar.Status := INSPECT_STATE_ERROR;
			END_IF;
				
		INSPECT_STATE_WAIT_RESULTS:
			pInspectionIO.oInspectionTrigger := NOT bgTimerIsTimeOut(InspVar.Timer.Timer_Inspection_Trigger_DO_High);
			pInspectionIO.oIlluminationTrigger := NOT bgTimerIsTimeOut(InspVar.Timer.Timer_Inspection_Illum_DO_High);
				
			IF NOT pInspectionIO.iInspectionBusy THEN
				pInspectionIO.oInspectionTrigger := FALSE;
				pInspectionIO.oIlluminationTrigger := FALSE;
				IF pInspectionIO.iInspectionError AND NOT pInspectionIO.iInspectionGood THEN
					pInspVBlock.Inspection[idx_inspect_unit].Item_Inspection_Status := INSPECTION_RESULTS_ERROR;
					pInspStats.Num_Err := pInspStats.Num_Err + 1;
				ELSE
					IF pInspectionIO.iInspectionGood THEN
						pInspVBlock.Inspection[idx_inspect_unit].Item_Inspection_Status := INSPECTION_RESULTS_GOOD;
						pInspStats.Num_Passed := pInspStats.Num_Passed + 1;
							
						pInspSeqFails := 0;
					ELSE
						pInspVBlock.Inspection[idx_inspect_unit].Item_Inspection_Status := INSPECTION_RESULTS_BAD;
						pInspStats.Num_Failed := pInspStats.Num_Failed + 1;
							
						pInspSeqFails := pInspSeqFails + 1;
					END_IF;
				END_IF;
				pInspVBlock.Inspection[idx_inspect_unit].Inspection_Time := bgTimerTimeElapsed(InspVar.Timer.Timer_Inspection_Results_Wait);
				//Return to state to wait for next inspection trigger event
				InspVar.Status := INSPECT_STATE_READY;
			ELSIF bgTimerIsTimeOut(InspVar.Timer.Timer_Inspection_Results_Wait) THEN
				//Failed to receive results within the specified timeout
				pInspectionIO.oInspectionTrigger := FALSE;
				pInspectionIO.oIlluminationTrigger := FALSE;
					
				pInspStats.Num_Unanswered := pInspStats.Num_Unanswered + 1;
					
				Alarms.Inspection_Results_TO_NoAnswer := TRUE;
				InspVar.Status := INSPECT_STATE_ERROR;
			ELSIF InspVar.VBlock_At_Inspect_Unit <> InspVar_LastCycle.VBlock_At_Inspect_Unit THEN
				Alarms.Inspection_VBlock_Idx_Waiting := TRUE;
				InspVar.Status := INSPECT_STATE_ERROR;
			END_IF;
			
		INSPECT_STATE_ERROR:

		INSPECT_STATE_DISABLED:
			IF pInspRec.Enable = 1 THEN
				InspVar.Status := INSPECT_STATE_INIT;
			END_IF;
	END_CASE;

	//Call timers
	bgTimerCyclic(InspVar.Timer.Timer_Inspection_Trigger_DO_High);
	bgTimerCyclic(InspVar.Timer.Timer_Inspection_Illum_DO_High);
	bgTimerCyclic(InspVar.Timer.Timer_Inspection_Results_Wait);
	bgTimerCyclic(InspVar.Timer.Timer_Inspection_Trigger_Wait);
	bgTimerCyclic(InspVar.Timer.Timer_Max_Insp_Busy_Signal);
//	bgTimerCyclic(InspectionRunSigBypass_ResetTime);
		
	
END_FUNCTION_BLOCK
