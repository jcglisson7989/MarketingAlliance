/********************************************************************
 * COPYRIGHT -- pai
 ********************************************************************
 * Program: palleteProcessor
 * File: palletProcessor.c
 * Author: goran
 * Created: Nov 01, 2015
 ********************************************************************
 * Implementation of program palleteProcessor
 ********************************************************************/

#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
	#include <AsDefault.h>
#endif

#include "../../paiComponents/bglib/bgString.h"

_LOCAL UDINT cycleCounter;
_LOCAL UDINT cycleCounterOld;

/*
###############################################################################
Utilities
###############################################################################
*/

/**
 Simple logging
 Log goes to an array of PV strings > see _LOCAL STRING log[][] variable below
 Log output is visible via Automation Studio watch window
 Example of a log statement used within the code is: 
 DBG("This is log example. %d ", value1);
 To complety disable logging from this source file, change next line to: #if 0
*/
#if 1
#include <../../paiComponents/bglib/bgPVLogger3.c>
#define LOG_ENTRY_COUNT 90	//max number of log entries
#define LOG_ENTRY_LENGTH  31 //max length of individual log message. Longer msg are truncated
_LOCAL STRING log[LOG_ENTRY_COUNT][LOG_ENTRY_LENGTH]; //log output visible from Automation Studio!
//static bgPVLogger_typ lgr;	//PV logger object
#else
#define DBG(format, args...) ;
#define DBGINIT()  ;
#endif

/*component states - InfeedCV*/
enum{
	STATE_InfeedCVZero = 0,
	STATE_InfeedCVPowerUp,
	STATE_InfeedCVIdle,
	STATE_InfeedCVInitAuto,
	STATE_InfeedCVAuto,
	STATE_InfeedCVExitAuto,
	STATE_InfeedCVLast
}PPINFEEDCVSTATES;

const char* getppInfeedCVStateName(int state)
{
	static const char* stateNames[] = {
		"Zero",
		"PowerUp",	
		"Idle",	
		"InitAuto",	
		"Auto",	
		"ExitAuto",	
		"unknown"
		};

	if( state >= STATE_InfeedCVLast)
		return "unknow";
	
	return stateNames[state];
};

/*component states - Infeed*/
enum{
	STATE_InfeedZero = 0,
	STATE_InfeedPowerUp,
	STATE_InfeedIdle,
	STATE_InfeedInit,
	STATE_InfeedWaitStageCVOn,
	STATE_InfeedExecuteCmd,
	STATE_InfeedWaitNextCase,
	STATE_InfeedRowComplete,
	STATE_InfeedLast
}PPINFEEDSTATES;

const char* getppInfeedStateName(int state)
{
	static const char* stateNames[] = {
		"Zero",
		"PowerUp",	
		"Idle",	
		"Init",	
		"WaitStageCVOn",	
		"ExecuteCmd",	
		"WaitNextCase",	
		"RowComplete",	
		"unknown"
		};

	if( state >= STATE_InfeedLast)
		return "unknow";
	
	return stateNames[state];
};
/*component states - Layer*/
enum{
	STATE_LayerZero = 0,
	STATE_LayerPowerUp,
	STATE_LayerIdle,
	STATE_LayerInit,
	STATE_LayerWaitRowComplete,
	STATE_LayerRowComplete,
	STATE_LayerRowPusherFwd,
	STATE_LayerRowPusherRet,
	STATE_LayerComplete,
	STATE_LayerLast
}PPLAYERSTATES;

const char* getppLayerStateName(int state)
{
	static const char* stateNames[] = {
		"Zero",
		"PowerUp",	
		"Idle",	
		"Init",	
		"WaitRowComplete",	
		"RowComplete",	
		"RowPushFwd",	
		"RowPushRet",	
		"LayerComplete",	
		"unknown"
		};

	if( state >= STATE_LayerLast)
		return "unknow";
	
	return stateNames[state];
};

/*component states - Elevator*/
enum{
	STATE_ElevZero = 0,
	STATE_ElevPowerUp,
	STATE_ElevIdle,
	STATE_ElevReady,
	STATE_ElevVMoveToDrop,
	STATE_ElevMoveTableToDrop,
	STATE_ElevRetBarDown,
	STATE_ElevVMoveToGrouping,
	STATE_ElevVMoveToAbovePallete,
	STATE_ElevWaitPalletExit,
	STATE_ElevTableToGrouping,
	STATE_ElevLast
}PPELEVATORSTATES;

const char* getppElevatorStateName(int state)
{
	static const char* stateNames[] = {
		"Zero",
		"PowerUp",	
		"Idle",	
		"Ready",	
		"ElevToDrop",	
		"TableToDrop",	
		"RetainerBarDown",	
		"ElevToGrouping",	
		"ElevToAbovePallete",
		"WaitPalletExit",
		"TableToGrouping",
		"unknown"
		};

	if( state >= STATE_ElevLast)
		return "unknow";
	
	return stateNames[state];
};

/*component states - Pallete*/
enum{
	STATE_PalleteZero = 0,
	STATE_PalletePowerUp,
	STATE_PalleteIdle,
	STATE_PalleteInit,
	STATE_PalleteExitRequest,
	STATE_PalleteExitIP,
	STATE_PalleteLast,
}PPPALLETESTATES;

const char* getppPalleteStateName(int state)
{
	static const char* stateNames[] = {
		"Zero",
		"PowerUp",	
		"Idle",	
		"Init",	
		"ExitRequest",
		"ExitIP",
		"unknown"
		};

	if( state >= STATE_PalleteLast)
		return "unknow";
	
	return stateNames[state];
};


/*
###############################################################################
Machine control interface functions
pp- prefix used for "pallete processor"
###############################################################################
*/
static BOOL machCtrlIsRowStageCVOn()
{
	return gCtrl.rowforming.hmiBtnOnOffStageCV;
}

static void machCtrlInfeedCV(BOOL off_on)
{
	gCtrl.infeedcv.hmiBtnOnOff = off_on;
}

static BOOL machCtrlIsInfeedCVOn()
{
	return gCtrl.infeedcv.hmiBtnOnOff;
}

static void	machCtrlStagingCV(BOOL off_on)
{
	gCtrl.rowforming.hmiBtnOnOffStageCV = off_on;
}

static BOOL	machCtrlIsStagingCVRunning()
{
	return gCtrl.rowforming.hmiBtnOnOffStageCV;
}

static BOOL machCtrlIsRowFormingCVRunning()
{
	//return ((gMachineVFD[5].vfdIn.Status.CurrentVelocity != 0) ? 1 : 0);
	return gCtrl.rowforming.hmiBtnOnOffCV;
}

static BOOL ppIsAutoMode()
{
	return gCtrl.main.modeAuto;
}

static BOOL ppIsNextCase()
{
	//TODO: use incoming case sensor to detect incoming cases
	if(gCtrl.infeedcv.caseInfeedDone){
		gCtrl.infeedcv.caseInfeedDone = 0;
		return 1;
	}	
	return 0;
}

static void ppRowFormingCV(BOOL off_on)
{
	gCtrl.rowforming.hmiBtnOnOffCV = off_on;
}

static BOOL ppIsRowFormingCVStopped()
{//Row forming CV > VFD5 ((which is VFD5 in the schematic) 
	return( (gMachineVFD[5].vfdIn.Status.CurrentVelocity != 0) ? 0 : 1);
}

static void	ppBladeStop(USINT cmdBlade, BOOL down_up, BOOL quickRaise)
{
	if(!quickRaise)	
		switch(cmdBlade){
			case 1:
				gCtrl.rowforming.hmiBtnStopBladeUpDown1 = down_up;				
			break;
			case 2:
				gCtrl.rowforming.hmiBtnStopBladeUpDown2 = down_up;				
			break;
			case 3:
				gCtrl.rowforming.hmiBtnStopBladeUpDown3 = down_up;				
				break;
			case 4:
				gCtrl.rowforming.hmiBtnStopBladeUpDown4 = down_up;				
			break;
			case 5:
				gCtrl.rowforming.hmiBtnStopBladeUpDown5 = down_up;				
			break;
			case 6:
				gCtrl.rowforming.hmiBtnStopBladeUpDown6 = down_up;				
				break;
		}
	else{
		switch(cmdBlade){
			case 1:
				gCtrl.rowforming.hmiBtnStopBladeUpDownQuick1 = down_up;				
				break;
			case 2:
				gCtrl.rowforming.hmiBtnStopBladeUpDownQuick2 = down_up;				
				break;
			case 3:
				gCtrl.rowforming.hmiBtnStopBladeUpDownQuick3 = down_up;				
				break;
			case 4:
				gCtrl.rowforming.hmiBtnStopBladeUpDownQuick4 = down_up;				
				break;
			case 5:
				gCtrl.rowforming.hmiBtnStopBladeUpDownQuick5 = down_up;				
				break;
			case 6:
				gCtrl.rowforming.hmiBtnStopBladeUpDownQuick6 = down_up;				
				break;
		}	
	}
}

