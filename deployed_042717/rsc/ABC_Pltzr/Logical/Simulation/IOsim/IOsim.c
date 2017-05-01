/********************************************************************
 * COPYRIGHT -- Gainco
 ********************************************************************
 * Program: IO
 * File: IO.c
 * Author: DavidT
 * Created: July 13, 2010
 ********************************************************************
 * Implementation of program IO
 ********************************************************************/

#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif

#include <..\globalvar.h>
#include <..\..\GlobalDef.h>
#include <..\..\GlobalDecl.h>
//#include "..\\..\\RecFIFO\\fifotest\\fifoif.h"
#include "..\\..\\bglib\\bgsprintf.h"
#include "..\\..\\bglib\\bgsprintf.c"

_LOCAL  BOOL   _inZeroSensor; //n-1 value
_LOCAL  BOOL   _inBeltFlite;  //n-1 value

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
 DBG(lgr, "This is log example. %d ", value1);
 To complety disable logging from this source file, change next line to: #if 0
IMPORTANT:
==========
DBGINIT() statement MUST BE PLACED as a first statement within the task _INIT function!
Example:
void _INIT myTaskINIT(void)
{
	//TODO: Add code here
	//init logger object
	DBGINIT(lgr, log, LOG_ENTRY_COUNT, LOG_ENTRY_LENGTH);
}
*/
#if 1
#include <../../bglib/bgPVLogger.c>
#define LOG_ENTRY_COUNT 20	//max number of log entries
#define LOG_ENTRY_LENGTH  32 //max length of individual log message. Longer msg are truncated
_LOCAL STRING log[LOG_ENTRY_COUNT][LOG_ENTRY_LENGTH]; //log output visible from Automation Studio!
static bgPVLogger_typ lgr;	//PV logger object
#else
#define DBG(loggerInstance, format, args...) ;
#define DBGINIT(loggerInstance, logoutput, logEntryCount, logEntrySize)  ;
#endif


#define TK_CYCLE_TIME_Xms 0.01
#define TK_CYCLE_TIME_counts 10
//stage hopper gate control functions for all hoppers
static void stageHoppersGatesClose()
{
	int i;
	for (i=0; i<Config.Cfg_NumTakeoffs; i++)
	{
		Stage[i] = 1;//1 (energized) keeps the gates closed
	}
}

static void stageHoppersGatesOpen()
{
	int i;
	for (i=0; i<Config.Cfg_NumTakeoffs; i++)
	{
		Stage[i] = 0; //0 (not energized) keeps the gates open
	}
}


static BOOL isQCRequiredCurrentStation()
{
	if (QCbypass[OutfeedStation-1] || ((qc[0].QCLoginedIn == 0) && (qc[1].QCLoginedIn == 0)) )
		return 0;//not required when: not request by the HMI and both QC station are not logged in
	
	return 1;
}

//Find if QC required for the pocket that's going to be dropped next into the outfeed hopper
//OutfeedStation contains number (i.e. 1..16) of the outfeed station that's currently beeing
//dumped into the outfeed hopper (note that it starts with 1 not with 0!)
//
static BOOL isQCRequiredNextStation()
{
int outfeedStationIndexCurrent;
int outfeedStationIndexNext;

	//if OutfeedStation == 0 > no dumping into the outfeed, we are in the search for 
	//zero tab > nothing to do
	if(!OutfeedStation)
		return 0;
		
	//find index (0 based) of the station beeing dumped into the outfeed hopper	
	outfeedStationIndexCurrent = OutfeedStation - 1;

	
	//check if station that's comming next shall be QC-ed	
	if(outfeedStationIndexCurrent){
		outfeedStationIndexNext = outfeedStationIndexCurrent - 1;
		if (QCbypass[outfeedStationIndexNext] || (qc[0].QCLoginedIn == 0) )
			return 0;
	}
	
	//note that for the last station (i.e. OutfeedStation==1), the next station # is Config.Cfg_NumTakeoffs	
	if(!outfeedStationIndexCurrent){
		outfeedStationIndexNext = Config.Cfg_NumTakeoffs - 1;	
		if (QCbypass[outfeedStationIndexNext] || (qc[0].QCLoginedIn == 0) )
			return 0;
	}

	return 1;	
}

