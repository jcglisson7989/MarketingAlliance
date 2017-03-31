
PROGRAM _INIT
	gHMIForceIO.forceItems[0].pAddrIO := ADR(ControlIO.iRunCmd);
	gHMIForceIO.forceItems[1].pAddrIO := ADR(ControlIO.iReservoirLevel);
	gHMIForceIO.forceItems[2].pAddrIO := ADR(CureIO.oUVCureChannel[0]);
	gHMIForceIO.forceItems[3].pAddrIO := ADR(CureIO.oUVCureChannel[1]);
	gHMIForceIO.forceItems[4].pAddrIO := ADR(StatusIO.iClearError);
	gHMIForceIO.forceItems[5].pAddrIO := ADR(ControlIO.iTargetPiP);
	gHMIForceIO.forceItems[6].pAddrIO := ADR(ControlIO.oTargetPresent);
	gHMIForceIO.forceItems[7].pAddrIO := ADR(StatusIO.oRunningReady);
END_PROGRAM

PROGRAM _CYCLIC
	IF gHMIForceIO.forceEnable = 0 THEN //IMPORTANTTODO: only go to max idx! FIX THIS IN AS5200 AND UVF AS WELL!
		gHMIForceIO.forceItemsVisibility := 1;
		
		FOR ii_force := 0 TO HMI_ENUM_FORCEIO_LASTINDEX BY 1 DO
			pForceIOPt ACCESS gHMIForceIO.forceItems[ii_force].pAddrIO;
			pSet ACCESS ADR(gHMIForceIO.forceItems[ii_force].set);
			pReset ACCESS ADR(gHMIForceIO.forceItems[ii_force].reset);
			pToggle ACCESS ADR(gHMIForceIO.forceItems[ii_force].toggle);
			
			pSet := FALSE;
			pReset := FALSE;
			pToggle := FALSE;
		END_FOR;
	ELSE
		gHMIForceIO.forceItemsVisibility := 0;
		
		FOR ii_force := 0 TO HMI_ENUM_FORCEIO_LASTINDEX BY 1 DO
			IF gHMIForceIO.forceItems[ii_force].pAddrIO <> 0 THEN
				pForceIOPt ACCESS gHMIForceIO.forceItems[ii_force].pAddrIO;
				pSet ACCESS ADR(gHMIForceIO.forceItems[ii_force].set);
				pReset ACCESS ADR(gHMIForceIO.forceItems[ii_force].reset);
				pToggle ACCESS ADR(gHMIForceIO.forceItems[ii_force].toggle);
				
				IF pSet THEN
					pForceIOPt := TRUE;
				END_IF;
				
				IF pReset THEN
					pForceIOPt := FALSE;
				END_IF;
				
				IF pToggle THEN
					pToggle := FALSE;
					pForceIOPt := NOT pForceIOPt;
				END_IF;
			END_IF;
		END_FOR;
	END_IF;
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

