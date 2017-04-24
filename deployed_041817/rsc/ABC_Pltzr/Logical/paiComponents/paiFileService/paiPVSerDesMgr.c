/********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Package: paiFileService
 * File: paiPVSerDesMgr.c
 * Author: goran
 * Created: August 18, 2015
 *******************************************************************/

#include <bur/plctypes.h>
#ifdef _DEFAULT_INCLUDES
	#include <AsDefault.h>
#endif

#include "../bglib/bgPVSerialize.h"
#include "paiPVSerDesMgr.h"
#include "paiFSInterface.h"
/*
###############################################################################
Functions
###############################################################################
*/
/**
captureCurrentTimeStamp()
-captures current datetime, converts it to a string a places the result string into a user supplied 
text buffer (pDst, dstSize)
*/
static void captureCurrentTimeStamp(char* pDst, UDINT dstSize)
{

	char txt_yyyy[8];
	char txt_mo[8];
	char txt_dd[8];
	char txt_hh[8];
	char txt_mm[8];
	char txt_ss[8];
	char txt_ms[8];

	if(!pDst)
		return;
		
	DTStructureGetTime_typ DTStrGetTime_1;
	DTStructure DTStruc;
	
	DTStrGetTime_1.enable = 1;
	DTStrGetTime_1.pDTStructure = (UDINT)&DTStruc;
	DTStructureGetTime(&DTStrGetTime_1);
	
	brsitoa(DTStruc.year, (UDINT)txt_yyyy);
	brsitoa(DTStruc.month, (UDINT)txt_mo);
	brsitoa(DTStruc.day, (UDINT)txt_dd);
	brsitoa(DTStruc.hour, (UDINT)txt_hh);
	brsitoa(DTStruc.minute, (UDINT)txt_mm);
	brsitoa(DTStruc.second, (UDINT)txt_ss);
	brsitoa(DTStruc.millisec, (UDINT)txt_ms);
	
	//sprintf(pDst, "%02d %02d %04d %02d:%02d:%02d", DTStruc.month, DTStruc.day, DTStruc.year, DTStruc.hour, DTStruc.minute, DTStruc.second);
	brsstrcpy((UDINT)pDst, (UDINT)txt_yyyy);
	brsstrcat((UDINT)pDst, (UDINT)"-");
	brsstrcat((UDINT)pDst, (UDINT)txt_mo);
	brsstrcat((UDINT)pDst, (UDINT)"-");
	brsstrcat((UDINT)pDst, (UDINT)txt_dd);
	brsstrcat((UDINT)pDst, (UDINT)" ");
	brsstrcat((UDINT)pDst, (UDINT)txt_hh);
	brsstrcat((UDINT)pDst, (UDINT)":");
	brsstrcat((UDINT)pDst, (UDINT)txt_mm);
	brsstrcat((UDINT)pDst, (UDINT)":");
	brsstrcat((UDINT)pDst, (UDINT)txt_ss);
	brsstrcat((UDINT)pDst, (UDINT)".");
	brsstrcat((UDINT)pDst, (UDINT)txt_ms);
}
/*
###############################################################################
PV Serialize / Deserialize Mgr
###############################################################################
*/

static void paiPVInitAtPowerUpCyclicSetStatus(char* pStatus, char* pText)
{
	brsstrcpy((UDINT)pStatus, (UDINT)pText);
}


