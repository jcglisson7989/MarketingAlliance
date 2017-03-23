/********************************************************************
 * COPYRIGHT -- pai
 ********************************************************************
 * Program: hmilogic
 * File: hmilogic.c
 * Author: goran
 * Created: August 28, 2013
 ********************************************************************
 * Implementation of program hmilogic
 ********************************************************************/

#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
	#include <AsDefault.h>
#endif

#include "../../paiComponents/paiHmi/paiHmiParamList.h"
#include "../../paiComponents/paiHmi/paiHmiPageChange.h"
#include "../../paiComponents/paiHmi/paiHmiAlert.h"
#include "../../paiComponents/bglib/bgBitUtilities.h"

/*
###############################################################################
Utilities
###############################################################################
*/


/**
Screen ID-s must match AutomationStudio's  VisualComponents Page Numbers!!!!!
NOTE: not all screen must have logic support written in this file! Actually,
less logic here and using more VC features is a prefered approach to
implement VC HMI apps.
*/
enum{
	SID_Init = 0,
	SID_Main = 10,
	SID_Main_Monitor = 11,
	SID_Settings_System = 60,
	SID_Settings_Timers = 61,
	SID_Settings_VFDs = 62,
	SID_Settings_Options = 63,
	SID_Settings_MachCfg = 65,
	SID_Recipe_LayerDesign = 44,
	SID_Recipe_LayerPreview = 41,
	SID_Recipe_PalletSelect = 46,
	SID_Recipe_PalletConfig = 45,
	SID_Recipe_PalletTimers = 47,
	SID_Recipe_PalletVFDs = 48,
	SID_Diag_Alarms = 81,
	SID_System_Files = 103,
	SID_Manual = 82,
	SID_Manual2 = 87,
	
	SID_MAX  /*always last!!!*/
}APPSCREENIDS;



/**
Application specific HMI dialogs must be unique. Always to in pair (accept,reject, etc)
*/
enum{
	DLG_Ok = 10,
	DLG_Cancel,
	DLG_DeleteL1FilenameOK = 20,
	DLG_DeleteL1FilenameCancel,
	DLG_SaveAppConfigOK = 30,
	DLG_SaveAppConfigCancel,
	DLG_SavePalletRecipeOK = 40,
	DLG_SavePalletRecipeCancel,
	
}APPHMIDIALOGIDS;


/*
###############################################################################
Parameter view/edit tables
###############################################################################
*/

/*
###############################################################################
Parameter view/edit tables
###############################################################################
*/
static void hmiTableRecipeTimers()
{
	//configApp_typ* pAppCfg = &gConfigApp;
	palleteCfgSettings_typ* pAppCfg = &gPallete.palCfg.palSettings;
	
	//	DINT decFormat_None = -2; //no dec places
	//	DINT decFormat_0 = -1;    //1 dec place
	DINT decFormat_00 = 0;    //default (2) dec places as set in the control 
	//	DINT decFormat_000 = 1;    //3 dec places 
	
	//scaling
	//y=kx+n where: y=HMI value, x=PLC value
	REAL k_factor = 1.0;
	REAL n_factor = 0.0;
	//	UINT valtypeUDINT = 0;//UDINT
	UINT valtypeREAL = 1;//REAL


	hmiParamListTableEntryFirst(&gHmiParamTable, "Pallet Timers");
		
//#if 0	
	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->timers.dlyTableLayerRdyToElevMove , "TableReadyToElevatorMove", 
		1.0, 0.1, 5.0, 
		decFormat_00, k_factor, n_factor, valtypeREAL, "Delay time from Table Layer Ready to Elevator Move [sec].");
	
	
	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->timers.dlyTableAtPalleteToRetBar , "DelayRetainerBarMoveDown", 
		1.0, 0.1, 5.0, 
		decFormat_00, k_factor, n_factor, valtypeREAL, "Delay time from Table at Pallet to Retainer Bar move down to Squaring [sec].");

	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->timers.onDlyPRRetBarDown , "DelayRetainerBarIsDown", 
		0.05, 0.00, 1.0, 
		decFormat_00, k_factor, n_factor, valtypeREAL, "On delay for Retainer Bar Down Prox sensor [sec]. Higher value > layer edge gets positioned deeper inside the pallete.");

	
	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->timers.onDlyEEPallete , "onDelayEE1Pallet", 
		0.05, 0.00, 1.0, 
		decFormat_00, k_factor, n_factor, valtypeREAL, "On delay for Pallet Sensor EE1[sec]. Longer delay results in table getting closer to the pallete when dropping a layer. DANGER: Setting this time too long may cause mechanical colision!");

	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->timers.offDlyEEPallete , "offDelayEE1Pallet", 
		0.05, 0.00, 3.0, 
		decFormat_00, k_factor, n_factor, valtypeREAL, "Off delay for Pallet Sensor EE1[sec].");

	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->timers.onDlyPalleteDischargeEE16 , "onDelayPalleteDischargeEE16", 
		0.05, 0.00, 3.0, 
		decFormat_00, k_factor, n_factor, valtypeREAL, "On delay for Pallet Discharge Sensor EE16[sec]. Longer delay results in pallete getting futher on the discharge CV. DANGER: Setting this time too long may cause pallete tip over!");
	
	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->timers.onTmCaseTurner , "onTimeCaseTurner", 
		1.0, 0.1, 5.0, 
		decFormat_00, k_factor, n_factor, valtypeREAL, "On Time for case turner[sec].");

	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->timers.dlyRowDoneToRowPush , "DelayForRowDoneToRowPush", 
		1.0, 0.1, 5.0, 
		decFormat_00, k_factor, n_factor, valtypeREAL, "Delay time from row forming conmplete signal to push the row to the table [sec].");

	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->timers.dlyLastCaseToRowCVStop , "DelayLastCaseToRowConvStop", 
		1.0, 0.1, 5.0, 
		decFormat_00, k_factor, n_factor, valtypeREAL, "Delay from the moment the last case for a row passes by EE4 until a row forming CV is stopped[sec].");
	
	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->timers.dlyPusherAtElevatorToRetract , "DelayPusherAtElevatorReturnToHome", 
		1.0, 0.1, 5.0, 
		decFormat_00, k_factor, n_factor, valtypeREAL, "Delay from the moment row pusher gets to the elevator before a reverse motion is started to retract row pusher back to home[sec].");
	
	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->timers.dlyTableAtPalleteToRetBar , "DelayTableFwdToRetainerBarDown", 
		1.0, 0.0, 5.0, 
		decFormat_00, k_factor, n_factor, valtypeREAL, "Delay from a moment the table starts moving towards the pallet top and before a retainter bar starts moving down[sec]. NOTE: Setting this value too short may cause a collision.");
	
	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->timers.onDlyTableToGrouping , "DelayTableToGrouping", 
		0.0, 0.0, 2.0, 
		decFormat_00, k_factor, n_factor, valtypeREAL, "Delay from a moment the layer is dropped onto the top of the pallet and before table starts moving towards the grouping[sec].");

	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->timers.JamAlarmTmAtInfeedEE2 , "JamAlarmTimeAtCaseInfeedEE2", 
		4.0, 1.0, 20.0, 
		decFormat_00, k_factor, n_factor, valtypeREAL, "Maximum time allowed to block the EE2 Case Infeed PE before a jam alarm is generated [sec].");

	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->timers.JamAlarmTmAtRowToLongEE8 , "JamAlarmTimeAtRowToLongEE8", 
		4.0, 1.0, 20.0, 
		decFormat_00, k_factor, n_factor, valtypeREAL, "Maximum time allowed to block the EE8 Row Too Long PE before an alarm is generated [sec].");
	

	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->timers.JamAlarmTmRowForming , "JamAlarmTimeAtRowForming", 
		4.0, 1.0, 20.0, 
		decFormat_00, k_factor, n_factor, valtypeREAL, "Maximum time allowed for a case to travel between EE2 (Case Infeed PE) and EE8 (Row Too Long PE) before an alarm is generated [sec].");
		
	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->timers.infeedCVIdleTime , "InfeedCVIdleTime", 
		30.0, 10.0, 600.0, 
		decFormat_00, k_factor, n_factor, valtypeREAL, "Maximum idle time for infeed CV-s before they get turned off[sec].");

	
	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->timers.palletExitAlarmTm , "PalletExitAlarmTime", 
		15.0, 5.0, 60.0, 
		decFormat_00, k_factor, n_factor, valtypeREAL, "Maximum time allowed for a pallet to exit the machine (i.e. activate EE16) [sec].");
