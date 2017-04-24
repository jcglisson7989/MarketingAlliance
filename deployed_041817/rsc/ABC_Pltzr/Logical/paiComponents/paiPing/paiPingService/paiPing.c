/********************************************************************
 * COPYRIGHT -- HP
 ********************************************************************
 * Program: TCP_serv
 * File: paiPing.c
 * Author: goran
 * Created: May 16, 2014
 *******************************************************************/

#include <bur/plctypes.h>
#ifdef _DEFAULT_INCLUDES
	#include <AsDefault.h>
#endif


static void paiConvertIpDigitsToIpAddrStr(char* ipAddr, USINT* pDigits)
{
char txtDigit[8];
char txtIpAddr[32];

	if(!ipAddr || !pDigits)
		return;
	
	txtIpAddr[0] = 0;
	
	brsitoa((UDINT)pDigits[0], (UDINT)txtDigit);
	brsstrcat((UDINT)txtIpAddr, (UDINT)txtDigit);		
	brsstrcat((UDINT)txtIpAddr, (UDINT)".");	
	
	brsitoa((UDINT)pDigits[1], (UDINT)txtDigit);
	brsstrcat((UDINT)txtIpAddr, (UDINT)txtDigit);		
	brsstrcat((UDINT)txtIpAddr, (UDINT)".");	
	
	brsitoa((UDINT)pDigits[2], (UDINT)txtDigit);
	brsstrcat((UDINT)txtIpAddr, (UDINT)txtDigit);		
	brsstrcat((UDINT)txtIpAddr, (UDINT)".");	
	
	brsitoa((UDINT)pDigits[3], (UDINT)txtDigit);
	brsstrcat((UDINT)txtIpAddr, (UDINT)txtDigit);		
		
	brsstrcpy((UDINT)ipAddr, (UDINT)txtIpAddr);	
	
}

void paiPingInit(paiPing_typ* p, UDINT pingIntervalXms, UDINT pingTimeoutXms)
{
	p->iPingIntervalxms = pingIntervalXms;//3 seconds
	p->iPingTimeoutxms = pingTimeoutXms;//1 second
}

void paiPingCyclic(paiPing_typ* p)
{
	bgTimerCyclic(&p->mPingTimer);
	p->mIcmpPing.timeout = (p->iPingTimeoutxms / 10);
	switch(p->mState){
		case 0://ping OFF
			if(!p->iEnable){
				p->mIcmpPing.enable = 0;
				p->oPingOk = 0;
				p->oPingStatus = 0;//ping is OFF
				return;
			}
	
			if(!p->iPingTimeoutxms || (p->iPingIntervalxms < (2 * p->iPingTimeoutxms)) ){
				p->iPingTimeoutxms = 1000;
				p->iPingIntervalxms	= 2 * p->iPingTimeoutxms;	
			}
					
			
			if(p->iNumericIpAddr[0] || p->iNumericIpAddr[1] || p->iNumericIpAddr[2] || p->iNumericIpAddr[3] ){
				paiConvertIpDigitsToIpAddrStr(&p->iIPAddrStr[0], &p->iNumericIpAddr[0]);			
			}
			
			p->mIcmpPing.pHost = (UDINT)&p->iIPAddrStr[0];
			bgTimerStart(&p->mPingTimer, p->iPingIntervalxms);
			p->mIcmpPing.enable = 1;
			p->mState = 1;
		break;
		case 1://ping active
		
			if( bgTimerIsTimeOut(&p->mPingTimer) ){
				p->mState = 3;//ping timeout				
				p->mIcmpPing.enable = 0;
			}
		
			if(!p->mIcmpPing.status){
				p->mState = 2;//ping ok
				p->mIcmpPing.enable = 0;
			}
		
		break;	
		case 2://ping OK
			p->oPingOk = 1;
			p->oPingStatus = 2;//ping is OK
			if( bgTimerIsTimeOut(&p->mPingTimer) ){
				p->mState = 0;
			}
			
		break;
		case 3://ping Failed
			p->oPingOk = 0;
			p->oPingStatus = 1;//ping is NOT OK
			p->mState = 0;
		break;
	}

	IcmpPing(&p->mIcmpPing);
}
