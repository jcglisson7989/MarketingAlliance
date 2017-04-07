/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _BUR_1491590275_1_
#define _BUR_1491590275_1_

#include <bur/plctypes.h>

/* Constants */
#ifdef _REPLACE_CONST
 #define MAX_IDX_CREASES 9U
 #define DEFINE_LOGIN_TO 600.0f
 #define MAX_IDX_TOTAL_RECIPES 100U
 #define DEFINE_HMI_SPLASHSCREEN_TO_MS 5000U
 #define DEFINE_MENU_R_HIDE_TIMEOUT_MS 7000U
 #define DEFINE_MENU_L_HIDE_TIMEOUT_MS 7000U
 #define RECIPE_ACCESS_LEVEL 1U
 #define CONFIG_ACCESS_LEVEL 2U
 #define FORCEIO_ACCESS_LEVEL 1U
#else
 _GLOBAL_CONST unsigned long MAX_IDX_CREASES;
 _GLOBAL_CONST float DEFINE_LOGIN_TO;
 _GLOBAL_CONST unsigned short MAX_IDX_TOTAL_RECIPES;
 _GLOBAL_CONST unsigned long DEFINE_HMI_SPLASHSCREEN_TO_MS;
 _GLOBAL_CONST unsigned long DEFINE_MENU_R_HIDE_TIMEOUT_MS;
 _GLOBAL_CONST unsigned long DEFINE_MENU_L_HIDE_TIMEOUT_MS;
 _GLOBAL_CONST unsigned short RECIPE_ACCESS_LEVEL;
 _GLOBAL_CONST unsigned short CONFIG_ACCESS_LEVEL;
 _GLOBAL_CONST unsigned short FORCEIO_ACCESS_LEVEL;
#endif


/* Variables */
_GLOBAL_RETAIN struct Global_Statistics_typ gStatistics;
_GLOBAL struct AriesIOPoints_typ IO_LastCycle;
_GLOBAL struct AriesIOPoints_typ IO;
_GLOBAL enum CreaserPrcsState_Enum ProcessState;
_GLOBAL enum AriesMachineState_Enum MachineState;
_GLOBAL struct MpAxisBasicParType AxisPar;
_GLOBAL struct MpAxisBasic AxisControl;
_GLOBAL struct ACP10AXIS_typ Axis1;
_GLOBAL plcstring gVersion[81];
_GLOBAL plcstring gProjectDate[81];
_GLOBAL plcstring gMachineName[81];
_GLOBAL struct Machine_Alarms_typ gAlarms;
_GLOBAL_RETAIN struct Global_Par_typ gRecCfg;





__asm__(".section \".plc\"");

/* Used IEC files */
__asm__(".ascii \"iecfile \\\"Logical/GlobalConstants.var\\\" scope \\\"global\\\"\\n\"");
__asm__(".ascii \"iecfile \\\"Logical/Libraries/MpAxis/MpAxis.fun\\\" scope \\\"global\\\"\\n\"");

/* Exported library functions and function blocks */

__asm__(".previous");


#endif /* _BUR_1491590275_1_ */

