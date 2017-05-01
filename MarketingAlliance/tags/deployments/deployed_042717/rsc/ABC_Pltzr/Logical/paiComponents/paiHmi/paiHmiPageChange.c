/********************************************************************
 * COPYRIGHT -- pai
 ********************************************************************
 * Program: hmilogic
 * File: hmiAlert.c
 * Author: goran
 * Created: September 05, 2013
 *******************************************************************/

#include <bur/plctypes.h>
#ifdef _DEFAULT_INCLUDES
	#include <AsDefault.h>
#endif

void paiHmiPageChangeInit(paiHmiTemplate_typ* p)
{
	

}


void paiHmiPageChangeCyclic(paiHmiTemplate_typ* pHmi)
{
	if(!pHmi)
		return;	
	
	//change screen is in progress; wait
	if( (UINT)pHmi->runtime.pageChange != 0xFFFF)
		return;
	
	//generate page init/exit events
	pHmi->prv.pageInit = 0;
	pHmi->prv.pageExit = 0;
	
	if(pHmi->runtime.pageCurrent != pHmi->prv.pagePrev){
		pHmi->prv.pageInit = 1;
		pHmi->prv.pagePrev = pHmi->runtime.pageCurrent;

	}
	
	

}
//eof
