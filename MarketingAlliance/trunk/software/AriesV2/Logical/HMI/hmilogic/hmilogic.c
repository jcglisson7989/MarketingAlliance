/********************************************************************
 * COPYRIGHT -- piedmont
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

#include "hmiParamList.h"
#include "hmiDialog.h"
#include "hmiAlert.h"
#include "loginLogic_Header.h"

/*
###############################################################################
Utilities
###############################################################################
*/


/** 
Bit manipulaiton utility functions.
 */
#include <../../bglib/bgBitUtilities.c>

#ifndef _BG_SPRINTF_H
#include <../../bglib/bgsprintf.h>
#include <../../bglib/bgsprintf.c>
#endif

#ifndef _BG_STRING_H
#include <../../bglib/bgstring.h>
#include <../../bglib/bgstring.c>
#endif


/*
###############################################################################
Menu keys logic
###############################################################################
*///logic control of the global MENU KEYS on the Left Side (i.e. STOPPED, FILLING, PRODUCTION, ...)
static void menuInitKeysLFRT()
{
	//make both menus not visible at the start
	gHmi.status.menuVisibleLT = 1;
	gHmi.status.menuVisibleRT = 1;
}


//logic control of the global MENU KEYS on the Left Side (i.e. STOPPED, FILLING, PRODUCTION, ...)
static void menuCyclicKeysRT()
{
	int ii;
	static UDINT menuVisibleLTOld;
	static UDINT menuVisibleRTOld;
	
	//make visible one of the 4 buttons stacked on each other 
	//this is due to buttons are of different color and use border property to set the colors
	for(ii=0; ii<HMI_ENUM_MENU_ITEMS_RT;ii++){
		gHmi.status.menuVisibleRTItems[ii] = 1;
		if(ii == gHmi.status.menuIndexRT){
			gHmi.status.menuVisibleRTItems[ii] = 0;
		}
	}
	
	bgTimerCyclic(&gHmi.status.menuLFHideTimer);
	bgTimerCyclic(&gHmi.status.menuRTHideTimer);
	
	//when menu becomes visible > start the timer
	if(!gHmi.status.menuVisibleLT && menuVisibleLTOld){
		/*bgTimerStart(&gHmi.status.menuLFHideTimer, gConfig.active.hmi.dropdwMenuLFTimeout * 1000);*/ //dropdown timer LF
		bgTimerStart(&gHmi.status.menuLFHideTimer, DEFINE_MENU_L_HIDE_TIMEOUT_MS);
	}
	menuVisibleLTOld = gHmi.status.menuVisibleLT;
	//if menu still visible after timer expires > hide menu
	if( !gHmi.status.menuVisibleLT && bgTimerIsTimeOut(&gHmi.status.menuLFHideTimer) ){
		gHmi.status.menuVisibleLT = 1;
	}
	
	//when menu becomes visible > start the timer
	if(!gHmi.status.menuVisibleRT && menuVisibleRTOld){
		bgTimerStart(&gHmi.status.menuRTHideTimer, DEFINE_MENU_R_HIDE_TIMEOUT_MS); //dropdown timer LF
	}
	menuVisibleRTOld = gHmi.status.menuVisibleRT;
	//if menu still visible after timer expires > hide menu
	if( !gHmi.status.menuVisibleRT && bgTimerIsTimeOut(&gHmi.status.menuRTHideTimer) ){
		gHmi.status.menuVisibleRT = 1;
	}
}

/*
###############################################################################
Tab keys logic
###############################################################################
*///logic control of the tab key operation (i.e. radio button fuction)
static void menuInitTabKeys()
{
	//activate first tab (applies to any screen)
	gHmi.status.tabKeysRadioDataPoint = 1;	
}

//logic control of the tab key operation (i.e. radio button fuction)
static void menuCyclicTabKeys()
{
	int ii;	
	for(ii=0;ii<HMI_ENUM_TAB_KEYS_MAX;ii++){
		if(ii == gHmi.status.tabKeysRadioDataPoint){
			gHmi.status.tabKeysRadioArray[ii] = 1;//select array elements that matches selected radio button		
		}else{
			gHmi.status.tabKeysRadioArray[ii] = 0;//unselect all other array elements
		}
	}
}

/*
###############################################################################
HMI screen handling logic
###############################################################################
*/
static void S_Global()
{
	menuCyclicKeysRT();
	menuCyclicTabKeys();
	loginLevelLogicCyclic();
}

