(*********************************************************************************
 * Copyright: Microsoft
 * Author:    Obed
 * Created:   May 26, 2015/11:38 AM 
 *********************************************************************************
 * Declaration of AppControl global data types for ABC Palletizer
 *********************************************************************************)
(*********************************************************************************							
	Application Structures					
*********************************************************************************)

TYPE
	macCtrlEnums_typ : 
		(
		APP_REC_MAXCASE := 12, (*Max number of cases per row*)
		APP_REC_MAXROW := 12, (*Max number of rows per layer*)
		APP_REC_MAXLAYER := 12 (*Max number of layers per palette*)
		);
END_TYPE

(*********************************************************************************							
macCtrl_typ Contains all machine Control Structures. Using "mac" as abbreviation for Machine, "Ctrl" as for Control			
*********************************************************************************)

TYPE
	macCtrl_typ : 	STRUCT 
		main : macCtrlMain_typ; (*Machine Main*)
		infeedcv : macCtrlInfeedCV_typ; (*Timing Infeed Conveyor*)
		rowforming : macCtrlRowForming_typ; (*Row Forming Conveyor*)
		caseturner : macCtrlCaseTurner_typ; (*Case Turner*)
		retainerbar : macCtrlRetainerBar_typ;
		transfertable : macCtrlTransferTable_typ; (*Roller Transfer Table*)
		squaring : macCtrlSquaringPlates_typ; (*Main Frame Side Squaring Plates*)
		elevator : macCtrlElevator_typ; (*Main Frame Elevator*)
		palletDispenser : macCtrlPalleteDispenser_typ; (*Pallet Dispenser*)
		palletDischarge : macCtrlPalleteDischarge_typ; (*Pallet Dispenser*)
	END_STRUCT;
END_TYPE

(*********************************************************************************							
macCtrlMain_typ Machine Main		
*********************************************************************************)

TYPE
	macCtrlMain_typ : 	STRUCT 
		modeMaintenance : BOOL; (*Mode: service/maintance. Minor or Major Fault active. Start (Auto) not possible.*)
		modeManual : BOOL; (*Mode: manual; No faults. Not in auto mode. Buttons to start auto mode IS available.*)
		modeAuto : BOOL; (*Mode: auto is active. See below for available auto modes.*)
		modeAutoProduction : BOOL; (*Mode: autoProduction; Auto. Production, Normal operation. Button to stop is available.*)
		modeAutoDryCycle : BOOL; (*Mode: autoDryCycle; Auto. DryCycleMode, Testing option. Button to stop is available.*)
		modeAutoDemo : BOOL; (*Mode: autoDemo; Auto. Demp/Show mode, Used for Show. Button to stop is available.*)
		modeAutoStarting : BOOL; (*Mode: autoStarting; Auto. Transitioning from Manual to Auto. (i.e. Start Button Pressed).*)
		modeAutoStopping : BOOL; (*Mode: autoStopping; Auto. Transitioning from Auto to Manual. (i.e. Stop Button Pressed).*)
		buttonEnabledStart : BOOL; (*Start Button control.*)
		buttonEnabledMaint : BOOL; (*Start Button control.*)
		noMajorFault : BOOL; (*No major fault on the machine.*)
		noMinorFault : BOOL; (*No minor fault on the machine.*)
		noFaults : BOOL; (*No minor or major fault on the machine.*)
		guardDoorsOk : BOOL; (*Guard door safety indicator.*)
		EStopOk : BOOL; (*EStop safety indicator.*)
		SafetyOk : BOOL; (*Safety Circuit OK*)
		VFDsNoFaults : BOOL; (*VFDs fault indication*)
		isAtZero : BOOL; (*machine is at zero position*)
		zeroIsNeeded : BOOL; (*machine is at zero position*)
		btnZero : BOOL; (*0-not pressed; 1-presed*)
		btnStart : BOOL; (*0-not pressed; 1-presed*)
		btnStop : BOOL; (*0-not pressed; 1-presed*)
		btnFaultAck : BOOL; (*1-ack fault / alarms*)
		btnClearCaseCounts : BOOL; (*1-ack fault / alarms*)
		btnZeroVisibility : INT; (*0-visible; 1-not visible*)
		hmiShowMsgZeroingNeeded : BOOL;
		btnNotInAutoModeVisibility : INT; (*0-visible; 1-not visible*)
		btnStartVisibility : INT; (*0-visible; 1-not visible*)
		btnLoadMachineCfg : BOOL;
		alwaysOnBit : BOOL; (*Always on bit*)
		testBit1 : BOOL; (*Test bit 1: TESTING ONLY! REMOVE FROM A FINAL PROGRAM!*)
		testBit2 : BOOL; (*Test bit 2: TESTING ONLY! REMOVE FROM A FINAL PROGRAM!*)
		testBit3 : BOOL; (*Test bit 3: TESTING ONLY! REMOVE FROM A FINAL PROGRAM!*)
		dummyCoil : BOOL; (*Dummy coil*)
		blink : BOOL; (*Light on/off blink signal*)
		gCamApp_btnPreview : BOOL;
		optionEStops : ARRAY[0..5]OF BOOL; (*Configuration Option for EStops Circuits*)
		optionDoorSw : ARRAY[0..5]OF BOOL; (*Configuration Options of Door Safety Switches*)
		visibleCaseInfeedOnLeft : UDINT; (*Visibility control for HMI when Case infeed on the left*)
		visibleCaseInfeedOnRight : UDINT; (*Visibility control for HMI when Case infeed on the right*)
		isDropLayerToPalletAllowed : BOOL;
		dropLayerToPalletBlock : BOOL;
		elevatorStopBlockActive : BOOL; (*Elevator stops blocks are active. This is part of the safety logic. *)
		tmrMCROnDelay : TON; (*Timer for MCR on delay*)
		tmrAirOnDelay : TON; (*Timer for air on delay*)
		tmrBlinkOn : TON; (*Timer for blink signal*)
		tmrBlinkOff : TOF; (*Timer for blink signal*)
	END_STRUCT;