//#endif
	
	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->timers.EE2OnDebounce , "EE2OnDebounce", 
		0.0, 0.0, 0.5, 
		decFormat_00, k_factor, n_factor, valtypeREAL, "EE2 (Infeed) On debounce time[sec].");
	
	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->timers.EE2OfDebounce , "EE2OffDebounce", 
		0.0, 0.0, 0.5, 
		decFormat_00, k_factor, n_factor, valtypeREAL, "EE2 (Infeed) Off debounce time[sec].");
	

	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->timers.EE4OnDebounce , "EE4OnDebounce", 
		0.0, 0.0, 0.5, 
		decFormat_00, k_factor, n_factor, valtypeREAL, "EE4 (Stage CV PE) On debounce time[sec].");
	
	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->timers.EE4OfDebounce , "EE4OffDebounce", 
		0.0, 0.0, 0.5, 
		decFormat_00, k_factor, n_factor, valtypeREAL, "EE4 (Stage CV PE) Off debounce time[sec].");

	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->timers.EE8OnDebounce , "EE8OnDebounce", 
		0.0, 0.0, 0.5, 
		decFormat_00, k_factor, n_factor, valtypeREAL, "EE8 (Row To Long) On debounce time[sec].");
	
	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->timers.EE8OfDebounce , "EE8OffDebounce", 
		0.0, 0.0, 0.5, 
		decFormat_00, k_factor, n_factor, valtypeREAL, "EE8 (Row To Long) Off debounce time[sec].");
	
	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->timers.EE16OfDebounce , "EE16OffDebounce", 
		5.0, 0.0, 60.0, 
		decFormat_00, k_factor, n_factor, valtypeREAL, "EE16 (Pallete Discharge Sensor) Off debounce time[sec]. Longer time prevents to quick exiting of a pallete from the staging CV to discharge CV after EE16 gets unblocked.");

	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->timers.onDlyFrontSquaring , "FrontSquaringOnDelay", 
		0.0, 0.0, 3.0, 
		decFormat_00, k_factor, n_factor, valtypeREAL, "Front Squaring On Delay[sec]. Allows for a delayed action of the front squaring bar to prevent product pushing.");
		
	if(gConfigApp.system.bladeStopCount >= 1){
		hmiParamListTableAddEntryNext(&gHmiParamTable, 
			(UDINT)&pAppCfg->timers.bladeStopOnDly1 , "Blade1TurnOnDelay", 
			1.0, 0.0, 10.0, 
			decFormat_00, k_factor, n_factor, valtypeREAL, "Blade 1 turn-on delay. Delayed turn-on when executing pattern program is required so that the blade does not block an incorrect case [sec].");
	}

	if(gConfigApp.system.bladeStopCount >= 2){
		hmiParamListTableAddEntryNext(&gHmiParamTable, 
			(UDINT)&pAppCfg->timers.bladeStopOnDly2 , "Blade2TurnOnDelay", 
			2.0, 0.0, 10.0, 
			decFormat_00, k_factor, n_factor, valtypeREAL, "Blade 2 turn-on delay. Delayed turn-on when executing pattern program is required so that the blade does not block an incorrect case [sec]");
	}
	
	if(gConfigApp.system.bladeStopCount >= 3){
		hmiParamListTableAddEntryNext(&gHmiParamTable, 
			(UDINT)&pAppCfg->timers.bladeStopOnDly3 , "Blade3TurnOnDelay", 
			3.0, 0.0, 10.0, 
			decFormat_00, k_factor, n_factor, valtypeREAL, "Blade 3 turn-on delay. Delayed turn-on when executing pattern program is required so that the blade does not block an incorrect case [sec]");
	}
	
	if(gConfigApp.system.bladeStopCount >= 4){
		hmiParamListTableAddEntryNext(&gHmiParamTable, 
			(UDINT)&pAppCfg->timers.bladeStopOnDly4 , "Blade4TurnOnDelay", 
			4.0, 0.0, 10.0, 
			decFormat_00, k_factor, n_factor, valtypeREAL, "Blade 4 turn-on delay. Delayed turn-on when executing pattern program is required so that the blade does not block an incorrect case [sec]");
	}

	if(gConfigApp.system.bladeStopCount >= 5){
		hmiParamListTableAddEntryNext(&gHmiParamTable, 
			(UDINT)&pAppCfg->timers.bladeStopOnDly5 , "Blade5TurnOnDelay", 
			5.0, 0.0, 10.0, 
			decFormat_00, k_factor, n_factor, valtypeREAL, "Blade 5 turn-on delay. Delayed turn-on when executing pattern program is required so that the blade does not block an incorrect case [sec]");
	}	
	
	hmiParamListTableEntryLast(&gHmiParamTable);
	
}	

static void hmiTableOptions()
{
	configApp_typ* pAppCfg = &gConfigApp;
	
	DINT decFormat_None = -2; //no dec places
//	DINT decFormat_0 = -1;    //1 dec place
	DINT decFormat_00 = 0;    //default (2) dec places as set in the control 
//	DINT decFormat_000 = 1;    //3 dec places 
	
	//scaling
	//y=kx+n where: y=HMI value, x=PLC value
	REAL k_factor = 1.0;
	REAL n_factor = 0.0;
	UINT valtypeUDINT = 0;//UDINT
	UINT valtypeREAL = 1;//REAL

	hmiParamListTableEntryFirst(&gHmiParamTable, "Options");

	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->options.dryCycleCaseCount, "DryCycleCaseCount", 
		5.0, 1.0, 5.0, 
		decFormat_None, k_factor, n_factor, valtypeUDINT, "Number of cases per row during DryCycle.");

	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->options.dryCycleRowCount, "DryCycleRowCount", 
		4.0, 1.0, 4.0, 
		decFormat_None, k_factor, n_factor, valtypeUDINT, "Number of rows per layer during DryCycle.");
	
	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->options.dryCycleLayerCount, "DryCycleLayerCount", 
		3.0, 1.0, 6.0, 
		decFormat_None, k_factor, n_factor, valtypeUDINT, "Number of layers on the pallet during DryCycle.");
	
	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->options.tmDryCycleElevatorUp, "DryCycleElevatorUp Time", 
		3.0, 1.0, 5.0, 
		decFormat_00, k_factor, n_factor, valtypeREAL, "DryCycle simulation timer for simulating layers [sec].");

	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->options.tmDryCycleCaseTime , "DryCycleCase Time", 
		2.0, 1.0, 5.0, 
		decFormat_00, k_factor, n_factor, valtypeREAL, "DryCycle simulation time for simulating loading a single case [sec].");
	
	
	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->options.tmDryCycleLayerZeroOffset , "DryCycleLayer0Offset", 
		2.0, 1.0, 5.0, 
		decFormat_00, k_factor, n_factor, valtypeREAL, "DryCycle layer 0 offset time. Alows elevator position control for the layer 0. [sec].");

	
	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->options.dryCycleLayerDonePause , "DryCyclePause", 
		0.0, 0.0, 1.0, 
		decFormat_None, k_factor, n_factor, valtypeUDINT, "0-continues DryCycle operation, 1-pause after layer completion during DryCycle.");
	
	hmiParamListTableEntryLast(&gHmiParamTable);
	
}	

static void hmiTableRecipeVFDs()
{
	//configApp_typ* pAppCfg = &gConfigApp;
	palleteCfgSettings_typ* pAppCfg = &gPallete.palCfg.palSettings;
	
	
	DINT decFormat_None = -2; //no dec places
	//DINT decFormat_0 = -1;    //1 dec place
	//DINT decFormat_00 = 0;    //default (2) dec places as set in the control 
	//	DINT decFormat_000 = 1;    //3 dec places 
	
	//scaling
	//y=kx+n where: y=HMI value, x=PLC value
	REAL k_factor = 1.0;
	REAL n_factor = 0.0;
	UINT valtypeUDINT = 0;//UDINT
	//	UINT valtypeREAL = 1;//REAL


	hmiParamListTableEntryFirst(&gHmiParamTable, "Pallet VFD Settings");
	
	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->vfd[1].velocity_rpm, "VelocityVFD1", 
		300.0, 0.0, 2700.0, 
		decFormat_None, k_factor, n_factor, valtypeUDINT, "VFD1(Elevator) Velocity [rpm]");

	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->vfd[1].velocitySlow_rpm, "VelocityVFD1Slow", 
		150.0, 0.0, 2700.0, 
		decFormat_None, k_factor, n_factor, valtypeUDINT, "VFD1(Elevator) Slow Velocity. Used when approaching home position [rpm]");
	
	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->vfd[2].velocity_rpm, "VelocityVFD2", 
		300.0, 0.0, 2700.0, 
		decFormat_None, k_factor, n_factor, valtypeUDINT, "VFD2(Table) Velocity [rpm]");
#if 0
	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->vfd[4].velocity_rpm, "VelocityVFD4", 
		300.0, 0.0, 2700.0, 
		decFormat_None, k_factor, n_factor, valtypeUDINT, "VFD4(Row Pusher) Velocity [rpm]");
