/********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Program: paiFile
 * File: paiFile.c
 * Author: goran_2
 * Created: August 05, 2011
 ********************************************************************
 * Implementation of program paiFile
 ********************************************************************/

#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
 #include <AsDefault.h>
#endif

#include "../../Libraries/sprintf2/sprintf2.h"
#include "paiFile.h"

/**
 Simple logging
 Log goes to an array of PV strings > see _LOCAL STRING log[][] variable below
 Log output is visible via Automation Studio watch window
 Example of a log statement used within the code is: 
 DBG("This is log example. %d ", value1);
 To complety disable logging from this source file, change next line to: #if 0
*/
#if 1
#include <../../bglib/bgPVLogger3.c>
#define LOG_ENTRY_COUNT 50	//max number of log entries
#define LOG_ENTRY_LENGTH  63 //max length of individual log message. Longer msg are truncated
_LOCAL STRING log[LOG_ENTRY_COUNT][LOG_ENTRY_LENGTH]; //log output visible from Automation Studio!
//static bgPVLogger_typ lgr;	//PV logger object
#else
#define DBG(format, args...) ;
#define DBGINIT()  ;
#endif

/*component states*/
enum{
	paiFileServiceStateIdle = 0,
	paiFileServiceStatePowerUp,
	paiFileServiceStateLink,
	paiFileServiceStateLinkError,
	paiFileServiceStateLinkNext,
	paiFileServiceStateOpenForRead,
	paiFileServiceStateRead,
	paiFileServiceStateOpenForWrite,
	paiFileServiceStateWrite,
	paiFileServiceStateWriteEx,
	paiFileServiceStateClose,
	paiFileServiceStateCreate,
	paiFileServiceStateDelete,
	paiFileServiceStateInfo,
	paiFileServiceStateDirInfo,
	paiFileServiceStateDirCreate,
	paiFileServiceLast
}APPCFGSTATEMACHINE;

const char* getPaiFileServiceStateName(int state)
{
static const char* stateNames[] = {
"Idle",
"PowerUp",	
"Link",	
"LinkError",	
"LinkNext",	
"OpenForRead",
"Read",
"OpenForWrite",
"Write",
"WriteEx",
"Close",
"Create",
"Delete",
"Info",
"DirInfo",
"DirCreate",
};

	if( state >= paiFileServiceLast)
		return "unknow";
	
	return stateNames[state];
};


/*
###############################################################################
Typedefs
###############################################################################
*/

//unsigned short paiFileServiceInit(paiFileService_typ* p, char* pDevice, char* pDeviceParam)
unsigned short paiFileServiceInit(paiFileService_typ* p, paiFileServiceDeviceTable_typ* pDeviceTable)
{
	if(!p)
		return 0;
	
	brsmemset((UDINT)p, 0, sizeof(paiFileService_typ));
	
	p->prv.pDeviceTable = pDeviceTable;
	
//	p->prv.device.link.pDevice = (UDINT)pDevice;
//	p->prv.device.link.pParam= (UDINT)pDeviceParam;
	
//	p->prv.file.open.pDevice = (UDINT)pDevice;

	
	

	bgSSMInit(&p->prv.bgssm, (UDINT)getPaiFileServiceStateName, 0);

	if(!pDeviceTable || ((p->prv.pDeviceTable->listDevsDirs[0].deviceName[0] == 0) && (p->prv.pDeviceTable->listDevsDirs[0].dirName[0] == 0))){
		//no devices defined
		bgSSMStateNext(&p->prv.bgssm, paiFileServiceStateIdle);
		
	}else{
		//link all available devices & check / create all specified folders
		p->prv.requestType = 0;
		bgSSMStateNext(&p->prv.bgssm, paiFileServiceStatePowerUp);
	}
	
	p->o.busy = 0;
	p->o.status = 0;
	p->o.initOk = 0;
	p->o.done = 0;
	p->o.bytecount = 0;	
				
	p->prv.device.link.enable = 0;
	
	p->prv.file.create.enable = 0;
	p->prv.file.open.enable = 0;
	p->prv.file.close.enable = 0;
	p->prv.file.read.enable = 0;
	p->prv.file.readex.enable = 0;
	p->prv.file.write.enable = 0;
	p->prv.file.writeex.enable = 0;

	p->prv.dir.info.enable = 0;
	p->prv.dir.create.enable = 0;
	return 0;
}

