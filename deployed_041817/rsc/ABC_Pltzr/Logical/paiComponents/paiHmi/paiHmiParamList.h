/********************************************************************
 * COPYRIGHT -- pai
 ********************************************************************
 * Program: hmilogic
 * File: hmiParamList.h
 * Author: goran
 * Created: September 05, 2013
 *******************************************************************/
#include <bur/plctypes.h>
#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif
void hmiParamListTableCyclic(hmiParamListTable_typ* p);
void hmiParamListTableEntryLast(hmiParamListTable_typ* p);
void hmiParamListTableEntryFirst(hmiParamListTable_typ* p, char* pListName);
 void hmiParamListTableAddEntryNext(hmiParamListTable_typ* p, UDINT pValue, char* pName, REAL valDefault, REAL valMin, REAL valMax, int decPlaces, REAL k_factor, REAL n_factor, UINT valueType, char* pDescription);