static void paiPVInitAtPowerUpCyclic(paiPVSerDesMgr_typ* p)
{
	int ii;
	
	if(!p)
		return;
	
	for(ii=0; ii < p->iItemCount; ii++){		
		if(p->pvItems[ii].optInitAtPowerUp.oInitReady)
			continue;
		
		//0-nothing to do
		if(p->pvItems[ii].optInitAtPowerUp.iPowerUpConfig == 0){
			p->pvItems[ii].optInitAtPowerUp.oInitReady = 1;
			paiPVInitAtPowerUpCyclicSetStatus(p->pvItems[ii].optInitAtPowerUp.oStatus, "off");
			continue;
		}
	
		//1-use test data, if diff, execute just default function
		if(p->pvItems[ii].optInitAtPowerUp.iPowerUpConfig == 1){
			//check test data validity
			if(!p->pvItems[ii].optInitAtPowerUp.pTestDataStorage ||
				!p->pvItems[ii].optInitAtPowerUp.iTestData){
				p->pvItems[ii].optInitAtPowerUp.oError = 1;
				continue;
			}	
			
			//check if callback function defined
			if(!p->pvItems[ii].pCallbackDefault){
				p->pvItems[ii].optInitAtPowerUp.oError = 2;
				continue;			
			}
			
			//compare test data
			if( (*(UDINT*)(p->pvItems[ii].optInitAtPowerUp.pTestDataStorage)) != p->pvItems[ii].optInitAtPowerUp.iTestData ){
				//difference!!! > execute default function
				void (*fDefault)() =  ( void(*) () ) p->pvItems[ii].pCallbackDefault;
				(*fDefault)();
				p->pvItems[ii].optInitAtPowerUp.oInitReady = 1;
				paiPVInitAtPowerUpCyclicSetStatus(p->pvItems[ii].optInitAtPowerUp.oStatus, "test+dflt");
			}else{
				p->pvItems[ii].optInitAtPowerUp.oInitReady = 1;			
				paiPVInitAtPowerUpCyclicSetStatus(p->pvItems[ii].optInitAtPowerUp.oStatus, "test+n.a.");
			}
			
			//write test data to data storage
			*((UDINT*)p->pvItems[ii].optInitAtPowerUp.pTestDataStorage) = p->pvItems[ii].optInitAtPowerUp.iTestData;
			continue;	
		}
		
		//2-use test data, if diff, execute default function then restore data from file
		if(p->pvItems[ii].optInitAtPowerUp.iPowerUpConfig == 2){
			//check test data validity
			if(!p->pvItems[ii].optInitAtPowerUp.pTestDataStorage ||
			!p->pvItems[ii].optInitAtPowerUp.iTestData){
				p->pvItems[ii].optInitAtPowerUp.oError = 1;
				continue;
			}	
			
			//check if callback function defined
			if(!p->pvItems[ii].pCallbackDefault){
				p->pvItems[ii].optInitAtPowerUp.oError = 2;
				continue;			
			}
			
			//compare test data
			if( *((UDINT*)p->pvItems[ii].optInitAtPowerUp.pTestDataStorage) != p->pvItems[ii].optInitAtPowerUp.iTestData ){
				//difference!!! > execute default function
				void (*fDefault)() =  ( void(*) () ) p->pvItems[ii].pCallbackDefault;
				(*fDefault)();
				//p->pvItems[ii].optInitAtPowerUp.oInitReady = 1;				
				paiPVInitAtPowerUpCyclicSetStatus(p->pvItems[ii].optInitAtPowerUp.oStatus, "test+dflt");
				//now, request read from file
				p->pvItems[ii].iDesRequest = 1;
			}else{
				paiPVInitAtPowerUpCyclicSetStatus(p->pvItems[ii].optInitAtPowerUp.oStatus, "test+n.a.");
				p->pvItems[ii].optInitAtPowerUp.oInitReady = 1;			
			}
			
			//write test data to data storage
			*((UDINT*)p->pvItems[ii].optInitAtPowerUp.pTestDataStorage) = p->pvItems[ii].optInitAtPowerUp.iTestData;			
			continue;	
		}
	}
}

static void paiPVChangeMonitorInit(paiPVSerDesMgr_typ* p)
{
	
	
}