END_TYPE

(*********************************************************************************							
macCtrlMode_typ Machine Control Modes of Operation			
*********************************************************************************)

TYPE
	macCtrlMode_typ : 	STRUCT 
		Maintenance : BOOL; (*Minor or Major Fault active*)
		Manual : BOOL; (*Not in auto mode. Buttons to start auto mode are available.*)
		AutoProduction : BOOL; (*Auto. Production, Normal operation. Button to stop is available.*)
		AutoDryCycle : BOOL; (*Auto. DryCycleMode, Testing option. Button to stop is available.*)
		AutoDemo : BOOL; (*Auto. Demp/Show mode, Used for Show. Button to stop is available.*)
		AutoStarting : BOOL;
		AutoStopping : BOOL;
	END_STRUCT;
END_TYPE

(*********************************************************************************							
macCtrlStats_typ Machine Statistics data (case counts, etc)			
*********************************************************************************)

TYPE
	macCtrlStats_typ : 	STRUCT 
		btnResetCounts : BOOL;
		btnResetCountsTotal : BOOL;
		casesPerMin : UDINT;
		caseCounter : UDINT;
		caseCounterTotal : UDINT;
		palletCounter : UDINT;
		palletCounterTotal : UDINT;
		palletTimeMin : REAL;
		palletTimeMax : REAL;
		palletTimeLast : REAL;
		runningTmr1 : TON;
		runningTmr1min : TON;
		runningTmr1sec : TON;
		palletTmr : TON;
		runTmrHours : UDINT;
		runTmrMins : UDINT;
		runTmrSec : UDINT;
		mCasesPerMinCounter : UDINT;
	END_STRUCT;
END_TYPE

(*********************************************************************************							
macCtrlTimingInfeedConveyor_typ #TIMING INFEED CONVEYOR			
*********************************************************************************)

TYPE
	macCtrlInfeedCV_typ : 	STRUCT 
		hmiBtnOnOff : BOOL;
		infeedCvOn : BOOL;
		caseInSensorNegEdge : BOOL;
		caseInSensorPosEdge : BOOL;
		caseInSensor : BOOL;
		caseOutSensorNegEdge : BOOL;
		caseOutSensorPosEdge : BOOL;
		caseOutSensor : BOOL;
		caseAtOneCaseOnlySection : BOOL;
		nextCaseToCloseMonitorEnabled : BOOL;
		caseInfeedDone : BOOL;
		tmrJamAtCaseInSensorEE2 : TON;
		tmrJamAtCaseStageSensorEE4 : TON;
		tmrJamAtCaseOutSensorEE8 : TON;
		tmrJamRowForming : TON;
		tmrInfeedCVIdle : TON;
		tmrInfeedStopDly : TON;
		rowFormingCVRunPosEdge : BOOL;
		rowFormingCVRunNegEdge : BOOL;
		ssmInfeedCV : bgSSM_typ;
		sleepState : BOOL;
		stopRequest : BOOL;
	END_STRUCT;