void paiFileServiceCyclicNextState(paiFileService_typ* p, unsigned short currentStatus, int nextstate, int errorstate)
{
	if(currentStatus == ERR_FUB_BUSY)
		return;

	if(currentStatus != ERR_OK){
		p->prv.status = currentStatus;
		DBG(lgr,"err=%d", currentStatus);
		bgSSMStateNext(&p->prv.bgssm, errorstate);
	}else{
		p->prv.status = ERR_OK;
		bgSSMStateNext(&p->prv.bgssm, nextstate);
	}
}

static BOOL paiFileServiceIsBusy(unsigned short currentStatus)
{
	if(currentStatus == ERR_FUB_BUSY)
		return 1;
	
	return 0;
}

static BOOL paiFileServiceIsError(unsigned short currentStatus)
{
	if(currentStatus != ERR_OK)
		return 1;
	
	return 0;
}


void	paiFileServiceIO(paiFileService_typ* p)
{

	if(!p) 
		return;

	if(!p->o.initOk)
		return;

	/*process file read request*/
	if(!p->o.busy && (p->i.request == PAI_FS_RDFILE)){
		p->o.busy = 1;
		p->o.status = 0;
		p->o.done = 0;
		p->o.bytecount = 0;	
		
		p->prv.file.open.pDevice = p->i.adrDeviceName;
		p->prv.file.open.pFile = p->i.adrName;
		p->prv.file.open.mode = fiREAD_ONLY;
		p->prv.file.readex.pDest = p->i.adrReadDst;
		p->prv.file.readex.len = p->i.readDstLen;
		p->prv.requestType = paiFileServiceStateRead;	
		DBG(lgr,"RDFile, dev=%s, fName=%s", (char*)p->i.adrDeviceName, (char*)p->i.adrName);
		bgSSMStateNext(&p->prv.bgssm, paiFileServiceStateOpenForRead);
		return;
	}


	/*process file write request*/
	if(!p->o.busy && (p->i.request == PAI_FS_WRFILE)){
		p->o.busy = 1;
		p->o.status = 0;
		p->o.done = 0;
		p->o.bytecount = 0;	
		
		p->prv.file.open.pDevice = p->i.adrDeviceName;
		p->prv.file.create.pDevice = p->i.adrDeviceName;		
		p->prv.file.open.pFile = p->i.adrName;
		p->prv.file.open.mode = fiREAD_WRITE;
		//p->prv.file.open.mode = fiWRITE_ONLY;		
		p->prv.file.write.pSrc = p->i.adrWriteSrc;
		p->prv.file.write.len = p->i.writeSrcLen;
		p->prv.file.writeex.pSrc = p->i.adrWriteSrc;
		p->prv.file.writeex.len = p->i.writeSrcLen;
		p->prv.requestType = paiFileServiceStateWrite;
		DBG(lgr,"WRFile, dev=%s, fName=%s", (char*)p->i.adrDeviceName, (char*)p->i.adrName);
		bgSSMStateNext(&p->prv.bgssm, paiFileServiceStateOpenForWrite);
		return;
	}

	/*process file info request*/
	if(!p->o.busy && (p->i.request == PAI_FS_INFOFILE)){
		p->o.busy = 1;
		p->o.status = 0;
		p->o.done = 0;
		p->o.bytecount = 0;	
		
		p->prv.file.info.pDevice = p->i.adrDeviceName;
		p->prv.file.info.pName = p->i.adrName;
		p->prv.file.info.pInfo = (UDINT)&p->prv.file.infoData;
		
		DBG(lgr,"INFFile, dev=%s, fName=%s", (char*)p->i.adrDeviceName, (char*)p->i.adrName);
		bgSSMStateNext(&p->prv.bgssm, paiFileServiceStateInfo);
		return;
	}

	/*process file delete request*/
	if(!p->o.busy && (p->i.request == PAI_FS_DELFILE)){
		p->o.busy = 1;
		p->o.status = 0;
		p->o.done = 0;
		p->o.bytecount = 0;	
		
		p->prv.file.delete.pDevice = p->i.adrDeviceName;
		p->prv.file.delete.pName = p->i.adrName;
		
		DBG(lgr,"DELFile, dev=%s, fName=%s", (char*)p->i.adrDeviceName, (char*)p->i.adrName);
		bgSSMStateNext(&p->prv.bgssm, paiFileServiceStateDelete);
		return;
	}

	
	/*process dir info request*/
	if(!p->o.busy && (p->i.request == PAI_FS_INFODIR)){
		p->o.busy = 1;
		p->o.status = 0;
		p->o.done = 0;
		p->o.bytecount = 0;	
		
		p->prv.dir.info.pDevice = p->i.adrDeviceName;
		p->prv.dir.info.pPath = p->i.adrName;
		
		DBG(lgr,"DirInfo, dev=%s path=%s", (char*)p->i.adrDeviceName, (char*)p->i.adrName);
		bgSSMStateNext(&p->prv.bgssm, paiFileServiceStateDirInfo);
		return;
	}

	/*process dir create request*/
	if(!p->o.busy && (p->i.request == PAI_FS_CRDIR)){
		p->o.busy = 1;
		p->o.status = 0;
		p->o.done = 0;
		p->o.bytecount = 0;	
		
		p->prv.dir.create.pDevice = p->i.adrDeviceName;
		p->prv.dir.create.pName = p->i.adrName;
		
		DBG(lgr,"DirCreate, dev=%s, name=%s", (char*) p->i.adrDeviceName, (char*)p->i.adrName);
		bgSSMStateNext(&p->prv.bgssm, paiFileServiceStateDirCreate);
		return;
	}


	
}