//============================================================================
void screenHandlers(UINT page)
{
	hmiControlLogic_typ* pHmi = &gHmi;
	
	bgTimerCyclic(&gHmi.prv.tmr4);
	
	//Page specific init logic
	if(pHmi->prv.pageInit){		
		//screen init event
		//define screen name
		switch(page){	
			case HMI_HOME_10_DASHBOARD:
//				loginLevelParameterEditControl((UINT) gRecCfg.active.Cfg.HMI.Access_Level_HomeForce);
				break;
			case HMI_RECIPE_20_SELECT:
				loginLevelParameterEditControl(RECIPE_ACCESS_LEVEL);
				break;
			case HMI_CONFIG_30_SELECT:
				loginLevelParameterEditControl(CONFIG_ACCESS_LEVEL);
				break;
			case HMI_LOGIN_40_MAIN:
				bgStrCpyN(gHmi.status.passwordStrings[0], "0000", HMI_PWD_MAXLEN);
				bgStrCpyN(gHmi.status.passwordStrings[1], gRecCfg.active.Cfg.HMI.passwordSetup, HMI_PWD_MAXLEN);
				bgStrCpyN(gHmi.status.passwordStrings[2], gRecCfg.active.Cfg.HMI.passwordEngineer, HMI_PWD_MAXLEN);
				bgStrCpyN(gHmi.status.passwordStrings[3], gRecCfg.active.Cfg.HMI.passwordFactory, HMI_PWD_MAXLEN);
				break;
			case HMI_LOGIN_41_OPERATOR:
				break;
			case HMI_LOGIN_42_SETUP:
				break;
			case HMI_LOGIN_43_ENGINEER:
				
				break;
			case HMI_LOGIN_45_FACTORY:
				break;
			case HMI_MOTION_61_IO_MOTORS:
				loginLevelParameterEditControl(FORCEIO_ACCESS_LEVEL);
				break;
			case HMI_AUX_90_FILE:
//				loginLevelParameterEditControl(FORCEIO_ACCESS_LEVEL);
				break;
			default:
				strcpy(pHmi->prv.currentPageText, "screen() ????");
				break;
		}	
	}
	
	if(pHmi->prv.pageExit){
		switch(page){
			default:
				break;
		}
	}

	//Page specific cyclic logic
	switch(page){
		case HMI_00_STARTUP:
			if( bgTimerIsTimeOut(&gHmi.prv.tmr4) ){
				gHmi.prv.changePage = HMI_HOME_10_DASHBOARD;
			}
			break;
		
		case HMI_RECIPE_21_PVLIST:
			break;
	
		case HMI_CONFIG_31_PVLIST:
			break;
		
		default:
			break;
	}
	
	//param table cyclic routine
	hmiParamListTableCyclic(&gHmiParamTable);	
}

static void screenPageChangeLogic(hmiControlLogic_typ* pHmi)
{
	if(!pHmi)
		return;
	
	//operate screen logic timer	
	bgTimerCyclic(&pHmi->prv.tmr1);

	//change screen is in progress; wait
	if(pHmi->prv.changePage != 0xFF)
		return;
	
	//generate page init/exit events
	pHmi->prv.pageInit = 0;
	pHmi->prv.pageExit = 0;
	if(pHmi->prv.currentPage != pHmi->prv.prevPage){
		pHmi->prv.pageExit = 1;
		screenHandlers(pHmi->prv.prevPage);
		pHmi->prv.pageExit = 0;
		
		pHmi->prv.pageInit = 1;
		pHmi->prv.prevPage = pHmi->prv.currentPage;

		//reset screen state
		pHmi->prv.state = 0;
		pHmi->prv.stateInit = 1;
	}else
		if(pHmi->prv.state != pHmi->prv.statePrev){
		
		//generate state init event
		pHmi->prv.statePrev = pHmi->prv.state;
		pHmi->prv.stateInit = 1;
	}
}
//============================================================================
static void screenLogicCyclic()
{
	hmiControlLogic_typ* pHmi = &gHmi;
	
	//Logic to detect page change events and generate approprite signals / flags (i/e/ pageInit etc)
	screenPageChangeLogic(pHmi);
	
	//Page(screen) specific logic. Logic that runs/applies only to a specific page/screen
	screenHandlers(pHmi->prv.currentPage);

	// TODO: S_Global() shall be possible to place above screenHandlers(). For now,
	//and due to clearing of one shot move related flags that's not working!!!!
	//Global screen logic that runs cyclicly
	S_Global();
}
//============================================================================


void _INIT hmilogicInit(void)
{
	
	gHmi.status.menuIndexLT = 0;

	menuInitKeysLFRT();
	menuInitTabKeys();
	hmiAlertHide(&gHmi.alertMsg);
	hmiDialogHide(&gHmi.dialogMsg);

	bgTimerStart(&gHmi.prv.tmr4, DEFINE_HMI_SPLASHSCREEN_TO_MS); 
}
//============================================================================
void _CYCLIC hmilogicCyclic(void)
{

	screenLogicCyclic();

}
//============================================================================

