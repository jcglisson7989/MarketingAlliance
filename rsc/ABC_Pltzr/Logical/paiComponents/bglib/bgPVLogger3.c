/********************************************************************
 * COPYRIGHT -- belgor
 ********************************************************************
 * Package: bglib
 * File: bgPVLogger.c
 * Author: goran
 * Created: October 13, 2011
 *******************************************************************/

#include <bur/plctypes.h>
#include <AsDefault.h>


/** 
 Simple logging.
 Set to 0 when simple log is not needed
 To view this log, open Automation Studio  watch window and insert below defined 
 logxx variable.
 Most recent log entry is always on the top (index 0)
 */
#if 1
//#include "bgsprintf.h"
#include "bgstring.h"

typedef struct bgPVLogger_typ
{
	int initOk;
	char* logbuf;
	int entryCount;
	int entryLen;
}bgPVLogger_typ;


static bgPVLogger_typ lgrObj;	//PV logger object
static bgPVLogger_typ* lgr;	//PV logger object


static void bgPVLoggerInit(bgPVLogger_typ* p, char* logbuf, int logEntryCount, int logEntryLen)
{
	if(!p || !logbuf || !logEntryCount || !logEntryLen)
		return;

	p->logbuf = logbuf;
	p->entryCount = logEntryCount;
	p->entryLen = logEntryLen;
	p->initOk = 1;
}


static void shiftlog(bgPVLogger_typ* p)
{
int ii;
	if(!p || !p->initOk)
		return;
	
	for(ii=(p->entryCount-2); ii>=0; ii--){
		bgStrCpyN(&p->logbuf[(ii+1) * p->entryLen], &p->logbuf[ii * p->entryLen], p->entryLen);
	}		
}

#define DBG(pLoggerInstance, format, args...)	{shiftlog(pLoggerInstance); snprintf2(&pLoggerInstance->logbuf[0], pLoggerInstance->entryLen, format, ## args);}
#define DBGINIT(pLoggerInstance,  logbuf, logEntryCount, logEntryLen) {lgr = &lgrObj; bgPVLoggerInit(pLoggerInstance, &logbuf[0][0], logEntryCount, logEntryLen);}

#else

#define DBG(format, args...)   ;

#endif

	
//#endif
