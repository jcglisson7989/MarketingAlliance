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

void paiHmiSystemDateTimeInit(paiHmiSystemTime_typ* p)
{
}
void paiHmiSystemDateTimeCyclic(paiHmiSystemTime_typ* p)
{	
	if(!p->iChangeTimeRequest){
		p->mGetTime.enable = 1;
		p->mGetTime.DT1 = (UDINT)&p->mDateTime;
		DTGetTime(&p->mGetTime);
		p->mDateTime = p->mGetTime.DT1;		
		DT_TO_DTStructure(p->mDateTime, (UDINT)&p->oDateTimeActual);	
	}else{
		p->iChangeTimeRequest = 0;
		p->mDateTime = DTStructure_TO_DT((UDINT)&p->oDateTimeActual);
		p->mSetTime.enable = 1;
		p->mSetTime.DT1 = p->mDateTime;
		DTSetTime(&p->mSetTime);
	}
	
	
}
//eof
