/********************************************************************
 * COPYRIGHT -- piedmont
 ********************************************************************
 * Program: cfgFS
 * File: cfgFS.c
 * Author: admin
 * Created: Jan 20, 2014
 ********************************************************************
 * Implementation of program cfgFS
 ********************************************************************/

#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
 #include <AsDefault.h>
#endif

/**
 Simple logging
 Log goes to an array of PV strings > see _LOCAL STRING log[][] variable below
 Log output is visible via Automation Studio watch window
 Example of a log statement used within the code is: 
 DBG("This is log example. %d ", value1);
 To complety disable logging from this source file, change next line to: #if 0
*/
#if 1
#include <../../paiComponents/bglib/bgPVLogger3.c>
#define LOG_ENTRY_COUNT 30	//max number of log entries
#define LOG_ENTRY_LENGTH  200//max length of individual log message. Longer msg are truncated
_LOCAL STRING log[LOG_ENTRY_COUNT][LOG_ENTRY_LENGTH]; //log output visible from Automation Studio!
//static bgPVLogger_typ lgr;	//PV logger object
#else
#define DBG(format, args...) ;
#define DBGINIT(args...) ;
#endif

//Support for PV serialization/deserialization
#include "../../paiComponents/bglib/bgPVSerialize.h"
#include "../appCfgRecDefault.h"
#include "../../paiComponents/paiFileService/paiPVSerDesMgr.h"
#include "../../paiComponents/paiFileService/paiFSInterface.h"
#include "../../paiComponents/paiFileService/paiFS/paiFile.h"
#include "../../paiComponents/Libraries/sprintf2/sprintf2.h"

/*
###############################################################################
PV-s
###############################################################################
*/


/*
###############################################################################
Functions
###############################################################################
*/

static void fileSetCfgFilePath(char* pCfgFilePath)
{
//Example:
//Output: pRecFilePath = "ABC/appcfg.txt"
	sprintf2(pCfgFilePath, "%s/%s", APP_DIR_NAME, APP_FILENAME_CFG);
}


/*
###############################################################################
Remanent Memory Handling
- remanent (REM) memory is battery backed SRAM
- unlike files, it has a fast, pointer based access
- in this application, it is used as a first level of storage, as follows

  working memory (DRAM) data   
- valid only while CPU powered
- working memory holds all PV-s and application strucutres

Remanent memory (SRAM battery backed) 
- power fail safe (only WARM restart! COLD restart deletes remanent memory)
- selected structures (eg. machine confiuration, current recipe) are copied into this area as a first level backup
- fast backup via simple memcpy

Files (CF disk)
- power fail safe and permanent
- backup requires use of FileIO access (slower, more complex)

This application combines use of the above mentioned memories.

IMPORTANT:
The REMMEM support was added before realizing that most CPU-s support only tiny (eg. 32 bytes) REM Memory areas.
As a result, the REM memory support is not really working as intended. The intended REMMEM PV-s are stored as
regular PV-s which means that these values are not preserved during power cycle.
###############################################################################
*/


static void defineFileNames()
{
	//file that holds machine configuration	
	//Example: cfgFilename = "Data/appcfg.txt"
	fileSetCfgFilePath(cfgFilename);
	
}

/*
###############################################################################
Init, Cyclic, Exit
###############################################################################
*/
void paiPVSerDesMgrConfigure();

void _INIT appCfgRecInit( void )
{
	/* TODO: Add code here */
	DBGINIT(lgr, log, LOG_ENTRY_COUNT, LOG_ENTRY_LENGTH);
	
	//Define file names used for storign PV-s in this application
	defineFileNames();			//define file names used in this application
	
	//Configure paiSerDesMgr
	paiPVSerDesMgrConfigure();

	
	//TODO: gRecipe
	brsstrcpy((UDINT)gRecipe.info.name, (UDINT)"ABC");
}

void _CYCLIC appCfgRecCyclic( void )
{	
	
	//paiFS callback execution cyclic service
	//This service executes File IO related callbacks in the context of this task
	paiFSExeCallbackCyclic(&paiFS);

	//paiSerDesMgr cyclic
	paiPVSerDesMgrCyclic(&gPVSerDesMgr);		
}
//EOF
