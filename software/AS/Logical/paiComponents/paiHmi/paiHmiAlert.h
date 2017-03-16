/********************************************************************
 * COPYRIGHT -- pai
 ********************************************************************
 * Program: hmilogic
 * File: hmiAlert.h
 * Author: goran
 * Created: September 05, 2013
 *******************************************************************/

#include <bur/plctypes.h>
#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif
void paiHmiAlertHide(paiHmiAlert_typ* p);
BOOL paiHmiAlertIsActive(paiHmiAlert_typ* p);
void paiHmiAlertShow(paiHmiAlert_typ* p, char* headerText, char* alertText, UDINT alertDuration);
void paiHmiAlertCyclic(paiHmiAlert_typ* p);