//q - qc station index (0 or 1)
static BOOL isQCInspectionActive(int q)
{
	//check if QC inspection is active
	if (qc[q].QCStarted && qc[q].QCLoginedIn)
		return 1;
	
	return 0;
}

static BOOL isQCLogged_NotStarted(int q)
{
	//check if QC inspection is active
	if (!qc[q].QCStarted && qc[q].QCLoginedIn)
		return 1;
	
	return 0;
}

//Advance outfeed to the next station
static void outfeedAdvance()
{						
	QCselect[0] = 0;
	QCselect[1] = 0;
	if (OutfeedStation == 1)
	{
		ZeroFlag = 0;
		OutfeedStation = 0;
		outstate = 12;
	}
	else
	{
		BeltClutch = 1;  
		OutfeedStation--;
		outstate++;
	}												

}

//Detect if stopping/pausing outfeed is allowed
static BOOL isOutfeedPauseBlocked()
{
	//Don't allow stop (pause) outfeed SM while belt clutch is on during product indexing
	//That way, we'll avoid a problem with partial dumping of the bin/station content (i.e. if 
	//indexing stopped when some product dropped and some product remains in the pocket)
	if( (outstate >= 9) && (outstate <= 11) && BeltClutch )
		return 1; //if above states are active and the belt clutch is on > that's indexing. Don't allow STOP to take place

	//Don't allow stop/pause when the first pocket to be dropped is about to reach the desitnation
	//state 8 is active afer product is dropped onto the belt, until the lead pocket gets dropped into the outfeed hopper 
	if( (outstate == 8) && (ZtoDump >= FlightCounter))
		return 1;
		
	return 0;
}


