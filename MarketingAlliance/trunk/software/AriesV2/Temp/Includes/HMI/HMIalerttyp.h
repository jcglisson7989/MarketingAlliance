/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _BUR_1491508150_17_
#define _BUR_1491508150_17_

#include <bur/plctypes.h>

/* Datatypes and datatypes of function blocks */
typedef struct hmiAlert_typ
{	plcstring message[513];
	unsigned char color_idx;
	plcstring header[129];
	unsigned short type;
	unsigned short status;
	unsigned long tmr1RemainingTimeSec;
	struct TON tmr1;
} hmiAlert_typ;






__asm__(".section \".plc\"");

/* Used IEC files */
__asm__(".ascii \"iecfile \\\"Logical/HMI/HMIalert.typ\\\" scope \\\"global\\\"\\n\"");

/* Exported library functions and function blocks */

__asm__(".previous");


#endif /* _BUR_1491508150_17_ */

