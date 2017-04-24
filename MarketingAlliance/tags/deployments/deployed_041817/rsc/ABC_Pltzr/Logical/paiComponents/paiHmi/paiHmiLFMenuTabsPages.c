/********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Package: paiHmiTemplate
 * File: paiHmiTemplateLogic.c
 * Author: goran
 * Created: July 27, 2015
 *******************************************************************/

#include <bur/plctypes.h>
#ifdef _DEFAULT_INCLUDES
	#include <AsDefault.h>
#endif

#include "../bglib/bgstring.h"

#define paiHMI_KEYWORD_COMMENT "//"
#define paiHMI_KEYWORD_BUTTON "BUTTON:"
#define paiHMI_KEYWORD_TAB "TAB:"
#define paiHMI_KEYWORD_DELIM ","


//copy current tab setting to current tab PV-s
static void menuTabSetCurrent(paiHmiTemplate_typ* p, int tabIndex){	
	if(!p)
		return;
		
	brsmemcpy((UDINT)p->activeTabs, (UDINT)p->prv.menuLF[p->currentMenuLF].tabs , sizeof(p->activeTabs));
	
	//activate first tab
	p->keys.tabKeysRadioDataPoint = tabIndex;
}

static void menuTopLFSetCurrent(paiHmiTemplate_typ* p){	
	if(!p)
		return;
		
	brsmemcpy((UDINT)&p->activeTopMenuLF, (UDINT)&p->prv.menuLF[p->currentMenuLF].button , sizeof(p->activeTopMenuLF));
}



//logic control of the tab key operation (i.e. radio button fuction)
static void menuButtonsVisibility(paiHmiTemplate_typ* p, int visible)
{
int ii;

	for(ii = 0; ii<paiHMI_ENUM_MENU_ITEMS_LT; ii++){
		if(!p->prv.menuLF[ii].button.itemDisabled){
			p->prv.menuLF[ii].button.itemVisible = visible;
		}else{
			p->prv.menuLF[ii].button.itemVisible = 1;//not visible
		}
	}
}

static void menuPageChange(paiHmiTemplate_typ* p, UINT newPage)
{
	//activate first tab (applies to any screen)
	p->runtime.pageChange = newPage;
	p->prv.pageSetByLFMenu = newPage;
}

static void menuCyclicTabKeys(paiHmiTemplate_typ* p);

//logic control of the global MENU KEYS on the Left Side
static void menuCyclicKeysLF(paiHmiTemplate_typ* p)
{
	static int menuVisibleLTOld = 0;
		
	bgTimerCyclic(&p->status.menuLFHideTimer);
	
	//top button pressed?
	if(p->keys.menuKeyTopLT){
		p->keys.menuKeyTopLT = 0;
		if(p->status.menuVisibleLT){
			p->status.menuVisibleLT = 0;		
		}else{
			p->status.menuVisibleLT = 1;		
		}
	}

	//menu item pressed?
	if((p->keys.currentMenuLF >= 0) && (p->keys.currentMenuLF <= paiHMI_ENUM_MENU_ITEMS_LT)){
		p->currentMenuLF = p->keys.currentMenuLF;
		p->keys.currentMenuLF = -1;
		menuPageChange(p, p->prv.menuLF[p->currentMenuLF].button.jumpPageId);		
		p->status.menuVisibleLT = 1;
		menuTopLFSetCurrent(p);
		//if(p->keys.tabKeysRadioDataPoint){
		//	p->keys.tabKeysRadioDataPointOld = 0;
		//	brsmemcpy((UDINT)p->activeTabs, (UDINT)p->prv.menuLF[p->currentMenuLF].tabs , sizeof(p->activeTabs));
		//	menuCyclicTabKeys(p);
		//}else{
			menuTabSetCurrent(p, 1);
		//}		
	}
	
	
	//when menu becomes visible > start the timer
	if(!p->status.menuVisibleLT && menuVisibleLTOld){
		bgTimerStart(&p->status.menuLFHideTimer, 5000); //dropdown timer LF
		menuButtonsVisibility(p, 0);//show menu items	
	}
	
	if(p->status.menuVisibleLT && !menuVisibleLTOld){
		menuButtonsVisibility(p, 1);//hide menu items	
	}
	
	menuVisibleLTOld = p->status.menuVisibleLT;
	//if menu still visible after timer expires > hide menu
	if( !p->status.menuVisibleLT && bgTimerIsTimeOut(&p->status.menuLFHideTimer) ){
		p->status.menuVisibleLT = 1;
	}	
	
	
	
}

