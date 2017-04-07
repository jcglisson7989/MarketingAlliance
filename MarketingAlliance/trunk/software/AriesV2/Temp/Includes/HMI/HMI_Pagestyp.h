/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _BUR_1491590275_12_
#define _BUR_1491590275_12_

#include <bur/plctypes.h>

/* Datatypes and datatypes of function blocks */
typedef enum HMI_Page_Enum
{	HMI_00_STARTUP = 0,
	HMI_HOME_10_DASHBOARD = 10,
	HMI_RECIPE_20_SELECT = 20,
	HMI_RECIPE_21_PVLIST = 21,
	HMI_CONFIG_30_SELECT = 30,
	HMI_CONFIG_31_PVLIST = 31,
	HMI_LOGIN_40_MAIN = 40,
	HMI_LOGIN_41_OPERATOR = 41,
	HMI_LOGIN_42_SETUP = 42,
	HMI_LOGIN_43_ENGINEER = 43,
	HMI_LOGIN_44_HERNON = 44,
	HMI_LOGIN_45_FACTORY = 45,
	HMI_DIAGNOSTICS_50_ALARMS = 50,
	HMI_DIAGNOSTICS_51_ALRMHST = 51,
	HMI_DIAGNOSTICS_52_SDM = 52,
	HMI_DIAGNOSTICS_53_SYSLOG = 53,
	HMI_MOTION_60_IO_DISPENSE = 60,
	HMI_MOTION_61_IO_MOTORS = 61,
	HMI_MOTION_62_DISPENSE_TREND = 62,
	HMI_MOTION_63_IO_INSPECT_IO = 63,
	HMI_MOTION_64_IO_INSPECT_TREND = 64,
	HMI_MOTION_65_IO_LOADER = 65,
	HMI_MOTION_66_IO_SAFETY = 66,
	HMI_MOTION_67_IO_ETC = 67,
	HMI_MOTION_68_IO_SENSOR = 68,
	HMI_MOTION_69_IO_LOAD5215 = 69,
	HMI_ACP_70_AXIS_OVERVIEW = 70,
	HMI_ACP_71_AXIS_REF = 71,
	HMI_ACP_72_AXIS_MOVE = 72,
	HMI_ACP_73_AXIS_SETUP = 73,
	HMI_ACP_74_CAM_CTRL = 74,
	HMI_ACP_75_CAM_SETUP = 75,
	HMI_ACP_76_CAM_TRACE = 76,
	HMI_AUX_90_FILE = 90
} HMI_Page_Enum;






__asm__(".section \".plc\"");

/* Used IEC files */
__asm__(".ascii \"iecfile \\\"Logical/HMI/HMI_Pages.typ\\\" scope \\\"global\\\"\\n\"");

/* Exported library functions and function blocks */

__asm__(".previous");


#endif /* _BUR_1491590275_12_ */