#endif
	
	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->vfd[5].velocity_rpm, "VelocityVFD5", 
		300.0, 0.0, 2700.0, 
		decFormat_None, k_factor, n_factor, valtypeUDINT, "VFD5 Row Forming Rollers Velocity [rpm]");

	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->vfd[6].velocity_rpm, "VelocityVFD52", 
		300.0, 0.0, 2700.0, 
		decFormat_None, k_factor, n_factor, valtypeUDINT, "VFD52 Row Forming Rollers 2 Velocity [rpm]");
	
	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->vfd[11].velocity_rpm, "VelocityVFD11", 
		300.0, 0.0, 2700.0, 
		decFormat_None, k_factor, n_factor, valtypeUDINT, "VFD11 (Pallet Forming Mesh CV) Velocity [rpm]");

	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->vfd[12].velocity_rpm, "VelocityVFD12", 
		300.0, 0.0, 2700.0, 
		decFormat_None, k_factor, n_factor, valtypeUDINT, "VFD12(Pallet Discharge Mesh CV) Velocity [rpm]");
	
	//Acceleration
	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->vfd[1].acc, "AccelVFD1", 
		1.0, 1.0, 10.0, 
		decFormat_None, k_factor, n_factor, valtypeUDINT, "VFD1(Elevator) Acceleration [0.1 sec]");

	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->vfd[2].acc, "AccelVFD2", 
		1.0, 1.0, 20.0, 
		decFormat_None, k_factor, n_factor, valtypeUDINT, "VFD2(Table) Acceleration [0.1 sec]");

	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->vfd[5].acc, "AccelVFD5", 
		1.0, 1.0, 20.0, 
		decFormat_None, k_factor, n_factor, valtypeUDINT, "VFD5(Row Forming Rollers) Acceleration [0.1 sec]");
	
	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->vfd[6].acc, "AccelVFD52", 
		1.0, 1.0, 20.0, 
		decFormat_None, k_factor, n_factor, valtypeUDINT, "VFD52(Row Forming Rollers 2) Acceleration [0.1 sec]");
	
	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->vfd[11].acc, "AccelVFD11", 
		1.0, 1.0, 200.0, 
		decFormat_None, k_factor, n_factor, valtypeUDINT, "VFD11(Forming Mesh CV) Acceleration [0.1 sec]");
		
	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->vfd[12].acc, "AccelVFD12", 
		1.0, 1.0, 200.0, 
		decFormat_None, k_factor, n_factor, valtypeUDINT, "VFD12(Exit Mesh CV) Acceleration [0.1 sec]");
	
	//Deceleration
	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->vfd[1].dec, "DecelVFD1", 
		1.0, 0.0, 10.0, 
		decFormat_None, k_factor, n_factor, valtypeUDINT, "VFD1(Elevator) Deceleration [0.1 sec]");

	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->vfd[2].dec, "DecelVFD2", 
		1.0, 0.0, 20.0, 
		decFormat_None, k_factor, n_factor, valtypeUDINT, "VFD2(Table) Deceleration [0.1 sec]");

	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->vfd[5].dec, "DecelVFD5", 
		1.0, 0.0, 20.0, 
		decFormat_None, k_factor, n_factor, valtypeUDINT, "VFD5(Row Forming Rollers) Deceleration [0.1 sec]");
	
	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->vfd[6].dec, "DecelVFD52", 
		1.0, 0.0, 20.0, 
		decFormat_None, k_factor, n_factor, valtypeUDINT, "VFD52(Row Forming Rollers 2) Deceleration [0.1 sec]");
	
	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->vfd[11].dec, "DecelVFD11", 
		1.0, 0.0, 200.0, 
		decFormat_None, k_factor, n_factor, valtypeUDINT, "VFD11(Forming Mesh CV) Deceleration [0.1 sec]");
		
	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->vfd[12].dec, "DecelVFD12", 
		1.0, 0.0, 200.0, 
		decFormat_None, k_factor, n_factor, valtypeUDINT, "VFD12(Exit Mesh CV) Deceleration [0.1 sec]");
	
	
	hmiParamListTableEntryLast(&gHmiParamTable);
	
}	

static void hmiTableMachCfg()
{
	configApp_typ* pAppCfg = &gConfigApp;
	
	DINT decFormat_None = -2; //no dec places
	DINT decFormat_0 = -1;    //1 dec place
	//DINT decFormat_00 = 0;    //default (2) dec places as set in the control 
//	DINT decFormat_000 = 1;    //3 dec places 
	
	//scaling
	//y=kx+n where: y=HMI value, x=PLC value
	REAL k_factor = 1.0;
	REAL n_factor = 0.0;
	UINT valtypeUDINT = 0;//UDINT
	UINT valtypeREAL = 1;//REAL


	hmiParamListTableEntryFirst(&gHmiParamTable, "Mechanical Properties");

	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->options.optTearSheetEquiped, "TierSheetPresent", 
		0.0, 0.0, 1.0, 
		decFormat_None, k_factor, n_factor, valtypeUDINT, "1-Machine is equiped with a tier sheet inserting assembly.");

	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->options.optOption1Equiped, "Option1Present", 
		0.0, 0.0, 1.0, 
		decFormat_None, k_factor, n_factor, valtypeUDINT, "1-Machine is equipped with Option1 assembly.");

	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->options.palletDispenserOption, "PalletDispenserOption", 
		0.0, 0.0, 1.0, 
		decFormat_None, k_factor, n_factor, valtypeUDINT, "0-Pallet Dispenser Is NOT Present/NOT Equipped; 1-Pallet Dispenser is present/equipped.");
	
	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->options.frontSquaringOption, "FrontSquaringOption", 
		0.0, 0.0, 1.0, 
		decFormat_None, k_factor, n_factor, valtypeUDINT, "0-Front Squaring assembly Is NOT Present/NOT Equipped; 1-Front Squaring assembly is present/equipped.");
	
	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->system.boxInfeedSide, "InfeedLeftOrRight", 
		0.0, 0.0, 1.0, 
		decFormat_None, k_factor, n_factor, valtypeUDINT, "0-Box infeed Right to Left. 1-Box infeed Left to Right. Point of reference: person standing in front of the row pusher assembly looking towards the layer forming table.");
	
	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->system.simulationMode , "SimulationMode", 
		0.0, 0.0, 1.0, 
		decFormat_None, k_factor, n_factor, valtypeUDINT, "Simulation Mode. 0-OFF, 1-ON (Testing only!)");
	
	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->system.bladeStopCount, "NumberOfBladeStops", 
		0.0, 0.0, 6.0, 
		decFormat_None, k_factor, n_factor, valtypeUDINT, "Total number of blade stops on the machine.");
		
	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->system.bladeStopDistance[0] , "BladeStop1Distance", 
		10.0, 0.0, 100.0, 
		decFormat_0, k_factor, n_factor, valtypeREAL, "Distance/position of the blade stop 1 [inch]. Blade 1 is ALWAYS the blade closest to the infeed/incoming side of the row forming CV.");

	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->system.bladeStopDistance[1] , "BladeStop2Distance", 
		12.0, 0.0, 100.0, 
		decFormat_0, k_factor, n_factor, valtypeREAL, "Distance/position of the blade stop 2 [inch]");

	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->system.bladeStopDistance[2] , "BladeStop3Distance", 
		14.0, 0.0, 100.0, 
		decFormat_0, k_factor, n_factor, valtypeREAL, "Distance/position of the blade stop 3 [inch]");

	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->system.bladeStopDistance[3] , "BladeStop4Distance", 
		16.0, 0.0, 100.0, 
		decFormat_0, k_factor, n_factor, valtypeREAL, "Distance/position of the blade stop 4 [inch]");

	hmiParamListTableAddEntryNext(&gHmiParamTable, 
		(UDINT)&pAppCfg->system.bladeStopDistance[4] , "BladeStop5Distance", 
		18.0, 0.0, 100.0, 
		decFormat_0, k_factor, n_factor, valtypeREAL, "Distance/position of the blade stop 5 [inch]");

	hmiParamListTableEntryLast(&gHmiParamTable);
}

//control visibility of the INPUT field (layer) for the parametar edit/view table
static void loginLevelParameterEditControl(UDINT minRights, UDINT minLevel)
{
	//controlling the locking of the editing form 
	//(i.e. to lock > visibility set to 0 (visible) as the flag is used for a touch area over the inputs
	gHmiParamTable.selValueFormVisible = ((gPaiUserMgr.currentGroup.AccessRights[0] >= minRights) && (gPaiUserMgr.currentGroup.Level >= minLevel)) ? 1 : 0;
}

/*
###############################################################################
HMI screen handling logic
###############################################################################
*/
void screenHandlers(paiHmiTemplate_typ* pHmi)
{
	//Page specific init logic
	if(pHmi->prv.pageInit){		
		//control visibility of the parametar input form

		
		//screen init event
		//define screen name
		switch(pHmi->runtime.pageCurrent){
			case SID_Settings_Timers:
			break;
			case SID_Settings_MachCfg:
				loginLevelParameterEditControl(mpUSER_ACCESS_FULL, 100); //only manufacturer
				hmiTableMachCfg();					
			break;	
			case SID_Settings_Options:
				loginLevelParameterEditControl(mpUSER_ACCESS_FULL, 100); //only manufacturer
				hmiTableOptions();					
				break;	
			case SID_Settings_VFDs:
				break;	
			case SID_Recipe_PalletTimers:
				loginLevelParameterEditControl(mpUSER_ACCESS_FULL, 20); //normaly, supervisor is allowed to change data
				hmiTableRecipeTimers();					
				break;	
			case SID_Recipe_PalletVFDs:
				loginLevelParameterEditControl(mpUSER_ACCESS_FULL, 20); //normaly, supervisor is allowed to change data
				hmiTableRecipeVFDs();					
				break;	
			case SID_Main_Monitor:
			case SID_Recipe_PalletSelect:
			case SID_Recipe_PalletConfig:
			case SID_System_Files:
			case SID_Recipe_LayerDesign:
			case SID_Recipe_LayerPreview:
			case SID_Settings_System:	
				loginLevelParameterEditControl(mpUSER_ACCESS_FULL, 10); //normaly, supervisor is allowed to change data
				break;
			case SID_Manual:
			case SID_Manual2:
				loginLevelParameterEditControl(mpUSER_ACCESS_FULL, 10); //normaly, supervisor is allowed to change data
				break;
			default:
			break;
		}	
	}

	//Page specific cyclic logic
//	switch(page){
//		case SID_Workers_51:
//			screen_Workers_51();
//		break;
//		case SID_Setup_61:
//			screen_Setup_61();
//			break;
//	}
	
	hmiParamListTableCyclic(&gHmiParamTable);
}

/*
###############################################################################
HMI Logic: Running msg support (see screen saver)
###############################################################################
*/
void paiRunningMsgInit(paiHmiMsgRunning_typ* p, char* pMsg)
{
	if(!p)
		return;
	
	p->iMsgAddr = (UDINT)pMsg;
	p->curIdx = 0;
	p->state = 0;
}