//logic control of the tab key operation (i.e. radio button function)
static void menuCyclicTabKeys(paiHmiTemplate_typ* p)
{
	int ii;	
	for(ii=0;ii<=paiHMI_ENUM_TABS_MAXIDX;ii++){
	
		if(p->keys.tabKeysRadioDataPoint != p->keys.tabKeysRadioDataPointOld){
			p->keys.tabKeysRadioDataPointOld = p->keys.tabKeysRadioDataPoint;
			menuPageChange(p, p->activeTabs[p->keys.tabKeysRadioDataPoint].jumpPageId );		
		}
	
		if(ii == p->keys.tabKeysRadioDataPoint){
			p->keys.tabKeysRadioArray[ii] = 1;//select array elements that matches selected radio button		
		}else{
			p->keys.tabKeysRadioArray[ii] = 0;//unselect all other array elements
		}
	}
}


static void paiHmiDefineTab(paiHmiTemplate_typ* p){
int offset;
int keywordLen;
char* pItemLine;
char *pItemTextEnd;
char *pItemPageNum;


	if(!p || !p->prv.indexButton)
		return;

	//Process following line (example):
	//    +------------------ keyword
	//    |     +------------ item label
	//    |     |     +------ page index for jump
	//    |     |     | 
	//"TAB: Main, 10		
	keywordLen = brsstrlen((UDINT)paiHMI_KEYWORD_TAB);
	offset = bgStrFind(p->prv.text, paiHMI_KEYWORD_TAB, 0, keywordLen);
	pItemLine = &p->prv.text[offset + keywordLen];	

	//find 1st comma
	keywordLen = brsstrlen((UDINT)paiHMI_KEYWORD_DELIM);
	offset = bgStrFind(pItemLine, paiHMI_KEYWORD_DELIM, -1, -1);
	if(offset < 0){	
		return;
	}
	pItemTextEnd = &pItemLine[offset];
	pItemPageNum = pItemTextEnd + keywordLen;
	
	//copy item label text
	brsmemcpy((UDINT)p->prv.menuLF[p->prv.indexButton - 1].tabs[p->prv.indexTab].itemText, (UDINT)pItemLine, pItemTextEnd - pItemLine);
	p->prv.menuLF[p->prv.indexButton - 1].tabs[p->prv.indexTab].itemText[offset] = 0;
	
	//get jumpPageIdx
	p->prv.menuLF[p->prv.indexButton - 1].tabs[p->prv.indexTab].jumpPageId = brsatoi((UDINT)pItemPageNum);
	p->prv.menuLF[p->prv.indexButton - 1].tabs[p->prv.indexTab].itemVisible = 0;//visible
	p->prv.menuLF[p->prv.indexButton - 1].tabs[p->prv.indexTab].itemDisabled = 0;//not disabled
		
	//increment button index; reset tab index
	p->prv.indexTab++;	
}

