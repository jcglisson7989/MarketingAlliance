/* Automation Studio generated header file */
/* Do not edit ! */
/* wbrPingSvc  */

#ifndef _WBRPINGSVC_
#define _WBRPINGSVC_
#ifdef __cplusplus
extern "C" 
{
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
#ifdef _SG4
		#include "astime.h"
		#include "wbrLogSvc.h"
		#include "bglibasWBR.h"
		#include "AsICMP.h"
#endif
#ifdef _SG3
		#include "astime.h"
		#include "wbrLogSvc.h"
		#include "bglibasWBR.h"
		#include "AsICMP.h"
#endif
#ifdef _SGC
		#include "astime.h"
		#include "wbrLogSvc.h"
		#include "bglibasWBR.h"
		#include "AsICMP.h"
#endif

/* Datatypes and datatypes of function blocks */
typedef struct wbrPingService_typ
{	struct IcmpPing fb;
	plcbit enable;
	unsigned short timeout;
	unsigned short count;
	unsigned short errorStatus;
	plcbit failed;
	unsigned char successesToCount;
	unsigned char failuresToCount;
	plcstring message1[128];
	plcstring message[128];
	unsigned char logbookID;
	plcstring destIPAddr[16];
	unsigned short repeatTime;
	struct TON retryTimer;
} wbrPingService_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC signed long wbrPingSvcInit(struct wbrPingService_typ* p);
_BUR_PUBLIC signed long wbrPingStation(struct wbrPingService_typ* p);
_BUR_PUBLIC signed long wbrSQL_DT2_ISOFmtdStringFromDT(struct DTStructure* pDT, plcstring* pDst, unsigned long dstSize);


#ifdef __cplusplus
};
#endif
#endif /* _WBRPINGSVC_ */

