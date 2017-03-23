/********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Package: paiHmiTemplate
 * File: paiHmiMsgScrolling.c
 * Author: goran
 * Created: July 29, 2015
 *******************************************************************/

#include <bur/plctypes.h>
#ifdef _DEFAULT_INCLUDES
	#include <AsDefault.h>
#endif

/*
###############################################################################
Message scrolling support
###############################################################################
*/
static DINT paiHmiMsgScrollingGetNext(paiHmiMsgScrolling_typ* p, UDINT startIndex)
{
	int ii, jj;
	BOOL* pAlarm;
	
	if(!p)
		return -1;
	
	pAlarm = (BOOL*)p->iAdrAlarmArray;
	
	for(ii=0, jj=startIndex; ii < p->iAlarmArrayLen; ii++){
		if( *(pAlarm + jj) ){
			return jj;
		}
		if(++jj>=p->iAlarmArrayLen){
			jj=0;
		}
	}
	return -1;
}

void paiHmiMsgScrollingInit(paiHmiMsgScrolling_typ* p, UDINT pAlarmArray, UDINT alarmArrayLen, UDINT msgTimeXms)
{
	if(!p)
		return;

	p->iAdrAlarmArray = (UDINT) pAlarmArray;
	p->iAlarmArrayLen = alarmArrayLen;
	p->iMsgTimeXms = msgTimeXms;
	p->state = 0; //msg not active
	p->oMsgID = 0;
	p->oMsgVisible = 1; //msg not visibile
}

void paiHmiMsgScrollingCyclic(paiHmiMsgScrolling_typ* p)
{
	int ii;
	BOOL* pAlarm;
	
	if(!p)
		return;

	pAlarm = (BOOL*)p->iAdrAlarmArray;
	
	//operate timer
	bgTimerCyclic(&p->tmr1) ;

	if(!p->iEnable){
		p->oMsgID = 0;
		p->state = 0;
		p->oMsgVisible = 1;
		return;
	}	
	
	//if msg not active, keep searching until it becomes active
	if(!p->state){
		if( (ii = paiHmiMsgScrollingGetNext(p, 0)) < 0){
			return;
		}
		p->oMsgID = ii;
		p->state = 1;
		p->oMsgVisible = 0;
		bgTimerStart(&p->tmr1, p->iMsgTimeXms); 
		return;
	} 

	//timer not expired and the same alarm still active > wait
	if( !bgTimerIsTimeOut(&p->tmr1) && *(pAlarm + p->oMsgID) ){
		return;
	}
	
	//timer expired or msg not active any longer > find next msg to show
	if( (ii = paiHmiMsgScrollingGetNext(p, p->oMsgID + 1)) < 0){
		p->oMsgID = 0;
		p->state = 0;
		p->oMsgVisible = 1;
		return;
	}

	//show next msg
	p->oMsgID = ii;
	p->state = 1;
	p->oMsgVisible = 0;
	bgTimerStart(&p->tmr1, p->iMsgTimeXms); 
}
//EOF

