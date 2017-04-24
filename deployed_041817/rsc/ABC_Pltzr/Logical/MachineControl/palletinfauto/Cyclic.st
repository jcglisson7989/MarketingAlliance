
PROGRAM _CYCLIC
	(* Insert code here *)	
	gCtrl.palletDispenser.clawsOpenTmr();
	
	
	IF ((gCtrl.palletDispenser.dispenseState <> 0) AND (NOT gCtrl.main.noFaults)) THEN
		gCtrl.palletDispenser.dispenseState := 0;
	END_IF;	
	
	
	CASE gCtrl.palletDispenser.dispenseState OF
		
		PLT_DISPENSE_ZERO : 
			IF gCtrl.main.modeAuto THEN//wait here for auto mode
				gCtrl.palletDispenser.dispenseState := PLT_DISPENSE_INIT;
				gCtrl.palletDispenser.hmiBtnClawsLiftToTop := 1;
			END_IF;	
		
		PLT_DISPENSE_INIT: //make sure to start at top						
			IF gCtrl.palletDispenser.atTop THEN
				gCtrl.palletDispenser.hmiBtnPalletClawsOpenClose := 1;//CLOSE CLAWS
				gCtrl.palletDispenser.dispenseState := PLT_DISPENSE_IDLE;
				gCtrl.palletDispenser.dispenseDN := FALSE;
				gCtrl.palletDispenser.dispenseIP := FALSE;
				gCtrl.palletDispenser.dispenseReq := FALSE;
			END_IF;
					
		PLT_DISPENSE_IDLE: 
			
			gCtrl.palletDispenser.dispenseDN := FALSE;
			gCtrl.palletDispenser.dispenseIP := FALSE;
			
			IF gCtrl.palletDispenser.dispenseReq THEN
				gCtrl.palletDispenser.dispenseIP := TRUE;
				gCtrl.palletDispenser.hmiBtnClawsLiftToBottom := 1;//GO TO BOTTOM
				gCtrl.palletDispenser.dispenseState := PLT_DISPENSE_TOBOTTOM;
			END_IF;		
		
		PLT_DISPENSE_TOBOTTOM://wait to bottom
			IF gCtrl.palletDispenser.atBottom THEN//WAIT TO GET TO BOTTOM
				gCtrl.palletDispenser.hmiBtnPalletClawsOpenClose := 0;//OPEN CLAWS
				gCtrl.palletDispenser.clawsOpenTmr.IN := 0;
				gCtrl.palletDispenser.clawsOpenTmr.PT := T#3s;
				gCtrl.palletDispenser.dispenseState := PLT_DISPENSE_WTCLAWSOPN;
			END_IF;	
		
		PLT_DISPENSE_WTCLAWSOPN://WAIT FOR CLAWS TO OPEN
			gCtrl.palletDispenser.clawsOpenTmr.IN := 1;
			IF gCtrl.palletDispenser.clawsOpenTmr.Q THEN
				gCtrl.palletDispenser.hmiBtnClawsLiftToMidLo := 1;//move to MID low
				gCtrl.palletDispenser.dispenseState := PLT_DISPENSE_TOMID;			
			END_IF;	
		
		PLT_DISPENSE_TOMID://WAIT FOR MID POSITION
			IF gCtrl.palletDispenser.atMidLo THEN//Wait for At mit Low
				gCtrl.palletDispenser.hmiBtnPalletClawsOpenClose := 1;//CLOSE CLAWS
				
				gCtrl.palletDispenser.clawsOpenTmr.IN := 0;
				gCtrl.palletDispenser.clawsOpenTmr.PT := T#3s;
				gCtrl.palletDispenser.dispenseState := PLT_DISPENSE_WTCLAWSCLS;
			END_IF;
		
		PLT_DISPENSE_WTCLAWSCLS://WAIT FOR CLAWS TO CLOSE
			gCtrl.palletDispenser.clawsOpenTmr.IN := 1;
			IF gCtrl.palletDispenser.clawsOpenTmr.Q THEN
				gCtrl.palletDispenser.hmiBtnClawsLiftToTop := 1;
				gCtrl.palletDispenser.dispenseState := PLT_DISPENSE_DN;			
			END_IF;	
		
		PLT_DISPENSE_DN://END OF DISPENSE CYCLE 
			IF gCtrl.palletDispenser.atTop THEN			
				gCtrl.palletDispenser.dispenseDN := TRUE;
				gCtrl.palletDispenser.dispenseReq := FALSE;
				gCtrl.palletDispenser.dispenseState := PLT_DISPENSE_IDLE;			
			END_IF;	
						
		ELSE
			
	END_CASE;	
	
END_PROGRAM
