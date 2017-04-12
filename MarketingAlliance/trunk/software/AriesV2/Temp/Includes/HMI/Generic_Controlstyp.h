/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _BUR_1492025066_11_
#define _BUR_1492025066_11_

#include <bur/plctypes.h>

/* Datatypes and datatypes of function blocks */
typedef enum Listbox_Option_Enum
{	ALLOW = 0,
	DISALLOW = 1,
	HIDDEN = 2
} Listbox_Option_Enum;

typedef struct HMI_Control_Change_Current
{	signed long Change;
	signed long Current;
} HMI_Control_Change_Current;

typedef struct HMI_Control_ScreenTimer
{	unsigned long Time_Remaining;
	unsigned long Time_Until_Display;
} HMI_Control_ScreenTimer;

typedef struct HMI_Control_Calibration
{	unsigned char State;
	unsigned char DataPoint;
} HMI_Control_Calibration;

typedef struct HMI_Ctrl_typ
{	struct HMI_Control_Change_Current KeyLevel;
	struct HMI_Control_Change_Current Language;
	struct HMI_Control_Change_Current Page;
	struct HMI_Control_ScreenTimer Screensaver;
	struct HMI_Control_ScreenTimer Backlight;
	struct HMI_Control_Calibration Calibration;
} HMI_Ctrl_typ;

typedef struct HMI_Data_Wheel_typ
{	plcbit Enter;
	signed long Counts;
} HMI_Data_Wheel_typ;

typedef struct HMI_Data_typ
{	struct HMI_Data_Wheel_typ Wheel;
} HMI_Data_typ;

typedef struct Generic_HMI_Ctrl
{	struct HMI_Ctrl_typ Ctrl;
	struct HMI_Data_typ Data;
} Generic_HMI_Ctrl;

typedef struct GenericListbox_typ
{	plcstring Strings[13][81];
	signed long Index;
	unsigned char maxidx;
	unsigned char minidx;
	unsigned char status;
	unsigned char option[13];
} GenericListbox_typ;

typedef struct GenericButton_typ
{	unsigned char datapoint;
	unsigned char status;
	plcstring text[65];
} GenericButton_typ;






__asm__(".section \".plc\"");

/* Used IEC files */
__asm__(".ascii \"iecfile \\\"Logical/HMI/Generic_Controls.typ\\\" scope \\\"global\\\"\\n\"");

/* Additional IEC dependencies */
__asm__(".ascii \"iecdep \\\"Logical/Libraries/MAPPSuppor/MAPPSuppor.var\\\" scope \\\"global\\\"\\n\"");

/* Exported library functions and function blocks */

__asm__(".previous");


#endif /* _BUR_1492025066_11_ */