void paiRunningMsgCyclic(paiHmiMsgRunning_typ* p)
{
	int lenMsg;
	int lenMax;
	int msgStartIdx;
	int msgCopyLen;
	
	
	if(!p || !p->iMsgAddr)
		return;
	
	bgTimerCyclic(&p->tmr1);
	
	if(!p->iEnable){
		p->oMsgVisible = 1;//not visible
		return;
	}
	p->oMsgVisible = 0;//visible
	
	if(!bgTimerIsTimeOut(&p->tmr1) ){
		return;
	}
	bgTimerStart(&p->tmr1, p->iScrollDelayXms);
	
	if(!p->state){
		p->curIdx++;
		if(p->curIdx >= p->iScrollLength){
			p->state = 1;
		}
	}else{
		p->curIdx--;
		if(p->curIdx == 0){
			p->state = 0;
		}	
	}
	
	lenMax = paiHMI_ENUM_RUNMSG_MAXLEN - 1;
	lenMsg = brsstrlen((UDINT)p->iMsgAddr);
	msgStartIdx = (p->curIdx < lenMax) ? p->curIdx : lenMax;
		
	brsmemset((UDINT)p->oMsg, ' ', lenMax);
	p->oMsg[lenMax] = 0;
	
	msgCopyLen = 0;
	if(msgStartIdx < lenMax){
		msgCopyLen = (lenMax - msgStartIdx) < lenMsg ? (lenMax - msgStartIdx) : lenMsg;
	}	
	brsmemcpy((UDINT)&p->oMsg[msgStartIdx], (UDINT)p->iMsgAddr, msgCopyLen);
}
		

/*
###############################################################################
HMI Logic: Layer editor HMI support
###############################################################################
*/
void appHmiLayerEditorCmdTxtGenCell(int row, int col)
{
	char txt[64];
	int 	cmdIdxBlade = gLayerEditor.palCfgRows[row].palCfgCmds[col].cmdBlade;
	int 	cmdIdxCase = gLayerEditor.palCfgRows[row].palCfgCmds[col].cmdCase;

	switch(cmdIdxCase){
		case 0:
			brsstrcpy((UDINT)txt, (UDINT)"");
			goto exitHere;
		break;
		case 1:
			brsstrcpy((UDINT)txt, (UDINT)"Case");			
		break;
		case 2:
			brsstrcpy((UDINT)txt, (UDINT)"Case+90");			
			break;
		case 3:
			brsstrcpy((UDINT)txt, (UDINT)"Case-90");			
			break;
		case 4:
			brsstrcpy((UDINT)txt, (UDINT)"Case180");			
			break;
		default:
			brsstrcpy((UDINT)txt, (UDINT)"Case???");			
			break;
	}

	switch(cmdIdxBlade){
		case 0:
			break;
		case 1:
			brsstrcat((UDINT)txt, (UDINT)"\nBlade1");			
			break;
		case 2:
			brsstrcat((UDINT)txt, (UDINT)"\nBlade2");			
			break;
		case 3:
			brsstrcat((UDINT)txt, (UDINT)"\nBlade3");			
			break;
		case 4:
			brsstrcat((UDINT)txt, (UDINT)"\nBlade4");			
			break;
		case 5:
			brsstrcat((UDINT)txt, (UDINT)"\nBlade5");			
			break;
		case 6:
			brsstrcat((UDINT)txt, (UDINT)"\nBlade6");			
			break;
		default:
			brsstrcat((UDINT)txt, (UDINT)"\nBlade??");			
			break;
	}	
	
exitHere:
	brsstrcpy( (UDINT)gLayerEditorTxt.palCfgRowsTxt[row].palCfgCmdsTxt[col].cmdTxt, (UDINT)txt);
}


void appHmiLayerEditorCmdTxtGen()
{
	int ii;
	int row;
	int col;
		
	for(ii=0; ii<64; ii++){
		row = ii / 8;
		col = ii % 8;
		appHmiLayerEditorCmdTxtGenCell(row, col);
	}
}

void appHmiLayerEditorActiveCellBackClr()
{
	int ii;
	int row;
	int col;
	
	if(gLayerEditorTxt.curIdxEditorCell == gLayerEditorTxt.curIdxEditorCellOld)
		return;
	gLayerEditorTxt.curIdxEditorCellOld = gLayerEditorTxt.curIdxEditorCell;
	
	for(ii=0; ii<64; ii++){
		row = ii / 8;
		col = ii % 8;
		
		if(ii != gLayerEditorTxt.curIdxEditorCell){
			gLayerEditorTxt.palCfgRowsTxt[row].palCfgCmdsTxt[col].colorIdx = 0;		
		}else{
			gLayerEditorTxt.palCfgRowsTxt[row].palCfgCmdsTxt[col].colorIdx = 1;
			gLayerEditorTxt.curIdxRow = row;
			gLayerEditorTxt.curIdxCmd = col;
			
			gLayerEditorTxt.cmdIdxBlade = gLayerEditor.palCfgRows[row].palCfgCmds[col].cmdBlade;
			gLayerEditorTxt.cmdIdxCase = gLayerEditor.palCfgRows[row].palCfgCmds[col].cmdCase;
			brsstrcpy((UDINT)gLayerEditorTxt.curCmdTxt, (UDINT)gLayerEditorTxt.palCfgRowsTxt[row].palCfgCmdsTxt[col].cmdTxt);
		}
	}
}

void appHmiLayerEditor()
{
	
	appHmiLayerEditorActiveCellBackClr();	

	if(gLayerEditorTxt.cmdEntryCompletion){
		gLayerEditorTxt.cmdEntryCompletion = 0;
		gLayerEditor.palCfgRows[gLayerEditorTxt.curIdxRow].palCfgCmds[gLayerEditorTxt.curIdxCmd].cmdBlade = gLayerEditorTxt.cmdIdxBlade;
		gLayerEditor.palCfgRows[gLayerEditorTxt.curIdxRow].palCfgCmds[gLayerEditorTxt.curIdxCmd].cmdCase = gLayerEditorTxt.cmdIdxCase;	
	}
	appHmiLayerEditorCmdTxtGenCell(gLayerEditorTxt.curIdxRow, gLayerEditorTxt.curIdxCmd);
	brsstrcpy((UDINT)gLayerEditorTxt.curCmdTxt, (UDINT)gLayerEditorTxt.palCfgRowsTxt[gLayerEditorTxt.curIdxRow].palCfgCmdsTxt[gLayerEditorTxt.curIdxCmd].cmdTxt);	
}



/*
###############################################################################
HMI Logic: Layer Editor PV (gLayerEdit) Load/Save from/to a file
###############################################################################
*/
static void appHmiLayerFileHandlerLoadFilename(UDINT pFilename)
{
	int IDX_SERDES_ITEM = 2;
	
	brsstrcpy((UDINT)gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].iFilename, (UDINT)pFilename);
	gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].iDesRequest = 1;
	gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oDesCountOld = gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oDesCount;
}

static void appHmiLayerFileHandlerLoadCurSel()
{
int curSel;	
int IDX_SERDES_ITEM = 2;
	
	curSel = gPaiMp.data.MpRecipeUIConnectCustom1.Recipe.List.SelectedIndex;
	if(curSel > gPaiMp.data.MpRecipeUIConnectCustom1.Recipe.List.MaxSelection){
		// Show the alert with a specified text and for a selected amount of time
		paiHmiAlertShow(&gPaiHmiAlertMsg, "WARNING:","Filename not selected!\nPlease select a filename from the list.", 3000);		
		return;
	}
	if(gPaiMp.data.MpRecipeUIConnectCustom1.Recipe.List.Names[curSel][0] == 0){
		// Show the alert with a specified text and for a selected amount of time
		paiHmiAlertShow(&gPaiHmiAlertMsg, "WARNING:","Filename not defined!\nPlease select a filename from the list.", 3000);		
		return;
	}
	brsstrcpy((UDINT)gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].iFilename, (UDINT)gPaiMp.data.MpRecipeUIConnectCustom1.Recipe.List.Names[curSel]);
	gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].iDesRequest = 1;
	gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oDesCountOld = gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oDesCount;
}

static void appHmiLayerFileHandlerCreateNew()
{
	int IDX_SERDES_ITEM = 2;
	
	if(gPaiMp.data.MpRecipeUIConnectCustom1.New.FileName[0] == 0){
		// Show the alert with a specified text and for a selected amount of time
		paiHmiAlertShow(&gPaiHmiAlertMsg, "WARNING:","New layer file not defined!\nPlease enter a file name.", 3000);		
		return;
	}
	brsstrcpy((UDINT)gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].iFilename, (UDINT)gPaiMp.data.MpRecipeUIConnectCustom1.New.FileName);
	brsstrcpy((UDINT)gLayerEditor.layerFilename, (UDINT)gPaiMp.data.MpRecipeUIConnectCustom1.New.FileName);
	gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].iSerRequest = 1;
	gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oSerCountOld = gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oSerCount;
}

static void appHmiLayerFileHandlerSaveCurrent()
{
	int IDX_SERDES_ITEM = 2;

	if(gLayerEditor.layerFilename[0] == 0){
		// Show the alert with a specified text and for a selected amount of time
		paiHmiAlertShow(&gPaiHmiAlertMsg, "WARNING:","Filename not defined!\nPlease use Create to save these changes.", 3000);		
		return;
	}
	brsstrcpy((UDINT)gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].iFilename, (UDINT)gLayerEditor.layerFilename);
	gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].iSerRequest = 1;
	gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oSerCountOld = gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oSerCount;
}