static void paiHmiDefineButton(paiHmiTemplate_typ* p){
int offset;
int keywordLen;
char* pItemLine;
char *pItemTextEnd;
char *pItemPageNum;

	if(!p)
		return;
	
	//Process following line (example):
	//    +------------------ keyword
	//    |     +------------ item label
	//    |     |     +------ page index for jump
	//    |     |     | 
	//"BUTTON: Main, 10		
	keywordLen = brsstrlen((UDINT)paiHMI_KEYWORD_BUTTON);
	offset = bgStrFind(p->prv.text, paiHMI_KEYWORD_BUTTON, 0, keywordLen);
	pItemLine = &p->prv.text[offset + keywordLen];	

	//find 1 comma
	keywordLen = brsstrlen((UDINT)paiHMI_KEYWORD_DELIM);
	offset = bgStrFind(pItemLine, paiHMI_KEYWORD_DELIM, -1, -1);
	if(offset < 0){	
		return;
	}
	pItemTextEnd = &pItemLine[offset];
	pItemPageNum = pItemTextEnd + keywordLen;
	
	//copy text
	brsmemcpy((UDINT)p->prv.menuLF[p->prv.indexButton].button.itemText, (UDINT)pItemLine, pItemTextEnd - pItemLine);
	p->prv.menuLF[p->prv.indexButton].button.itemText[offset] = 0;
	
	//get jumpPageIdx
	p->prv.menuLF[p->prv.indexButton].button.jumpPageId = brsatoi((UDINT)pItemPageNum);
	p->prv.menuLF[p->prv.indexButton].button.itemDisabled = 0;//not disabled
		
}

static void paiHmiDefinePageNavigation(paiHmiTemplate_typ* p){
int ii;
int jj;

	if(!p)
		return;

	//clear parsing error
	brsstrcpy((UDINT)p->prv.parseErrorText, (UDINT)"");
	
	
	//make all buttons and tabs NOT VISIBLE
	for(jj=0; jj <= paiHMI_ENUM_MENU_ITEMS_LT; jj++){
		p->prv.menuLF[jj].button.itemVisible = 1;//not visible
		p->prv.menuLF[jj].button.itemDisabled = 1;//disabled
		for(ii = 0; ii <= paiHMI_ENUM_TABS_MAXIDX ; ii++){
			p->prv.menuLF[jj].tabs[ii].itemVisible = 1;//not visible
		}
	}
	
	//reset tab / button indexes
	p->prv.indexTab = 1;//Start from index 1; Index 0 not used!
	p->prv.indexButton = 0;
	
	for(p->prv.index = 0; p->prv.index <= paiHMI_ENUM_TG_TEXT_MAXIDX; p->prv.index++ ){
	
		bgStrCpyN(p->prv.text, p->prv.textLines[p->prv.index], sizeof(p->prv.text));
		
		if( bgStrFind(p->prv.text, paiHMI_KEYWORD_COMMENT, 0, brsstrlen((UDINT)paiHMI_KEYWORD_COMMENT)) >= 0){
			//comment: skip this line
			continue;
		}	
		
		if( bgStrFind(p->prv.text, paiHMI_KEYWORD_BUTTON, 0, brsstrlen((UDINT)paiHMI_KEYWORD_BUTTON))  >= 0 ){
			//button: process button line
			paiHmiDefineButton(p);
			//increment button index; reset tab index
			p->prv.indexButton++;
			p->prv.indexTab = 1;	
			continue;
		}	

		if( bgStrFind(p->prv.text, paiHMI_KEYWORD_TAB, 0, brsstrlen((UDINT)paiHMI_KEYWORD_TAB)) >= 0 ){
			//tab: process tab line
			paiHmiDefineTab(p);
			continue;
		}	
	}
				
}

static void paiHmiIncTxtIndex(paiHmiTemplate_typ* p){
	if(!p)
		return;
		
	p->prv.index++;
	if(p->prv.index > paiHMI_ENUM_TG_TEXT_MAXIDX ){
		 p->prv.state = 3;
	}
}

static void paiHmiGetTGText(paiHmiTemplate_typ* p){
	if(!p)
		return;
	brsstrcpy((UDINT)p->prv.textLines[p->prv.index], (UDINT)&p->prv.text);	
}

