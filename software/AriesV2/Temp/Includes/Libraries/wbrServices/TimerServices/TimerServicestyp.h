/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _BUR_1491242196_8_
#define _BUR_1491242196_8_

#include <bur/plctypes.h>

/* Datatypes and datatypes of function blocks */
typedef struct msTimerHourMeter_typ
{	plcbit enable;
	unsigned long count;
} msTimerHourMeter_typ;

typedef struct msTimer_typ
{	unsigned long clock_ms;
	unsigned long diff_ms;
	unsigned long C1ms;
	unsigned long C10ms;
	unsigned long C100ms;
	unsigned long C1s;
	unsigned long C10s;
	unsigned long C60s;
	unsigned long C60sAbs;
	plcbit F100ms;
	plcbit F500ms;
	plcbit F1s;
	plcbit F2s;
	plcbit F10s;
	plcbit pulse01Hz100ms;
	plcbit pulse1day100ms;
	unsigned long _old60s;
} msTimer_typ;






__asm__(".section \".plc\"");

/* Used IEC files */
__asm__(".ascii \"iecfile \\\"Logical/Libraries/wbrServices/TimerServices/TimerServices.typ\\\" scope \\\"global\\\"\\n\"");

/* Exported library functions and function blocks */

__asm__(".previous");


#endif /* _BUR_1491242196_8_ */

