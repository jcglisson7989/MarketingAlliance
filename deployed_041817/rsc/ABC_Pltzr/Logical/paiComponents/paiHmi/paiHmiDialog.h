/********************************************************************
 * COPYRIGHT -- pai
 ********************************************************************
 * Program: hmilogic
 * File: hmiDialog.h
 * Author: goran
 * Created: September 05, 2013
 *******************************************************************/

#include <bur/plctypes.h>
#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif
BOOL paiHmiDialogIsActive(paiHmiDialog_typ* p);
void paiHmiDialogHide(paiHmiDialog_typ* p);
void paiHmiDialogShow(paiHmiDialog_typ* p, char* msg, UINT timeout_ms, UINT resultForOk, UINT resultForCancel, UINT timeoutConfig);
UINT paiHmiDialogCyclic(paiHmiDialog_typ* p);




