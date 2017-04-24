
#include <..\..\GlobalDef.h>
#include <..\..\GlobalDecl.h>  
//#include "..\\..\\RecFIFO\\fifotest\\fifoif.h"
#include "..\\..\\bglib\\bgsprintf.h"
#include "..\\..\\bglib\\bgsprintf.c"

static BOOL simIsProductAtInfeedWeigh()
{
	if(((MasterMode == RUN_MODE) || (MasterMode == FILL_MODE))&& (App[0].Hopper.State == APP4_FILL) ){
		return 1;
	}else{
		return 0;
	}	
}

static BOOL simIsProductAtOutfeedWeigh()
{
	if((MasterMode == RUN_MODE) /*&& (App[1].Hopper.State == APP4_FILL)*/ && (OutfeedDumped == 1)){
		return 1;
	}else{
		return 0;
	}	
}

static void simonlySimulateInfeedWt()
{
	if( simIsProductAtInfeedWeigh() ){
		Sys[0].Raw_wt = 8000;
	}else{
		if((MasterMode == RUN_MODE) || (MasterMode == FILL_MODE)){
			Sys[0].Raw_wt = 0;
		}
	}	
}

static void simonlySimulateOutfeedWt()
{
	if( simIsProductAtOutfeedWeigh() ){
		Sys[1].Raw_wt = 2000;
	}else{
		if((MasterMode == RUN_MODE)){
			Sys[1].Raw_wt = 0;
		}
	}	
}


static void simonlySimulateZeroFlag()
{
static int zeroFlagCounter;
static int zeroFlagState;

	//if BeltClutch is off > no updates / changes to the zero flag states
	if(!BeltClutch)
		return;

	switch(zeroFlagState){
		case 0:
			if(zeroFlagCounter++ > 1500){
				zeroFlagState = 1;
				zeroFlagCounter = 0;
				ZeroFlag = 1;
			}
		break;
		case 1:
			if(zeroFlagCounter++ > 5){
				zeroFlagState = 0;
				zeroFlagCounter = 0;
				ZeroFlag = 0;
			}		
		break;
	}

}

void _INIT simonlyINIT(void)
{
	/* TODO: Add code here */
	
	
	//Overrid UDP Client operation settings (Use HMI if needed)
	//gUdpSystemCfg.udpClientMode = 1;//continues mode
	gUdpSystemCfg.udpClientUpdateRate = 5;//[Hz]
	strcpy(gUdpSystemCfg.udpRemoteHostIpAddress.text, "127.0.0.1");
	gUdpClient.clientIf.iTaskCycleTimeXms = 10;//udp client runs under 10ms cycle time
	
}

void _CYCLIC simonlyCYCLIC(void)
{
	/* TODO: Add code here */
	simonlySimulateInfeedWt();
	simonlySimulateOutfeedWt();
	simonlySimulateZeroFlag();
		
}
