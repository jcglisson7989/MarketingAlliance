#ifndef _BG_DEBUG_H
#define _BG_DEBUG_H

#include <bur/plctypes.h>
#ifdef _DEFAULT_INCLUDES
	#include <AsDefault.h>
#endif

#ifdef WIN32
#define DBG printf
#define DBGMSG printf


#define DBGCRT printf
#define DBGERR printf
#define DBGWAR printf
#define DBGINF printf
#define DBGDBG printf

#else

#include <bur/plc.h>
#include "bgringbuffer.h"

#define BG_DEBUG_LEVEL_CRITICAL		0
#define BG_DEBUG_LEVEL_ERROR		1
#define BG_DEBUG_LEVEL_WARNING		2
#define BG_DEBUG_LEVEL_INFO			3
#define BG_DEBUG_LEVEL_DEBUG		4

#define BG_DEBUG_UNUSED	0x0


/*
- To completly remove debug msgs from the source code use:
#define BG_DEBUG_ENABLE 0
*/
#define BG_DEBUG_ENABLE 1


#if BG_DEBUG_ENABLE == 1
/*BG_DEBUG_ENABLE == 1 => debug messages present in the source code*/
#define DBG(pRB, format, args...)	bgRingBuffPutDbgInfo(pRB, __FILE__, (char*)__FUNCTION__, BG_DEBUG_LEVEL_CRITICAL, BG_DEBUG_UNUSED, format, ## args);
#define DBGMSG(pRB, format, args...)  {char txt[512]; snprintf2(txt, 512, format, ## args);	brsstrcat((UDINT)txt, (UDINT)"\r"); bgRingBuffPutString(pRB, txt);}

#define DBGCRT(pRB, format, args...)	bgRingBuffPutDbgInfo(pRB, __FILE__, (char*)__FUNCTION__, BG_DEBUG_LEVEL_CRITICAL, BG_DEBUG_UNUSED, format, ## args);
#define DBGERR(pRB, format, args...)	bgRingBuffPutDbgInfo(pRB, __FILE__, (char*)__FUNCTION__, BG_DEBUG_LEVEL_ERROR, BG_DEBUG_UNUSED, format, ## args);
#define DBGWAR(pRB, format, args...)	bgRingBuffPutDbgInfo(pRB, __FILE__, (char*)__FUNCTION__, BG_DEBUG_LEVEL_WARNING, BG_DEBUG_UNUSED, format, ## args);
#define DBGINF(pRB, format, args...)	bgRingBuffPutDbgInfo(pRB, __FILE__, (char*)__FUNCTION__, BG_DEBUG_LEVEL_INFO, BG_DEBUG_UNUSED, format, ## args);
#define DBGDBG(pRB, format, args...)	bgRingBuffPutDbgInfo(pRB, __FILE__, (char*)__FUNCTION__, BG_DEBUG_LEVEL_DEBUG, BG_DEBUG_UNUSED, format, ## args);


#else	
/*BG_DEBUG_ENABLE == 0 => all debug messages removed from the source code*/
#define DBG(pRB, format, args...)  ;
#define DBGMSG(pRB, format, args...)  ;

#define DBGCRT(pRB, format, args...)	;
#define DBGERR(pRB, format, args...)	;
#define DBGWAR(pRB, format, args...)	;
#define DBGINF(pRB, format, args...)	;
#define DBGDBG(pRB, format, args...)	;

	
#endif /*#if BG_DEBUG_ENABLE*/

#endif /*#ifdef WIN32*/

#endif /*#ifndef _BG_DEBUG_H*/