//Process MasterMode signal and control outfeed state machine
//based upon MasterMode changes
static BOOL outfeedMasterModeLogic()
{
static BOOL _BeltClutch;
static DINT _pauseOperation;
int   i,j;
	
	//process MasterMode changes
	if (MasterMode != _MasterMode)  
	{
		//Previos mode
		switch (_MasterMode)
		{	
			case RUN_MODE:
				_BeltClutch = BeltClutch;//preserve belt clutch state when leaving RUN mode
			break;
		}	
	
		//New mode
		switch (MasterMode)
		{
			case STOP_MODE:
				//check if stop/pause is allowed
				if( isOutfeedPauseBlocked() ){
					//pause is blocked, can't switch to stopped mode! wait here until it gets unblocked (i.e. belt turns off)
					//when exiting here, _MasterMode does not get updated. As a result, we'll keep 
					//comming back to this point until pause gets unblocked
					return 0;//make sure outfeed SM continues execution!!!				
				}
					
				//entering STOP mode from any other state
				//_BeltClutch = BeltClutch;//preserve belt clutch state
				BeltClutch  = 0;//stop belt
				//NOTE: SM stops executing in this mode, see below
			break;

			case RUN_MODE:
				BeltClutch = _BeltClutch;//restore belt clutch state (preserved when exited RUN state)
				ZeroFlag = 0;//make sure to clear this flag before restoring RUN state
				
				//when starting RUN from states:
				//0-stopped
				//1-filling 
				//3- washdown
				//force the outstate to start at first step in the RUN state (2)
				if(outstate <= 3){
					outstate = 2;						
				}else{
					//BAND AID TO MAKE SURE OUTFEED BELT MOVES WHEN SWITCHING TO RUN STATE
					switch(outstate){
						case 5:
						case 6:
						case 8:
						case 9:
						case 11:
							if(!BeltClutch){
								DBG(lgr, "beltOFF,ONreq! otst=%d", outstate);		
								BeltClutch = 1;
							}
						break;
					}
				}		

				
				//VERY DIFFICULT PROBLEM DISCOVERED AT MILFORD	
				if(outstate == 10){
					OutfeedDumped = 1;//restart handshake to a point that the hopper can pick it up without locking up	
				}
						
				//otherwise, don't touch outstate > it will continue execution from the point where it stopped (outstate > 3)
			break;
			
			case FILL_MODE:
//				outstate = 1; //start fill
				//check if stop/pause is allowed
				if( isOutfeedPauseBlocked() ){
					//pause is blocked, can't switch to stopped mode! wait here until it gets unblocked (i.e. belt turns off)
					//when exiting here, _MasterMode does not get updated. As a result, we'll keep 
					//comming back to this point until pause gets unblocked
					return 0;//make sure outfeed SM continues execution!!!				
				}
					
				//entering STOP mode from any other state
				//_BeltClutch = BeltClutch;//preserve belt clutch state
				BeltClutch  = 0;//stop belt
				//NOTE: SM stops executing in this mode, see below
				
				//case 1: // fill
					BeltClutch  = 0;
					QCselect[0] = 0;
					QCselect[1] = 0;
					stageHoppersGatesClose();		
				//break;
				
			break;

			case WASHDOWN_MODE:
				outstate = 3; // goto washdown
			break;
		}
		
		DBG(lgr, "outfeed MasterMode=%d", MasterMode);		
		_MasterMode = MasterMode;
	}

	//pause request set
	if(gUdpCmdMsg.outfeed.pauseOperation && !_pauseOperation){
		//same as stop mode
		if(MasterMode == RUN_MODE){
		
			//check if stop/pause is allowed
			if( isOutfeedPauseBlocked() ){
				//pause is blocked! wait here until it gets unblocked (i.e. belt turns off)
				//when exiting here, _pauseOperation does not get updated. As a result, we'll keep 
				//comming back to this point until pause gets unblocked
				return 0;//make sure outfeed SM continues execution!!!				
			}
		
			//pause feature is supported only in RUN mode
			_BeltClutch = BeltClutch;//preserve belt clutch state
			BeltClutch  = 0;//stop belt
		}
		_pauseOperation = gUdpCmdMsg.outfeed.pauseOperation;
	}
		
	//pause request reset
	if(!gUdpCmdMsg.outfeed.pauseOperation && _pauseOperation){
		if(MasterMode == RUN_MODE){
			//pause feature is supported only in RUN mode
			BeltClutch = _BeltClutch;//restore belt clutch state
			_pauseOperation = gUdpCmdMsg.outfeed.pauseOperation;
		}
	}
		
	//if STOP mode active > exit here (i.e. don't execute SM)
	if((MasterMode == STOP_MODE) || (MasterMode == FILL_MODE) || (  (MasterMode == RUN_MODE) && _pauseOperation) ){
		return 1;//returning 1 means that outfeed SM will not be executed!!!
	}
	
	return 0;
}

_LOCAL BOOL lastSelectedQC;

