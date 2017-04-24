
ACTION Action_CreaserProcess_SM: 

	CASE ProcessState OF
		PRCS_STATE_INIT:
			IO.oBoardFeedingLight := FALSE;
			Current_Board_Position := 0;
					
			Action_Validate_Board_Length;					
					
			IF flagBoardLengthCfgErr THEN
				flagBoardLengthCfgErr := FALSE;
				ProcessState := PRCS_STATE_ERROR;
			ELSIF IO.iCreaserShaftSensor THEN
				ii_crease_count := 0;
				ProcessState := PRCS_STATE_READY;
			END_IF;					
				
		PRCS_STATE_READY:
			IO.oBoardFeedingLight := FALSE;
			Current_Board_Position := 0;
					
			IF AxisControl.InVelocity THEN
				ii_crease_count := 0;
				ProcessState := PRCS_STATE_FEED_BOARD;
			END_IF;
					
		//				PRCS_STATE_FEED_BOARD:
		//					IO.oBoardFeedingLight := TRUE;
		//					IF IO.iFiberOpticSensor AND NOT IO_LastCycle.iFiberOpticSensor THEN
		//						Action_Move_Section_Distance;
		//						
		//						Current_Board_Position := 0;
		//						
		//						ProcessState := PRCS_STATE_MOVE_CREASE;
		//					END_IF;
				
		PRCS_STATE_FEED_BOARD:
			IO.oBoardFeedingLight := TRUE;
			IF IO.iFiberOpticSensor AND NOT IO_LastCycle.iFiberOpticSensor THEN
				Action_Move_Photoeye_Offset;
						
				ProcessState := PRCS_STATE_MOVE_PHOTOEYE_OFFSET;
			END_IF;
				
		PRCS_STATE_MOVE_PHOTOEYE_OFFSET:
			IO.oBoardFeedingLight := Pulse_Slow.bFlashOut;
					
			IF AxisControl.InPosition THEN
				Action_Move_Section_Distance;
				Current_Board_Position := 0;
				ProcessState := PRCS_STATE_MOVE_CREASE;
			END_IF;
				
		PRCS_STATE_MOVE_CREASE:
			IO.oBoardFeedingLight := Pulse_Slow.bFlashOut;
			IF AxisControl.InPosition THEN
				setflagCreaserIndexCommand := TRUE;
				ProcessState := PRCS_STATE_CREASE;
			END_IF;
				
		PRCS_STATE_CREASE:
			IO.oBoardFeedingLight := Pulse_Fast.bFlashOut;
					
			IF setFlagCreaserIdxFinished THEN //Wait for flag set by creaser that it has indexed and is at the "ready" position to move board
				ii_crease_count := ii_crease_count + 1; //Increment crease counter
						
				IF ii_crease_count = (gRecCfg.active.Rec.Crease.CreaseCount) THEN
					//							Action_Start_Feeder;
							
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
							
					ProcessState := PRCS_STATE_EJECT_FINISHED_BOARD;
				ELSE
					Action_Move_Crease_Width;
					ProcessState := PRCS_STATE_MOVE_CREASE_WIDTH;
				END_IF;
			END_IF;
				
		PRCS_STATE_MOVE_CREASE_WIDTH:
			IO.oBoardFeedingLight := Pulse_Slow.bFlashOut;
					
			IF AxisControl.InPosition THEN
				Action_Move_Section_Distance;
				ProcessState := PRCS_STATE_MOVE_CREASE;
			END_IF;
				
		PRCS_STATE_EJECT_FINISHED_BOARD:
			IO.oBoardFeedingLight := Pulse_Slow.bFlashOut AND Pulse_Fast.bFlashOut;
					
			IF NOT IO.iFiberOpticSensor AND IO_LastCycle.iFiberOpticSensor THEN
						
				Latch_Board_Length := Current_Board_Position;
						
				IF Latch_Board_Length > (gRecCfg.active.Rec.Crease.TotalBoardLength + gRecCfg.active.Cfg.Creaser.BoardLengthTolerance) THEN
					gAlarms.Measured_Length_GT_Configured := TRUE;
					ProcessState := PRCS_STATE_ERROR;
				ELSIF Latch_Board_Length < (gRecCfg.active.Rec.Crease.TotalBoardLength - gRecCfg.active.Cfg.Creaser.BoardLengthTolerance) THEN
					gAlarms.Board_Length_LT_Confgd_Amount := TRUE;
					ProcessState := PRCS_STATE_ERROR;
				ELSE
					gStatistics.total_processed := gStatistics.total_processed + 1;
					gStatistics.Sum_Board_Travel_Lengths := gStatistics.Sum_Board_Travel_Lengths + Latch_Board_Length;
					gStatistics.Avg_Board_Length := gStatistics.Sum_Board_Travel_Lengths / UDINT_TO_REAL(gStatistics.total_processed);						
						
					Action_Start_Feeder;
						
					ProcessState := PRCS_STATE_READY;
				END_IF;
						
						
			END_IF;
				
		PRCS_STATE_ERROR:
			IO.oBoardFeedingLight := FALSE;
				
		PRCS_STATE_SOFT_STOP:
			IO.oBoardFeedingLight := FALSE;
				
			IF NOT iSoftStopCommand THEN
				Action_Start_Feeder;
						
				IF IO.iFiberOpticSensor THEN  //Eject this part, maybe in the future resume from last state but for now just consider the current part a wash
					ProcessState := PRCS_STATE_INIT;
				ELSE //Re-cycle back to process SM jump-off point
					setflagCreaserIndexCommand := TRUE;
					ii_crease_count := 0;
					ProcessState := PRCS_STATE_INIT;
				END_IF;
			END_IF;
	END_CASE;
	

END_ACTION
