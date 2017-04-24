/********************************************************************
 * COPYRIGHT -- piedmont
 ********************************************************************
 * Program: Defaults_gConfigApp
 * File: Defaults_gConfigApp.c
 * Author: admin
 * Created: Jan 20, 2015
 ********************************************************************
 * Implementation of program Defaults_gConfigApp
 ********************************************************************/

#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
 #include <AsDefault.h>
#endif

/*
###############################################################################
PAI_CONFIGURATION_SECTION
Code below allows configuration of the PV serialization / deserialization
manager.
###############################################################################
*/
#warning "app Configuration: PV Defaults for gConfigApp"

void gConfigAppDefaults()
{
int ii;
	
	gConfigApp.options.dryCycleCaseCount = 5;
	gConfigApp.options.dryCycleLayerCount = 3;
	gConfigApp.options.dryCycleLayerDonePause = 0;
	gConfigApp.options.palletDispenserOption = 1;
	gConfigApp.options.dryCycleRowCount = 4;
	gConfigApp.options.tmDryCycleCaseTime = 2.0;
	gConfigApp.options.tmDryCycleElevatorUp = 3.0;
	gConfigApp.options.tmDryCycleLayerZeroOffset = 2.0;
		
	gConfigApp.system.simulationMode = 0;
	gConfigApp.system.boxInfeedSide = 0;
	gConfigApp.system.bladeStopCount = 1;
	gConfigApp.system.bladeStopDistance[0] = 6.0;
	gConfigApp.system.bladeStopDistance[1] = 8.0;
	gConfigApp.system.bladeStopDistance[2] = 10.0;
	gConfigApp.system.bladeStopDistance[3] = 12.0;
	gConfigApp.system.bladeStopDistance[4] = 14.0;
	gConfigApp.system.bladeStopDistance[5] = 16.0;
	
}

void gPalletCfgDefaults()
{
	int ii;
	
	gPallete.palCfg.palSettings.timers.dlyTableAtPalleteToRetBar = 1.0;
	gPallete.palCfg.palSettings.timers.dlyTableLayerRdyToElevMove = 1.0;
	gPallete.palCfg.palSettings.timers.offDlyEEPallete = 1.0;
	gPallete.palCfg.palSettings.timers.onDlyPRRetBarDown = 1.0;
	gPallete.palCfg.palSettings.timers.onDlyPRRetBarDown2 = 1.0;
	gPallete.palCfg.palSettings.timers.onTmCaseTurner = 1.0;
	gPallete.palCfg.palSettings.timers.dlyRowDoneToRowPush = 1.0;
	gPallete.palCfg.palSettings.timers.dlyTableAtPalleteToRetBar = 1.0;
	gPallete.palCfg.palSettings.timers.JamAlarmTmAtInfeedEE2 = 4.0;
	gPallete.palCfg.palSettings.timers.JamAlarmTmRowForming = 4.0;
	gPallete.palCfg.palSettings.timers.JamAlarmTmAtRowToLongEE8 = 4.0;
	gPallete.palCfg.palSettings.timers.palletExitAlarmTm = 10.0;
	gPallete.palCfg.palSettings.timers.infeedCVIdleTime = 15.0;
	gPallete.palCfg.palSettings.timers.onDlyPalleteDischargeEE16 = 1.0;
	gPallete.palCfg.palSettings.timers.onDlyTableToGrouping = 0.0;
	gPallete.palCfg.palSettings.timers.EE2OfDebounce = 0.0;
	gPallete.palCfg.palSettings.timers.EE2OnDebounce = 0.0;
	gPallete.palCfg.palSettings.timers.EE4OfDebounce = 0.0;
	gPallete.palCfg.palSettings.timers.EE4OnDebounce = 0.0;
	gPallete.palCfg.palSettings.timers.EE8OfDebounce = 0.0;
	gPallete.palCfg.palSettings.timers.EE8OnDebounce = 0.0;
	gPallete.palCfg.palSettings.timers.EE16OfDebounce = 0.0;
	gPallete.palCfg.palSettings.timers.onDlyFrontSquaring = 0.0;
	gPallete.palCfg.palSettings.timers.bladeStopOnDly1 = 3.0;
	gPallete.palCfg.palSettings.timers.bladeStopOnDly2 = 3.0;
	gPallete.palCfg.palSettings.timers.bladeStopOnDly3 = 3.0;
	gPallete.palCfg.palSettings.timers.bladeStopOnDly4 = 2.0;
	gPallete.palCfg.palSettings.timers.bladeStopOnDly5 = 2.0;
	gPallete.palCfg.palSettings.timers.bladeStopOnDly6 = 2.0;
	
	
	for(ii=0; ii<=APP_VFD_IDXLAST; ii++){
		gPallete.palCfg.palSettings.vfd[ii].velocitySlow_rpm = 0.0;
		gPallete.palCfg.palSettings.vfd[ii].velocity_rpm = 0.0;	
	}
	
	gPallete.palCfg.palSettings.vfd[1].velocitySlow_rpm = 300.0;
	gPallete.palCfg.palSettings.vfd[1].velocity_rpm = 600.0;
	gPallete.palCfg.palSettings.vfd[2].velocitySlow_rpm = 300.0;
	gPallete.palCfg.palSettings.vfd[2].velocity_rpm = 600.0;
	gPallete.palCfg.palSettings.vfd[4].velocitySlow_rpm = 300.0;
	gPallete.palCfg.palSettings.vfd[4].velocity_rpm = 600.0;
	gPallete.palCfg.palSettings.vfd[5].velocitySlow_rpm = 300.0;
	gPallete.palCfg.palSettings.vfd[5].velocity_rpm = 600.0;
	gPallete.palCfg.palSettings.vfd[6].velocitySlow_rpm = 300.0;
	gPallete.palCfg.palSettings.vfd[6].velocity_rpm = 600.0;
	gPallete.palCfg.palSettings.vfd[11].velocitySlow_rpm = 300.0;
	gPallete.palCfg.palSettings.vfd[11].velocity_rpm = 600.0;
	gPallete.palCfg.palSettings.vfd[12].velocitySlow_rpm = 300.0;
	gPallete.palCfg.palSettings.vfd[12].velocity_rpm = 600.0;

	for(ii=0; ii <= APP_VFD_IDXLAST; ii++){
		gPallete.palCfg.palSettings.vfd[ii].acc = 1;
		gPallete.palCfg.palSettings.vfd[ii].dec = 1;	
	}
	
}
//EOF