static void	ppBladeStopAllDown()
{
	gCtrl.rowforming.hmiBtnStopBladeUpDown1 = 0;		
	gCtrl.rowforming.hmiBtnStopBladeUpDown2 = 0;		
	gCtrl.rowforming.hmiBtnStopBladeUpDown3 = 0;		
	gCtrl.rowforming.hmiBtnStopBladeUpDown4 = 0;		
	gCtrl.rowforming.hmiBtnStopBladeUpDown5 = 0;		
	gCtrl.rowforming.hmiBtnStopBladeUpDown6 = 0;	
	
	gCtrl.rowforming.hmiBtnStopBladeUpDownQuick1 = 0;		
	gCtrl.rowforming.hmiBtnStopBladeUpDownQuick2 = 0;		
	gCtrl.rowforming.hmiBtnStopBladeUpDownQuick3 = 0;		
	gCtrl.rowforming.hmiBtnStopBladeUpDownQuick4 = 0;		
	gCtrl.rowforming.hmiBtnStopBladeUpDownQuick5 = 0;		
	gCtrl.rowforming.hmiBtnStopBladeUpDownQuick6 = 0;		
}


static void	ppCaseTurner(USINT cmdTurner)
{
	if(cmdTurner <= 1){//case turner > no turn
		gCtrl.caseturner.hmiAutoCaseTurn = 0;		
	}
	
	if(cmdTurner == 2){//case turner > yes turn
		gCtrl.caseturner.hmiAutoCaseTurn = 1;		
	}
}

static void ppRowPusherFwd()
{
	gCtrl.rowforming.hmiBtnPusherFwd = 1;
	gCtrl.rowforming.hmiBtnPusherRev = 0;
}

static void ppRowPusherRet()
{
	gCtrl.rowforming.hmiBtnPusherFwd = 0;
	gCtrl.rowforming.hmiBtnPusherRev = 1;
}

static void ppElevatorToPalleteTop()
{
	gCtrl.elevator.hmiBtnElevatorToPallete = 1;
}

static void ppElevatorToPalleteTopResume()
{
	if(gMachineIO.din.ElevatorDetectPalletLayerLF_EE1){
		//If pallete detect PE is blocked > move elevator up
		gCtrl.elevator.hmiBtnElevatorFwd = 1;						
		gCtrl.elevator.hmiBtnElevatorRev = 0;	
	}else{
		//If pallete detect PE NOT blocked > move table to pallete
		gCtrl.transfertable.hmiBtnTableFwd = 1;						
		gCtrl.transfertable.hmiBtnTableRev = 0;							
	}
}

static BOOL ppIsElevatorAtPalleteTop()
{	
	return (gCtrl.elevator.elevatorIsAtPalleteAboveHome | gCtrl.elevator.elevatorIsAtPalleteBelowHome | gCtrl.elevator.elevatorIsAtBottom);		
}

static void ppElevatorAbovePalleteTop()
{
	gCtrl.elevator.hmiBtnElevatorToAbovePallete = 1;
}

static void ppElevatorToTopPosition()
{
	gCtrl.elevator.hmiBtnElevatorToTop = 1;
}

static BOOL ppIsElevatorAbovePalleteTop()
{	
	return (gCtrl.elevator.hmiBtnElevatorToAbovePallete ? 0 : 1);		
}

static BOOL ppIsElevatorIsAtTop()
{	
	return gCtrl.elevator.elevatorIsAtTop;		
}

static void ppElevatorToGrouping()
{
	gCtrl.elevator.hmiBtnElevatorToGrouping = 1;
}

static BOOL ppIsElevatorAtGrouping()
{
	return gCtrl.elevator.elevatorIsAtHome;
}

static BOOL ppIsRowPusherExtended()
{
	return gCtrl.rowforming.isRowPusherAtElevator;
}

static BOOL ppIsRowPusherRetracted()
{
	return gCtrl.rowforming.isRowPusherAtHome;
}

static BOOL ppIsRowPushAllowed()
{
	return (gCtrl.transfertable.isTableAtGrouping & (gPallete.ctrlProc.ssmElevator.state == STATE_ElevReady));
}

static BOOL ppIsLayerDropToPalletAllowed()
{
	return (gCtrl.main.isDropLayerToPalletAllowed); 
}

static void ppTransferTableToPallete()
{
	gCtrl.transfertable.hmiBtnTableFwd = 1;	
	
}

static void ppTransferTableToPalleteResume()
{
	gCtrl.transfertable.hmiBtnTableFwd = 1;
	//after an E-Stop, and to restart the table move, start CV directly
	gMachineVFD[2].vfdCtrl.iMoveFwd = 1;	
}

static void ppWaitPalletExitResume(){
	ppElevatorToTopPosition();
}

static void ppTransferTableToGrouping()
{
	gCtrl.transfertable.hmiBtnTableRev = 1;	
}

static BOOL ppIsTransferTableAtPallete()
{
	return gCtrl.transfertable.isTableAtPallete;
}

static BOOL ppIsTransferTableAtGrouping()
{
	return gCtrl.transfertable.isTableAtGrouping;
}

static void	ppSquaringPlatesExtRet(BOOL extRet)
{//Extend=1; Retract=0
	gCtrl.squaring.hmiBtnSidePlatesExtRet = extRet;
	gCtrl.squaring.hmiBtnFrontPlateExtRet = extRet;
}	

static void ppRetainerBarDown()
{
	gCtrl.retainerbar.hmiBtnRetainterBarFwd = 1;
}

static void ppRetainerBarUp()
{
	gCtrl.retainerbar.hmiBtnRetainterBarRev = 1;
}

static BOOL ppIsRetainerBarDown()
{
	return gCtrl.retainerbar.barIsDown;
}

static BOOL ppIsRetainerBarUp()
{
	return gCtrl.retainerbar.barIsUp;
}


static USINT ppGetCmdCase()
{
	USINT command;
	
	USINT cmd = gPallete.ctrlProc.cmdIdx;
	USINT row = gPallete.ctrlProc.rowIdx;
	USINT lay = gPallete.ctrlProc.layerIdx;
	command = gPallete.palCfgLayers[lay].palCfgRows[row].palCfgCmds[cmd].cmdCase;
	return command;
}

static USINT ppGetCmdBlade()
{
	USINT command;
	
	USINT cmd = gPallete.ctrlProc.cmdIdx;
	USINT row = gPallete.ctrlProc.rowIdx;
	USINT lay = gPallete.ctrlProc.layerIdx;
	command = gPallete.palCfgLayers[lay].palCfgRows[row].palCfgCmds[cmd].cmdBlade;
	return command;
}

static USINT ppGetCmdFeature()
{
	USINT command;
	
	USINT cmd = gPallete.ctrlProc.cmdIdx;
	USINT row = gPallete.ctrlProc.rowIdx;
	USINT lay = gPallete.ctrlProc.layerIdx;
	command = gPallete.palCfgLayers[lay].palCfgRows[row].palCfgCmds[cmd].cmdFeature;
	return command;
}

static void ppExeCmdCase(USINT cmdCase)
{
	switch(cmdCase)
	{
		case 0: //end of row
			
		break;
		case 1: //normal case
			ppCaseTurner(cmdCase);
		break;
		case 2: //case +90 turn
			ppCaseTurner(cmdCase);			
		break;
	}
}

static void ppExeCmdBlade(USINT cmdBlade, BOOL quickBladeRaise)
{
	switch(cmdBlade)
	{
		case 0: //nothing todo
			break;
		case 1: //raise blade 1
		case 2: //raise blade 2
		case 3: //raise blade 3
		case 4: //raise blade 4
		case 5: //raise blade 5
			ppBladeStop(cmdBlade, 1, quickBladeRaise);
			break;
		default:
			break;
	}
}

//this function is called when entereding auto mode in order to restore required blade state for the current row beeing formed
static void ppResumeBladeCmdsForCurrentRow()
{
	int ii;
	USINT bladeCmd;
	
	USINT cmd = gPallete.ctrlProc.cmdIdx;
	USINT row = gPallete.ctrlProc.rowIdx;
	USINT lay = gPallete.ctrlProc.layerIdx;
	
	for(ii=0; ii<cmd; ii++){
		bladeCmd = gPallete.palCfgLayers[lay].palCfgRows[row].palCfgCmds[ii].cmdBlade;
		ppExeCmdBlade(bladeCmd, 1);
	}	
}

static void ppStatisticsCaseCountIncrement()
{
	gStats.caseCounter++;
	gStats.caseCounterTotal++;
}

static void ppStatisticsPalletCountIncrement()
{
	gStats.palletCounter++;
	gStats.palletCounterTotal++;
}

//Command execution routines
static void ppNextCommand()
{
	gPallete.ctrlProc.cmdIdx++;
	if(gPallete.ctrlProc.cmdIdx >= APP_REC_MAXCASE){
		DBG(lgr,"LYR ppNextCommand() OVRFLOW");	
	
	}
	ppStatisticsCaseCountIncrement();
}
static void ppNextRow()
{
	gPallete.ctrlProc.cmdIdx = 0;
	gPallete.ctrlProc.rowIdx++;
	if(gPallete.ctrlProc.rowIdx >= APP_REC_MAXROW){
		DBG(lgr,"LYR ppNextRow() OVRFLOW");	
	
	}
}
static void ppNextLayer()
{
	gPallete.ctrlProc.cmdIdx = 0;
	gPallete.ctrlProc.rowIdx = 0;
	gPallete.ctrlProc.layerIdx++;
	if(gPallete.ctrlProc.layerIdx >= APP_REC_MAXLAYER){
		DBG(lgr,"LYR ppNextLayer() OVRFLOW");	
	
	}
}

