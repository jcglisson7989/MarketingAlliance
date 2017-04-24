/* Automation Studio generated header file */
/* Do not edit ! */
/* wbrMemSvc  */

#ifndef _WBRMEMSVC_
#define _WBRMEMSVC_
#ifdef __cplusplus
extern "C" 
{
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
#ifdef _SG4
		#include "AsMem.h"
#endif
#ifdef _SG3
		#include "AsMem.h"
#endif
#ifdef _SGC
		#include "AsMem.h"
#endif

/* Datatypes and datatypes of function blocks */
typedef struct wbrMemSvcStatus_typ
{	plcbit memInitValid;
	unsigned long blockFree;
} wbrMemSvcStatus_typ;

typedef struct wbrMemSvcStoredConfig_typ
{	unsigned long memRequestSize;
} wbrMemSvcStoredConfig_typ;

typedef struct wbrMemService_typ
{	struct wbrMemSvcStatus_typ status;
	struct wbrMemSvcStoredConfig_typ* config;
} wbrMemService_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC plcbit initMemSvc(unsigned long partitionSize);
_BUR_PUBLIC unsigned long memSvcAllocate(unsigned long size);
_BUR_PUBLIC unsigned short memSvcFree(unsigned long block);
_BUR_PUBLIC unsigned long memSvcGetMemInfo(void);


#ifdef __cplusplus
};
#endif
#endif /* _WBRMEMSVC_ */