END_TYPE

(*********************************************************************************							
macCtrlRowFormingConveyor_typ #ROW FORMING CONVEYOR			
*********************************************************************************)

TYPE
	macCtrlRowForming_typ : 	STRUCT 
		isRowPusherAtHome : BOOL;
		isRowPusherAtElevator : BOOL;
		hmiBtnPusherFwdJog : BOOL;
		hmiBtnPusherRevJog : BOOL;
		hmiBtnPusherFwd : BOOL;
		hmiBtnPusherRev : BOOL;
		hmiBtnOnOffStageCV : BOOL;
		hmiBtnOnOffCV : BOOL;
		hmiBtnStopBladeUpDown1 : BOOL;
		hmiBtnStopBladeUpDown2 : BOOL;
		hmiBtnStopBladeUpDown3 : BOOL;
		hmiBtnStopBladeUpDown4 : BOOL;
		hmiBtnStopBladeUpDown5 : BOOL;
		hmiBtnStopBladeUpDown6 : BOOL;
		hmiBtnStopBladeUpDownQuick1 : BOOL;
		hmiBtnStopBladeUpDownQuick2 : BOOL;
		hmiBtnStopBladeUpDownQuick3 : BOOL;
		hmiBtnStopBladeUpDownQuick4 : BOOL;
		hmiBtnStopBladeUpDownQuick5 : BOOL;
		hmiBtnStopBladeUpDownQuick6 : BOOL;
		New_Member : USINT;
		isStopBladeUsed1 : BOOL;
		isStopBladeUsed2 : BOOL;
		isStopBladeUsed3 : BOOL;
		isStopBladeUsed4 : BOOL;
		isStopBladeUsed5 : BOOL;
		isStopBladeUsed6 : BOOL;
		allBladesDown : BOOL;
		lastCaseToStopCVDly : TON;
		rowPusherOnDly : TON;
		bladeStopOnDly : ARRAY[0..5]OF TON;
	END_STRUCT;
END_TYPE

(*********************************************************************************							
macCtrlCaseTurner_typ #CASE TURNER			
*********************************************************************************)

TYPE
	macCtrlCaseTurner_typ : 	STRUCT 
		hmiBtnCaseTurnerUpDown : BOOL;
		hmiAutoCaseTurn : BOOL; (*0-no case turn; 1-case turn (raise turner)*)
		tmrCaseTurnerActive : TON;
	END_STRUCT;
END_TYPE

(*********************************************************************************							
macCtrlRollerTransferTable_typ #ROLLER TRANSFER TABLE			
*********************************************************************************)

TYPE
	macCtrlTransferTable_typ : 	STRUCT 
		isTableAtGrouping : BOOL;
		isTableAtPallete : BOOL;
		hmiBtnTableFwdJog : BOOL;
		hmiBtnTableRevJog : BOOL;
		hmiBtnTableFwd : BOOL;
		hmiBtnTableRev : BOOL;
		hmiBtnOnOffCV : BOOL;
	END_STRUCT;
	macCtrlRetainerBar_typ : 	STRUCT 
		revTimer : TON;
		fwdTimer : TON;
		barDwOffDlyTmr : TON;
		barDwDlyTmXms : UDINT;
		barIsUp : BOOL;
		barIsDown : BOOL;
		hmiBtnRetainterBarFwdJog : BOOL;
		hmiBtnRetainterBarRevJog : BOOL;
		hmiBtnRetainterBarFwd : BOOL;
		hmiBtnRetainterBarRev : BOOL;
	END_STRUCT;
END_TYPE

(*********************************************************************************							
macCtrlElevator_typ #MAIN FRAME ELEVATOR			
*********************************************************************************)