static void appHmiLayerFileHandlerCyclic()
{
	char txtMsg[255];
	int IDX_SERDES_ITEM = 2;
	
	
	if(gLayerFileHandler.iBtnLoad){
		gLayerFileHandler.iBtnLoad = 0;
		
		gLayerEditorTxt.curIdxEditorCell = 1000;
		gLayerEditorTxt.curIdxEditorCellOld = 0;
	
		appHmiLayerFileHandlerLoadCurSel();
	}
	
	if(gLayerFileHandler.iBtnLoadL1Preview){
		gLayerFileHandler.iBtnLoadL1Preview = 0;
		
		gLayerEditorTxt.curIdxEditorCell = 1000;
		gLayerEditorTxt.curIdxEditorCellOld = 0;
	
		appHmiLayerFileHandlerLoadFilename((UDINT)gPallete.palCfg.palLayerSettings[0].layerFilename);
		
		gPaiHmiMain.runtime.pageChange = 41;//layer preview page
	}

	if(gLayerFileHandler.iBtnLoadL2Preview){
		gLayerFileHandler.iBtnLoadL2Preview = 0;
		
		gLayerEditorTxt.curIdxEditorCell = 1000;
		gLayerEditorTxt.curIdxEditorCellOld = 0;
	
		appHmiLayerFileHandlerLoadFilename((UDINT)gPallete.palCfg.palLayerSettings[1].layerFilename);
		
		gPaiHmiMain.runtime.pageChange = 41;//layer preview page
	}
	
	if(gLayerFileHandler.iBtnNew){
		gLayerFileHandler.iBtnNew = 0;
		appHmiLayerFileHandlerCreateNew();
	}

	if(gLayerFileHandler.iBtnSave){
		gLayerFileHandler.iBtnSave = 0;
		appHmiLayerFileHandlerSaveCurrent();
	}
	
	
	//===================================
	//Check for file load/save events
	//===================================
	//check if PV restored from a file
	if(gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oDesCountOld != gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oDesCount){
		gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oDesCountOld = gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oDesCount;
			
		gLayerEditorTxt.curIdxEditorCell = 0;
		gLayerEditorTxt.curIdxEditorCellOld = 1000;

		//rebuild current layer editor view
		appHmiLayerEditorCmdTxtGen();		
		brsstrcpy((UDINT)txtMsg, "Layer program loaded from a file!\n\nFilename: ");
		brsstrcat((UDINT)txtMsg, (UDINT)gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].iFilename);
		paiHmiAlertShow(&gPaiHmiAlertMsg, "MESSAGE:", txtMsg, 3000);
		brsstrcpy((UDINT)gLayerEditor.layerFilename, (UDINT)gPVSerDesMgr.pvItems[2].iFilename);
		
		//trigger canvas redraw of the layer
		gCtrl.main.gCamApp_btnPreview = 1;
	}
	
	if(gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oSerCountOld != gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oSerCount){
		gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oSerCountOld = gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oSerCount;
		//rebuild current layer editor view
		appHmiLayerEditorCmdTxtGen();	
		brsstrcpy((UDINT)txtMsg, "Layer program saved to a file!\n\nFilename: ");
		brsstrcat((UDINT)txtMsg, (UDINT)gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].iFilename);
		paiHmiAlertShow(&gPaiHmiAlertMsg, "MESSAGE:", txtMsg, 3000);
		brsstrcpy((UDINT)gLayerEditor.layerFilename, (UDINT)gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].iFilename);
		//refresh file viewer
		gPaiMp.data.MpRecipeUIConnectCustom1.Recipe.Refresh = 1;
	}
	
		
}

/*
###############################################################################
HMI Logic: Pallete recipe utility functions.
###############################################################################
*/
static void appHmiInitPalleteCfg()
{
	int ii;
	
	gPallete.palCfg.palLayerSettings[0].sameAsOtherLayer = 0;
	gPallete.palCfg.palLayerSettings[0].sameAsOtherLayer = 0;
	for(ii=2; ii<gPallete.palCfg.palActiveLayers; ii++){
		gPallete.palCfg.palLayerSettings[ii].sameAsOtherLayer = 1;
	}
}

static void appHmiSetPalleteLayersCfgL0Only()
{
	int ii;
	
	for(ii=1; ii<gPallete.palCfg.palActiveLayers; ii++){
		gPallete.palCfg.palLayerSettings[ii].sameAsOtherLayer = 1;
		gPallete.palCfg.palLayerSettings[ii].otherLayerIdx = 0;
	}
}

static BOOL appHmiIsLayerL1ProgramRequired()
{
	if(gPallete.palCfg.palLayerSettings[1].layerFilename[0] != 0)
		return 1;
	
	return 0;
}

static BOOL appHmiIsLayerL1RefExist()
{
int ii;
	
	for(ii=2; ii<gPallete.palCfg.palActiveLayers; ii++){
		if(gPallete.palCfg.palLayerSettings[ii].otherLayerIdx != 0)
			return 1;
	}
	return 0;
}

/*
###############################################################################
HMI Logic: Support from loadig Layer configuration PV-s (gLayer1 and gLayer2) 
based on the information contained within a pallete recipe
###############################################################################
*/

static void appHmiLayerL0L1LoadRequest()
{
	gLayer_L0_L1_FileHandler.iBtnLoad = 1;	
}

static BOOL appHmiLayerL0L1IsLoadRequested()
{
	if(gLayer_L0_L1_FileHandler.iBtnLoad){
		gLayer_L0_L1_FileHandler.iBtnLoad = 0;
		return 1;
	}
	return 0;
}


static void	appHmiSetLayerPrograms()
{
	
int ii;
	
	//layer[0] = always from file layerLO
	brsmemcpy( (UDINT)&gPallete.palCfgLayers[0], (UDINT)&gLayer_L0, sizeof(gLayer_L0));
	
	//layer 1 - if sameAsOtherLayer > it must be from layerLO file
	if(gPallete.palCfg.palLayerSettings[1].sameAsOtherLayer){
		brsmemcpy( (UDINT)&gPallete.palCfgLayers[1], (UDINT)&gLayer_L0, sizeof(gLayer_L0));	
	}else{
		brsmemcpy( (UDINT)&gPallete.palCfgLayers[1], (UDINT)&gLayer_L1, sizeof(gLayer_L1));	
	}
	
	//other active layers; check what layer used, copy required layer data
	for(ii=2; ii < gPallete.palCfg.palActiveLayers; ii++){
		if(gPallete.palCfg.palLayerSettings[ii].otherLayerIdx){
			brsmemcpy( (UDINT)&gPallete.palCfgLayers[ii], (UDINT)&gLayer_L1, sizeof(gLayer_L1));	
		}else{
			brsmemcpy( (UDINT)&gPallete.palCfgLayers[ii], (UDINT)&gLayer_L0, sizeof(gLayer_L0));			
		}	
	}

	for(ii=gPallete.palCfg.palActiveLayers; ii < APP_REC_MAXLAYER; ii++){
			brsmemset( (UDINT)&gPallete.palCfgLayers[ii], 0, sizeof(gLayer_L0));	
	}
	
}

