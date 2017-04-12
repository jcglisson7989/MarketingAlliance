/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _BUR_1492025066_13_
#define _BUR_1492025066_13_

#include <bur/plctypes.h>

/* Datatypes and datatypes of function blocks */
typedef struct hmiDialog_typ
{	plcstring message[513];
	unsigned short result;
	unsigned short resultForOk;
	unsigned short resultForCancel;
	unsigned short timeoutConfig;
	unsigned short status;
	unsigned long tmr1RemainingTimeSec;
	unsigned short btnOk;
	unsigned short btnCancel;
	struct TON tmr1;
} hmiDialog_typ;






__asm__(".section \".plc\"");

/* Used IEC files */
__asm__(".ascii \"iecfile \\\"Logical/HMI/HMIdialog.typ\\\" scope \\\"global\\\"\\n\"");

/* Exported library functions and function blocks */

__asm__(".previous");


#endif /* _BUR_1492025066_13_ */