//outfeed state machine
void outfeed(void)
{
int   i,j;
static DINT _OutfeedDumped;
	
	//process MasterMode and control outfeed SM (outstate)
	//if outfeed SM should be stopped (i.e. not executed, the function returns 1)
	if(outfeedMasterModeLogic()){
		return;	
	}

	//log outstate change
	if(outstate != _outstate)
	{
		_outstate = outstate;
		DBG(lgr, "outfeed sm: %d", outstate);	
	}
	
	//log OutfeedDumped change
	if(OutfeedDumped != _OutfeedDumped)
	{
		_OutfeedDumped = OutfeedDumped;
		DBG(lgr, "OfD=%d, Qsl=%d, Qst=%d OfHD=%d", OutfeedDumped, QCselect[0], qc[0].QCStarted, Weigh[1]);	
				
		bgsprintf(gDiagEventRecToFIFO.eventText, "OfD=%d, Qsl=%d, Qst=%d OfHD=%d", OutfeedDumped, QCselect[0], qc[0].QCStarted, Weigh[1]);
		gDiagEventRecToFIFO.eventId = 103;
		captureDiagEvent(gDiagEventRecToFIFO.eventId, gDiagEventRecToFIFO.eventText);
	}
	
	//outfeed state machine (SM)
	switch (outstate)
	{
	case 0: //stop
		BeltClutch  = 0;
		QCselect[0] = 0;
		QCselect[1] = 0;
		stageHoppersGatesClose();		
	break;

	case 1: // fill
		BeltClutch  = 0;
		QCselect[0] = 0;
		QCselect[1] = 0;
		stageHoppersGatesClose();		
	break;

	case 2: // run
		//set hw for run
		BeltClutch  = 0;
		QCselect[0] = 0;
		QCselect[1] = 0;
		stageHoppersGatesClose();		
		outstate = 4;
	break;

	case 3: // washdown
		// set i/o for washdown
		BeltClutch  = 1;
		QCselect[0] = 0;
		QCselect[1] = 0;
		stageHoppersGatesOpen();		
	break;

	case 4: // start outfeed 
		BeltClutch = 1;
		outstate++;
	break;

	case 5:  // look for zero tab
		if (ZeroFlag)
		{
			ZeroFlag = 0;
			stop1dly = 0.0;
			outstate++;
		}
	break;

	case 6:  // stop 1 delay after zero tab detected
		stop1dly += .001;
		if (stop1dly > Config.Cfg_Stop1dly)
		{
			BeltClutch = 0;
			ZtoDump = 0;
			Stagedly1 = 0.0;
			Stagedly2 = 0.0;
			stageHoppersGatesOpen();//as soon as the belt stops, dump product onto the outfeed belt		
			outstate++;
		}
	break;

	case 7:  // Delay for Dumping Staging Hoppers & dump to outfeed belt

		Stagedly1 += TK_CYCLE_TIME_Xms;
		if (Stagedly1 >= gUdpCmdMsg.outfeed.stagingHopperOpenDuration)
		{
			stageHoppersGatesClose();		
//			stageHoppersGatesOpen();		
				
			Stagedly2 += TK_CYCLE_TIME_Xms;
			if (Stagedly2 >= gUdpCmdMsg.outfeed.outfeedBeltCycleStartDelay)
			{
				FltCntFlg  = 0;//reset flight counter
				//stageHoppersGatesClose();		
				BeltClutch = 1; // Start Moving belt
				outstate++;
			}
		}
	break;

	case 8:  // Zero to first Dump
		if (FltCntFlg)
		{
			FltCntFlg = 0;
			ZtoDump++;
			if (ZtoDump > FlightCounter)
			{
				stop2dly = 0.0;
				OutfeedStation = Config.Cfg_NumTakeoffs;//set the station that will be processed first at the outfeed hopper
				outstate++;
			}
		}
	break;

	case 9:  // Stop 2 DLY, delay after a flight that contains product that shall be dropped first is detected
		stop2dly += TK_CYCLE_TIME_Xms;
		if (stop2dly > Config.Cfg_Stop2dly)
		{
			BeltClutch = 0;//stop the outfeed belt
			OutfeedDumped = 1;//request to outfeed hopper to weigh the product
			QCskip = 0;//QC skip is cleared (i.e. QC shall be executed if possible/required)		
			outstate++;
		}
	break;

	case 10:  // startup belt
	/*
	IMPORTANT: in this state, a handshake between this SM and the outfeed hopper SM takes place
	For outfeed hopper see master.c, outfeed() function, state APP4_DUMP and function call: 
	HopperOutfeedDump(Ch)

	Chain of events:
			
	outfeedSM, state 9:
	OutfeedDumped = 1 //request to hopper SM to weigh product

	outfeedHopperSM, state APP4_FILL:
	if(	OutfeedDumped == 1)
	goto NextStep //i.e. measure product dumpped into the outfeed hopper

	outfeedHopperSM, state APP4_DUMP:
	if( CaptureWeight is GoodForQC)
	OutfeedDumped = 2 //signal to outfeed SM that product weight is GOOD
	else
	OutfeedDumped = 5 //signal to outfeed SM that product weight is NO GOOD
	etc.
	*/
		switch(OutfeedDumped){
		case 0:	//Outfeed hopper is done. Product is dropped!
			//Continue here and decide if QC shall be started for this product 
						
			if(QCskip || !isQCRequiredCurrentStation()){
				//QCskip == 1 when product weight is NO GOOD (small weight) for QC
				//QC not required > advance outfeed conveyer to the next station
				outfeedAdvance(); //outfeed SM will be changed within this call!
				return;				
			}
							
			//Check if current product shall be QC-ed AND the product is dumpped at the QC
			if( isQCRequiredCurrentStation() && isQCLogged_NotStarted(0) && (QCselect[0] == 1) ){
				//Yes, current product shall be QC-ed AND the product is dumpped at the QC (QC deverter gate is towards QC)
				qc[0].OutfeedRecId = getOutfeedRecId();
				qc[0].QCcurStation = OutfeedStation;
				qc[0].QCStarted   = 1;
				qc[0].QCtotaltime = 0.0;
			}else
			if( isQCRequiredCurrentStation() && isQCLogged_NotStarted(1) && (QCselect[1] == 1) ){
				//Yes, current product shall be QC-ed AND the product is dumpped at the QC (QC deverter gate is towards QC)
				qc[1].OutfeedRecId = getOutfeedRecId();
				qc[1].QCcurStation = OutfeedStation;
				qc[1].QCStarted   = 1;
				qc[1].QCtotaltime = 0.0;			
			}			
			
				
			outfeedAdvance();					
		break;
		case 1://set by outfeed sm (above) after product dumped into outfeed hopper for weighing
			//nothing to do > wait for outfeed hopper sm to change the state variable OutfeedDumped
			stop2dly = 0.0;	
		break;
		case 2://set by the outfeed hopper sm after sufficent product weight detected at the outfeed scale

			if( !isQCRequiredCurrentStation() ){
			//QC is not required for the current station
			//not required when: no request by the HMI OR both QC station are NOT logged in
				QCselect[0] = 0;
				QCselect[1] = 0;
							
				stop2dly += TK_CYCLE_TIME_Xms;//wait for timer to expire before letting hopper sm to proceed
				if (stop2dly > 0.05){
					OutfeedDumped = 3;					
				}
				return;
			}
		
			//YES, QC is required for the current station!
			
			if( isQCLogged_NotStarted(0) && isQCLogged_NotStarted(1) ){
				//Both are available for inspection
				
				//Select the QC that is different then the last one
				if(lastSelectedQC){
					QCselect[0] = 1;
					QCselect[1] = 0;
					qc[0].QCweight = App[1].Hopper.GrossWeight;
					lastSelectedQC = 0;
				}else{
					QCselect[0] = 0;
					QCselect[1] = 1;
					qc[1].QCweight = App[1].Hopper.GrossWeight;
					lastSelectedQC = 1;
				}
			}else
			if(isQCLogged_NotStarted(0)){
				//QC 0 is available for inspection
				
				QCselect[0] = 1;
				QCselect[1] = 0;
				qc[0].QCweight = App[1].Hopper.GrossWeight;
				lastSelectedQC = 0;			
			}else
			if(isQCLogged_NotStarted(1)){				
				//QC 1 is available for inspection
				
				QCselect[0] = 0;
				QCselect[1] = 1;
				qc[1].QCweight = App[1].Hopper.GrossWeight;
				lastSelectedQC = 1;						
			}else{
				//no QC is available
			
				QCselect[0] = 0;
				QCselect[1] = 0;
			
				//check the qc mode
				if(qc[0].QCmode == 0){
					//QC mode is MUST DO QC > stop the outfeed until a QC is available (wait here)
					return;
				}
				//otherwise, advance the outfeed following a delay below
			}
						
			stop2dly += TK_CYCLE_TIME_Xms;//wait for timer to expire before letting hopper sm to proceed
			if (stop2dly > 0.65){//7/10/13 - increade delay to make sure that QC shoot moves to a position before weigh door gets opened
				OutfeedDumped = 3;					
			}
																			
	break;
	case 3:
	case 4:
	case 5:
	//nothing to do > wait for outfeed hopper sm to change the state variable OutfeedDumped
	break;
	}
			
	break;
   
	case 11:  // next flt
		if (FltCntFlg)
		{
			FltCntFlg = 0;
			stop2dly = 0.0;
			outstate = 9;
		}
	break;

	case 12:  // look for next zero
		BeltClutch = 1;
		outstate = 5;
	break;
	}
	
}


