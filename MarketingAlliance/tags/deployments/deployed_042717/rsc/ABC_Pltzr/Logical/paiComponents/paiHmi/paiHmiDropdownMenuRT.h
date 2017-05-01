/********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Package: paiHmiTemplate
 * File: paiHmiDropdownMenuRT.h
 * Author: goran
 * Created: July 29, 2015
 *******************************************************************/

#include <bur/plctypes.h>
#ifdef _DEFAULT_INCLUDES
	#include <AsDefault.h>
#endif


//logic control of the global MENU KEYS on the Left Side (i.e. STOPPED, FILLING, PRODUCTION, ...)
void paiHmiDropDownMenuRTInit(paiHmiDropdwMenuRT_typ* p);
//logic control of the global MENU KEYS on the Left Side (i.e. STOPPED, FILLING, PRODUCTION, ...)
void paiHmiDropDownMenuRTCyclic(paiHmiDropdwMenuRT_typ *p);
