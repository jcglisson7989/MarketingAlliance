/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _BUR_1491590275_14_
#define _BUR_1491590275_14_

#include <bur/plctypes.h>

/* Datatypes and datatypes of function blocks */
typedef struct hmiMsgScrolling_typ
{	unsigned long iAdrAlarmArray;
	unsigned long iAlarmArrayLen;
	unsigned long iMsgTimeXms;
	unsigned short oMsgID;
	unsigned short oMsgVisible;
	unsigned short state;
	struct TON tmr1;
} hmiMsgScrolling_typ;






__asm__(".section \".plc\"");

/* Used IEC files */
__asm__(".ascii \"iecfile \\\"Logical/HMI/HMImsgScroll.typ\\\" scope \\\"global\\\"\\n\"");

/* Exported library functions and function blocks */

__asm__(".previous");


#endif /* _BUR_1491590275_14_ */

