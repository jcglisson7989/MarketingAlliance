/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _BUR_1492025066_15_
#define _BUR_1492025066_15_

#include <bur/plctypes.h>

/* Datatypes and datatypes of function blocks */
typedef struct hmiForceIOItem_typ
{	unsigned long reset;
	unsigned long set;
	unsigned long toggle;
	unsigned long pAddrIO;
} hmiForceIOItem_typ;

typedef struct hmiForceIO_typ
{	unsigned long forceEnable;
	unsigned long forceItemsVisibility;
	struct hmiForceIOItem_typ forceItems[8];
	plcbit Flag_Reset_All;
} hmiForceIO_typ;






__asm__(".section \".plc\"");

/* Used IEC files */
__asm__(".ascii \"iecfile \\\"Logical/HMI/HMIForceIO.typ\\\" scope \\\"global\\\"\\n\"");

/* Additional IEC dependencies */
__asm__(".ascii \"iecdep \\\"Logical/HMI/HMI.var\\\" scope \\\"global\\\"\\n\"");

/* Exported library functions and function blocks */

__asm__(".previous");


#endif /* _BUR_1492025066_15_ */