/** Tabs logic */
static void paiHmiParsePageNavigationTG(paiHmiTemplate_typ* p, char* pVisuName, UDINT indexOfTGForHmiNavigation){
	UINT status;

	if(!p || !pVisuName || p->prv.initDone)
		return;

	switch(p->prv.state){
		case 0:
			p->prv.vcHandle = VA_Setup(1 , pVisuName);
			if(p->prv.vcHandle){
				p->prv.state = 1;
				p->prv.index = 0;
			}
		break;
		case 1:
	   		if( VA_Saccess(1, p->prv.vcHandle) )
				return;
			
			p->prv.textLen = sizeof(p->prv.text);		
	        status = VA_GetTextByTextGroup(1, p->prv.vcHandle, indexOfTGForHmiNavigation, p->prv.index, (UDINT)p->prv.text,(UDINT)&p->prv.textLen);			
			if(!status){
			 	//Text read ok; get next text
				paiHmiGetTGText(p);
				paiHmiIncTxtIndex(p);
			}else
			if(status == vaERR_BUSY){
			 
			}else
			if(status == vaERR_PARAMETER){
				paiHmiIncTxtIndex(p);
			}else{
				p->prv.state = 2;			 
			} 
	        VA_Srelease(1, p->prv.vcHandle);		 
		break;
		case 2:
		//error state
		break;
		case 3:
		//parse text lines from the TG, populate page navigation structure
			paiHmiDefinePageNavigation(p);	
			
			//define current top left menu
			menuTopLFSetCurrent(p);
				
			//set current tab 
			menuTabSetCurrent(p, 1);
			
			p->keys.currentMenuLF = -1;
			p->prv.state = 4;			 
		 	p->prv.initDone = 1;			
		break;
		case 4:
		
		break;
	}

}

//logic to handle external page changes (i.e. from the code or VC)
//when such page change takes place, button and tab need adjustment in order to keep it in sync with the new page
static void	menuCyclicExternPageChange(paiHmiTemplate_typ* p)
{
int btnIndex;
int tabIndex;
int found;
	
	if(!p){
		return;
	}
	
	if(p->runtime.pageChange != -1){
		return;//page change in progress, nothing to do
	}
	
	if(p->prv.pageSetByLFMenu == p->runtime.pageCurrent){
		return;//no external page changes
	}
	//exteren page change event! > adjust menu button and tabs!
	//in order to ajdust menu buttons and tabs, need to find a menu button index/tab index pair for the newly selected page index
	found = 0; 
	
	for(btnIndex = 0; btnIndex < paiHMI_ENUM_MENU_ITEMS_LT; btnIndex++){
		
		for(tabIndex=0; tabIndex < paiHMI_ENUM_TABS_MAXIDX; tabIndex++){
			if(p->prv.menuLF[btnIndex].tabs[tabIndex].jumpPageId == p->runtime.pageCurrent){
				found = 1;
				break;	
			}
		}
		
		if(found)
			break;
	}
	
	if(!found){
		//IMPORTANT CASE: we have not found a page that is associated with LF menu/tabs operation
		//don't do anything!
		//Explanation: in this case, a change page was made to a page outside of the scope of LF menu/tabs navigation
		//for example, screen saver could be activated, etc. allow this to take place!!!
		
		return;
	}
	
	p->prv.pageSetByLFMenu = p->runtime.pageCurrent;
	
	//adjust LF menu
	p->keys.currentMenuLF = btnIndex;
	menuCyclicKeysLF(p);
	
	//adjust tabs
	p->keys.tabKeysRadioDataPoint = tabIndex;
	menuCyclicTabKeys(p);
}

void paiHmiPageNavLFMenuTabsCyclic(paiHmiTemplate_typ* p, char* pVisuName, UDINT indexOfTGForHmiNavigation)
{
	if(!p)
		return;
	
	//On system init, parse page navigation Text Group (TG) and build the page navigation structure
	paiHmiParsePageNavigationTG(p, pVisuName, indexOfTGForHmiNavigation);		

	if(!p->prv.initDone)
		return;

	menuCyclicExternPageChange(p);	
	
	menuCyclicKeysLF(p);		
	
	menuCyclicTabKeys(p);	

}
//eof
