/********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Package: paiHmiTemplate
 * File: paiHmiMsgScrolling.h
 * Author: goran
 * Created: July 29, 2015
 *******************************************************************/

#include <bur/plctypes.h>
#ifdef _DEFAULT_INCLUDES
	#include <AsDefault.h>
#endif
void paiHmiMsgScrollingInit(paiHmiMsgScrolling_typ* p, UDINT pAlarmArray, UDINT alarmArrayLen, UDINT msgTimeXms);
void paiHmiMsgScrollingCyclic(paiHmiMsgScrolling_typ* p);