void paiFileServiceCyclic(paiFileService_typ* p)
{

bgSSM_typ *pssm = &p->prv.bgssm;
	
	if(!p)
		return;

	paiFileServiceIO(p);


	/*execute control state machine cyclic handler*/		
	bgSSMCyclic(pssm);
	//show change of state in a log
	if( bgSSMIsStateInit(pssm) ){
		DBG(lgr,"sm=%s(%d)", bgSSMGetStateText(pssm), bgSSMGetState(pssm));
	}
	switch( bgSSMGetState(pssm) ){
		/*--------------------------------------------------*/
		case paiFileServiceStateIdle:
			if( bgSSMIsStateInit(pssm) ){
				p->o.busy = 0;

				p->prv.device.link.enable = 0;
				
				p->prv.file.create.enable = 0;
				p->prv.file.open.enable = 0;
				p->prv.file.close.enable = 0;
				p->prv.file.read.enable = 0;
				p->prv.file.readex.enable = 0;
				p->prv.file.write.enable = 0;
				p->prv.file.writeex.enable = 0;

				p->prv.dir.info.enable = 0;
				p->prv.dir.create.enable = 0;
			}

		break;
		/*--------------------------------------------------*/
		case paiFileServiceStatePowerUp:
			{
				if( bgSSMIsStateInit(pssm) ){
					p->o.powerUp = 1;
					if(p->prv.pDeviceTable->listDevsDirs[p->prv.currentDeviceIndex].deviceConfiguration[0] != 0){
						//configuration string is defined > entry is a device link request
						p->prv.device.link.enable = 1;
						p->prv.device.link.pDevice = (UDINT)p->prv.pDeviceTable->listDevsDirs[p->prv.currentDeviceIndex].deviceName;
						p->prv.device.link.pParam= (UDINT)p->prv.pDeviceTable->listDevsDirs[p->prv.currentDeviceIndex].deviceConfiguration;
						DBG(lgr,"PwrUp|DevLink|dev=%s,cfg=%s", (char*)p->prv.device.link.pDevice, p->prv.device.link.pParam);	
						bgSSMStateNext(pssm, paiFileServiceStateLink);
					}else{
						//configuration string is NOT defined > entry is a related to directory (i.e check if dir exists; if not, create it)
						p->prv.dir.info.enable = 1;
						p->prv.dir.info.pDevice = (UDINT)p->prv.pDeviceTable->listDevsDirs[p->prv.currentDeviceIndex].deviceName;
						p->prv.dir.info.pPath = (UDINT)p->prv.pDeviceTable->listDevsDirs[p->prv.currentDeviceIndex].dirName;
						DBG(lgr,"PwrUp|DirTest|dev=%s,dir=%s", (char*)p->prv.dir.info.pDevice, p->prv.dir.info.pPath);	
						bgSSMStateNext(pssm, paiFileServiceStateDirInfo);
					}
					break;
				}
			}
			break;
		/*--------------------------------------------------*/
		case paiFileServiceStateLink:
		{
			if( bgSSMIsStateInit(pssm) ){
				p->prv.device.link.enable = 1;
				p->prv.device.link.pDevice = (UDINT)p->prv.pDeviceTable->listDevsDirs[p->prv.currentDeviceIndex].deviceName;
				p->prv.device.link.pParam= (UDINT)p->prv.pDeviceTable->listDevsDirs[p->prv.currentDeviceIndex].deviceConfiguration;	
				break;
			}
			

			if( paiFileServiceIsBusy(p->prv.device.link.status) )
				break;

//			p->o.done = 1;
			p->prv.device.link.enable = 0;
				
			if( paiFileServiceIsError(p->prv.device.link.status) ){
				/*override default handling for certain errors*/
				DBG(lgr,"link.status=%d", p->prv.device.link.status);
				if(p->prv.device.link.status == fiERR_DEVICE_ALREADY_EXIST){
					p->prv.device.link.status = 0;
					//p->prv.pDeviceTable->listDevices[p->prv.currentDeviceIndex].status = 0;	
				}else{
					//p->prv.pDeviceTable->listDevices[p->prv.currentDeviceIndex].status = p->prv.device.link.status;	
				}
			}
			p->prv.pDeviceTable->listDevsDirs[p->prv.currentDeviceIndex].status = p->prv.device.link.status;	
			bgSSMStateNext(pssm, paiFileServiceStateLinkNext);
			
			//p->o.initOk = 1;
			//bgSSMStateNext(pssm, paiFileServiceStateIdle);
		}
		break;
		/*--------------------------------------------------*/
		case paiFileServiceStateLinkError:
		{
			if( bgSSMIsStateInit(pssm) ){
				p->o.initOk = 0;
			}
			// TODO: device link error handling
		}
		break;
		/*--------------------------------------------------*/
		case paiFileServiceStateLinkNext:
			{
				if( bgSSMIsStateInit(pssm) ){
					p->prv.currentDeviceIndex++;
					if( (p->prv.currentDeviceIndex > PAI_FS_DEVICE_MAXIDX) || 
						(p->prv.pDeviceTable->listDevsDirs[p->prv.currentDeviceIndex].deviceName[0] == 0) ){
						p->o.done = 1;
						p->o.initOk = 1;
						p->o.powerUp = 0;
						bgSSMStateNext(pssm, paiFileServiceStateIdle);				
					}else{
						bgSSMStateNext(pssm, paiFileServiceStatePowerUp);					
					}	
				}
				// TODO: device link next handling
			}
			break;
		/*--------------------------------------------------*/
		case paiFileServiceStateOpenForRead:
		{

			if( bgSSMIsStateInit(pssm) ){
				p->prv.file.open.enable = 1;
				break;
			}

			if( paiFileServiceIsBusy(p->prv.file.open.status) )
				break;

			p->o.done = 1;
			p->prv.file.open.enable = 0;
			if( paiFileServiceIsError(p->prv.file.open.status) ){
				DBG(lgr,"open.status=%d", p->prv.file.open.status);
				p->o.status = p->prv.file.open.status;
				bgSSMStateNext(pssm, paiFileServiceStateIdle);
				break;
			}

			p->prv.file.readex.ident = p->prv.file.open.ident;
			p->prv.file.close.ident = p->prv.file.open.ident;
			bgSSMStateNext(pssm, paiFileServiceStateRead);
		}
		break;
		/*--------------------------------------------------*/
		case paiFileServiceStateRead:
		{
			if( bgSSMIsStateInit(pssm) ){
				p->prv.file.readex.enable = 1;
				break;
			}
			
			if( paiFileServiceIsBusy(p->prv.file.readex.status) )
				break;

			p->o.done = 1;
			p->o.bytecount = p->prv.file.readex.bytesread;	
			p->prv.file.readex.enable = 0;
			if( paiFileServiceIsError(p->prv.file.readex.status) ){
				DBG(lgr,"readex.status=%d", p->prv.file.readex.status);
				p->o.status = p->prv.file.readex.status;
			}

			//write 0 into the read buffer at the position where content that was just read ends
			//this is important when reading from a text file and than post processing using 
			//string functions
			if(p->prv.file.readex.bytesread < p->prv.file.readex.len){
				*((char*)(p->prv.file.readex.pDest + p->prv.file.readex.bytesread)) = 0;
			}

			bgSSMStateNext(pssm, paiFileServiceStateClose);
		}
		break;
		/*--------------------------------------------------*/
		case paiFileServiceStateOpenForWrite:
		{
			if( bgSSMIsStateInit(pssm) ){
				p->prv.file.open.enable = 1;
				break;
			}
			
			if( paiFileServiceIsBusy(p->prv.file.open.status) )
				break;

			p->o.done = 1;
			p->prv.file.open.enable = 0;
			if( paiFileServiceIsError(p->prv.file.open.status) ){
				DBG(lgr,"open.status=%d", p->prv.file.open.status);
				/*override default handling for certain errors*/
				if(p->prv.file.open.status == fiERR_FILE_NOT_FOUND ){
					/*write request & file not found > create file*/
					
					bgSSMStateNext(pssm, paiFileServiceStateCreate);
					break;
				}			
				
				p->o.status = p->prv.file.open.status;
				bgSSMStateNext(pssm, paiFileServiceStateIdle);
				break;				
			}

			p->prv.file.write.ident = p->prv.file.open.ident;
			p->prv.file.writeex.ident = p->prv.file.open.ident;
			p->prv.file.close.ident = p->prv.file.open.ident;
//			bgSSMStateNext(pssm, paiFileServiceStateWrite);			
			bgSSMStateNext(pssm, paiFileServiceStateWriteEx);			
		}
		break;
		/*--------------------------------------------------*/
		case paiFileServiceStateWrite:
		{
			if( bgSSMIsStateInit(pssm) ){
				p->prv.file.write.enable = 1;
				break;
			}
			
			if( paiFileServiceIsBusy(p->prv.file.write.status) )
				break;

			p->o.done = 1;
			p->prv.file.write.enable = 0;
			if( paiFileServiceIsError(p->prv.file.write.status) ){
				DBG(lgr,"write.status=%d", p->prv.file.write.status);
				p->o.status = p->prv.file.write.status;
			}

			bgSSMStateNext(pssm, paiFileServiceStateClose);			
		}
		break;
		/*--------------------------------------------------*/
		case paiFileServiceStateWriteEx:
		{
			if( bgSSMIsStateInit(pssm) ){
				p->prv.file.writeex.enable = 1;
				//p->prv.file.writeex.option = fiTruncate;		
				p->prv.file.writeex.option = 0;		
				p->prv.file.writeex.offset = 0;		
					break;
			}
			
			if( paiFileServiceIsBusy(p->prv.file.writeex.status) )
				break;

			p->o.done = 1;
			p->prv.file.writeex.enable = 0;
			if( paiFileServiceIsError(p->prv.file.writeex.status) ){
				DBG(lgr,"writeex.status=%d", p->prv.file.writeex.status);
				p->o.status = p->prv.file.writeex.status;
			}

			bgSSMStateNext(pssm, paiFileServiceStateClose);			
		}
		break;
		/*--------------------------------------------------*/
		case paiFileServiceStateClose:
		{
			if( bgSSMIsStateInit(pssm) ){
				p->prv.file.close.enable = 1;
				break;
			}
			
			if( paiFileServiceIsBusy(p->prv.file.close.status) )
				break;

			p->o.done = 1;
			p->prv.file.close.enable = 0;
			if( paiFileServiceIsError(p->prv.file.close.status) && !p->o.status){
				DBG(lgr,"close.status=%d", p->prv.file.close.status);
				p->o.status = p->prv.file.close.status;
			}

			bgSSMStateNext(pssm, paiFileServiceStateIdle);			
		}
		break;
		/*--------------------------------------------------*/
		case paiFileServiceStateCreate:
		{	
			if( bgSSMIsStateInit(pssm) ){
				p->prv.file.create.enable = 1;
				//p->prv.file.create.pDevice = p->prv.device.link.pDevice;
				p->prv.file.create.pFile = p->i.adrName;
				break;
			}
			
			if( paiFileServiceIsBusy(p->prv.file.create.status) )
				break;

			p->o.done = 1;
			p->prv.file.create.enable = 0;
			if( paiFileServiceIsError(p->prv.file.create.status) ){
				DBG(lgr,"create.status=%d", p->prv.file.create.status);
				p->o.status = p->prv.file.create.status;
				bgSSMStateNext(pssm, paiFileServiceStateIdle);
				break;
			}

			p->prv.file.write.ident = p->prv.file.create.ident;
			p->prv.file.close.ident = p->prv.file.create.ident;
			bgSSMStateNext(pssm, paiFileServiceStateWrite);			
		}
		break;
		/*--------------------------------------------------*/
		case paiFileServiceStateInfo:
			{	
				if( bgSSMIsStateInit(pssm) ){
					p->prv.file.info.enable = 1;
					break;
				}
			
				if( paiFileServiceIsBusy(p->prv.file.info.status) )
					break;

				p->o.done = 1;
				p->prv.file.info.enable = 0;
				if( paiFileServiceIsError(p->prv.file.info.status) ){
					DBG(lgr,"info.status=%d", p->prv.file.info.status);
					p->o.status = p->prv.file.info.status;
					bgSSMStateNext(pssm, paiFileServiceStateIdle);
					break;
				}

				p->o.status = p->prv.file.info.status;
				bgSSMStateNext(pssm, paiFileServiceStateIdle);
			}
			break;
		/*--------------------------------------------------*/
		case paiFileServiceStateDelete:
			{	
				if( bgSSMIsStateInit(pssm) ){
					p->prv.file.delete.enable = 1;
					break;
				}
			
				if( paiFileServiceIsBusy(p->prv.file.delete.status) )
					break;

				p->o.done = 1;
				p->prv.file.delete.enable = 0;
				if( paiFileServiceIsError(p->prv.file.delete.status) ){
					DBG(lgr,"delete.status=%d", p->prv.file.delete.status);
					p->o.status = p->prv.file.delete.status;
					bgSSMStateNext(pssm, paiFileServiceStateIdle);
					break;
				}

				p->o.status = p->prv.file.delete.status;
				bgSSMStateNext(pssm, paiFileServiceStateIdle);
			}
			break;
		/*--------------------------------------------------*/		
		case paiFileServiceStateDirInfo:
		{	
			if( bgSSMIsStateInit(pssm) ){
				p->prv.dir.info.enable = 1;
				break;
			}
			
			if( paiFileServiceIsBusy(p->prv.dir.info.status) )
				break;

			p->o.done = 1;
			p->prv.dir.info.enable = 0;
			
			//support for power up check/creation of folders
			if(p->o.powerUp){
				if( paiFileServiceIsError(p->prv.dir.info.status) ){
						DBG(lgr,"dir.info.status=%d | PwrUP>try create", p->prv.dir.info.status);
						p->prv.dir.create.pDevice = p->prv.dir.info.pDevice;
						p->prv.dir.create.pName = p->prv.dir.info.pPath;						
						bgSSMStateNext(pssm, paiFileServiceStateDirCreate);						
					}else{
						p->prv.pDeviceTable->listDevsDirs[p->prv.currentDeviceIndex].status = 0;
						bgSSMStateNext(pssm, paiFileServiceStateLinkNext);						
					}	
				break;	
			}		
				
			if( paiFileServiceIsError(p->prv.dir.info.status) ){
				DBG(lgr,"dir.info.status=%d", p->prv.dir.info.status);
				p->o.status = p->prv.dir.info.status;
				bgSSMStateNext(pssm, paiFileServiceStateIdle);
				break;
			}

			bgSSMStateNext(pssm, paiFileServiceStateIdle);			
		}
		break;
		/*--------------------------------------------------*/
		case paiFileServiceStateDirCreate:
		{	
			if( bgSSMIsStateInit(pssm) ){
				p->prv.dir.create.enable = 1;
				break;
			}
			
			if( paiFileServiceIsBusy(p->prv.dir.create.status) )
				break;

			//support for power up check/creation of folders
			if(p->o.powerUp){
				if( paiFileServiceIsError(p->prv.dir.create.status) ){
					DBG(lgr,"dir.create.status=%d | PwrUP>FATALERR", p->prv.dir.create.status);
					p->prv.pDeviceTable->listDevsDirs[p->prv.currentDeviceIndex].status = p->prv.dir.create.status;
				}else{
					//indicate that this directory is just created at system power up
					p->prv.pDeviceTable->listDevsDirs[p->prv.currentDeviceIndex].createdAtPowerUp = 1;
					p->prv.pDeviceTable->listDevsDirs[p->prv.currentDeviceIndex].status = 0;
				}	
				bgSSMStateNext(pssm, paiFileServiceStateLinkNext);						
				break;	
			}		
				
				
			p->o.done = 1;
			p->prv.dir.create.enable = 0;
			if( paiFileServiceIsError(p->prv.dir.create.status) ){
				DBG(lgr,"dir.create.status=%d", p->prv.dir.create.status);
				p->o.status = p->prv.dir.create.status;
				bgSSMStateNext(pssm, paiFileServiceStateIdle);
				break;
			}

			bgSSMStateNext(pssm, paiFileServiceStateIdle);			
		}
		break;
		/*--------------------------------------------------*/
		default:
		{
			bgSSMStateNext(&p->prv.bgssm, paiFileServiceStateIdle);
		}
		break;			
		/*--------------------------------------------------*/
	}


	DevLink(&p->prv.device.link);
	
	FileCreate(&p->prv.file.create);
	FileOpen(&p->prv.file.open);
	FileReadEx(&p->prv.file.readex);
	FileWrite(&p->prv.file.write);
	FileWriteEx(&p->prv.file.writeex);
	FileClose(&p->prv.file.close);
	FileInfo(&p->prv.file.info);
	FileDelete(&p->prv.file.delete);
			
	DirInfo(&p->prv.dir.info);
	DirCreate(&p->prv.dir.create);


	return;
}

/*
###############################################################################
PV-s
###############################################################################
*/
void paiFSDeviceAndDirConfig();

/*
###############################################################################
Init, Cyclic, Exit
###############################################################################
*/
void _INIT paiFileSrvINIT( void )
{
	/* TODO: Add code here */
	DBGINIT(lgr, log, LOG_ENTRY_COUNT, LOG_ENTRY_LENGTH);
		
	//Configure devices and directories in this application
	//Executed at system startup
	paiFSDeviceAndDirConfig();
		
	paiFileServiceInit(&paiFS, &paiFSDevices);	
}

void _CYCLIC paiFileSrvCYCLIC( void )
{
	/* TODO: Add code here */	
	paiFileServiceCyclic(&paiFS);
}

void _EXIT paiFileSrvEXIT( void )
{
	/* TODO: Add code here */
}
