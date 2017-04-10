
ACTION Action_Creaser_Idx: 
	setFlagCreaserIdxFinished := FALSE;
	
	IF setflagCreaserIndexCommand THEN
		setFlagTravelEdgeOffset := FALSE;
		setFlagCreaserWaitEdge := TRUE;
	END_IF;
	
	IF setFlagCreaserWaitEdge THEN
		IO.oCreaserCCWRotation := (gRecCfg.active.Rec.Crease.CreaserDirection = 0);
		IO.oCreaserCWRotation  := (gRecCfg.active.Rec.Crease.CreaserDirection = 1);
		
		IF setFlagTravelEdgeOffset AND bgTimerIsTimeOut(Timer_Creaser_Idx_Edge) THEN
			setFlagTravelEdgeOffset := FALSE;
			setFlagCreaserWaitEdge := FALSE;
			setFlagCreaserIdxFinished := TRUE;
		END_IF;
		
		CASE gRecCfg.active.Rec.Crease.ShaftSensorEdge OF
			0:
				IF IO.iCreaserShaftSensor AND NOT IO_LastCycle.iCreaserShaftSensor AND NOT setFlagTravelEdgeOffset THEN
					setFlagTravelEdgeOffset := TRUE;
					bgTimerStart(Timer_Creaser_Idx_Edge, Tms(gRecCfg.active.Rec.Crease.CreaserMotorIdxLag_S));
				END_IF;
			1:
				IF NOT IO.iCreaserShaftSensor AND IO_LastCycle.iCreaserShaftSensor AND NOT setFlagTravelEdgeOffset THEN
					setFlagTravelEdgeOffset := TRUE;
					bgTimerStart(Timer_Creaser_Idx_Edge, Tms(gRecCfg.active.Rec.Crease.CreaserMotorIdxLag_S));
				END_IF;
		END_CASE;
	ELSE
		IO.oCreaserCCWRotation := FALSE;
		IO.oCreaserCWRotation  := FALSE;
	END_IF;
	
	bgTimerCyclic(Timer_Creaser_Idx_Edge);
	
	
	setflagCreaserIndexCommand := FALSE;
END_ACTION