static void ppReset()
{
	gPallete.ctrlProc.cmdIdx = 0;
	gPallete.ctrlProc.rowIdx = 0;
	gPallete.ctrlProc.layerIdx = 0;
}

//================================================================================
//Row, Layer, Pallet completed events and signals
//generated by the LYR SM while executing commands
static USINT ppLYRLayerEndEventCheck()
{
//current row is last row in the first command [0] in the following row is 0
	USINT command;
	
	USINT row = gPallete.ctrlProc.rowIdx;
	USINT lay = gPallete.ctrlProc.layerIdx;
	
	if((gPallete.ctrlProc.rowIdx) == APP_REC_MAXROW){
		return 0;
	}
		
	command = gPallete.palCfgLayers[lay].palCfgRows[row].palCfgCmds[0].cmdCase;
	return command;

}
static void ppLYRLayerEndEventSet()
{
	DBG(lgr,"ppLYRLayerEndEventSet()");	
	gPallete.ctrlProc.ssmLayer.event[0] = 1;
}
static void ppLYRLayerEndEventRst()
{
	DBG(lgr,"ppLYRLayerEndEventRst()");	
	gPallete.ctrlProc.ssmLayer.event[0] = 0;
}
static BOOL ppLYRLayerEndEventGet()
{
	return (gPallete.ctrlProc.ssmLayer.event[0]);
}
static USINT ppLYRPalletEndEventCheck()
{
	//current row is last row in the first command [0] in the following row is 0
	USINT command;
	USINT lay = gPallete.ctrlProc.layerIdx;
	
	if((gPallete.ctrlProc.layerIdx) == APP_REC_MAXLAYER ){
		return 0;
	}
		
	command = gPallete.palCfgLayers[lay].palCfgRows[0].palCfgCmds[0].cmdCase;
	return command;

}
static void ppLYRPalletEndEventSet()
{
	DBG(lgr,"ppLYRPalletEndEventSet()");	
	gPallete.ctrlProc.ssmLayer.event[1] = 1;
}
static void ppLYRPalletEndEventRst()
{
	DBG(lgr,"ppLYRPalletEndEventRst()");	
	gPallete.ctrlProc.ssmLayer.event[1] = 0;
}
static BOOL ppLYRPalletEndEventGet()
{
	return (gPallete.ctrlProc.ssmLayer.event[1]);
}

static void ppLYRManualEndEventSet()
{
	DBG(lgr,"ppLYRManualEndEventSet()");	
	gPallete.ctrlProc.ssmLayer.event[2] = 1;
}
static void ppLYRManualEndEventRst()
{
	DBG(lgr,"ppLYRManualEndEventRst()");	
	gPallete.ctrlProc.ssmLayer.event[2] = 0;
}
static BOOL ppLYRManualEndEventGet()
{
	return (gPallete.ctrlProc.ssmLayer.event[2]);
}


//Event from infeed
static void ppINFRowEndEventSet()
{
	DBG(lgr,"ppINFRowEndEventSet()");	
	gPallete.ctrlProc.ssmInfeed.event[0] = 1;
}
static void ppINFRowEndEventRst()
{
	DBG(lgr,"ppINFRowEndEventRst()");	
	gPallete.ctrlProc.ssmInfeed.event[0] = 0;
}
static BOOL ppINFRowEndEventGet()
{
	return (gPallete.ctrlProc.ssmInfeed.event[0]);
}

//================================================================================
//Event sent from LYR to ELV to indicate completion of the layer
static void ppLYRtoELVSendLayerReadySignal()
{
	DBG(lgr,"ppLYRtoELVSendLayerReadySignal()");	
	gPallete.ctrlProc.ssmElevator.event[0] = 1;//signal to elevator SM to transfer the completed layer to the pallete
}
static BOOL ppELVIsLayerReadyForPalleteGet()
{
	return ((BOOL)gPallete.ctrlProc.ssmElevator.event[0]);
}		
static void ppELVIsLayerReadyForPalleteRst()
{
	DBG(lgr,"ppELVIsLayerReadyForPalleteRst()");	
	gPallete.ctrlProc.ssmElevator.event[0] = 0;
}

//================================================================================
//Event sent from LYR to ELV to indicate completion of the pallet
static void ppLYRtoELVSendPalletReadySignal()
{
	DBG(lgr,"ppLYRtoELVSendPalletReadySignal()");	
	gPallete.ctrlProc.ssmElevator.event[1] = 1;//signal to ELV SM that the pallet is complete
}
static BOOL ppELVIsPalletReadyGet()
{
	return ((BOOL)gPallete.ctrlProc.ssmElevator.event[1]);
}		
static void ppELVIsPalletReadyRst()
{
	DBG(lgr,"ppELVIsPalletReadyRst()");	
	gPallete.ctrlProc.ssmElevator.event[1] = 0;
}

//================================================================================
//Event sent from ELV to PAL to indicate completion of the pallet
static void ppELVtoPALSendPalletReadySignal()
{
	DBG(lgr,"ppELVtoPALSendPalletReadySignal()");	
	gPallete.ctrlProc.ssmPallete.event[0] = 1;//signal to pallet SM that the pallet is complete
}
static BOOL ppPALIsPalletReadyGet()
{
	return ((BOOL)gPallete.ctrlProc.ssmPallete.event[0]);
}		
static void ppPALIsPalletReadyRst()
{
	DBG(lgr,"ppPALIsPalletReadyRst()");	
	gPallete.ctrlProc.ssmPallete.event[0] = 0;
}

//================================================================================
//Event sent from ELV to PAL to indicate completion of the pallet
static void	ppPALtoELVSendPalleteExitDone()
{
	gPallete.ctrlProc.ssmElevator.event[2] = 1;
}
static BOOL	ppELVIsPalleteExitDoneGet()
{
	return((BOOL)gPallete.ctrlProc.ssmElevator.event[2]);
}
static void	ppELVIsPalleteExitDoneRst()
{
	gPallete.ctrlProc.ssmElevator.event[2] = 0;
}


//================================================================================
//Event sent from HMI to LYR to request premature completion and exit of the pallet
static BOOL ppLYRIsManualFinishPalletGet()
{
	return(gCtrl.palletDischarge.palletManualFinishRequest);
}

static void ppLYRIsManualFinishPalletRst()
{
	gCtrl.palletDischarge.palletManualFinishRequest = 0;
}



static BOOL ppIsPalleteExitAllowed()
{
	return(gCtrl.palletDischarge.isDischargeAllowed);
}

static void	ppReqPalletExit()
{
	gCtrl.palletDischarge.hmiBtnPalletDischargeCVFwd = 1;
	gCtrl.palletDispenser.hmiBtnPalletInCVFwd = 1;	
}

static BOOL	ppIsPalletExitDN()
{
	return ( gCtrl.palletDischarge.dischargeDN || !gCtrl.palletDischarge.hmiBtnPalletDischargeCVFwd);
}

static void ppSSMStateResumeAtInit(bgSSM_typ *pssm)
{
	pssm->stateInit = 1;
}

static void ppUpdateTargetCaseCounts()
{
	USINT cmd = gPallete.ctrlProc.cmdIdx;
	USINT row = gPallete.ctrlProc.rowIdx;
	USINT lay = gPallete.ctrlProc.layerIdx;
	int ii;
	int jj;
	int kk;
	
	if((cmd == 0) && (row == 0) && (lay == 0) ){
		//count layers and total cases	
		gPallete.ctrlProc.oTargetPalletCases = 0;
		gPallete.ctrlProc.oTargetLayers = 0;
		gPallete.ctrlProc.oCurrentCases = 0;
		
		for(ii=0; ii < 12; ii++){
			if(!gPallete.palCfgLayers[ii].palCfgRows[0].palCfgCmds[0].cmdCase){
				break;
			}
			gPallete.ctrlProc.oTargetLayers++;
			
			for(jj=0; jj<12; jj++){				
				if(!gPallete.palCfgLayers[ii].palCfgRows[jj].palCfgCmds[0].cmdCase){
					break;
				}			
				for(kk=0; kk<12; kk++){
					if( !gPallete.palCfgLayers[ii].palCfgRows[jj].palCfgCmds[kk].cmdCase ){
						break;
					}
					gPallete.ctrlProc.oTargetPalletCases++;						
				}			
			}
		
		}	
	}
	
	
	if(!gPallete.ctrlProc.oCurrentCases && (cmd != 0) ){
		//count gPallete.ctrlProc.oCurrentCases
		//if user resets case counts, and enters number for rows/layers/cases other than 0 recalculate currentCases value 
		for(ii=0; ii < 12; ii++){
			if(!gPallete.palCfgLayers[ii].palCfgRows[0].palCfgCmds[0].cmdCase){
				break;
			}			
			for(jj=0; jj < 12; jj++){				
				if(!gPallete.palCfgLayers[ii].palCfgRows[jj].palCfgCmds[0].cmdCase){
					break;
				}			
				for(kk=0; kk < 12; kk++){
					if( !gPallete.palCfgLayers[ii].palCfgRows[jj].palCfgCmds[kk].cmdCase ){
						break;
					}
					if((ii==lay) && (jj==row) && (kk==cmd)){
						ii=12;
						jj=12;
						kk=12;
						break;
					}
					gPallete.ctrlProc.oCurrentCases++;
				}			
			}
		
		}		
	}	
	
	
	if((cmd == 0) && (row == 0) ){
		//count rows per layer	
		gPallete.ctrlProc.oTargetRows = 0;
		for(jj=0; jj<12; jj++){			
			if(!gPallete.palCfgLayers[lay].palCfgRows[jj].palCfgCmds[0].cmdCase){
				break;
			}
			gPallete.ctrlProc.oTargetRows++;
		}
	}
	
	if((cmd == 0) ){
		//count cases per row	
		gPallete.ctrlProc.oTargetCases = 0;
		for(kk=0; kk<12; kk++){
			if( !gPallete.palCfgLayers[lay].palCfgRows[row].palCfgCmds[kk].cmdCase ){
				break;
			}
			gPallete.ctrlProc.oTargetCases++;						
		}			
	}
}