//Functions to support DO-s forcing from the host
static BOOL diagIsForceDOsActive()
{
	if( !gUdpCmdMsg.diag.io.enableDOForce ){
		return 0;
	}

	if( MasterMode != STOP_MODE ){
		return 0;
	}

	return 1;
}
static void diagForceDOs()
{
	int ii;

	if( !diagIsForceDOsActive() )
		return;

	//Following DO-s are controlled from this task
	//When DO force gets activagted, these DO-s are congtrolled directly by the host via UDP cmd msg
	BeltClutch = (gUdpCmdMsg.diag.io.outfeed.DOModule & 0x02) ? 1 : 0;
	QCselect[0] = (gUdpCmdMsg.diag.io.outfeed.DOModule & 0x10) ? 1 : 0;
	QCselect[1] = (gUdpCmdMsg.diag.io.outfeed.DOModule & 0x80) ? 1 : 0;

	for(ii=0; ii<YP_MAX_STATIONMODULES; ii++){
		Stage[ii*4 + 0] = (gUdpCmdMsg.diag.io.stations[ii].DOModule & 0x02) ? 1 : 0;
		Stage[ii*4 + 1] = (gUdpCmdMsg.diag.io.stations[ii].DOModule & 0x08) ? 1 : 0;
		Stage[ii*4 + 2] = (gUdpCmdMsg.diag.io.stations[ii].DOModule & 0x20) ? 1 : 0;
		Stage[ii*4 + 3] = (gUdpCmdMsg.diag.io.stations[ii].DOModule & 0x80) ? 1 : 0;
	}	
}

