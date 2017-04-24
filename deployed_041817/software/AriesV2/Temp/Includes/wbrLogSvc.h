/* Automation Studio generated header file */
/* Do not edit ! */
/* wbrLogSvc  */

#ifndef _WBRLOGSVC_
#define _WBRLOGSVC_
#ifdef __cplusplus
extern "C" 
{
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
#ifdef _SG4
		#include "AsArLog.h"
		#include "wbrsprintf.h"
		#include "wbrListSvc.h"
#endif
#ifdef _SG3
		#include "AsArLog.h"
		#include "wbrsprintf.h"
		#include "wbrListSvc.h"
#endif
#ifdef _SGC
		#include "AsArLog.h"
		#include "wbrsprintf.h"
		#include "wbrListSvc.h"
#endif

/* Datatypes and datatypes of function blocks */
typedef struct wbrLogServiceTextLog_typ
{	plcstring view[128][128];
	struct wbrListSvcStringList_typ str;
} wbrLogServiceTextLog_typ;

typedef struct wbrLogServiceLogListNode_typ
{	struct AsArLogWrite fb;
	plcstring inMsg[128];
} wbrLogServiceLogListNode_typ;

typedef struct wbrLogService_typ
{	struct linkedList_typ list;
	plcstring message[128];
	struct wbrLogServiceTextLog_typ log;
	unsigned char logLevel;
	plcbit busy;
	unsigned long maxNodesUsed;
} wbrLogService_typ;

typedef struct wbrLogServiceLogbookInfo_typ
{	plcstring name[16];
	unsigned long length;
	unsigned long memType;
	unsigned short status;
	unsigned long ident;
	unsigned long index;
	unsigned long formatVer;
	struct AsArLogGetInfo* fb;
} wbrLogServiceLogbookInfo_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC unsigned long setLogServiceDataAddress(struct wbrLogService_typ* p);
_BUR_PUBLIC signed long initLogService(void);
_BUR_PUBLIC signed long requestMessageToLog(unsigned long msgAdr, unsigned long logIdent, unsigned long logMsgType, unsigned long erNum, unsigned long data, unsigned long dataLen);
_BUR_PUBLIC signed long requestInfoMsgToLogbookNoData(unsigned long msgAdr, unsigned long logIdent);
_BUR_PUBLIC signed long requestMessageToLogDefault(unsigned long msgAdr);
_BUR_PUBLIC signed long writeMessagesToLog(void);
_BUR_PUBLIC signed long getLogbookInfo(struct wbrLogServiceLogbookInfo_typ* logInfo);
_BUR_PUBLIC signed long createNewLogbook(struct wbrLogServiceLogbookInfo_typ* logInfo);


#ifdef __cplusplus
};
#endif
#endif /* _WBRLOGSVC_ */