static void appHmiLayerL0L1FileLoadingCyclic()
{
int curSel;	
char txtMsg[255];
int IDX_SERDES_ITEM = 4;
	
	bgTimerCyclic(&gLayer_L0_L1_FileHandler.fileHandlerTimer);
	
	switch(gLayer_L0_L1_FileHandler.fileHandlerState){
		case 0:
			if( !appHmiLayerL0L1IsLoadRequested() )
				return;
					
			appHmiInitPalleteCfg();
			
			gLayer_L0_L1_FileHandler.fileHandlerState = 10;
			bgTimerStart(&gLayer_L0_L1_FileHandler.fileHandlerTimer, 2500);			
		
		break;
		case 10:
			if(!bgTimerIsTimeOut(&gLayer_L0_L1_FileHandler.fileHandlerTimer))
				return;
			
			//try to load L0 layer configuration			
			if(gPallete.palCfg.palLayerSettings[0].layerFilename[0] == 0){
				// Show the alert with a specified text and for a selected amount of time
				paiHmiAlertShow(&gPaiHmiAlertMsg, "ERROR:","Layer L0 filename is not defined!\nInvalid pallete recipe file.", 3000);
				gPallete.ctrlProc.oPalleteRecipeIsValid = 0;
				gLayer_L0_L1_FileHandler.fileHandlerState = 50;					
				return;
			}
			IDX_SERDES_ITEM = 4;
			brsstrcpy((UDINT)gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].iFilename, (UDINT)gPallete.palCfg.palLayerSettings[0].layerFilename);
			gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].iDesRequest = 1;
			gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oDesCountOld = gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oDesCount;
			gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oErrorCountOld = gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oErrorCount;
			gLayer_L0_L1_FileHandler.fileHandlerState = 20;					
		break;
		case 20:
			IDX_SERDES_ITEM = 4;
			if(gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oDesCountOld != gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oDesCount){
				brsstrcpy((UDINT)txtMsg, "Layer L0 program loaded from a file!\n\nFilename: ");
				brsstrcat((UDINT)txtMsg, (UDINT)gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].iFilename);
				paiHmiAlertShow(&gPaiHmiAlertMsg, "MESSAGE:", txtMsg, 2000);
				bgTimerStart(&gLayer_L0_L1_FileHandler.fileHandlerTimer, 2500);						
				gLayer_L0_L1_FileHandler.fileHandlerState = 30;
			}
			
			if(gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oErrorCountOld != gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oErrorCount){
				paiHmiAlertShow(&gPaiHmiAlertMsg, "ERROR:","Layer L0 program load error!\nPallete recipe is NOT valid.\nPlease use a different pallete recipe.", 3000);
				gPallete.ctrlProc.oPalleteRecipeIsValid = 0;
				gLayer_L0_L1_FileHandler.fileHandlerState = 50;			
			}
			break;
		case 30:
			if(!bgTimerIsTimeOut(&gLayer_L0_L1_FileHandler.fileHandlerTimer))
				return;

			if(!appHmiIsLayerL1ProgramRequired() && !appHmiIsLayerL1RefExist()){
				// Show the alert with a specified text and for a selected amount of time
				paiHmiAlertShow(&gPaiHmiAlertMsg, "WARNING:","Layer L1 is NOT used!\n", 3000);
				gLayer_L0_L1_FileHandler.fileHandlerState = 50;					
				return;
			}
			if(!appHmiIsLayerL1ProgramRequired() && appHmiIsLayerL1RefExist()){
				// Show the alert with a specified text and for a selected amount of time
				paiHmiAlertShow(&gPaiHmiAlertMsg, "ERROR:","Layer L1 referenced but not defined!\nInvalid pallete recipe file.", 3000);
				gPallete.ctrlProc.oPalleteRecipeIsValid = 0;
				gLayer_L0_L1_FileHandler.fileHandlerState = 50;					
				return;
			}
			IDX_SERDES_ITEM = 5;
			brsstrcpy((UDINT)gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].iFilename, (UDINT)gPallete.palCfg.palLayerSettings[1].layerFilename);
			gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].iDesRequest = 1;
			gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oDesCountOld = gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oDesCount;
			gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oErrorCountOld = gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oErrorCount;
			gLayer_L0_L1_FileHandler.fileHandlerState = 40;					
			
			break;
		case 40:
			IDX_SERDES_ITEM = 5;
			if(gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oDesCountOld != gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oDesCount){
				brsstrcpy((UDINT)txtMsg, "Layer L1 program loaded from a file!\n\nFilename: ");
				brsstrcat((UDINT)txtMsg, (UDINT)gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].iFilename);
				paiHmiAlertShow(&gPaiHmiAlertMsg, "MESSAGE:", txtMsg, 2000);
				bgTimerStart(&gLayer_L0_L1_FileHandler.fileHandlerTimer, 2500);						
				gLayer_L0_L1_FileHandler.fileHandlerState = 50;
			}
			
			if(gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oErrorCountOld != gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oErrorCount){
				paiHmiAlertShow(&gPaiHmiAlertMsg, "ERROR:","Layer L1 program load error!\nPallete recipe is NOT valid.\nPlease use a different pallete recipe.", 3000);
				gPallete.ctrlProc.oPalleteRecipeIsValid = 0;
				gLayer_L0_L1_FileHandler.fileHandlerState = 50;			
			}
			break;
			break;
		case 50:
			bgTimerStart(&gLayer_L0_L1_FileHandler.fileHandlerTimer, 2500);			
			gLayer_L0_L1_FileHandler.fileHandlerState = 51;						
			break;
		case 51:
			if(!bgTimerIsTimeOut(&gLayer_L0_L1_FileHandler.fileHandlerTimer))
				return;
			
			if(gPallete.ctrlProc.oPalleteRecipeIsValid){
				//paiHmiAlertShow(&gPaiHmiAlertMsg, "INFO:","Layer L1 program load error!\nPallete recipe is NOT valid.\nPlease use a different pallete recipe.", 1000);
				appHmiSetLayerPrograms();
			}else{
				paiHmiAlertShow(&gPaiHmiAlertMsg, "ERROR:","Loaded pallete recipe is not valid!\nPlease use/create a different pallete recipe.", 5000);
			}
			gLayer_L0_L1_FileHandler.fileHandlerState = 0;			
			break;
	}
}
/*
###############################################################################
HMI Logic: Pallete configuration recipe PV (gPallete.palCfg) Load/Save from/to a file
###############################################################################
*/
static void appHmiPalleteFileHandlerLoadCurrent()
{
	int curSel;	
	int IDX_SERDES_ITEM = 3;
	
	curSel = gPaiMp.data.MpRecipeUIConnectCustom2.Recipe.List.SelectedIndex;
	if(curSel > gPaiMp.data.MpRecipeUIConnectCustom2.Recipe.List.MaxSelection){
		// Show the alert with a specified text and for a selected amount of time
		paiHmiAlertShow(&gPaiHmiAlertMsg, "WARNING:","Filename not selected!\nPlease select a filename from the list.", 3000);		
		return;
	}
	if(gPaiMp.data.MpRecipeUIConnectCustom2.Recipe.List.Names[curSel][0] == 0){
		// Show the alert with a specified text and for a selected amount of time
		paiHmiAlertShow(&gPaiHmiAlertMsg, "WARNING:","Filename not defined!\nPlease select a filename from the list.", 3000);		
		return;
	}
	brsstrcpy((UDINT)gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].iFilename, (UDINT)gPaiMp.data.MpRecipeUIConnectCustom2.Recipe.List.Names[curSel]);
	gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].iDesRequest = 1;
	gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oDesCountOld = gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oDesCount;
	
	
	//gSerDesHMI_gPalletCfg.iBtnDesRequest = 1;
	
}

static void appHmiPalleteFileHandlerCreateNew()
{
	int curSel;	
	int IDX_SERDES_ITEM = 3;

	if(gPaiMp.data.MpRecipeUIConnectCustom2.New.FileName[0] == 0){
		// Show the alert with a specified text and for a selected amount of time
		paiHmiAlertShow(&gPaiHmiAlertMsg, "WARNING:","New layer file not defined!\nPlease enter a file name.", 3000);		
		return;
	}
	brsstrcpy((UDINT)gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].iFilename, (UDINT)gPaiMp.data.MpRecipeUIConnectCustom2.New.FileName);
	brsstrcpy((UDINT)gPallete.palCfg.palFilename, (UDINT)gPaiMp.data.MpRecipeUIConnectCustom2.New.FileName);
	gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].iSerRequest = 1;
	gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oSerCountOld = gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oSerCount;
	//gSerDesHMI_gPalletCfg.iBtnSerRequest = 1;

}

static void appHmiPalleteFileHandlerSaveCurrent()
{
	int IDX_SERDES_ITEM = 3;

	if(gPallete.palCfg.palFilename[0] == 0){
		// Show the alert with a specified text and for a selected amount of time
		paiHmiAlertShow(&gPaiHmiAlertMsg, "WARNING:","Filename not defined!\nPlease use Create to save changes.", 3000);		
		return;
	}
	brsstrcpy((UDINT)gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].iFilename, (UDINT)gPallete.palCfg.palFilename);
	gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].iSerRequest = 1;
	gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oSerCountOld = gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oSerCount;	
	//gSerDesHMI_gPalletCfg.iBtnSerRequest = 1;
	
}

static void appHmiPalleteFileHandlerCyclic()
{
	char txtMsg[255];
	int IDX_SERDES_ITEM = 3;
	
	if(gPalleteFileHandler.iBtnLoad){
		gPalleteFileHandler.iBtnLoad = 0;
		appHmiPalleteFileHandlerLoadCurrent();
	}
	
	if(gPalleteFileHandler.iBtnNew){
		gPalleteFileHandler.iBtnNew = 0;
		appHmiPalleteFileHandlerCreateNew();
	}

	if(gPalleteFileHandler.iBtnSave){
		gPalleteFileHandler.iBtnSave = 0;
		appHmiPalleteFileHandlerSaveCurrent();
	}
	
	
	//===================================
	//Check for patter file PV-s load/save events
	//===================================
	//check if PV restored from a file
	if(gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oDesCountOld != gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oDesCount){
		gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oDesCountOld = gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oDesCount;
		//rebuild current layer editor view
		appHmiLayerEditorCmdTxtGen();		
		brsstrcpy((UDINT)txtMsg, "Pattern program loaded from a file!\n\nFilename: ");
		brsstrcat((UDINT)txtMsg, (UDINT)gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].iFilename);
		paiHmiAlertShow(&gPaiHmiAlertMsg, "MESSAGE:", txtMsg, 2000);
		brsstrcpy((UDINT)gPallete.palCfg.palFilename, (UDINT)gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].iFilename);
		//mark recipe as valid
		gPallete.ctrlProc.oPalleteRecipeIsValid = 1;
		//start layer program loading; during that process, the above valid flag may get reset to 0!
		appHmiLayerL0L1LoadRequest();
		//GB: magic write
		*((UDINT*)gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].optInitAtPowerUp.pTestDataStorage) = gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].optInitAtPowerUp.iTestData;
	}
	
	if(gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oSerCountOld != gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oSerCount){
		gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oSerCountOld = gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oSerCount;
		//rebuild current layer editor view
		appHmiLayerEditorCmdTxtGen();	
		brsstrcpy((UDINT)txtMsg, (UDINT)"Patttern program saved to a file!\n\nFilename: ");
		brsstrcat((UDINT)txtMsg, (UDINT)gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].iFilename);
		paiHmiAlertShow(&gPaiHmiAlertMsg, "MESSAGE:", txtMsg, 3000);
		//refresh file viewer
		gPaiMp.data.MpRecipeUIConnectCustom2.Recipe.Refresh = 1;
		//GB: magic write
		*((UDINT*)gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].optInitAtPowerUp.pTestDataStorage) = gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].optInitAtPowerUp.iTestData;
	}
		
}