static void paiPVChangeMonitorCyclic(paiPVSerDesMgr_typ* p)
{
int ii;
	
	if(!p)
		return;
	
	for(ii=0; ii < p->iItemCount; ii++){
		
		//HMI DesRequest (i.e. Read PV from file request via HMI)
		if(!p->pvItems[ii].iDesRequest && (p->pvItems[ii].optPtrHMIData && p->pvItems[ii].optPtrHMIData->iBtnDesRequest)){
			p->pvItems[ii].optPtrHMIData->iBtnDesRequest = 0;
			p->pvItems[ii].iDesRequest = 1;
			continue;
		}
			
		//HMI SerRequest (i.e. Write PV to file request via HMI)
		if(!p->pvItems[ii].iSerRequest && (p->pvItems[ii].optPtrHMIData && p->pvItems[ii].optPtrHMIData->iBtnSerRequest)){
			p->pvItems[ii].optPtrHMIData->iBtnSerRequest = 0;
			p->pvItems[ii].iSerRequest = 1;
			continue;
		}	
		
		//check if feature PV change monitoring feature is enabled for an item
		if(!p->pvItems[ii].optChangeMonitor.iChngEnable)
			continue;

		if(!p->pvItems[ii].pPV || !p->pvItems[ii].iPVSize){
			p->pvItems[ii].optChangeMonitor.oError = 3;
			continue;
		}
		
		if(!p->pvItems[ii].optChangeMonitor.pChangeMonitorMem){
			p->pvItems[ii].optChangeMonitor.oError = 1;
			continue;
		}
		
		if(p->pvItems[ii].iPVSize > p->pvItems[ii].optChangeMonitor.iChangeMonitorMemSize ){
			p->pvItems[ii].optChangeMonitor.oError = 2;
			continue;		
		}
	
		if(p->pvItems[ii].optChangeMonitor.oState == 0){
			//init state > copy PV to private memory, begin change monitor
			brsmemcpy((UDINT)p->pvItems[ii].optChangeMonitor.pChangeMonitorMem, (UDINT)p->pvItems[ii].pPV, p->pvItems[ii].iPVSize);

			p->pvItems[ii].optChangeMonitor.iChngAccepted = 0;
			p->pvItems[ii].optChangeMonitor.iChngRejected = 0;
			p->pvItems[ii].optChangeMonitor.oChngDetected = 0;
			
			p->pvItems[ii].optChangeMonitor.oState = 1;
		}
		
		if(p->pvItems[ii].optChangeMonitor.oState == 1){			
			
			//working state > monitor PV changes
			if( !brsmemcmp((UDINT)p->pvItems[ii].optChangeMonitor.pChangeMonitorMem, (UDINT)p->pvItems[ii].pPV, p->pvItems[ii].iPVSize) ){
				p->pvItems[ii].optChangeMonitor.oChngDetected = 0;
				if(p->pvItems[ii].optPtrHMIData){
					//HMI is defined
					p->pvItems[ii].optPtrHMIData->oBtnVisible = 1;//not visible
				}				
				continue;
			}
			//change detected!
			p->pvItems[ii].optChangeMonitor.oChngDetected = 1;
			if(p->pvItems[ii].optPtrHMIData){
				//HMI is defined
				p->pvItems[ii].optPtrHMIData->oBtnVisible = p->pvItems[ii].optChangeMonitor.oChngDetected ? 0 : 1;
			}				
						
			if(p->pvItems[ii].optChangeMonitor.iChngRejected || (p->pvItems[ii].optPtrHMIData && p->pvItems[ii].optPtrHMIData->iBtnChangeReject)){
				p->pvItems[ii].optChangeMonitor.iChngRejected = 0;
				if(p->pvItems[ii].optPtrHMIData){
					//HMI is defined
					p->pvItems[ii].optPtrHMIData->iBtnChangeReject = 0;
				}				
				
				//restore changes from the private memory
				memcpy(p->pvItems[ii].pPV, p->pvItems[ii].optChangeMonitor.pChangeMonitorMem, p->pvItems[ii].iPVSize);
			}
			
			if(!p->pvItems[ii].iSerRequest && (p->pvItems[ii].optChangeMonitor.iChngAccepted || 
				(p->pvItems[ii].optPtrHMIData && p->pvItems[ii].optPtrHMIData->iBtnChangeAccept))){
				p->pvItems[ii].optChangeMonitor.iChngAccepted = 0;
				if(p->pvItems[ii].optPtrHMIData){
					//HMI is defined
					p->pvItems[ii].optPtrHMIData->iBtnChangeAccept = 0;
				}				
				p->pvItems[ii].iSerRequest = 1;
				//update private memory
				memcpy(p->pvItems[ii].optChangeMonitor.pChangeMonitorMem, p->pvItems[ii].pPV, p->pvItems[ii].iPVSize);
			}					
		}		
	}
}