//Process and detect belt zero signal rising edge
static void ioBeltZeroDetect()
{
	if (inBeltZero && !_inZeroSensor)  //Rising Edge
	{
		ZeroCount++;
		ZeroFlag = 1;
	}
	_inZeroSensor = inBeltZero;
}

//Flite sensor operation
//This function processes the flite sensor digital input
//During normal operation, flite sensor detects passing of each flite on the outfeed
//belt conveyer. Detecting flites is critical for the proper operation of the machine.
//In case of a flite sensor mulfunction (or erronius flite detection), machine operation
//may be severly disturbed.
//As a result, and in addition to the normal operation, this function provides
//funcionality to detect, report and handle common flite sensor errors
static void ioFliteDetectEx(ioFliteSensorDetector_typ* p)
{

	//single shot (cycle) flag
	p->oFliteSignalDetected = 0;

	switch(p->prvState){
		case 0: //at startup, init variables
			p->prvOnCounter = 0;
			p->prvOffCounter = 0;
			p->oPulseOffTimeMin = 1000;
			p->oPulseOffTimeMax = 0;
			p->oPulseOnTimeMin = 1000;
			p->oPulseOnTimeMax = 0;
			p->prvState = 5;
		break;	
		case 5:	//belt off			
		//when belt if off, flites are not moving, nothing to do		
			
			if(!p->iBelt){
				p->oAlarmPulsOff = 0;
				p->oAlarmPulsOn = 0;
				p->oFliteSignalDetected = 0;
				p->oFliteCounter = 0;
				return;
			}
			
			//belt got turned on
			p->prvOffCounter = 0;
			p->prvOnCounter = 0;
			
			//depending on the current state of the flite sensor input
			//goto an appropirate state
			if(p->iFliteSensor){
				p->prvState = 20;//goto physical flite signal on
			}else{
				p->prvState = 10;//goto physical flite signal off			
			} 
		break;
		case 10://physical flite signal is off
			p->prvOffCounter += TK_CYCLE_TIME_counts; //measure the time in this state
			
			if(!p->iBelt){
				p->prvState = 5;//if belt turned off > goto belt off state
				return;
			}
			
			//pulse off duration too long?
			if(p->prvOffCounter > p->iPulseOffTimeMax){
				//trouble! sensor signal is off longer than expected!
				p->oAlarmPulsOff = 1;//generate alarm
				p->oFliteSignalDetected = 1;//create a fake flite signal detected indication (used by the machine logic)					
				p->prvOnCounter = 0;//reset pulse on counter for the fake on signal generation
				p->prvState = 11;//pulse off is too long > simulate pulse on!
				return;
			}		
			
			if(p->iFliteSensor){
				//ok, this is normal! pulse turned on
				//capture min/max off times
				if(p->prvOffCounter > p->oPulseOffTimeMax){
					p->oPulseOffTimeMax = p->prvOffCounter;
				}
				if(p->prvOffCounter < p->oPulseOffTimeMin){
					p->oPulseOffTimeMin = p->prvOffCounter;
				}
				
				p->oFliteSignalDetected = 1;//create a flite signal detected indication (used by the machine logic)					
				p->prvOnCounter = 0;					
				p->prvState = 15;//physical signal on filter
			}
		break;
		case 11://pulse off too long > simulate on pulse
			p->prvOnCounter+=TK_CYCLE_TIME_counts;

			if(!p->iBelt){
				p->prvState = 5;//if belt turned off > goto belt off state
				return;
			}

			if(p->iFliteSensor){
				p->prvState = 15;//ups! physical signal is on > good!					
				p->prvOnCounter = 0;
				return;					
			}
			
			//virtual on signal expired?
			if(p->prvOnCounter > p->iPulseOnTimeMax){
				p->prvOffCounter=0;
				p->prvState = 10;//back to physical pulse off					
			}		
		break;
		case 15://physical pulse on filter
			p->prvOnCounter+=TK_CYCLE_TIME_counts;

			if(!p->iBelt){
				p->prvState = 5;//goto belt off
				return;
			}
									
			if(p->prvOnCounter > p->iPulseOnFilterTime){
				//on filter! disable any processing for the specified interval
				p->prvState = 20;//physical signal on
				return;
			}		
		break;		
		case 20://physical signal is on
			p->prvOnCounter+=TK_CYCLE_TIME_counts;

			if(!p->iBelt){
				p->prvState = 5;//goto belt off
				return;
			}
					
			//pulse on duration too long?	
			if(p->prvOnCounter > p->iPulseOnTimeMax){
				p->prvOffCounter = 0;
				p->oAlarmPulsOn = 1;//generate alarm
				p->prvState = 21;//signal on too long!
				return;
			}		
			
			if(!p->iFliteSensor){
				//ok, this is normal! sensor signal turned off
				//capture min/max on times
				if(p->prvOnCounter > p->oPulseOnTimeMax){
					p->oPulseOnTimeMax = p->prvOnCounter;
				}
				if(p->prvOnCounter < p->oPulseOnTimeMin){
					p->oPulseOnTimeMin = p->prvOnCounter;
				}
				
				p->prvState = 10;//physical pulse off					
				p->prvOffCounter = 0;					
			}
		break;
		case 21://signal on too long > simulate off signal
			p->prvOffCounter+=TK_CYCLE_TIME_counts;

			if(!p->iBelt){
				p->prvState = 5;//goto belt off
				return;
			}

			if(!p->iFliteSensor){
				p->prvState = 10;//physical signal off					
				p->prvOffCounter = 0;
				return;					
			}
			
			//virtual signal off expired?
			if(p->prvOffCounter > p->iPulseOffTimeMax){
				p->prvOnCounter=0;
				p->oFliteSignalDetected = 1;//fake sensor signal
				p->prvState = 20;//back to physical pulse on					
			}		
		break;
	}
}

