
PROGRAM _CYCLIC
	(* Insert code here *)	

	gCtrlAnimation.tmrCase();
	
	FOR ii :=0 TO 9 BY 1 DO
		IF ii  <  gCtrlAnimation.currentCase THEN
			gCtrlAnimation.visiCase.animationRow[ii] := 0;//visible		
		ELSE
			gCtrlAnimation.visiCase.animationRow[ii] := 1;//not visible			
		END_IF;	
		
		IF ii  <  gCtrlAnimation.currentRow THEN
			FOR jj := 0 TO 9 BY 1 DO
				IF jj < gConfigApp.options.dryCycleCaseCount THEN
					gCtrlAnimation.visiRow[ii].animationRow[jj] := 0;//visible					
				ELSE
					gCtrlAnimation.visiRow[ii].animationRow[jj] := 1;//not visible										
				END_IF;	
			END_FOR;
			
		ELSE
			FOR jj := 0 TO 9 BY 1 DO
				gCtrlAnimation.visiRow[ii].animationRow[jj] := 1;//not visible					
			END_FOR;	
		END_IF;	

		IF ii  <  gCtrlAnimation.currentLayer THEN
			FOR jj := 0 TO 9 BY 1 DO
				IF jj < gConfigApp.options.dryCycleRowCount THEN
					gCtrlAnimation.visiLayer[ii].animationRow[jj] := 0;//visible					
				ELSE
					gCtrlAnimation.visiLayer[ii].animationRow[jj] := 1;//not visible										
				END_IF;	
			END_FOR;
			
		ELSE
			FOR jj := 0 TO 9 BY 1 DO
				gCtrlAnimation.visiLayer[ii].animationRow[jj] := 1;//not visible					
			END_FOR;	
		END_IF;	
		
		
	END_FOR;	
	
	IF ((animationState <> 0) AND (NOT gCtrl.main.noFaults)) THEN
		animationState := 50;
	END_IF;	
		
	CASE animationState OF
		0:
			gCtrlAnimation.currentCase := 0;
			gCtrlAnimation.currentRow := 0;
			gCtrlAnimation.currentLayer := 0;	
			IF gCtrl.main.modeAuto THEN
				animationState := 10;
				gCtrl.infeedcv.hmiBtnOnOff := 1;
				gCtrl.rowforming.hmiBtnOnOffCV := 1;
			END_IF;	
		10: 
			gCtrlAnimation.currentCase := gCtrlAnimation.currentCase + 1;
			IF gCtrlAnimation.currentCase >= gConfigApp.options.dryCycleCaseCount THEN
				gCtrl.rowforming.hmiBtnPusherFwd := 1;
				gCtrl.rowforming.hmiBtnPusherRev := 0;
				gCtrl.infeedcv.hmiBtnOnOff := 0;
				gCtrl.rowforming.hmiBtnOnOffCV := 0;
				animationState := 11;				
			ELSE
				animationState := 20;				
			END_IF;	
		11://waiting for row pusher at elev
			IF gCtrl.rowforming.isRowPusherAtElevator THEN
				gCtrlAnimation.currentCase := 0;
				gCtrlAnimation.currentRow := gCtrlAnimation.currentRow + 1;
				gCtrl.rowforming.hmiBtnPusherFwd := 0;
				gCtrl.rowforming.hmiBtnPusherRev := 1;
				
				IF gCtrlAnimation.currentRow >= gConfigApp.options.dryCycleRowCount THEN
					gCtrl.main.testBit1 := 1;//start elev drycycle
					animationState := 13;							
				ELSE
					animationState := 12;						
				END_IF;		
			END_IF;
		12://waiting for row pusher back home
			IF gCtrl.rowforming.isRowPusherAtHome THEN
				gCtrl.infeedcv.hmiBtnOnOff := 1;
				gCtrl.rowforming.hmiBtnOnOffCV := 1;

				animationState := 20;										
			END_IF;	
		13:
			IF gCtrl.main.testBit3 THEN//wait for elev dry cycle to complete
				gCtrl.main.testBit3 := 0;
				animationState := 14;														
			END_IF;	
		14:
			gCtrlAnimation.currentRow := 0;
			gCtrlAnimation.currentLayer := gCtrlAnimation.currentLayer + 1;
			IF gCtrlAnimation.currentLayer >= gConfigApp.options.dryCycleLayerCount THEN
				animationState := 30;
			ELSE
				gCtrl.infeedcv.hmiBtnOnOff := 1;
				gCtrl.rowforming.hmiBtnOnOffCV := 1;

				animationState := 20;
			END_IF;		
		20:
			gCtrl.infeedcv.hmiBtnOnOff := 1;
			gCtrl.rowforming.hmiBtnOnOffCV := 1;
			gCtrlAnimation.tmrCase.IN := 0;
			gCtrlAnimation.tmrCase.PT := REAL_TO_UDINT(gConfigApp.options.tmDryCycleCaseTime * 1000);
			
			IF (gConfigApp.options.dryCycleCaseCount >= 2) AND  (gCtrlAnimation.currentCase = 1) THEN
				gCtrl.caseturner.hmiBtnCaseTurnerUpDown := 1;	//turn on blade1 and case turner
				gCtrl.rowforming.hmiBtnStopBladeUpDown1 := 1;	
			ELSE
				gCtrl.caseturner.hmiBtnCaseTurnerUpDown := 0;	
				gCtrl.rowforming.hmiBtnStopBladeUpDown1 := 0;	
			END_IF;	
				
			
			animationState := 21;
			IF gCtrl.main.modeManual THEN
				animationState := 50;									
			END_IF;
		
		21:	
			gCtrlAnimation.tmrCase.IN := 1;
			IF gCtrlAnimation.tmrCase.Q THEN
				gCtrlAnimation.tmrCase.IN := 0;
				animationState := 10;						
			END_IF;	

		30:
			//Pallete is Done!
			IF gConfigApp.options.dryCycleLayerDonePause <> 0 THEN			
				gPaiHmiRTMenu.iMenuSelectItem[1] := 1;//switch to manual mode
				gCtrlAnimation.tmrCase.IN := 0;
				gCtrlAnimation.tmrCase.PT := T#1s;
				animationState := 31;
			ELSE
				//continue with a new layer
				animationState := 0;//clear all, and start cycle again														
			END_IF;	
		31:
			gCtrlAnimation.tmrCase.IN := 1;
			IF gCtrlAnimation.tmrCase.Q THEN
				IF gCtrl.main.modeAuto THEN
					animationState := 0;//clear all, and start cycle again										
				END_IF;	
			END_IF;	
		
		50:
		//wait for resume
			gCtrl.infeedcv.hmiBtnOnOff := 0;
			gCtrl.rowforming.hmiBtnOnOffCV := 0;
			IF gCtrl.main.modeAuto THEN
				gCtrl.infeedcv.hmiBtnOnOff := 1;
				gCtrl.rowforming.hmiBtnOnOffCV := 1;
				animationState := 20;									
			END_IF;	
		
	END_CASE;	
	
END_PROGRAM
