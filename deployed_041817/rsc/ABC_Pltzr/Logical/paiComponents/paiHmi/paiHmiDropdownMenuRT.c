/********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Package: paiHmiTemplate
 * File: paiHmiDropdownMenuRT.c
 * Author: goran
 * Created: July 29, 2015
 *******************************************************************/

#include <bur/plctypes.h>
#ifdef _DEFAULT_INCLUDES
	#include <AsDefault.h>
#endif


//logic control of the global MENU KEYS on the Left Side (i.e. STOPPED, FILLING, PRODUCTION, ...)
void paiHmiDropDownMenuRTInit(paiHmiDropdwMenuRT_typ* p)
{
	//menu not visible at start
	p->oMenuVisible = 1;
}

//logic control of the global MENU KEYS on the Left Side (i.e. STOPPED, FILLING, PRODUCTION, ...)
void paiHmiDropDownMenuRTCyclic(paiHmiDropdwMenuRT_typ *p)
{
	int ii;
	
	//process input array to allow selection of menu items from the program
	for(ii=0; ii<=paiHMI_ENUM_MENU_ITEMS_RT;ii++){
		if(p->iMenuSelectItem[ii]){
			p->iMenuSelectItem[ii] = 0;
			p->iMenuIndexRT = ii;
			break;
		}
	}
		
	//set a bit within an array of the item that is currently selected
	for(ii=0; ii<=paiHMI_ENUM_MENU_ITEMS_RT;ii++){
		p->oMenuSelectedItems[ii] = 0;
		if(ii == p->iMenuIndexRT){
			p->oMenuSelectedItems[ii] = 1;
		}
	}
	
	
	bgTimerCyclic(&p->menuRTHideTimer);
	
	//clear all single shot flags
	for(ii=0; ii<=paiHMI_ENUM_MENU_ITEMS_RT;ii++){
		p->oMenuPressedItems[ii] = 0;
	}
	//generate single shot for a button press
	if(p->oMenuIndexRT != p->iMenuIndexRT){
		p->oMenuPressedItems[p->iMenuIndexRT] = 1;
	}
	p->oMenuIndexRT = p->iMenuIndexRT;

	
	
	
	//when menu becomes visible > start the timer
	if(!p->oMenuVisible && p->mMenuVisibleOld){
		bgTimerStart(&p->menuRTHideTimer, p->iMenuRTTimeout * 1000); //dropdown timer LF
	}
	p->mMenuVisibleOld = p->oMenuVisible;
	//if menu still visible after timer expires > hide menu
	if( !p->oMenuVisible && bgTimerIsTimeOut(&p->menuRTHideTimer) ){
		p->oMenuVisible = 1;
	}	
	
	
}
