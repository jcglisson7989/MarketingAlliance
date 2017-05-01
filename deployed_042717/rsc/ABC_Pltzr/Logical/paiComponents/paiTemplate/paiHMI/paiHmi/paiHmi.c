/********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Program: paiHmi
 * File: paiHmi.c
 * Author: goran
 * Created: July 27, 2015
 ********************************************************************
 * Implementation of program paiHmi
 ********************************************************************/

#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
	#include <AsDefault.h>
#endif

#include "../../../paiHmi/paiHmiParamList.h"
#include "../../../paiHmi/paiHmiDialog.h"
#include "../../../paiHmi/paiHmiAlert.h"
#include "../../../paiHmi/paiHmiSystemDateTime.h"
#include "../../../paiHmi/paiHmiSystemNetworking.h"
#include "../../../paiHmi/paiHmiMsgScrolling.h"
#include "../../../paiHmi/paiHmiLFMenuTabsPages.h"
#include "../../../paiHmi/paiHmiDropdownMenuRT.h"



/**
Recipe and config support cyclic logic. Monitors recipe and config changes (a change indication provided by recipe and config subsystem) 
and controls visibility of the global buttons that allows user to trigger recipe and config save actions.
Prompts the user to make a decession about saving changes using an HMI dialog. Based on the user input,
it than notifies the recipe and config subsystem to either accept or discard changes in active recipe or config.
NOTE: uses global variables
*/
#if 0
static void recipeSaveCyclic()
{
	UINT ret;

	//control visibility: save cfg button
	//NOTE: button is not visible during setting of a new recipe! During that time, active recipe is in transition and it should not be
	//posible to store it
//	bgBitSetUINT(&gHmi.status.visibleSaveCfg, 0, (gConfig.out.isChanged)?0:1);


	//NOTE: visibility of this button is controlled! This action is only possible when the button is visible!
//	if(gHmi.keys.btnSaveCfg){
//		DBG(lgr, "save cfg request");
//		gHmi.keys.btnSaveCfg = 0;
		paiHmiDialogShow(&gPaiHmiDialogMsg, "Save Machine Config Changes?", 10000, 1, 2, 0);		
//	}


	ret = paiHmiDialogCyclic(&gPaiHmiDialogMsg);	
	if(ret == 1){
		//save config accepted
//		DBG(lgr, "save cfg accepted!");
		paiHmiAlertShow(&gPaiHmiAlertMsg, "Machine Config changes saved.", 2000);		
//		gConfig.in.isChangeAccepted = 1;

	}
	if(ret == 2){
		//save config canceled
//		DBG(lgr, "save cfg rejected!");
		paiHmiAlertShow(&gPaiHmiAlertMsg, "Machine Config changes NOT saved.\nValues restored.", 3000);		
//		gConfig.in.isChangeRejected = 1;
	}
	
	paiHmiAlertCyclic(&gPaiHmiAlertMsg);

}
#endif

void _INIT paiHmiInit(void)
{
	/* TODO: Add code here */
	
	//Message scrolling support - init
	gPaiHmiMsgScroll.iEnable = 1;
	paiHmiMsgScrollingInit(&gPaiHmiMsgScroll, (UDINT)&gAlarmsFiltered.alarmActive[0], APP_ALARM_LAST + 1, 3000);
	
	//Support for alert message - init	
	paiHmiAlertHide(&gPaiHmiAlertMsg);
	
	//Support for dialog message - init
	paiHmiDialogHide(&gPaiHmiDialogMsg);
	
	//Support for RT drop-down menu
	gPaiHmiRTMenu.iMenuRTTimeout = 5.0;//gConfig.active.paiHmi.timerSettings.dropdwMenuRTTimeout;
	paiHmiDropDownMenuRTInit(&gPaiHmiRTMenu);
	
	//System Date & Time support
	paiHmiSystemDateTimeInit(&gPaiHmiSystemDateTime);

	//Screensaver support
	if(gScrensaverTimeout < 60){
		gScrensaverTimeout = 60;
	}
	
	/*
###############################################################################
	PAI_CONFIGURATION_SECTION
	Enter correct IF for the Ethernet port.
###############################################################################
	*/
	//System networking
	brsstrcpy((UDINT)gPaiConfigSys.paiSys.ethernet.ethDevice, (UDINT)"IF2");
	gPaiHmiNetworking.iPtrNWConfig = &gPaiConfigSys.paiSys.ethernet;
	paiHmiSystemNetworkingInit(&gPaiHmiNetworking);


}

void _CYCLIC paiHmiCyclic(void)
{
	/* TODO: Add code here */
	
	/*
###############################################################################
	PAI_CONFIGURATION_SECTION
	Code below allows configuration of VC resource used in this project.
	Enter correct name of the VC object.
###############################################################################
	*/
#warning "pai Configuration: HMI and Visual Components"
	
	
	//Page navigation using dropdown Menu (upper left corner) and Tabs
	paiHmiPageNavLFMenuTabsCyclic(&gPaiHmiMain, "WSVGA", 15);
	
	//Message scrolling support - cyclic
	paiHmiMsgScrollingCyclic(&gPaiHmiMsgScroll);
	
	//Support for RT drop-down menu
	paiHmiDropDownMenuRTCyclic(&gPaiHmiRTMenu);
	
	//System Date & Time support
	paiHmiSystemDateTimeCyclic(&gPaiHmiSystemDateTime);
	
	//System networking
	paiHmiSystemNetworkingCyclic(&gPaiHmiNetworking);

	
	//Alert cyclic control
	paiHmiAlertCyclic(&gPaiHmiAlertMsg);
	
	//Support for dialog message - cyclic
	paiHmiDialogCyclic(&gPaiHmiDialogMsg);
	
	
}

