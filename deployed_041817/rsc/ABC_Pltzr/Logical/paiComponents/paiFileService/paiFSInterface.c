/********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Package: paiFileService
 * File: paiFSInterface.c
 * Author: goran
 * Created: August 18, 2015
 *******************************************************************/

#include <bur/plctypes.h>
#ifdef _DEFAULT_INCLUDES
	#include <AsDefault.h>
#endif

#include "paiFSInterface.h"

/*
###############################################################################
Utility function to access paiFS service
###############################################################################
*/
void paiFSSetCallback(paiFileService_typ* p, UDINT pCallback, UDINT pCallbackData)
{
	if(!p)
		return;
		
	p->i.pCallback = pCallback;
	p->i.pCallbackData = pCallbackData;
}

void paiFSExeCallback(paiFileService_typ* p)
{
	if(!p)
		return;
		
	//execute fs callback to enable app to process file io
	if(p->i.pCallback){
		void (*fsCB)(paiFileService_typ* pFS, UDINT pCallbackData) =  ( void(*) (paiFileService_typ* pFS, UDINT pCallbackData) ) p->i.pCallback;
		(*fsCB)(p, p->i.pCallbackData);
	}
}

void paiFSExeCallbackCyclic(paiFileService_typ* p)
{
	//wait until request completes
	if( paiFSFileRequestIsBusy(p) )
		return;
	
	if( p->o.done ){
		//clear done event
		p->o.done = 0;
		
		//execute call back after file IO command execution is complete
		paiFSExeCallback(p);
	}				
}

void paiFSDirCreateRequest(paiFileService_typ* p, UDINT adrDeviceName, UDINT adrPath, UDINT pCallback, UDINT pCallbackData)
{
	p->i.request = PAI_FS_CRDIR;
	p->i.adrName = (UDINT)adrPath;
	p->i.adrDeviceName = (UDINT) adrDeviceName;
	paiFSSetCallback(p, pCallback, pCallbackData);
}


void paiFSDirInfoRequest(paiFileService_typ* p, UDINT adrDeviceName, UDINT adrPath, UDINT pCallback, UDINT pCallbackData)
{
	p->i.request = PAI_FS_INFODIR;
	p->i.adrName = (UDINT)adrPath;
	p->i.adrDeviceName = (UDINT) adrDeviceName;
	paiFSSetCallback(p, pCallback, pCallbackData);
}

void paiFSFileDelRequest(paiFileService_typ* p, UDINT adrDeviceName, UDINT adrName, UDINT pCallback, UDINT pCallbackData)
{
	p->i.request = PAI_FS_DELFILE;
	p->i.adrName = (UDINT)adrName;
	p->i.adrDeviceName = (UDINT) adrDeviceName;
	paiFSSetCallback(p, pCallback, pCallbackData);
}

void paiFSFileRdRequest(paiFileService_typ* p, UDINT adrDeviceName, UDINT adrName, UDINT adrDst, UDINT sizeDst, UDINT pCallback, UDINT pCallbackData)
{
	p->i.request = PAI_FS_RDFILE;
	p->i.adrDeviceName = (UDINT) adrDeviceName;
	p->i.adrName = (UDINT)adrName;
	p->i.adrReadDst = (UDINT)adrDst;
	p->i.readDstLen = sizeDst;
	paiFSSetCallback(p, pCallback, pCallbackData);
}


void paiFSFileWrRequest(paiFileService_typ* p, UDINT adrDeviceName, UDINT adrName, UDINT adrSrc, UDINT sizeSrc, UDINT pCallback, UDINT pCallbackData)
{
	p->i.request= PAI_FS_WRFILE;
	p->i.adrDeviceName = (UDINT) adrDeviceName;
	p->i.adrName = (UDINT)adrName;
	p->i.adrWriteSrc = (UDINT)adrSrc;
	p->i.writeSrcLen= sizeSrc;
	paiFSSetCallback(p, pCallback, pCallbackData);
}


BOOL paiFSFileRequestIsBusy(paiFileService_typ* p)
{
	//wait until request completes
	if(p->o.busy)
		return 1;

	//reset request! IMPORTANT!
	p->i.request = PAI_FS_IDLE;
	return 0;
}

BOOL paiFSFileSystemIsInit(paiFileService_typ* p)
{
	if(!p->o.initOk)	//can't do much before paiFS completes
		return 0;
		
	return 1;	
}
