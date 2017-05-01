/********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Package: paiFileService
 * File: paiPVSerDesMgr.h
 * Author: goran
 * Created: August 18, 2015
 *******************************************************************/

#include <bur/plctypes.h>

void paiPVSerDesMgrInit(paiPVSerDesMgr_typ* p);
void paiPVSerDesMgrCyclic(paiPVSerDesMgr_typ* p);

//callback functions
void paiCBWriteFileSerPV(paiFileService_typ* p, UDINT pCallbackData);
void paiCBReadFileDesPV(paiFileService_typ* p, UDINT pCallbackData);


//EOF
