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


/** 
Bit manipulaiton utility functions.
 */
#include "../bglib/bgBitUtilities.h"

/** 
String manipulaiton utility functions.
 */
//#include <../../bglib/bgsprintf.h>
#include "../bglib/bgstring.h"

/** 
 Timer control utility functions.
 */
//#include <../../bglib/bgTimer1ms.h>

//Control on/off a variable that control the visibility of the alarm alert display
void paiHmiAlertHide(paiHmiAlert_typ* p)
{
	//control visibility of the layer > make it invisible
	bgBitSetUINT(&p->status, 0, 1);
}

// Is alert message active (visible)?
BOOL paiHmiAlertIsActive(paiHmiAlert_typ* p)
{
	if(bgTimerIsTimeOut(&p->tmr1))
		return 0;
	else
		return 1;
}

// Show the alert with a specified text and for a selected amount of time
void paiHmiAlertShow(paiHmiAlert_typ* p, char* headerText, char* alertText, UDINT alertDuration)
{
	if(!p)
		return;

	//control visibility of the layer > make it visible
	bgBitSetUINT(&p->status, 0, 0);	
	
	if(!headerText){
		bgStrCpyN(p->header, "Message", sizeof(p->header));
	}else{
		bgStrCpyN(p->header, headerText, sizeof(p->header));
	}
	
	if(!p->message){
		bgStrCpyN(p->message, "No message.", sizeof(p->message));	
	}else{
		bgStrCpyN(p->message, alertText, sizeof(p->message));	
	}
	if(alertDuration < 500){
		alertDuration = 500;
	}else
	if(alertDuration > 10000){
		alertDuration = 10000;
	}
	bgTimerStart(&p->tmr1, alertDuration);		
}

// Cyclic operation of the alert box.
void paiHmiAlertCyclic(paiHmiAlert_typ* p)
{
	bgTimerCyclic(&p->tmr1);			
	if( !(p->status & 0x1) && bgTimerIsTimeOut(&p->tmr1) ){
		paiHmiAlertHide(p);
	}
}
//eof