/*
###############################################################################
Pallete Processor State Machine - Infeed
-handles incoming cases and executes commands that are part of the 
pallete building recipe
-This routine is responsible for building a single pallete row.
###############################################################################
*/
static void ppSSMInfeedCyclic()
{
	int currentState;
	static int resumeRequest;
	
	bgSSM_typ *pssm = &gPallete.ctrlProc.ssmInfeed;
	
	//clear events
	gPallete.ctrlProc.oRowDN = 0;
	gPallete.ctrlProc.oLayerDN = 0;
	gPallete.ctrlProc.oPalletDN = 0;
	gPallete.ctrlProc.oPalletStart = 0;
	gPallete.ctrlProc.oCaseDN = 0;
	
	if(!pssm)
		return;

	/*execute control state machine cyclic handler*/		
	if( bgSSMCyclic(pssm) ) return;
	
	
	//show change of state in a log
	if( bgSSMIsStateInit(pssm) ){
		DBG(lgr,"INF sm=%s(%d)", bgSSMGetStateText(pssm), bgSSMGetState(pssm));
	}
	
	if((bgSSMGetState(pssm) > STATE_InfeedIdle) && (bgSSMGetState(&gCtrl.infeedcv.ssmInfeedCV) != STATE_InfeedCVAuto)){
		//stop row forming CV
		//ppRowFormingCV(0);	
#if 0		
		if(bgSSMGetState(pssm) >= STATE_InfeedRowComplete){
			//resume needed
			resumeRequest = 1;
			if(gCtrl.main.btnZero){
				ppLYRIsManualFinishPalletRst();
				bgSSMStateNext(pssm, STATE_InfeedIdle);	
			}
		}else{
			//just reset
			bgSSMStateNext(pssm, STATE_InfeedIdle);	
		}		
#endif		
		bgSSMStateNext(pssm, STATE_InfeedIdle);	
		return;
	}
	
	//workaround for resuming (retriggering) init of the state machine
	//this is needed in case machine gets stopped in the middle of the cycle
	currentState = bgSSMGetState(pssm);
	if(resumeRequest){
		ppSSMStateResumeAtInit(pssm);
	}
	resumeRequest = 0;
	switch( currentState ){
		/*--------------------------------------------------*/
		case STATE_InfeedZero:			
			bgSSMStateNext(pssm, STATE_InfeedIdle);	
			break;
		/*--------------------------------------------------*/
		case STATE_InfeedPowerUp:
			bgSSMStateNext(pssm, STATE_InfeedIdle);	
			break;
		/*--------------------------------------------------*/
		case STATE_InfeedIdle:		
			if ( ppIsAutoMode() ){
				bgSSMStateNext(pssm, STATE_InfeedInit);	
			} 
			break;
		/*--------------------------------------------------*/
		case STATE_InfeedInit:	

			ppResumeBladeCmdsForCurrentRow();//resume state of blade stops for the current row (raises all blades that shall be active for the row beeing formed)
			bgSSMStateNextTimeDelay(pssm, STATE_InfeedExecuteCmd, 750);	
			
			//detect if we are restarting w. a row full of cases
			pssm->event[3] = 0;
			if( !ppGetCmdCase() && gPallete.ctrlProc.cmdIdx){
				//yes! we are restartig with a row full of cases
				DBG(lgr,"INFstartWFullRow");	
				pssm->event[3] = 1;
			}
			
			break;		
		/*--------------------------------------------------*/
		case STATE_InfeedWaitStageCVOn:
			
			//IMPORTANT: following code is to rectify the issue w. blades not beeing raised if they are the first command for the row
			//Root cause: row puhser will lower all blades; so previous action of the command to raise blade will be cleared
			//this code rectifies this issue
			//keep checking if pusher will get back home
			if(gCtrl.rowforming.isRowPusherAtHome && !pssm->event[1]){
				//single shot > pusher is back home
				DBG(lgr,"INF RepatCmdAfterPusherBackHome");	
				pssm->event[2] = 1;
				//reexceute the same command
				bgSSMStateNext(pssm, STATE_InfeedExecuteCmd);				
			}
			pssm->event[1] = gCtrl.rowforming.isRowPusherAtHome;
			
			//keep checking is row forming cv is running?
			if( gCtrl.rowforming.hmiBtnOnOffStageCV ){
				bgSSMStateNext(pssm, STATE_InfeedExecuteCmd);								
				return;
			}		
			
			break;
		/*--------------------------------------------------*/
		case STATE_InfeedExecuteCmd:	
			
			if( bgSSMIsStateInit(pssm) ){
				//go row forming CV
				//ppRowFormingCV(1);
			}	
			
			//update target case/row/layer counts
			ppUpdateTargetCaseCounts();
				
			//execute a command from the current recipe - Case cmd
			ppExeCmdCase( ppGetCmdCase() );
			DBG(lgr,"INFcmdexe C=%d,R=%d,L=%d", gPallete.ctrlProc.cmdIdx, gPallete.ctrlProc.rowIdx, gPallete.ctrlProc.layerIdx);	
			//execute a command from the current recipe - Blade cmd
			ppExeCmdBlade( ppGetCmdBlade(), pssm->event[2]);
			pssm->event[2] = 0;

			bgSSMStateNext(pssm, STATE_InfeedWaitNextCase);
			break;
		/*--------------------------------------------------*/
		case STATE_InfeedWaitNextCase:	
			
			//keep checking for a request to finish the layer
			if( ppLYRIsManualFinishPalletGet() ){
				DBG(lgr,"INF ppINFIsManualFinishPalletGet");	
				ppLYRIsManualFinishPalletRst();
				
				//yes, this is also end of the layer > signal it
				ppLYRLayerEndEventSet();
				
				//yes, this is also end of the pallet > signal it
				ppLYRPalletEndEventSet();
					
				//set flag for manual pallet exit > as a result, elevator shall go all the way to the top
				ppLYRManualEndEventSet();
				
				//reset all program execution indexes > start building a new pallete
				ppReset();
				
				//goto layer/pallet complete
				bgSSMStateNext(pssm, STATE_InfeedRowComplete);					
				break;
			}
			
			//keep checking is stage cv is running?
			if( !gCtrl.rowforming.hmiBtnOnOffStageCV ){
				bgSSMStateNext(pssm, STATE_InfeedWaitStageCVOn);								
				return;
			}

			//IMPORTANT: following code is to rectify the issue w. blades not beeing raised if they are the first command for the row
			//Root cause: row puhser will lower all blades; so previous action of the command to raise blade will be cleared
			//this code rectifies this issue
			//keep checking if pusher will get back home
			if(gCtrl.rowforming.isRowPusherAtHome && !pssm->event[1]){
				//single shot > pusher is back home
				DBG(lgr,"INF RepatCmdAfterPusherBackHome");	
				pssm->event[2] = 1;
				//reexceute the same command
				bgSSMStateNext(pssm, STATE_InfeedExecuteCmd);				
			}
			pssm->event[1] = gCtrl.rowforming.isRowPusherAtHome;
			
			//keep waiting for next case
			if( !ppIsNextCase() && !pssm->event[3]){
				return;
			}
			//reset event that indicates restarting w. row full of cases
			pssm->event[3] = 0;
			
			if(!gPallete.ctrlProc.cmdIdx && !gPallete.ctrlProc.layerIdx && !gPallete.ctrlProc.rowIdx){
				gPallete.ctrlProc.oPalletStart = 1;//generate pallet start signal	
			}
			
			//generate case event
			gPallete.ctrlProc.oCaseDN = 1;
			gPallete.ctrlProc.oCurrentCases++;
			
			//increment current case counter
			ppNextCommand();
							
			//Evaluate current command
			if( ppGetCmdCase() ){
				//more cases within the current row > execute next cmd
				bgSSMStateNext(pssm, STATE_InfeedExecuteCmd);
				return;
			}
		
			gPallete.ctrlProc.oRowDN = 1;
			//End of the row! (cmd=0 indicates end of row)
			
			//generate end of row event
			gPallete.ctrlProc.oRowDN = 1;
			gPallete.ctrlProc.oRowIdxDN = gPallete.ctrlProc.rowIdx;
			
			ppNextRow();//increment row
						
			//check if this is also end of layer
			if( ppLYRLayerEndEventCheck() == 0){			
				//yes, this is also end of the layer > signal it
				ppLYRLayerEndEventSet();
						
				//generate end of layer event
				gPallete.ctrlProc.oLayerDN = 1;
				gPallete.ctrlProc.oLayerIdxDN = gPallete.ctrlProc.layerIdx;
			
				ppNextLayer();//increment layer	
			}
			
			//check if this is also end of pallet 
			if( ppLYRPalletEndEventCheck() == 0){
				//yes, this is also end of the pallet > signal it
				ppLYRPalletEndEventSet();	
			
				//generate end of pallet event
				gPallete.ctrlProc.oPalletDN = 1;
			
				//reset all program execution indexes > start building a new pallete
				ppReset();
			}
			
			//bgSSMStateNext(pssm, STATE_InfeedRowComplete);
			bgSSMStateNext(pssm, STATE_InfeedRowComplete);							
			break;
		/*--------------------------------------------------*/
		case STATE_InfeedRowComplete:
			
			if( bgSSMIsStateInit(pssm) ){
			}
			ppINFRowEndEventSet();
			bgSSMStateNext(pssm, STATE_InfeedExecuteCmd);							
			break;
		/*--------------------------------------------------*/
		default:
			break;
		/*--------------------------------------------------*/
	}
}
/*
###############################################################################
Pallete Processor State Machine - Layer
-handles incoming cases and executes commands that are part of the 
pallete building recipe
-This routine is responsible for building a single pallete layer.
-Layer consist of multiple rows
-When all rows are pushed onto the transfer table this routine signal the ELV state machine to transfer the layer onto the pallet
###############################################################################
*/
static void ppSSMLayerCyclic()
{
	int currentState;
	static int resumeRequest;
	
	bgSSM_typ *pssm = &gPallete.ctrlProc.ssmLayer;
	
	if(!pssm)
		return;

	/*execute control state machine cyclic handler*/		
	if( bgSSMCyclic(pssm) ) return;
	
	
	//show change of state in a log
	if( bgSSMIsStateInit(pssm) ){
		DBG(lgr,"LYR sm=%s(%d)", bgSSMGetStateText(pssm), bgSSMGetState(pssm));
	}
	
	if((bgSSMGetState(pssm) > STATE_LayerIdle) && !gCtrl.main.modeAuto){
		//go row forming CV
		ppRowFormingCV(0);	
		
		if(bgSSMGetState(pssm) >= STATE_LayerRowComplete){
			//resume needed
			resumeRequest = 1;
			if(gCtrl.main.btnZero){
				ppLYRIsManualFinishPalletRst();
				ppLYRLayerEndEventRst();
				ppLYRPalletEndEventRst();
				ppLYRManualEndEventRst();
				bgSSMStateNext(pssm, STATE_LayerIdle);	
			}
		}else{
			//just reset
			bgSSMStateNext(pssm, STATE_LayerIdle);	
		}		
		return;
	}
	
	//workaround for resuming (retriggering) init of the state machine
	//this is needed in case machine gets stopped in the middle of the cycle
	currentState = bgSSMGetState(pssm);
	if(resumeRequest){
		ppSSMStateResumeAtInit(pssm);
	}
	resumeRequest = 0;
	switch( currentState ){
		/*--------------------------------------------------*/
		case STATE_LayerZero:
			bgSSMStateNext(pssm, STATE_LayerIdle);	
			break;
		/*--------------------------------------------------*/
		case STATE_LayerPowerUp:
			bgSSMStateNext(pssm, STATE_LayerIdle);	
			break;
		/*--------------------------------------------------*/
		case STATE_LayerIdle:		
			if ( ppIsAutoMode() ){
				bgSSMStateNext(pssm, STATE_LayerInit);	
			} 
			break;
		/*--------------------------------------------------*/
		case STATE_LayerInit:	

			bgSSMStateNext(pssm, STATE_LayerWaitRowComplete);	
						
			break;		
		/*--------------------------------------------------*/
		case STATE_LayerWaitRowComplete:
					
			if( bgSSMIsStateInit(pssm) ){
				//go row forming CV
				ppRowFormingCV(1);
				
				//go staging CV
				machCtrlStagingCV(1);					
			}
		
			//bgSSMStateNext(pssm, STATE_LayerRowComplete);
			if( ppINFRowEndEventGet() ){
				//ppINFRowEndEventRst();
				bgSSMStateNextTimeDelay(pssm, STATE_LayerRowComplete, (UDINT)(gPallete.palCfg.palSettings.timers.dlyLastCaseToRowCVStop * 1000));							
			}
			break;
		/*--------------------------------------------------*/
		case STATE_LayerRowComplete:
			
			if( bgSSMIsStateInit(pssm) ){
				//stop row forming CV
				ppRowFormingCV(0);
			}
			
			if( ppIsRowFormingCVStopped() ){
				//lower all blades once the CV stops
				ppBladeStopAllDown();					
			}
			
			//wait until allowed to push the row
			if( ppIsRowPushAllowed() && ppIsRowFormingCVStopped()){			
				ppBladeStopAllDown();					
				bgSSMStateNext(pssm, STATE_LayerRowPusherFwd);					
			}		
			break;
		/*--------------------------------------------------*/
		case STATE_LayerRowPusherFwd:		
			
			if( bgSSMIsStateInit(pssm) ){			
				//start row pushing fwd towards the table	
				ppRowPusherFwd();		
			}
					
			//wait for row pusher to extend
			if( ppIsRowPusherExtended() ){
				bgSSMStateNextTimeDelay(pssm, STATE_LayerRowPusherRet, (UDINT)(gPallete.palCfg.palSettings.timers.dlyPusherAtElevatorToRetract * 1000));					
			}
			break;
		/*--------------------------------------------------*/
		case STATE_LayerRowPusherRet:		
			
			if( bgSSMIsStateInit(pssm) ){				
				//reset the event NOTE: this event is used in two places!!!!
				ppINFRowEndEventRst();
				//retract row pusher	
				ppRowPusherRet();
			}
			
			//wait for row pusher to retract
			if( !ppIsRowPusherRetracted() ){
				return;
			}
		
			//end of the layer?
			if( !ppLYRLayerEndEventGet() ){
				bgSSMStateNext(pssm, STATE_LayerWaitRowComplete);
				return;
			}
		
			//Not only end of the row; it's also last row for this layer!
			bgSSMStateNext(pssm, STATE_LayerComplete);												
			
			break;
		/*--------------------------------------------------*/
		case STATE_LayerComplete:		
			
			if( bgSSMIsStateInit(pssm) ){
				//Reset events
				ppLYRLayerEndEventRst();
				//send signal to ELV SM that the layer is complete and shall be transfered to the pallete
				ppLYRtoELVSendLayerReadySignal();	
			}
			
			//end of the entire pallet?
			if( !ppLYRPalletEndEventGet() ){
				bgSSMStateNext(pssm, STATE_LayerWaitRowComplete);
				return;
			}
	
			ppLYRPalletEndEventRst();//reset event
			
			//ppReset();//reset all program execution parametars > start building a new pallete
			
			//pallete is complete! > send signal to ELV SM that the pallete is complete > the pallet shall be discharged
			ppLYRtoELVSendPalletReadySignal();			
			
			bgSSMStateNext(pssm, STATE_LayerWaitRowComplete);							
			break;				
		/*--------------------------------------------------*/
		default:
			break;
		/*--------------------------------------------------*/
	}
}
/*
###############################################################################
Pallete Processor State Machine - Elevator
-controls operation of the elevator and the transfer table during automatic
operation
-This routine is responsible for transfering a complete layer onto the pallete
-When all layers are dropped onto the pallet this routine signal the PALLET state machine to 
exit the pallet onto the discharge CV
###############################################################################
*/
static void ppSSMElevatorCyclic()
{
	
	bgSSM_typ *pssm = &gPallete.ctrlProc.ssmElevator;
	int currentState;
	static int resumeRequest;
	
	if(!pssm)
		return;

	/*execute control state machine cyclic handler*/		
	if( bgSSMCyclic(pssm) ) return;
	
	//show change of state in a log
	if( bgSSMIsStateInit(pssm) ){
		DBG(lgr,"ELV sm=%s(%d)", bgSSMGetStateText(pssm), bgSSMGetState(pssm));
	}

	if((bgSSMGetState(pssm) > STATE_ElevIdle) && !gCtrl.main.modeAuto){
		
		//bgSSMStateNext(pssm, STATE_ElevIdle);
		//ppSSMStateResumeAtInit(pssm);
		resumeRequest = 1;
		if(gCtrl.main.btnZero){
			
			ppELVIsPalletReadyRst();
			ppELVIsLayerReadyForPalleteRst();
			ppELVIsPalleteExitDoneRst();
			
			bgSSMStateNext(pssm, STATE_ElevIdle);	
		}
		return;
	}
	
	//workaround for resuming (retriggering) init of the state machine
	//this is needed in case machine gets stopped in the middle of the cycle
	currentState = bgSSMGetState(pssm);
	if(resumeRequest){
		ppSSMStateResumeAtInit(pssm);
				
		if(currentState == STATE_ElevVMoveToDrop){
			ppElevatorToPalleteTopResume();	
		}
		
		if(currentState == STATE_ElevMoveTableToDrop){
			ppTransferTableToPalleteResume();	
		}
		
		if(currentState == STATE_ElevWaitPalletExit){
			ppWaitPalletExitResume();	
		}
	}
	resumeRequest = 0;
	switch( currentState ){
		/*--------------------------------------------------*/
		case STATE_ElevZero:
			bgSSMStateNext(pssm, STATE_ElevIdle);	
			break;
		/*--------------------------------------------------*/
		case STATE_ElevPowerUp:
			bgSSMStateNext(pssm, STATE_ElevIdle);	
			break;
		/*--------------------------------------------------*/
		case STATE_ElevIdle:		
			if ( ppIsAutoMode() ){
				ppELVIsPalleteExitDoneRst();
				bgSSMStateNext(pssm, STATE_ElevReady);	
			} 
			break;
		/*--------------------------------------------------*/
		case STATE_ElevReady:
						
			if( ppIsLayerDropToPalletAllowed() && ppELVIsLayerReadyForPalleteGet() ){
				ppELVIsLayerReadyForPalleteRst();
				bgSSMStateNextTimeDelay(pssm, STATE_ElevVMoveToDrop, (UDINT)(gPallete.palCfg.palSettings.timers.dlyTableLayerRdyToElevMove * 1000));					
			}
			break;
		/*--------------------------------------------------*/
		case STATE_ElevVMoveToDrop:
			
			if( bgSSMIsStateInit(pssm) ){
				ppElevatorToPalleteTop();
				pssm->counter[0] = 0;
			}
			
			if( gCtrl.transfertable.hmiBtnTableFwd && gCtrl.retainerbar.barIsUp && !pssm->counter[0]){
				//start the retainer bar go down timer
				bgTimerStart(&pssm->timer_x1ms[0], (UDINT)    (gPallete.palCfg.palSettings.timers.dlyTableAtPalleteToRetBar * 1000.0) );
				pssm->counter[0] = 1;
			}							

			//lower the bar as soon as the dly timer expires
			if( (pssm->counter[0] == 1) && bgTimerIsTimeOut( &pssm->timer_x1ms[0] ) ){
				//
				pssm->counter[0] = 2;
				DBG(lgr,"ELV: RetBar down early.");
				//lower retainer bar
				ppRetainerBarDown();						
			}
			
			if( ppIsElevatorAtPalleteTop() ){
				bgSSMStateNext(pssm, STATE_ElevMoveTableToDrop);					
			}		
			break;
		/*--------------------------------------------------*/
		case STATE_ElevMoveTableToDrop:
			
			if( bgSSMIsStateInit(pssm) ){
				ppTransferTableToPallete();
			}
						
			if( ppIsTransferTableAtPallete() ){
				bgSSMStateNext(pssm, STATE_ElevRetBarDown);					
			}			
			break;
		/*--------------------------------------------------*/
		case STATE_ElevRetBarDown:
			
			if( bgSSMIsStateInit(pssm) ){
				//extend squaring plates
				ppSquaringPlatesExtRet(1);//extend
			
				//lower retainer bar
				ppRetainerBarDown();				
			}
			
			if( ppIsRetainerBarDown() && gCtrl.elevator.elevatorIsAtPalleteBelowHome){
				//Start moving back to grouping (i.e. drop the layeron top of the pallet) ONLY
				//when the elevagtor is ABOVE the PALLET (see flag elevatorIsAtPalleteBelowHome)ollows
				bgSSMStateNextTimeDelay (pssm, STATE_ElevTableToGrouping, (UDINT)(gPallete.palCfg.palSettings.timers.onDlyTableToGrouping * 1000));									
			}		
			break;
		/*--------------------------------------------------*/
		case STATE_ElevTableToGrouping:
			
			if( bgSSMIsStateInit(pssm) ){
				ppTransferTableToGrouping();
			}
			
			if( ppIsTransferTableAtGrouping() ){
				//retract squaring plates
				ppSquaringPlatesExtRet(0);//retract
			
				//raise retainer bar
				ppRetainerBarUp();				
				
				if( ppELVIsPalletReadyGet() && gCtrl.squaring.frontSquaringEquipped){
					//if front squaring is present, elevator must be at the top of the pallete in oreder to exit the pallet!!!
					bgSSMStateNext(pssm, STATE_ElevVMoveToAbovePallete);							
				}else{
					//move elevator to grouping
					bgSSMStateNext(pssm, STATE_ElevVMoveToGrouping);				
				}			
			}		
			break;
		/*--------------------------------------------------*/
		case STATE_ElevVMoveToGrouping:
			
			if( bgSSMIsStateInit(pssm) ){
				ppElevatorToGrouping();
			}
			
			if( ppIsElevatorAtGrouping() ){
			
				if(!gCtrl.squaring.frontSquaringEquipped && ppELVIsPalletReadyGet() ){
					ppELVtoPALSendPalletReadySignal();
				}
			
				ppELVIsPalletReadyRst();
				
				bgSSMStateNext(pssm, STATE_ElevReady);																	
			}
			break;
		/*--------------------------------------------------*/
		case STATE_ElevVMoveToAbovePallete:
			
			if( bgSSMIsStateInit(pssm) ){
				//if manual pallet complete request, send elevator to the top before exiting pallet
				if( ppLYRManualEndEventGet() ){
					ppElevatorToTopPosition();				
				}else{
					ppElevatorAbovePalleteTop();				
				}
			}
			
			//if( ppIsElevatorAbovePalleteTop() ){
			if( (!ppLYRManualEndEventGet() && ppIsElevatorAbovePalleteTop()) || (ppLYRManualEndEventGet() && ppIsElevatorIsAtTop()) ){
			
				//reset manual request
				ppLYRManualEndEventRst();
			
				if( ppELVIsPalletReadyGet()  ){
					ppELVtoPALSendPalletReadySignal();
				}
			
				ppELVIsPalletReadyRst();
			
				bgSSMStateNext(pssm, STATE_ElevWaitPalletExit);																	
			}	
			break;		
		/*--------------------------------------------------*/
		case STATE_ElevWaitPalletExit:
			
			if( bgSSMIsStateInit(pssm) ){				
			}
			
			if( ppELVIsPalleteExitDoneGet() ){
				ppELVIsPalleteExitDoneRst();
				bgSSMStateNext(pssm, STATE_ElevVMoveToGrouping);																	
			}	
			break;		
		/*--------------------------------------------------*/
		default:
			break;
	}
}
/*
###############################################################################
Pallete Processor State Machine - Pallete
-controls operation of the pallet exit and discharge from the machine
-recives signal from ELV sm
-sends signal back to ELV sm
###############################################################################
*/
static void ppSSMPalleteCyclic()
{
	
	bgSSM_typ *pssm = &gPallete.ctrlProc.ssmPallete;
	int currentState;
	static int resumeRequest;
	
	if(!pssm)
		return;

	/*execute control state machine cyclic handler*/		
	if( bgSSMCyclic(pssm) ) return;
	
	//show change of state in a log
	if( bgSSMIsStateInit(pssm) ){
		DBG(lgr,"PAL sm=%s(%d)", bgSSMGetStateText(pssm), bgSSMGetState(pssm));
	}

	if((bgSSMGetState(pssm) > STATE_PalleteIdle) && !gCtrl.main.modeAuto){
		
		//bgSSMStateNext(pssm, STATE_ElevIdle);
		//ppSSMStateResumeAtInit(pssm);
		resumeRequest = 1;
		if(gCtrl.main.btnZero){			
			bgSSMStateNext(pssm, STATE_PalleteIdle);	
		}
		return;
	}
	
	//workaround for resuming (retriggering) init of the state machine
	//this is needed in case machine gets stopped in the middle of the cycle
	currentState = bgSSMGetState(pssm);
	if(resumeRequest){
		ppSSMStateResumeAtInit(pssm);				
	}
	resumeRequest = 0;	
	
	
	switch( bgSSMGetState(pssm) ){
		/*--------------------------------------------------*/
		case STATE_PalleteZero:
			bgSSMStateNext(pssm, STATE_PalletePowerUp);	
			break;
		/*--------------------------------------------------*/
		case STATE_PalletePowerUp:
			bgSSMStateNext(pssm, STATE_PalleteIdle);	
			break;
		/*--------------------------------------------------*/
		case STATE_PalleteIdle:		
			if ( ppIsAutoMode() ){
				ppPALIsPalletReadyRst();
				gMessages.msgActive[APP_MSG_DISCHARGE_BLOCKED] = 0;
				bgSSMStateNext(pssm, STATE_PalleteInit);	
			} 
						
			break;
		/*--------------------------------------------------*/
		case STATE_PalleteInit:							
			
			if( ppPALIsPalletReadyGet() ){
				DBG(lgr,"PAL LayerComplete!");
				ppPALIsPalletReadyRst();
				
				//Pallete is complete!	
				ppStatisticsPalletCountIncrement();
				bgSSMStateNext(pssm, STATE_PalleteExitRequest);
			}
			break;
		/*--------------------------------------------------*/
		case STATE_PalleteExitRequest:							
			
			if( ppIsPalleteExitAllowed() ){
				DBG(lgr,"PAL LayerComplete! Exit now.");
				ppReqPalletExit();
				gMessages.msgActive[APP_MSG_DISCHARGE_BLOCKED] = 0;
				bgSSMStateNext(pssm, STATE_PalleteExitIP);
			}else{
				gMessages.msgActive[APP_MSG_DISCHARGE_BLOCKED] = 1;
			}	
			break;
		/*--------------------------------------------------*/
		case STATE_PalleteExitIP:										
			if( ppIsPalletExitDN() ){
				ppPALtoELVSendPalleteExitDone();
				bgSSMStateNext(pssm, STATE_PalleteInit);
			}			
			break;
		/*--------------------------------------------------*/
		default:
			break;
	}
}