TYPE
	macCtrlElevator_typ : 	STRUCT 
		elevatorIsAtTop : BOOL; (*Elevator at home position*)
		elevatorIsAboveHomeUnknown : BOOL; (*Elevator above home*)
		elevatorIsAboveNearHome : BOOL; (*Elevator above home*)
		elevatorIsAboveHome : BOOL; (*Elevator above home*)
		elevatorIsAtHome : BOOL; (*Elevator at home position*)
		elevatorIsBelowHome : BOOL; (*Elevator is below home position*)
		elevatorIsBelowNearHome : BOOL; (*Elevator is below home position*)
		elevatorIsBelowHomeUnknown : BOOL; (*Elevator is below home position, both switches out*)
		elevatorIsAtBottom : BOOL; (*Elevator at home position*)
		elevatorIsUknownPosition : BOOL; (*Elevator is below home position*)
		elevatorIsMovingUp : BOOL; (*Elevator is below home position*)
		elevatorIsMovingDw : BOOL; (*Elevator is below home position*)
		elevatorIsAtPalleteBelowHome : BOOL; (*Elevator is below home position*)
		elevatorIsAtPalleteAboveHome : BOOL; (*Elevator is below home position*)
		hmiBtnElevatorToHome : BOOL; (*Send elevator to home (which is grouping/loading position)*)
		hmiBtnElevatorToGrouping : BOOL; (*Send elevator to grouping/loading position*)
		hmiBtnElevatorToAbovePallete : BOOL; (*Send elevator to above the pallete for pallete exiting when front squaring option is present*)
		hmiBtnElevatorToPallete : BOOL; (*Send elevator to pallete top/unloading position*)
		hmiBtnElevatorToTop : BOOL; (*Send elevator to the top position*)
		hmiBtnElevatorFwdJog : BOOL; (*Jog Fwd (UP)*)
		hmiBtnElevatorRevJog : BOOL; (*Jog Rev (DW)*)
		hmiBtnElevatorFwd : BOOL; (*Move Fwd (UP to the top)*)
		hmiBtnElevatorRev : BOOL; (*Move Rev (DW to the bottom)*)
		tmrPalletePEOff : TOF;
		tmrPalletePEOn : TON;
	END_STRUCT;
END_TYPE

(*********************************************************************************							
macCtrlSideSquaringPlates_typ #SIDE SQUARING PLATES			
*********************************************************************************)

TYPE
	macCtrlSquaringPlates_typ : 	STRUCT 
		frontSquaringEquipped : BOOL;
		hmiBtnFrontPlateExtRet : BOOL;
		hmiBtnSidePlatesExtRet : BOOL;
		tmrFrontSquaringOnDly : TON;
	END_STRUCT;
END_TYPE

(*********************************************************************************							
macCtrlDispenser_typ #PALLET DISPENSER			
*********************************************************************************)

TYPE
	macCtrlPalleteDispenserEnums_typ : 
		(
		PLT_DISPENSE_ZERO := 0,
		PLT_DISPENSE_INIT,
		PLT_DISPENSE_IDLE,
		PLT_DISPENSE_TOBOTTOM,
		PLT_DISPENSE_WTCLAWSOPN,
		PLT_DISPENSE_TOMID,
		PLT_DISPENSE_WTCLAWSCLS,
		PLT_DISPENSE_DN
		);
	macCtrlPalleteDispenser_typ : 	STRUCT 
		palletDispenserEquippedVis : USINT; (*0-visible when  equipped; 1-not visible when not equipped*)
		palletDispenserEquipped : BOOL; (*0-not equipped; 1-equipped*)
		hmiBtnPalletClawsOpenClose : BOOL;
		hmiBtnPalletInCVFwdJog : BOOL;
		hmiBtnPalletInCVRevJog : BOOL;
		hmiBtnPalletInCVFwd : BOOL;
		hmiBtnPalletInCVRev : BOOL;
		hmiBtnClawsLiftUpJog : BOOL;
		hmiBtnClawsLiftDwJog : BOOL;
		atTop : BOOL;
		atMidHi : BOOL;
		atMidLo : BOOL;
		atBottom : BOOL;
		flagClawsLiftToMidHi : BOOL;
		flagClawsLiftToMidLo : BOOL;
		flagMoveUp : BOOL;
		hmiBtnClawsLiftToTop : BOOL;
		hmiBtnClawsLiftToMidHi : BOOL;
		hmiBtnClawsLiftToMidLo : BOOL;
		hmiBtnClawsLiftToBottom : BOOL;
		dispenseState : macCtrlPalleteDispenserEnums_typ;
		dispenseReq : BOOL;
		dispenseIP : BOOL;
		dispenseDN : BOOL;
		clawsOpenTmr : TON;
	END_STRUCT;
	macCtrlPalleteDischarge_typ : 	STRUCT 
		hmiBtnPalletDischargeCVFwdJog : BOOL;
		hmiBtnPalletDischargeCVRevJog : BOOL;
		hmiBtnPalletDischargeCVFwd : BOOL;
		hmiBtnPalletDischargeCVRev : BOOL;
		hmiBtnPalletManualExit : BOOL;
		palletManualExitRequest : BOOL;
		palletManualFinishRequest : BOOL;
		muteLightCurtainDuringDischarge : BOOL;
		dischargePESensor : BOOL;
		dischargeState : UDINT;
		dischargeReq : BOOL;
		isDischargeAllowed : BOOL;
		dischargeIP : BOOL;
		dischargeDN : BOOL;
		dischargeRecoveryIP : BOOL;
		dischargeRecoveryVisible2 : BOOL;
		dischargeRecoveryVisible : UINT;
		dischargePESensorTmrOf : TOF;
		dischargeMuteRecoveryTmr : TON;
		dischargeMuteTmr : TOF;
		dischargeTmr : TON;
		palleteExitTmoutTmr : TON;
	END_STRUCT;