//Process and detect flight sensor signal
static void ioFliteDetect()
{
//#if 0
	ioFliteSensor.iBelt = BeltClutch;
	ioFliteSensor.iFliteSensor = inBeltFlite;
	ioFliteSensor.iPulseOnFilterTime = gUdpCmdMsg.outfeed.flightFilterCount;
	ioFliteSensor.iPulseOffTimeMax = (UDINT)(gUdpCmdMsg.outfeed.flightTimeMax * 1000.0);
	ioFliteSensor.iPulseOnTimeMax = (UDINT)(gUdpCmdMsg.outfeed.flightTimeMin * 1000.0);	
	ioFliteDetectEx(&ioFliteSensor);
	
	if(ioFliteSensor.oAlarmPulsOff){
		ioFliteSensor.oAlarmPulsOff = 0;
		memset(gDiagEventRecToFIFO.eventText, 0, sizeof(gDiagEventRecToFIFO.eventText));
		bgsprintf(gDiagEventRecToFIFO.eventText, "flite signal OFF error (maxOffTime=%d[ms]", (UDINT)(ioFliteSensor.iPulseOffTimeMax));
		gDiagEventRecToFIFO.eventId = 101;
		captureDiagEvent(gDiagEventRecToFIFO.eventId, gDiagEventRecToFIFO.eventText);
	}
	
	if(ioFliteSensor.oAlarmPulsOn){
		ioFliteSensor.oAlarmPulsOn = 0;
		memset(gDiagEventRecToFIFO.eventText, 0, sizeof(gDiagEventRecToFIFO.eventText));
		bgsprintf(gDiagEventRecToFIFO.eventText, "flite signal ON error (maxOnTime=%d[ms]", (UDINT)(ioFliteSensor.iPulseOnTimeMax));
		gDiagEventRecToFIFO.eventId = 102;
		captureDiagEvent(gDiagEventRecToFIFO.eventId, gDiagEventRecToFIFO.eventText);
	}
	
	FltCntFlg = ioFliteSensor.oFliteSignalDetected;
	
//#endif

#if 0
	if (FltFilter == 0)
	{
		if (inBeltFlite && !_inBeltFlite)  //Rising Edge
		{
			FltCount++;
			FltFilter  = 1;
			FltCntFlg  = 1;
		}
	}
	else 
	{
		FltFilter++;
		if (FltFilter>FltFilterCount)
		{
			FltFilter = 0;
		}  
	}
	_inBeltFlite = inBeltFlite;
#endif	
}

