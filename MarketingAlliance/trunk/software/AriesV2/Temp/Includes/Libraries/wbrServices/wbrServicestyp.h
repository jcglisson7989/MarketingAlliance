/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _BUR_1492025066_5_
#define _BUR_1492025066_5_

#include <bur/plctypes.h>

/* Datatypes and datatypes of function blocks */
typedef enum wbrSvcBool_enum
{	NO = 0,
	YES,
	OFF = 0,
	ON,
	STOP = 0,
	START,
	UNCHECK = 0,
	CHECK
} wbrSvcBool_enum;

typedef struct cfgFileInfo_typ
{	plcstring timestamp[64];
	plcstring path[128];
	unsigned long machineNumber;
	plcstring machineName[32];
} cfgFileInfo_typ;






__asm__(".section \".plc\"");

/* Used IEC files */
__asm__(".ascii \"iecfile \\\"Logical/Libraries/wbrServices/wbrServices.typ\\\" scope \\\"global\\\"\\n\"");

/* Exported library functions and function blocks */

__asm__(".previous");


#endif /* _BUR_1492025066_5_ */