END_TYPE

(*********************************************************************************							
appControlLogic_typ			
*********************************************************************************)

TYPE
	appControlLogic_typDELETE : 	STRUCT  (*Application Control*)
		cmd : appControlCmd_typ; (*Commands*)
		status : appMachineStatus_typ; (*Machine Status*)
		seekStartPosition : BOOL; (*Seek Start Position*)
		seekStartInAuto : BOOL; (*Seek Start In Auto*)
		seekStartInHand : BOOL; (*Seek Start In Hand*)
		autoCycleComplete : BOOL; (*Auto Cycle Complete*)
		handExitFullPallet : BOOL; (*Hand Exit Full Pallet*)
		handMode : BOOL; (*Hand Mode*)
		palletRunout : BOOL; (*Pallet Runout*)
		safetyCircuitEnergized : BOOL; (*Safety Circuit Energized*)
		guardDoorsOK : BOOL; (*Guard Doors OK*)
		guardDoor1Message : BOOL; (*Guard Door 1 Message*)
		guardDoor2Message : BOOL; (*Guard Door 2 Message*)
		guardDoor3Message : BOOL; (*Guard Door 3 Message*)
		guardDoor4Message : BOOL; (*Guard Door 4 Message*)
		dispenserGuardEyeMessage : BOOL; (*Dispenser Guard Eye Message*)
		machineHasPalletDispensor : BOOL; (*Machine Has Palllet Dispensor ???*)
		dischargeGuardEyeMessage : BOOL; (*Discharge Guard Eye Message*)
		inserterGuardEyeMessage : BOOL; (*Inserter Guard Eye Message*)
		Check_Drive1 : BOOL; (*Check Drive 1*)
		Check_Drive4 : BOOL; (*Check Drive 4*)
		Drive4_OverCurrent : BOOL; (*Drive 4 OverCurrent*)
		VFD_On_Row_Pusher : BOOL; (*VFD On Row Pusher*)
		rollerSleep : BOOL; (*Roller Sleep Reset ????*)
		machineHasServoOrTurnTable : BOOL; (*Machine Has Servo Or Turn Table #TURNER*)
		dryCycleMode : BOOL; (*Dry Cycle Mode*)
		runOut : BOOL; (*RunOut*)
		CheckDrive4TON : TON; (*Check Drive 4 TON*)
		DelayForDriveDischargeTON : TON; (*Delay For Drive Discharge TON*)
		DelayAirOnTON : TON; (*Delay For Air On TON*)
		CheckDrive1TON : TON; (*Check Drive 1TON*)
		MSROnDelayedTOF : TOF; (*MSR ON Delayed TOF*)
		CaseCountEyeOFFDelayTOF : TOF; (*Case Count Eye OFF Delay*)
		AutoCycleDelayOFF : BOOL; (*AutoCycleDelayOFF*)
		AutoCycleDelayOFFTOF : TOF; (*AutoCycleDelayOFF TOF*)
		RollerSleepTON : TON; (*Roller Sleep TON*)
		noDrive1Confirm : BOOL; (*No Drive 1 Confirm*)
		MSROnDelayed : BOOL; (*MSR On Delayed*)
		DelayForDriveDischarge : BOOL; (*Delay For Drive Discharge*)
		NoMinorFault : BOOL; (*No Minor Fault*)
		NoMajorFault : BOOL; (*No Major Fault*)
		NotOkOneShot : BOOL; (*Not Ok One Shot*)
		DelayForAirOn : BOOL; (*Delay For Air On*)
		noProductComming : BOOL; (*No Product Comming*)
		MotorOverloads : BOOL; (*Motor Overloads ???*)
		MachineHasCategory3Safety : BOOL; (*Machine has category 3 safety*)
		MachineHasAuxsVFDs : BOOL; (*Machine has Auxs VFDs ???*)
		MachineHasServoTurner : BOOL; (*Machine has Servo Turner SERVO_OPTION*)
		MachineHasBottomSheetInserter : BOOL; (*Machine has Bottom Sheet Inserter ???*)
		MachineHasOverHeadPusher : BOOL; (*Machine has Overhead Pusher ???*)
		MachineHasOverHeadInserter : BOOL; (*Machine has Overhead Inserter ???*)
		CountsDontMatch : BOOL; (*Counts Dont Match*)
		StartPosition : BOOL; (*Start Position*)
		ZeroMachine : BOOL; (*Zero Machine*)
		ResetLayer : BOOL; (*Reset Layer*)
		Pallet_Disch_BypassSelectorSW : BOOL; (*Pallet Discharge Bypass Selector Switch SS5 ???*)
		DownCount : BOOL; (*Down Count*)
		PushedEndOfRun : BOOL; (*Pushed End of Run*)
		RowPusherLeavingHome : BOOL; (*Row Pusher Leaving Home*)
		RowCountImpulse : BOOL; (*RowCountImpulse*)
		CaseCountEyeOFFDelay : BOOL; (*Case Count Eye OFF Delay*)
		CaseCountImpulse : BOOL; (*Case Count Impulse*)
		DontRunThisOne : BOOL; (*Don't Run This One*)
		SingleScan : BOOL; (*Single Scan*)
		ResetCaseCount : BOOL; (*Reset Case Counts*)
		BackOfLastBag : BOOL; (*Back Of Last Bag*)
		NewPatternOneShot : BOOL; (*New Pattern One Shot*)
		EndOfRun : BOOL; (*End Of Run EOR*)
	END_STRUCT;
END_TYPE

(*********************************************************************************							
appControlCmd_typ				
*********************************************************************************)

TYPE
	appMachineStatus_typ : 	STRUCT  (*Application Control Commands*)
		machine_running : BOOL; (*Machine Running AUTO*)
	END_STRUCT;
END_TYPE

(*********************************************************************************							
appControlCmd_typ				
*********************************************************************************)

TYPE
	appControlCmd_typ : 	STRUCT  (*Application Control Commands*)
		acknowledge_btn : BOOL; (*Acknowledge Button*)
		machine_start : BOOL; (*Machine Start*)
		machine_stop : BOOL; (*Machine Stop*)
		guard_eye_reset : BOOL; (*Guard Eye Reset PB5 ???*)
		pallet_discharge_selector_switch : BOOL; (*Pallet Discharge Selector Switch???*)
	END_STRUCT;
	appPalleteCfg_typ : 	STRUCT  (*Application Control Commands*)
		palleteSizeIdx : UDINT; (*Acknowledge Button*)
		layerCount : UDINT; (*Machine Start*)
		layerPatternIdx : ARRAY[0..15]OF UDINT; (*Machine Start*)
		layerUseTierSheet : ARRAY[0..15]OF UDINT; (*Machine Start*)
		layerOption1 : ARRAY[0..15]OF UDINT; (*Machine Start*)
	END_STRUCT;
	appPalleteCtrl_typ : 	STRUCT  (*Application Control Commands*)
		layerVisibility : ARRAY[0..15]OF USINT; (*Acknowledge Button*)
		layerCount : UDINT; (*Machine Start*)
	END_STRUCT;
END_TYPE

(*========================================================*)
(*Pallete configuration (recipe) structures*)
(*========================================================*)

TYPE
	palleteCfgSettings_typ : 	STRUCT  (*Pallete configuration (recipe) settings*)
		testTimer1 : REAL;
		timers : appCfgTimers_typ;
		vfd : ARRAY[0..APP_VFD_IDXLAST]OF cfgMachineVFDs_typ;
	END_STRUCT;
	palleteCfgLayerSettings_typ : 	STRUCT  (*Pallete configuration (recipe) settings*)
		layerFilename : STRING[31]; (*filename of the layer program to use*)
		insertTearSheet : UDINT; (*feature: insert tear sheet*)
		layerFeature1 : UDINT; (*feature: tbd*)
		sameAsOtherLayer : UDINT; (*0-not used at all; 1-use settings/configuration from the other layer (i.e. layerFilename not used, local values here not used);2-use layer settings*)
		otherLayerIdx : UDINT; (*if useOtherLayer=1, this is the index of the layer to use (0..maxLayerIdx)*)
	END_STRUCT;
	palleteCfgDimensions_typ : 	STRUCT  (*Pallete configuration (recipe) dimensions*)
		caseWidth : REAL;
		caseLength : REAL;
		caseHeight : REAL;
		palleteHeight : REAL;
		palleteWidth : REAL;
		palleteLength : REAL;
		palleteSizeHmiIdx : UDINT;
	END_STRUCT;
	palleteCfgCmdsTxt_typ : 	STRUCT  (*Pallete configuration program single instruction*)
		colorIdx : UDINT; (*0-none;1-case; 2-case +90 deg; 3-case -90 deg; 4-case 180 deg; *)
		cmdTxt : STRING[31];
	END_STRUCT;
	palleteCfgCmds_typ : 	STRUCT  (*Pallete configuration program single instruction*)
		cmdCase : USINT; (*0-none;1-case; 2-case +90 deg; 3-case -90 deg; 4-case 180 deg; *)
		cmdBlade : USINT; (*0-none, 1-bladeStop1; 2-bladeStop2, etc*)
		cmdFeature : USINT; (*0-none; 1-tbd*)
		cmdExtra : USINT; (*0-none; 1-tbd*)
	END_STRUCT;
	palleteCfgRowTxt_typ : 	STRUCT  (*Pallete row configuration (recipe) structure - collection of single instructions*)
		palCfgCmdsTxt : ARRAY[0..11]OF palleteCfgCmdsTxt_typ;
	END_STRUCT;
	palleteCfgRow_typ : 	STRUCT  (*Pallete row configuration (recipe) structure - collection of single instructions*)
		palCfgCmds : ARRAY[0..11]OF palleteCfgCmds_typ;
	END_STRUCT;
	palleteCfgLayerTxt_typ : 	STRUCT  (*Pallete layer configuration (recipe) structure - collection of rows*)
		layerFilename : STRING[31];
		layerDescription : STRING[31];
		curIdxEditorCell : UDINT;
		curIdxEditorCellOld : UDINT;
		curIdxRow : UDINT;
		curIdxCmd : UDINT;
		curCmdTxt : STRING[31];
		cmdIdxBlade : USINT;
		cmdIdxCase : USINT;
		cmdEntryCompletion : USINT;
		palCfgRowsTxt : ARRAY[0..11]OF palleteCfgRowTxt_typ;
	END_STRUCT;
	palleteCfgLayer_typ : 	STRUCT  (*Pallete layer configuration (recipe) structure - collection of rows*)
		layerFilename : STRING[31];
		layerDescription : STRING[31];
		palCfgRows : ARRAY[0..11]OF palleteCfgRow_typ;
	END_STRUCT;
	palleteCfg_typ : 	STRUCT  (*Pallete configuration (recipe) structure - collection of layers*)
		palFilename : STRING[31];
		palDescription : STRING[31];
		palActiveLayers : UDINT;
		palSettings : palleteCfgSettings_typ;
		palDimensions : palleteCfgDimensions_typ;
		palLayerSettings : ARRAY[0..11]OF palleteCfgLayerSettings_typ;
		magicNumber : UDINT;
	END_STRUCT;
END_TYPE

(*========================================================*)
(*Pallete program control structures*)
(*========================================================*)

TYPE
	palleteCtrlProcessor_typ : 	STRUCT  (*Pallete control processor data*)
		ssmInfeed : bgSSM_typ;
		ssmLayer : bgSSM_typ; (*state machine - layer forming*)
		ssmElevator : bgSSM_typ; (*state machine - elevator control*)
		ssmPallete : bgSSM_typ; (*state machine - pallete infeed / outfeed*)
		cmdIdx : UDINT; (*Current command index (from the current row)*)
		rowIdx : UDINT; (*Current row index (from the current layer)*)
		layerIdx : UDINT; (*Current layer index (from the collection of pallete layers)*)
		oPalleteRecipeIsValid : UDINT; (*Output: 1-loaded pallete recipe program is valid and it may run; 0-load pallete recipe program is not valid *)
		oRowIdxDN : USINT;
		oLayerIdxDN : USINT;
		oPalletStart : BOOL;
		oRowDN : BOOL; (*Output: current row execution is complete*)
		oLayerDN : BOOL; (*Output: current layer execution is complete*)
		oPalletDN : BOOL; (*Output: current case execution is complete*)
		oCaseDN : BOOL;
		oCurrentCases : UDINT; (*Current  number of cases processed for the entire pallet*)
		oTargetCases : UDINT; (*Target number of cases for the current row*)
		oTargetRows : UDINT; (*Targe number of rows for the current layer*)
		oTargetLayers : UDINT; (*Target number of layers for the pallet*)
		oTargetPalletCases : UDINT; (*Total number of target cases for the pallet*)
		iPause : UDINT; (*External input: pause execution*)
		iContinue : UDINT; (*External input: continue / resume execution*)
		iReset : UDINT; (*External input: reset execution*)
		iSet : UDINT; (*External input: set state of the processor execution*)
		iSetParamRow : UDINT; (*External input: parameter for the set state -  execution row*)
		iSetParamLayer : UDINT; (*External input: parameter for the set state - execution layer*)
		cmdBreakpoint : UDINT;
	END_STRUCT;
	palleteCtrlCmds_typ : 	STRUCT 
		cmdActive : SINT; (*0-none;1-case; 2-case +90 deg; 3-case -90 deg; 4-case 180 deg; *)
		cmdVisible : SINT; (*0-none, 1-bladeStop1; 2-bladeStop2, etc*)
		cmdBreakpoint : SINT; (*0-none; 1-tbd*)
		cmdExtra : SINT; (*0-none; 1-tbd*)
	END_STRUCT;
	palleteCtrlRow_typ : 	STRUCT  (*Pallete row configuration (recipe) structure - collection of single instructions*)
		palCtrlCmds : ARRAY[0..11]OF palleteCtrlCmds_typ;
	END_STRUCT;
	palleteCtrlLayer_typ : 	STRUCT  (*Pallete layer configuration (recipe) structure - collection of rows*)
		btnAssignLayerFilename : USINT;
		btnDeleteLayerFilename : USINT;
		layerVisible : USINT;
		tearSheetOptionVisible : USINT;
		option1Visible : USINT;
		palCtrlRows : ARRAY[0..11]OF palleteCtrlRow_typ;
	END_STRUCT;
	palleteCtrl_typ : 	STRUCT  (*Pallete runtime control structure*)
		palCfg : palleteCfg_typ; (*Active pallete configuration - loaded/saved to/from a pallete recipe file*)
		palCfgLayers : ARRAY[0..11]OF palleteCfgLayer_typ; (*Active layer configuration for the active pallete - each layer structure loaded from an appropriate layer file (speficied in the pallet structure)*)
		ctrlLayers : ARRAY[0..11]OF palleteCtrlLayer_typ; (*Layer control structures used during runtime to control / operate layer loading*)
		ctrlProc : palleteCtrlProcessor_typ; (*Pallete building processor control structure*)
	END_STRUCT;
END_TYPE

(*========================================================*)
(*Animation stuff*)
(*========================================================*)

TYPE
	appHmiFileHandling_typ : 	STRUCT 
		iBtnLoadL1Preview : USINT;
		iBtnLoadL2Preview : USINT;
		iBtnLoad : USINT;
		iBtnSave : USINT;
		iBtnNew : USINT;
		fileHandlerState : UDINT;
		fileHandlerTimer : TON;
	END_STRUCT;
END_TYPE

(*========================================================*)
(*Animation stuff*)
(*========================================================*)

TYPE
	appControlAnimationRow_typ : 	STRUCT  (*Application Animation Control*)
		animationRow : ARRAY[0..9]OF UDINT;
	END_STRUCT;
	appControlAnimation_typ : 	STRUCT  (*Application Animation Control*)
		tmrCase : TON;
		New_Member1 : USINT;
		New_Member : USINT;
		currentCase : UDINT;
		currentRow : UDINT;
		currentLayer : UDINT;
		visiCase : appControlAnimationRow_typ;
		visiRow : ARRAY[0..9]OF appControlAnimationRow_typ;
		visiLayer : ARRAY[0..9]OF appControlAnimationRow_typ;
	END_STRUCT;
END_TYPE