//generate delay timers using 1ms cycle time
static void	hopperDelayTimers()
{
	int i,j;

	for(i=0; i<DELAY_MAX; i++)
	{
		for(j=0; j<Config.Cfg_NumHoppers; j++)
		{
			if (IODelaySec[i][j] != -0.5)
			{  
				if (IODelaySec[i][j] >= 0.0)
				{ 
					IODelaySec[i][j] -= TK_CYCLE_TIME_Xms;
					if (IODelaySec[i][j] < 0.0)
					{
						if (i == DELAY_LINE)
						{
							Line[j] = IODelayBit[DELAY_LINE][j];
						}
						else if (i == DELAY_WEIGH)
						{
							Weigh[j] = IODelayBit[DELAY_WEIGH][j];
						}
						else if (i == DELAY_BUFFER)
						{
							Buffer[j] = IODelayBit[DELAY_BUFFER][j];  
						}
						else if (i == DELAY_1)  
						{
							Delay1[j] = IODelayBit[DELAY_1][j];
						}
						IODelaySec[i][j] = -0.5;
					}
				}
			}  
		}
	}   
}	
/*
###############################################################################
Task execution entry points: Init & Cyclic Functions
###############################################################################
*/
_INIT void DataINIT(void)
{
	int i, j;

	//init logger object
	DBGINIT(lgr, log, LOG_ENTRY_COUNT, LOG_ENTRY_LENGTH);
   
	ZeroCount      = 0;
	FltCount       = 0;
	FltFilter      = 0;
	FltFilterCount = 100; //100ms
 
	//turn off all delay timers	
	for(i=0; i<DELAY_MAX; i++)
	{
		for(j=0; j<MAX_CHANNELS; j++)
		{
			IODelaySec[i][j] = -0.5; //Stoped
			IODelayBit[i][j] = 0;  
		}
	}  

	ZeroFlag       = 0;
	MasterMode     = STOP_MODE;
	//Screen.DoneVis = 1;
	qc[0].QCDoneVis = 1;
	qc[1].QCDoneVis = 1;

}
  
void _CYCLIC IO(void)
{
  
	//Startup delay???
	if (StartUpInit < 10000)
	{
		StartUpInit += TK_CYCLE_TIME_counts;
	}  

	//detect belt zero signal rising edge
	ioBeltZeroDetect();

	//process and filter flite signal 
	ioFliteDetect();
 
	//generate delay timers using 1ms cycle time
	hopperDelayTimers();

	//Handle force DO-s in case feature gets activated by the host
	if(diagIsForceDOsActive()){
		diagForceDOs();
	}else{
		outfeed();
	}	
}
//eof