static void ppClearCaseCounts(){

	if(!gCtrl.main.btnClearCaseCounts){
		return;
	}
	
	gCtrl.main.btnClearCaseCounts = 0;
	
	gPallete.ctrlProc.cmdIdx = 0;
	gPallete.ctrlProc.layerIdx = 0;
	gPallete.ctrlProc.rowIdx = 0;
	
	gPallete.ctrlProc.oCurrentCases = 0;
	
	
	gPallete.ctrlProc.ssmElevator.stateNext = STATE_ElevZero;
	gPallete.ctrlProc.ssmPallete.stateNext = STATE_PalleteZero;
	gPallete.ctrlProc.ssmLayer.stateNext = STATE_LayerZero;
	
	//reset all events
	ppINFRowEndEventRst();
	
	ppLYRLayerEndEventRst();
	ppLYRPalletEndEventRst();
		
	ppELVIsLayerReadyForPalleteRst();
	ppELVIsPalleteExitDoneRst();
	
	ppPALIsPalletReadyRst();	
}
/*
###############################################################################
Infeed Case Logic
###############################################################################
*/



static void ppSSMInfeedCVCyclic()
{
	int currentState;
	static int resumeRequest;
	
	bgSSM_typ *pssm = &gCtrl.infeedcv.ssmInfeedCV;
	
	if(!pssm)
		return;

	static BOOL ee4Prev;
	//static BOOL stopRequest;
	UDINT delayTimeXms=3000;
	
	int caseInPosEdge = 0;
	int caseInNegEdge = 0;
	int caseOutPosEdge = 0;
	int caseOutNegEdge = 0;
	int formingCVRunPosEdge = 0;
	int formingCVRunNegEdge = 0;
	
	//Input Signal processing
	//================================================================
	//define in & out sensors
	gCtrl.infeedcv.caseInSensor = gMachineIO.din.ProductAtInfeed_EE2;	
	
	//front edge of the EE4 > set Out sensor value to 1
	if(gMachineIO.din.ProductAtStage_EE4 && !ee4Prev){
		gCtrl.infeedcv.caseOutSensor = 1;
	}	
	//if Out sensor is 1, reset it when EE4=0 AND StageCV is moving!
	//if(gCtrl.infeedcv.caseOutSensor && !gMachineIO.din.ProductAtStage_EE4 && (gCtrl.main.modeManual || gCtrl.rowforming.hmiBtnOnOffStageCV)){
	if(gCtrl.infeedcv.caseOutSensor && !gMachineIO.din.ProductAtStage_EE4 && (bgSSMGetState(pssm) == STATE_InfeedCVAuto) /**GB ADD!!!*/ && machCtrlIsRowFormingCVRunning()){
		gCtrl.infeedcv.caseOutSensor = 0;
	}	
	if(gCtrl.main.btnZero){
		gCtrl.infeedcv.caseAtOneCaseOnlySection = 0;
			gCtrl.infeedcv.caseOutSensor = 0;		
	}
	ee4Prev = gMachineIO.din.ProductAtStage_EE4;
	//gCtrl.infeedcv.caseOutSensor = gMachineIO.din.ProductAtStage_EE4;
	
	//edge detection - in sensor
	caseInPosEdge = gCtrl.infeedcv.caseInSensor	& !gCtrl.infeedcv.caseInSensorPosEdge;
	caseInNegEdge = !gCtrl.infeedcv.caseInSensor & gCtrl.infeedcv.caseInSensorNegEdge;
	gCtrl.infeedcv.caseInSensorPosEdge = gCtrl.infeedcv.caseInSensor;
	gCtrl.infeedcv.caseInSensorNegEdge = gCtrl.infeedcv.caseInSensor;
		
	//edge detection - out sensor
	caseOutPosEdge = gCtrl.infeedcv.caseOutSensor	& !gCtrl.infeedcv.caseOutSensorPosEdge;
	caseOutNegEdge = !gCtrl.infeedcv.caseOutSensor & gCtrl.infeedcv.caseOutSensorPosEdge;
	gCtrl.infeedcv.caseOutSensorPosEdge = gCtrl.infeedcv.caseOutSensor;
	gCtrl.infeedcv.caseOutSensorNegEdge = gCtrl.infeedcv.caseOutSensor;
	
	//infeed cv motor control
	gMachineIO.dout.ProductInfeedCV_M6 = gCtrl.infeedcv.hmiBtnOnOff & gCtrl.main.noFaults;
	if(!gCtrl.main.noFaults){
		gMachineIO.dout.ProductInfeedCV_M6 = 0;
		gCtrl.infeedcv.hmiBtnOnOff = 0;
	}
		
	//forming CV pos/neg edge
	formingCVRunPosEdge = machCtrlIsRowFormingCVRunning() && !gCtrl.infeedcv.rowFormingCVRunPosEdge;
	formingCVRunNegEdge = !machCtrlIsRowFormingCVRunning() && gCtrl.infeedcv.rowFormingCVRunNegEdge;
	gCtrl.infeedcv.rowFormingCVRunPosEdge = machCtrlIsRowFormingCVRunning();
	gCtrl.infeedcv.rowFormingCVRunNegEdge = machCtrlIsRowFormingCVRunning();
	
	//Timers
	bgTimerCyclic(&gCtrl.infeedcv.tmrInfeedStopDly);
	
	
	
	//Input Signal processing
	//================================================================
	
	
	/*execute control state machine cyclic handler*/		
	if( bgSSMCyclic(pssm) ) return;
	
	//show change of state in a log
	if( bgSSMIsStateInit(pssm) ){
		DBG(lgr,"ICVsm=%s(%d)", bgSSMGetStateText(pssm), bgSSMGetState(pssm));
	}
	
	if((bgSSMGetState(pssm) > STATE_InfeedCVIdle)){
	}
	
	//workaround for resuming (retriggering) init of the state machine
	//this is needed in case machine gets stopped in the middle of the cycle
	currentState = bgSSMGetState(pssm);
	if(resumeRequest){
		ppSSMStateResumeAtInit(pssm);
	}
	resumeRequest = 0;
	switch( currentState ){
		/*--------------------------------------------------*/
		case STATE_InfeedCVZero:			
			bgSSMStateNext(pssm, STATE_InfeedCVIdle);	
			break;
		/*--------------------------------------------------*/
		case STATE_InfeedCVPowerUp:
			bgSSMStateNext(pssm, STATE_InfeedCVIdle);	
			break;
		/*--------------------------------------------------*/
		case STATE_InfeedCVIdle:							
			if ( ppIsAutoMode() ){
				gCtrl.infeedcv.stopRequest = 0;
				//ee4Prev = 0; //clear prev state in order to detect if the sensor is blocked when starting auto mode
				bgSSMStateNext(pssm, STATE_InfeedCVInitAuto);	
			} 						
			break;
		/*--------------------------------------------------*/
		case STATE_InfeedCVInitAuto:		
			//ee4Prev = 0; //clear prev state in order to detect if the sensor is blocked when starting auto mode
			bgSSMStateNext(pssm, STATE_InfeedCVAuto);				
			break;		
		/*--------------------------------------------------*/
		case STATE_InfeedCVAuto:	

			if( bgSSMIsStateInit(pssm) ){
				gCtrl.infeedcv.caseAtOneCaseOnlySection = 0;//GB Not allowed after restart; problem w. double count!!!
				if(gCtrl.infeedcv.caseAtOneCaseOnlySection){
					DBG(lgr,"ICV=restartYESCaseInbetween");	
				}else{
					DBG(lgr,"ICV=restartNOCaseInbetween");	
					machCtrlInfeedCV(1);//start infeed cv
				}
				machCtrlStagingCV(1);//start staging cv
				
				//when restarting, set the caseOutSensor based on the PE
				if(gMachineIO.din.ProductAtStage_EE4){
					gCtrl.infeedcv.caseOutSensor = 1;
				}else{
					gCtrl.infeedcv.caseOutSensor = 0;				
				}	
				
			
				if(/*gCtrl.infeedcv.caseInSensor ||*/ gCtrl.infeedcv.caseOutSensor){//is case at the infeed or stage (outfeed) sensor
					DBG(lgr,"ICV=Case@1CaseONINI");	
					gCtrl.infeedcv.caseAtOneCaseOnlySection = 1;		
					machCtrlInfeedCV(0);//stop infeed cv
				}
			}
			
			//register case when it enters critical section (betwen In and Out sensor)
			if(!gCtrl.infeedcv.caseAtOneCaseOnlySection && caseInNegEdge){
				DBG(lgr,"ICV=Case@1CaseON");	
				gCtrl.infeedcv.caseAtOneCaseOnlySection = 1;
			}

			//if case is already in critical section, next case at the input must not be allowed to proceed	> stop the infeed CV
			if(gCtrl.infeedcv.caseAtOneCaseOnlySection && caseInPosEdge){
				DBG(lgr,"ICV=stopInfCV>CaseSpacing");	
				machCtrlInfeedCV(0);//stop infeed cv
			}
					
			//when case exist at the Out sensor 
			//if case detected at the Out sensor without one beeing detected at In sensor > fault
			//IMPORTANT: This must be placed before the next line
			if(!gCtrl.infeedcv.caseAtOneCaseOnlySection && caseOutNegEdge){
				DBG(lgr,"ICV=fault>INFEED_CASE_COUNT");	
				gAlarms.alarmActive[APP_ALARM_INFEED_CASE_COUNT] = 1;
			}
			
			//when case exist at the Out sensor 
			if(gCtrl.infeedcv.caseAtOneCaseOnlySection && caseOutNegEdge){
				DBG(lgr,"ICV=caseInfeedDone(%d)", cycleCounter - cycleCounterOld);
				cycleCounterOld = cycleCounter;
				gCtrl.infeedcv.caseAtOneCaseOnlySection = 0;
				gCtrl.infeedcv.caseInfeedDone = 1;//signal that the case is moved into the row forming area
				if(gCtrl.infeedcv.stopRequest){
					DBG(lgr,"ICV=stoppingDly");	
					bgSSMStateNextTimeDelay(pssm, STATE_InfeedCVExitAuto, delayTimeXms);										
				}else{
					DBG(lgr,"ICV=startICV");	
					machCtrlInfeedCV(1);//restart infeed cv
				}	
			}
						
			//monitor row forming CV > if it turns on, make sure stage CV turns on as well
			if( formingCVRunPosEdge && !machCtrlIsStagingCVRunning()){
				DBG(lgr,"ICV=formCV+Edge>StageCVON");	
				machCtrlStagingCV(1);//start staging cv	
			}
			
			//when row forming CV is not running, stage the case at the Out sensor
			//if( !machCtrlIsRowFormingCVRunning() && gCtrl.infeedcv.caseAtOneCaseOnlySection && gCtrl.infeedcv.caseOutSensor && machCtrlIsRowStageCVOn()){
			//if( ppINFRowEndEventGet() && gCtrl.infeedcv.caseAtOneCaseOnlySection && gCtrl.infeedcv.caseOutSensor && machCtrlIsRowStageCVOn()){
			if( (ppINFRowEndEventGet() || !gCtrl.rowforming.isRowPusherAtHome) && gCtrl.infeedcv.caseAtOneCaseOnlySection && gCtrl.infeedcv.caseOutSensor && machCtrlIsRowStageCVOn()){
				DBG(lgr,"ICV=case@Stage>stopCV");	
				machCtrlStagingCV(0);//stop staging cv					
			}
			
			//register stop machine request
			if( !gCtrl.main.modeAuto && !gCtrl.infeedcv.stopRequest){
				DBG(lgr,"ICV=stopReq");	
				gCtrl.infeedcv.stopRequest = 1;
				bgTimerStart(&gCtrl.infeedcv.tmrInfeedStopDly, 2000);//2 sec delay t
			}	
			
			
			//if stop requested && no case at infeed > stop infeed
			if(gCtrl.infeedcv.stopRequest && !gCtrl.infeedcv.caseInSensor && machCtrlIsInfeedCVOn() ){
				DBG(lgr,"ICV=stopReq>stopINF");	
				machCtrlInfeedCV(0);//stop infeed cv		
			}
						
			//not in auto mode any longer (and no alarm means normal stop request) > wait for case to exit before switching to manual mode
			if( (!gCtrl.main.modeAuto && !gCtrl.infeedcv.caseAtOneCaseOnlySection && !gAlarms.oIsAlarmActive) ||
			    (gCtrl.infeedcv.stopRequest && bgTimerIsTimeOut(&gCtrl.infeedcv.tmrInfeedStopDly) )){
				DBG(lgr,"ICV=stopReq>ExitAuto");	
				bgSSMStateNext(pssm, STATE_InfeedCVExitAuto);					
			}
			
			if(!gCtrl.main.modeAuto && gAlarms.oIsAlarmActive){
				bgSSMStateNext(pssm, STATE_InfeedCVExitAuto);					
			}						
			break;		
		/*--------------------------------------------------*/
		case STATE_InfeedCVExitAuto:			
			gAlarms.alarmActive[APP_ALARM_INFEED_CASE_COUNT] = 0;
			machCtrlInfeedCV(0);//stop infeed cv
			machCtrlStagingCV(0);//stop staging cv			
			bgSSMStateNext(pssm, STATE_InfeedCVIdle);					
			break;		
		/*--------------------------------------------------*/
		default:
			break;
		/*--------------------------------------------------*/
	}
}
	