/*
###############################################################################
HMI Logic: Pallete Editor
###############################################################################
*/
void appHmiPalleteEditorVisibility()
{
	int ii;
		
	//control visibility of the pallete editor components
	for(ii=0; ii < 12; ii++){//todo: use const here
		if(ii < gPallete.palCfg.palActiveLayers){
			//visible
			gPallete.ctrlLayers[ii].layerVisible = 0;
			if(gConfigApp.options.optTearSheetEquiped){
				gPallete.ctrlLayers[ii].tearSheetOptionVisible = 0;		
			}else{
				gPallete.ctrlLayers[ii].tearSheetOptionVisible = 1;					
			}
			if(gConfigApp.options.optOption1Equiped){
				gPallete.ctrlLayers[ii].option1Visible = 0;		
			}else{
				gPallete.ctrlLayers[ii].option1Visible = 1;					
			}
		}else{
			//not visible
			gPallete.ctrlLayers[ii].layerVisible = 1; 
			gPallete.ctrlLayers[ii].tearSheetOptionVisible = 1;					
			gPallete.ctrlLayers[ii].option1Visible = 1;					
		}		
	}
}

static void appHmiPalleteEditorAssignLayerProgram()
{
	int curSel;	
	
	if(gPallete.ctrlLayers[0].btnAssignLayerFilename){
		gPallete.ctrlLayers[0].btnAssignLayerFilename = 0;
		curSel = gPaiMp.data.MpRecipeUIConnectCustom1.Recipe.List.SelectedIndex;
		if(curSel > gPaiMp.data.MpRecipeUIConnectCustom1.Recipe.List.MaxSelection){
			// Show the alert with a specified text and for a selected amount of time
			paiHmiAlertShow(&gPaiHmiAlertMsg, "WARNING:","Filename not selected!\nPlease select a filename from the list.", 3000);		
			return;
		}
		if(gPaiMp.data.MpRecipeUIConnectCustom1.Recipe.List.Names[curSel][0] == 0){
			// Show the alert with a specified text and for a selected amount of time
			paiHmiAlertShow(&gPaiHmiAlertMsg, "WARNING:","Filename not defined!\nPlease select a filename from the list.", 3000);		
			return;
		}
		brsstrcpy((UDINT)gPallete.palCfg.palLayerSettings[0].layerFilename, (UDINT)gPaiMp.data.MpRecipeUIConnectCustom1.Recipe.List.Names[curSel]);
	}
	
	if(gPallete.ctrlLayers[1].btnAssignLayerFilename){
		gPallete.ctrlLayers[1].btnAssignLayerFilename = 0;
		curSel = gPaiMp.data.MpRecipeUIConnectCustom1.Recipe.List.SelectedIndex;
		if(curSel > gPaiMp.data.MpRecipeUIConnectCustom1.Recipe.List.MaxSelection){
			// Show the alert with a specified text and for a selected amount of time
			paiHmiAlertShow(&gPaiHmiAlertMsg, "WARNING:","Filename not selected!\nPlease select a filename from the list.", 3000);		
			return;
		}
		if(gPaiMp.data.MpRecipeUIConnectCustom1.Recipe.List.Names[curSel][0] == 0){
			// Show the alert with a specified text and for a selected amount of time
			paiHmiAlertShow(&gPaiHmiAlertMsg, "WARNING:","Filename not defined!\nPlease select a filename from the list.", 3000);		
			return;
		}
		brsstrcpy((UDINT)gPallete.palCfg.palLayerSettings[1].layerFilename, (UDINT)gPaiMp.data.MpRecipeUIConnectCustom1.Recipe.List.Names[curSel]);
		gPallete.palCfg.palLayerSettings[1].sameAsOtherLayer = 0;		
	}
	
	if(gPallete.ctrlLayers[1].btnDeleteLayerFilename){
		gPallete.ctrlLayers[1].btnDeleteLayerFilename = 0;
		
		if(gPallete.palCfg.palLayerSettings[1].layerFilename[0] != 0){
			paiHmiDialogShow(&gPaiHmiDialogMsg, "Delete layer L1 program filename and remove all reference to L1?", 10000, DLG_DeleteL1FilenameOK, DLG_DeleteL1FilenameCancel, 1);				
		}
	}
	
	if(gPaiHmiDialogMsg.result == DLG_DeleteL1FilenameOK){
		gPaiHmiDialogMsg.result = 0;
		gPallete.palCfg.palLayerSettings[1].layerFilename[0] = 0;
		appHmiSetPalleteLayersCfgL0Only();
	}
	if(gPaiHmiDialogMsg.result == DLG_DeleteL1FilenameCancel){
		gPaiHmiDialogMsg.result = 0;
	}
	
	
}

void appHmiPalleteEditorCyclic()
{
	
	appHmiPalleteEditorVisibility();	
	appHmiPalleteEditorAssignLayerProgram();	
	
}


void appScalingAndConversion()
{
	gCtrl.retainerbar.barDwDlyTmXms = (UDINT)(gPallete.palCfg.palSettings.timers.onDlyPRRetBarDown * 1000.0);
}

void appBladeStopsUsed()
{
	switch(gConfigApp.system.bladeStopCount){
		case 0:
			gCtrl.rowforming.isStopBladeUsed1 = 0;
			gCtrl.rowforming.isStopBladeUsed2 = 0;
			gCtrl.rowforming.isStopBladeUsed3 = 0;
			gCtrl.rowforming.isStopBladeUsed4 = 0;
			gCtrl.rowforming.isStopBladeUsed5 = 0;
			gCtrl.rowforming.isStopBladeUsed6 = 0;
		break;
		case 1:
			gCtrl.rowforming.isStopBladeUsed1 = 1;
			gCtrl.rowforming.isStopBladeUsed2 = 0;
			gCtrl.rowforming.isStopBladeUsed3 = 0;
			gCtrl.rowforming.isStopBladeUsed4 = 0;
			gCtrl.rowforming.isStopBladeUsed5 = 0;
			gCtrl.rowforming.isStopBladeUsed6 = 0;
			break;
		case 2:
			gCtrl.rowforming.isStopBladeUsed1 = 1;
			gCtrl.rowforming.isStopBladeUsed2 = 1;
			gCtrl.rowforming.isStopBladeUsed3 = 0;
			gCtrl.rowforming.isStopBladeUsed4 = 0;
			gCtrl.rowforming.isStopBladeUsed5 = 0;
			gCtrl.rowforming.isStopBladeUsed6 = 0;
			break;
		case 3:
			gCtrl.rowforming.isStopBladeUsed1 = 1;
			gCtrl.rowforming.isStopBladeUsed2 = 1;
			gCtrl.rowforming.isStopBladeUsed3 = 1;
			gCtrl.rowforming.isStopBladeUsed4 = 0;
			gCtrl.rowforming.isStopBladeUsed5 = 0;
			gCtrl.rowforming.isStopBladeUsed6 = 0;
			break;
		case 4:
			gCtrl.rowforming.isStopBladeUsed1 = 1;
			gCtrl.rowforming.isStopBladeUsed2 = 1;
			gCtrl.rowforming.isStopBladeUsed3 = 1;
			gCtrl.rowforming.isStopBladeUsed4 = 1;
			gCtrl.rowforming.isStopBladeUsed5 = 0;
			gCtrl.rowforming.isStopBladeUsed6 = 0;
			break;
		case 5:
			gCtrl.rowforming.isStopBladeUsed1 = 1;
			gCtrl.rowforming.isStopBladeUsed2 = 1;
			gCtrl.rowforming.isStopBladeUsed3 = 1;
			gCtrl.rowforming.isStopBladeUsed4 = 1;
			gCtrl.rowforming.isStopBladeUsed5 = 1;
			gCtrl.rowforming.isStopBladeUsed6 = 0;
			break;
		case 6:
			gCtrl.rowforming.isStopBladeUsed1 = 1;
			gCtrl.rowforming.isStopBladeUsed2 = 1;
			gCtrl.rowforming.isStopBladeUsed3 = 1;
			gCtrl.rowforming.isStopBladeUsed4 = 1;
			gCtrl.rowforming.isStopBladeUsed5 = 1;
			gCtrl.rowforming.isStopBladeUsed6 = 1;
			break;
	}
}


void appVisibilityCaseInfeedSide()
{
	if(gConfigApp.system.boxInfeedSide == 0){
		gCtrl.main.visibleCaseInfeedOnLeft = 1;
		gCtrl.main.visibleCaseInfeedOnRight = 0;
	}else{
		gCtrl.main.visibleCaseInfeedOnLeft = 0;
		gCtrl.main.visibleCaseInfeedOnRight = 1;
	}	
}


/*
###############################################################################
Logic to change to Alarm screen when alarm pops up
###############################################################################
*/
static void appHmiGotoAlarmScreen()
{
	static BOOL alarmIsTriggered;//remeber if switch to alarm page took place in order to allow going to other pages when alarm is active/present
	
	//switch to alarm screen when alarm pops up;
	if(!alarmIsTriggered && gAlarms.oIsAlarmActive && gAlarms.oIsAlarmNotAck && (gPaiHmiMain.runtime.pageCurrent != SID_Diag_Alarms) && (gPaiHmiMain.runtime.pageChange == -1)){
		gPaiHmiMain.runtime.pageChange = SID_Diag_Alarms;
		alarmIsTriggered = 1;
	}
	
	//reset alarm is triggered when no active alarms
	if(!gAlarms.oIsAlarmActive){
		alarmIsTriggered = 0;		
	}	
	
	//switch automatically back to main page when alarms are clear
	if(!alarmIsTriggered && !gAlarms.oIsAlarmActive && !gAlarms.oIsAlarmNotAck && (gPaiHmiMain.runtime.pageCurrent == SID_Diag_Alarms) && (gPaiHmiMain.runtime.pageChange == -1)){
		//9/21/2016; Following line commented out on the request from customer (David@ABC, based on the input from the end user (Duckhorn)
		//gPaiHmiMain.runtime.pageChange = SID_Main;		
		
	}		
		
}