/*
Callback routine for paiPVSerDesMgr manager used for processing paiPVSerDesDesFromFile request.
This routine will be invoked following a file RD request.
The file data is deserialized into a provided PV within this function.
IMPORTANT:
- to handle a posibility for either file read error or deserialize error, make sure that the 
given PV variable is initialized to default values before this request is executed.
*/
void paiCBReadFileDesPV(paiFileService_typ* p, UDINT pCallbackData)
{
DINT errCount;
paiPVSerDesMgr_typ* pPVSerDesMgr;
int ii;
	
	if(!p || !pCallbackData){
//		DBG(lgr,"cbReadFileDesPV: err: pCallbackData=0!");
		return;
	}
	
	pPVSerDesMgr = (paiPVSerDesMgr_typ*)pCallbackData;
	ii = pPVSerDesMgr->oState;

	captureCurrentTimeStamp(&pPVSerDesMgr->pvItems[ii].oTimestampLastDes[0], sizeof(pPVSerDesMgr->pvItems[ii].oTimestampLastDes));
	
	//read error?
	if(p->o.status){
		pPVSerDesMgr->pvItems[ii].oDesCount++;
		pPVSerDesMgr->pvItems[ii].oErrorCount++;
		pPVSerDesMgr->pvItems[ii].oError = p->o.status;
		//read error for a config file > file does not exist > use defaults!
		//gConfigApp.out.readcountererr++;
//		DBG(lgr,"cbReadFileDesPV: fileRD err (%s, %d)", pPVSerDesMgr->pvItems[ii].iFilename, p->o.status);
		
		//DBG(lgr,"cfg RD error=%d", paiFS.o.status);
//		DBG(lgr,"cbReadFileDesPV: Using cfg defaults");
		// TODO: nofify machine operator
		return;
	}
	
//	DBG(lgr,"cbReadFileDesPV: fileRD OK (%s)", pPVSerDesMgr->pvItems[ii].iFilename);
	
	pPVSerDesMgr->pvItems[ii].oDesCount++;
	pPVSerDesMgr->pvItems[ii].oFilesizeLastDes = p->o.bytecount;
	
	errCount = bgPVStructDeserialize(pPVSerDesMgr->pvItems[ii].iPVName, (char*)pPVSerDesMgr->pvItems[ii].pFilebuffer, p->prv.file.readex.bytesread);			
	if(errCount){
//		DBG(lgr,"cbReadFileDesPV: des err(%d); struct change?", errCount);
	}
	
	//write test data to data storage if this option is enabled/defined
	if(!pPVSerDesMgr->pvItems[ii].optInitAtPowerUp.oInitReady && pPVSerDesMgr->pvItems[ii].optInitAtPowerUp.pTestDataStorage && pPVSerDesMgr->pvItems[ii].optInitAtPowerUp.iTestData){
		*((UDINT*)pPVSerDesMgr->pvItems[ii].optInitAtPowerUp.pTestDataStorage) = pPVSerDesMgr->pvItems[ii].optInitAtPowerUp.iTestData;
		paiPVInitAtPowerUpCyclicSetStatus(pPVSerDesMgr->pvItems[ii].optInitAtPowerUp.oStatus, "test+dflt+fRD");
		pPVSerDesMgr->pvItems[ii].optInitAtPowerUp.oInitReady = 1;
	}
	
	//Reset change monitor
	pPVSerDesMgr->pvItems[ii].optChangeMonitor.oState = 0;
	
}


void paiCBWriteFileSerPV(paiFileService_typ* p, UDINT pCallbackData)
{
paiPVSerDesMgr_typ* pPVSerDesMgr;
int ii;
	
	if(!p || !pCallbackData){
//		DBG(lgr,"cbWriteFileSerPV: err: pCallbackData=0!");
		return;
	}
	
	pPVSerDesMgr = (paiPVSerDesMgr_typ*)pCallbackData;
	ii = pPVSerDesMgr->oState;
	
	captureCurrentTimeStamp(&pPVSerDesMgr->pvItems[ii].oTimestampLastSer[0], sizeof(pPVSerDesMgr->pvItems[ii].oTimestampLastSer));
	
	//write error?
	if(p->o.status){
		pPVSerDesMgr->pvItems[ii].oErrorCount++;
		pPVSerDesMgr->pvItems[ii].oError = p->o.status;
		//read error for a config file > file does not exist > use defaults!
		//gConfigApp.out.readcountererr++;
//		DBG(lgr,"cbWriteFileSerPV: fileRD err (%s, %d)", pPVSerDesMgr->pvItems[ii].iFilename, p->o.status);
		
		//DBG(lgr,"cfg RD error=%d", paiFS.o.status);
//		DBG(lgr,"cbWriteFileSerPV: Using cfg defaults");
		// TODO: nofify machine operator
		return;
	}
	
//	DBG(lgr,"cbWriteFileSerPV: fileRD OK (%s)", pPVSerDesMgr->pvItems[ii].iFilename);	
}

static BOOL paiPVSerDesSerToFile(paiPVSerDesMgr_typ* p, char* pvName, char* fileDeviceName, char* fileName, UDINT pBuffer, UDINT bufSize, UDINT pCallbackSer)
{
	DINT jj;
	DINT charsWritten;
	
	if(!p || !pvName || !fileName || !pBuffer || !bufSize)
		return 0;
	
	jj = p->oState;	
	charsWritten = bgPVStructSerialize(pvName, (char*)pBuffer, bufSize);
	if(  charsWritten > 0){
//		DBG(lgr,"WRrec %s size=%d", fileName, charsWritten);
		p->pvItems[jj].oFilesizeLastSer = charsWritten;
		p->pvItems[jj].oSerCount++;
		paiFSFileWrRequest((paiFileService_typ*) p->pPaiFS, (UDINT) fileDeviceName, (UDINT)fileName, (UDINT)pBuffer, charsWritten, (UDINT) pCallbackSer, (UDINT) p);
		return 1;
	}else{
		p->pvItems[jj].oSerCount++;
		p->pvItems[jj].oErrorCount++;
//		DBG(lgr,"Can't serialize pv=%s", pvName);
		return 0;
	}
}