/*
###############################################################################
Machine statics
###############################################################################
*/
static void	ppStatistics()
{
	UDINT elapsed_mSecs;
	UDINT elapsed_Secs;
	
	gStats.runningTmr1.IN = gCtrl.main.modeAuto;
	bgTimerCyclic(&gStats.runningTmr1);
	
	gStats.runningTmr1min.IN = gCtrl.main.modeAuto;
	bgTimerCyclic(&gStats.runningTmr1min);
	
	gStats.runningTmr1sec.IN = gCtrl.main.modeAuto;
	bgTimerCyclic(&gStats.runningTmr1sec);

	gStats.palletTmr.IN = gCtrl.main.modeAuto;
	bgTimerCyclic(&gStats.palletTmr);
	
	if( bgTimerIsTimeOut(&gStats.runningTmr1sec) ){
		bgTimerStart(&gStats.runningTmr1sec, 1000);
	}
		
	if(gPallete.ctrlProc.oCaseDN){
		gStats.mCasesPerMinCounter++;
	}
	if( bgTimerIsTimeOut(&gStats.runningTmr1min) ){
		gStats.casesPerMin = gStats.mCasesPerMinCounter;
		gStats.mCasesPerMinCounter = 0;
		bgTimerStart(&gStats.runningTmr1min, 1000 * 60);
	}
	
	if(gStats.btnResetCounts){
		gStats.btnResetCounts = 0;
		gStats.caseCounter = 0;
		gStats.palletCounter = 0;
		bgTimerStart(&gStats.runningTmr1, 1000 * 60 * 60 * 24 * 100);		
	}

	if(gStats.btnResetCountsTotal){
		gStats.btnResetCountsTotal = 1;
		gStats.caseCounterTotal = 0;
		gStats.palletCounterTotal = 0;
	}
	
	//measure pallet time
	if(gPallete.ctrlProc.oPalletStart){
		bgTimerStart(&gStats.palletTmr, 10000000);		
	}

	//measure pallet time
	if(gPallete.ctrlProc.oPalletStart){
		bgTimerStart(&gStats.palletTmr, 10000000);		
	}
	if(gPallete.ctrlProc.oPalletDN){
		gStats.palletTimeLast = bgTimerTimeElapsed(&gStats.palletTmr) / 1000;		
	}
	
	elapsed_mSecs = bgTimerTimeElapsed(&gStats.runningTmr1);
	elapsed_Secs = elapsed_mSecs / 1000;
		
	gStats.runTmrSec = elapsed_Secs % 60;
	gStats.runTmrMins = (elapsed_Secs / 60) % 60;
	gStats.runTmrHours = (elapsed_Secs / (60 * 60));
		
}

