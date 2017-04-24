(********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Package: ConfigAndRecipes
 * File: appConfig.typ
 * Author: goran_2
 * Created: August 06, 2011

DEFINE APPLICATION SPECIFIC CONFIG STRUCTURES AS NEEDED


(*Insert your comment here.*)

TYPE
	appCfgEnums_typ : 
		(
		New_Member
		);
	appCfgTimers_typ : 	STRUCT 
		dlyTableLayerRdyToElevMove : REAL; (*delay from table layer ready before elevator moves*)
		dlyTableAtPalleteToRetBar : REAL; (*delay from table at pallete before retainter bar lowered*)
		onDlyPRRetBarDown : REAL; (*on delay for Retainer Bar Down prox switch*)
		onTmCaseTurner : REAL; (*case turner dwell time*)
		onDlyEEPallete : REAL; (*on delay for pallete/box detection PE EE2*)
		offDlyEEPallete : REAL; (*off delay for pallete/box detection PE EE2*)
		onDlyPRRetBarDown2 : REAL; (*on delay for Retainer Bar Down prox switch*)
		dlyLastCaseToRowCVStop : REAL; (*delay from Row forming complete to row push. Needed to allow box to travel.*)
		dlyRowDoneToRowPush : REAL; (*delay from Row forming complete to row push. Needed to allow box to travel.*)
		infeedCVIdleTime : REAL; (*max allowed time to run infeed cv-s before stopping them*)
		JamAlarmTmAtInfeedEE2 : REAL;
		JamAlarmTmAtRowToLongEE8 : REAL;
		JamAlarmTmRowForming : REAL;
		onDlyPalleteDischargeEE16 : REAL; (*on delay for pallete discharge sensor; longer time adjustst position of the pallete pass the sensor*)
		palletExitAlarmTm : REAL; (*pallet exit alarm time*)
		EE2OnDebounce : REAL;
		EE2OfDebounce : REAL;
		EE4OnDebounce : REAL;
		EE4OfDebounce : REAL;
		EE8OnDebounce : REAL;
		EE8OfDebounce : REAL;
		EE16OfDebounce : REAL;
		dlyPusherAtElevatorToRetract : REAL; (*dealy from pusher at extended position (et elevator) to trigger retracted motion *)
		onDlyFrontSquaring : REAL;
		onDlyTableToGrouping : REAL; (*on delay after layer is dropped onto the paller before table is moved back to grouping*)
		onDlyRetBarDown : REAL; (*On delay from the moment table starts moving to the pallet before retainer bar is lowered*)
		bladeStopOnDly1 : REAL; (*Blade stop turn on delay time; to accomoated for case traveling on the row forming belt*)
		bladeStopOnDly2 : REAL; (*Blade stop turn on delay time; to accomoated for case traveling on the row forming belt*)
		bladeStopOnDly3 : REAL; (*Blade stop turn on delay time; to accomoated for case traveling on the row forming belt*)
		bladeStopOnDly4 : REAL; (*Blade stop turn on delay time; to accomoated for case traveling on the row forming belt*)
		bladeStopOnDly5 : REAL; (*Blade stop turn on delay time; to accomoated for case traveling on the row forming belt*)
		bladeStopOnDly6 : REAL; (*Blade stop turn on delay time; to accomoated for case traveling on the row forming belt*)
	END_STRUCT;
	appCfgOptions_typ : 	STRUCT 
		optTearSheetEquiped : UDINT; (*1-Tear sheet insert mechanism is present*)
		optOption1Equiped : UDINT; (*1-Tear sheet insert mechanism is present*)
		palletDispenserOption : UDINT; (*0-pallet dispenser is NOT present/NOTequipped; 1-pallet dispenser option IS present/equipped*)
		frontSquaringOption : UDINT; (*0-front squaring option is NOT present/NOTequipped; 1-front squaring option is present*)
		dryCycleCaseCount : UDINT;
		dryCycleRowCount : UDINT;
		dryCycleLayerCount : UDINT;
		tmDryCycleElevatorUp : REAL; (*time to dry cycle operation to simulate layers*)
		tmDryCycleCaseTime : REAL; (*single case loading time in dry cycle simulation*)
		dryCycleLayerDonePause : UDINT;
		tmDryCycleLayerZeroOffset : REAL; (*single case loading time in dry cycle simulation*)
	END_STRUCT;
	appCfgSystem_typ : 	STRUCT 
		bladeStopCount : UDINT; (*number of blade stops (0...6)*)
		simulationMode : UDINT; (*1-yes*)
		bladeStopOnDly : ARRAY[0..APP_CFG_BLADESTOP_MAXIDX]OF REAL; (*Blade stop turn on delay time; to accomoated for case traveling on the row forming belt*)
		bladeStopDistance : ARRAY[0..APP_CFG_BLADESTOP_MAXIDX]OF REAL; (*Blade stop distance[inch]*)
		boxInfeedSide : UDINT; (*0-infeed from left to right 1-infeed from right to left; point of refernece if front of the machine infeed looking towards the table*)
	END_STRUCT;
	cfgMachineVFDs_typ : 	STRUCT 
		velocitySlow_rpm : DINT; (*slow velocity (if needed)*)
		velocity_rpm : DINT; (*normal velocity*)
		acc : DINT; (*accelaration [x0.1sec]*)
		dec : DINT; (*decelaration [x0.1sec]*)
	END_STRUCT;
END_TYPE

(*######################################################*)

TYPE
	configApp_typ : 	STRUCT  (*Machine configuration includes settings for timers and settings for servo drives.*)
		system : appCfgSystem_typ;
		options : appCfgOptions_typ;
		magicNumber : UDINT;
	END_STRUCT;
END_TYPE