static void paiPVSerDesDesFromFile(paiPVSerDesMgr_typ* p, char* pvName, char* fileDeviceName, char* fileName, UDINT pBuffer, UDINT bufSize, UDINT pCallbackDes)
{
	paiFSFileRdRequest((paiFileService_typ*)p->pPaiFS, (UDINT) fileDeviceName, (UDINT)fileName, (UDINT)pBuffer, bufSize, (UDINT) pCallbackDes, (UDINT) p);
}


static BOOL paiPVSerDesIsItemDataOk(paiPVSerDesMgr_typ* p, int jj)
{
	//jj - current item index
	if(	!p->pvItems[jj].iPVName[0] || 
		!p->pvItems[jj].pPV ||
		!p->pvItems[jj].iPVSize ||
		!p->pvItems[jj].iFilename[0] ||
		!p->pvItems[jj].iDevicename[0] ||
		!p->pvItems[jj].pFilebuffer ||
		!p->pvItems[jj].iFilebufferSize){
		return 0; //not ok
	}
	
	return 1; //ok
}

void paiPVSerDesMgrInit(paiPVSerDesMgr_typ* p)
{
	if(!p || !p->iItemCount || (p->iItemCount > (PAI_FS_SERDESMGR_MAXITEMIDX+1)))
		return;
	
	//PV Change Monitor - init
	paiPVChangeMonitorInit(p);
}

void paiPVSerDesMgrCyclic(paiPVSerDesMgr_typ* p)
{
int ii;
int jj;

	//check params
	if(!p || !p->pPaiFS || !p->iItemCount || (p->iItemCount > (PAI_FS_SERDESMGR_MAXITEMIDX+1)))
		return;

	//PV InitAtPowerUp option
	paiPVInitAtPowerUpCyclic(p);
	
	//PV Change Monitor - cyclic
	paiPVChangeMonitorCyclic(p);
	
	//nothing to do if paiFS is busy
	if( paiFSFileRequestIsBusy((paiFileService_typ*)p->pPaiFS) )
		return;

	//check current item beeing processed	
	if(p->oState >= p->iItemCount ){
		p->oState = 0;
	}
	
	//scan for serialize / deserialize requests	
	for(ii = 0, jj = p->oState; ii < p->iItemCount; ii++){
	
		if(p->pvItems[jj].iSerRequest){
			p->pvItems[jj].iSerRequest = 0;
			if( paiPVSerDesIsItemDataOk(p, jj) ){
				p->oState = jj;
				paiPVSerDesSerToFile(p, (char*)p->pvItems[jj].iPVName,(char*)p->pvItems[jj].iDevicename, (char*)p->pvItems[jj].iFilename, (UDINT)p->pvItems[jj].pFilebuffer, p->pvItems[jj].iFilebufferSize, (UDINT) p->pvItems[jj].pCallbackSer);
				break;
			}else{
				p->pvItems[jj].oError = 1;
				brsstrcpy((UDINT)p->pvItems[jj].oErrorTxt, (UDINT)"paiPVSerDesSerToFile: Invalid Input Params" );			
			}
		}
		
		if(p->pvItems[jj].iDesRequest){		
			p->pvItems[jj].iDesRequest = 0;
			if( paiPVSerDesIsItemDataOk(p, jj) ){
				p->oState = jj;
				paiPVSerDesDesFromFile(p, (char*)p->pvItems[jj].iPVName,(char*)p->pvItems[jj].iDevicename, (char*)p->pvItems[jj].iFilename, (UDINT)p->pvItems[jj].pFilebuffer, p->pvItems[jj].iFilebufferSize, (UDINT) p->pvItems[jj].pCallbackDes);
				break;			
			}else{
				p->pvItems[jj].oError = 1;
				brsstrcpy((UDINT)p->pvItems[jj].oErrorTxt, (UDINT)"paiPVSerDesDesFromFile: Invalid Input Params" );			
			}
		}
	
		if(++jj >= p->iItemCount){
			jj = 0;
		} 
	}
}
//eof