/*
###############################################################################
Configuration file gConfig HMI logic
###############################################################################
*/
static void appHmiAppConfigFileLoadRequest()
{
	int IDX_SERDES_ITEM = 0;
	
	gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].iDesRequest = 1;
	gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oDesCountOld = gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oDesCount;
}

static void appHmiAppConfigFileSaveRequest()
{
	int IDX_SERDES_ITEM = 0;

	gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].optChangeMonitor.iChngAccepted = 1;
	gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oSerCountOld = gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oSerCount;	
}

static void appHmiPalletRecipeFileSaveRequest()
{
	int IDX_SERDES_ITEM = 3;

	gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].optChangeMonitor.iChngAccepted = 1;
	gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oSerCountOld = gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oSerCount;	
}

static void appHmiAppConfigCancelChange()
{
	int IDX_SERDES_ITEM = 0;
	gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].optChangeMonitor.iChngRejected = 1;
}

static void appHmiPalletRecipeCancelChange()
{
	int IDX_SERDES_ITEM = 3;
	gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].optChangeMonitor.iChngRejected = 1;
}

static BOOL appHmiIsAppConfigChanged()
{
	int IDX_SERDES_ITEM = 0;
	return(gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].optChangeMonitor.oChngDetected);
}


//check if PV restored from a file
static void appHmiAppConfigFileLoadEventCyclic()
{
	char txtMsg[255];
	int IDX_SERDES_ITEM = 0;
	
	if(gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oDesCountOld == gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oDesCount)
		return;		
				
	gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oDesCountOld = gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oDesCount;	
	brsstrcpy((UDINT)txtMsg, "Application configuration loaded from file.\n\nFilename: ");
	brsstrcat((UDINT)txtMsg, (UDINT)gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].iFilename);
	paiHmiAlertShow(&gPaiHmiAlertMsg, "MESSAGE:", txtMsg, 3000);
}

static void appHmiAppConfigFileSaveEventCyclic()
{
	char txtMsg[255];
	int IDX_SERDES_ITEM = 0;
	
	if(gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oSerCountOld == gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oSerCount)
		return;
		
	gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oSerCountOld = gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oSerCount;	
	brsstrcpy((UDINT)txtMsg, (UDINT)"Application configuration saved to file.\n\nFilename: ");
	brsstrcat((UDINT)txtMsg, (UDINT)gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].iFilename);
	paiHmiAlertShow(&gPaiHmiAlertMsg, "MESSAGE:", txtMsg, 3000);
}

static void appHmiPalletRecipeFileSaveEventCyclic()
{
	char txtMsg[255];
	int IDX_SERDES_ITEM = 3;
	
	if(gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oSerCountOld == gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oSerCount)
		return;
		
	gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oSerCountOld = gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].oSerCount;	
	brsstrcpy((UDINT)txtMsg, (UDINT)"Pallet recipe saved to file.\n\nFilename: ");
	brsstrcat((UDINT)txtMsg, (UDINT)gPVSerDesMgr.pvItems[IDX_SERDES_ITEM].iFilename);
	paiHmiAlertShow(&gPaiHmiAlertMsg, "MESSAGE:", txtMsg, 3000);
}
	
void appHmiConfigFileCyclic(){

	if(gCtrl.main.btnLoadMachineCfg){//when hmi button pressed
		gCtrl.main.btnLoadMachineCfg = 0;
		appHmiAppConfigFileLoadRequest();//trigger AppConfig file load
	}
	
	
	if( gSerDesHMI_gConfigApp.oBtnClick ){
		gSerDesHMI_gConfigApp.oBtnClick = 0;
		paiHmiDialogShow(&gPaiHmiDialogMsg, "Application Configuration Is Changed!\n\nAccept and Save changes?", 10000, DLG_SaveAppConfigOK, DLG_SaveAppConfigCancel, 1);				
	}
	
	if(gPaiHmiDialogMsg.result == DLG_SaveAppConfigOK){
		gPaiHmiDialogMsg.result = 0;
		appHmiAppConfigFileSaveRequest();
	}
	
	if(gPaiHmiDialogMsg.result == DLG_SaveAppConfigCancel){
		gPaiHmiDialogMsg.result = 0;
		appHmiAppConfigCancelChange();
	}
	
	appHmiAppConfigFileLoadEventCyclic();
	appHmiAppConfigFileSaveEventCyclic();
}

void appHmiPalletRecipeCyclic(){

	
	if( gSerDesHMI_gPalletCfg.oBtnClick ){
		gSerDesHMI_gPalletCfg.oBtnClick = 0;
		paiHmiDialogShow(&gPaiHmiDialogMsg, "Pallet Recipe Is Changed!\n\nAccept and Save changes?", 10000, DLG_SavePalletRecipeOK, DLG_SavePalletRecipeCancel, 1);				
	}
	
	if(gPaiHmiDialogMsg.result == DLG_SavePalletRecipeOK){
		gPaiHmiDialogMsg.result = 0;
		appHmiPalletRecipeFileSaveRequest();
	}
	
	if(gPaiHmiDialogMsg.result == DLG_SavePalletRecipeCancel){
		gPaiHmiDialogMsg.result = 0;
		appHmiPalletRecipeCancelChange();
	}
	
	appHmiPalletRecipeFileSaveEventCyclic();
}

/*
###############################################################################
Init, Cyclic, Exit
###############################################################################
*/
void _INIT appHmiLogicInit(void)
{
	/* TODO: Add code here */
	
	paiRunningMsgInit(&gMsgRunningCtrl, gMsgRunning);
	gMsgRunningCtrl.iEnable = 1;
	gMsgRunningCtrl.iScrollDelayXms = 1000;
	gMsgRunningCtrl.iScrollLength = 100;	
	
	//Remove 
	gLayerEditorTxt.curIdxRow = 0;
	gLayerEditor.palCfgRows[0].palCfgCmds[0].cmdExtra = 0;
	
	//trigger cell selection on powerup
	gLayerEditorTxt.curIdxEditorCellOld = 1000;
	
	bgTimerStart(&gStats.runningTmr1sec, 1000);
	bgTimerStart(&gStats.runningTmr1min, 1000 * 60);
	bgTimerStart(&gStats.runningTmr1, 1000 * 60 * 60 * 24 * 100);
	
	//visibility flag for the pallet dispenser option
	gCtrl.palletDispenser.palletDispenserEquippedVis = gCtrl.palletDispenser.palletDispenserEquipped ? 0 : 1;
	
}
_LOCAL int gbTest;

//============================================================================
void _CYCLIC appHmiLogicCyclic(void)
{
	/* TODO: Add code here */
	
	//Logic to detect page change events and generate approprite signals / flags (i/e/ pageInit etc)
	paiHmiPageChangeCyclic(&gPaiHmiMain);
		
	//Page(screen) specific logic. Logic that runs/applies only to a specific page/screen
	screenHandlers(&gPaiHmiMain);
	
	if(gbTest == 1){
		gbTest = 0;
		// Show the alert with a specified text and for a selected amount of time
		paiHmiAlertShow(&gPaiHmiAlertMsg, "WARNING:","This is alert test!\nGoran Bjelcevic", 3000);
	}
		
	if(gbTest == 2){
		gbTest = 0;
		paiHmiDialogShow(&gPaiHmiDialogMsg, "Test or not?", 10000, 11, 12, 0);				
	}	

	if(gPaiHmiDialogMsg.result == 11){
		gPaiHmiDialogMsg.result = 0;
		paiHmiAlertShow(&gPaiHmiAlertMsg, "WARNING:", "Test 111.", 2000);			
	}
	if(gPaiHmiDialogMsg.result == 12){
		gPaiHmiDialogMsg.result = 0;
		paiHmiAlertShow(&gPaiHmiAlertMsg, "WARNING:", "Test 222.", 2000);			
	}
	
	
	paiRunningMsgCyclic(&gMsgRunningCtrl);
	if(gMsgRunningCtrl.curIdx < 30){
		gMsgRunningCtrl.oMsgFCIdx = 1;	
	}else
	if(gMsgRunningCtrl.curIdx > 60){
		gMsgRunningCtrl.oMsgFCIdx = 2;	
	}else{
		gMsgRunningCtrl.oMsgFCIdx = 0;	
	}
	
	
	if(gCtrl.main.hmiShowMsgZeroingNeeded){
		gCtrl.main.hmiShowMsgZeroingNeeded = 0;
		paiHmiAlertShow(&gPaiHmiAlertMsg, "WARNING", "Machine Counts Changed!\nPlease Zero Machine!", 3000);	
	}	

	
	appHmiLayerEditor();
	
	appHmiPalleteEditorCyclic();
	
	appHmiLayerFileHandlerCyclic();
	appHmiPalleteFileHandlerCyclic();
	
	appHmiLayerL0L1FileLoadingCyclic();
	
	appScalingAndConversion();
	
	appBladeStopsUsed();
	
	appVisibilityCaseInfeedSide();	
	
	appHmiConfigFileCyclic();
	
	appHmiPalletRecipeCyclic();
	
	appHmiGotoAlarmScreen();
	
}
//============================================================================
//EOF