/*
###############################################################################
Init & Cyclic
###############################################################################
*/
void _INIT palleteProcessorInit(void)
{
	bgSSM_typ *pssm;
	
	/* TODO: Add code here */
	DBGINIT(lgr, log, LOG_ENTRY_COUNT, LOG_ENTRY_LENGTH);

	pssm = &gCtrl.infeedcv.ssmInfeedCV;
	bgSSMInit(pssm, (UDINT)getppInfeedCVStateName, 0);
	DBG(lgr,"ICV sm=%s(%d)", bgSSMGetStateText(pssm), bgSSMGetState(pssm));
	
	pssm = &gPallete.ctrlProc.ssmInfeed;
	bgSSMInit(pssm, (UDINT)getppInfeedStateName, 0);
	DBG(lgr,"INF sm=%s(%d)", bgSSMGetStateText(pssm), bgSSMGetState(pssm));
	
	pssm = &gPallete.ctrlProc.ssmLayer;
	bgSSMInit(pssm, (UDINT)getppLayerStateName, 0);
	DBG(lgr,"LYR sm=%s(%d)", bgSSMGetStateText(pssm), bgSSMGetState(pssm));

	pssm = &gPallete.ctrlProc.ssmElevator;
	bgSSMInit(pssm, (UDINT)getppElevatorStateName, 0);
	DBG(lgr,"ELV sm=%s(%d)", bgSSMGetStateText(pssm), bgSSMGetState(pssm));
	
	pssm = &gPallete.ctrlProc.ssmPallete;
	bgSSMInit(pssm, (UDINT)getppPalleteStateName, 0);
	DBG(lgr,"PAL sm=%s(%d)", bgSSMGetStateText(pssm), bgSSMGetState(pssm));
	
	gPallete.palCfg.palDimensions.caseHeight = 12.0;
}

//============================================================================
void _CYCLIC palleteProcessorCyclic(void)
{
	/* TODO: Add code here */
	//machCtrlInfeedCaseLogic();
	ppSSMInfeedCVCyclic();
	ppSSMInfeedCyclic();
	ppSSMLayerCyclic();
	ppSSMElevatorCyclic();
	ppSSMPalleteCyclic();
	ppClearCaseCounts();
	ppStatistics();
	
	cycleCounter++;
	
}
//============================================================================
//EOF
