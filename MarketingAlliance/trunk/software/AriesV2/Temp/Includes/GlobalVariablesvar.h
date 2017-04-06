/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _BUR_1491508286_4_
#define _BUR_1491508286_4_

#include <bur/plctypes.h>

/* Constants */
#ifdef _REPLACE_CONST
#else
#endif


/* Variables */
_GLOBAL_RETAIN struct Global_Statistics_typ gStatistics;
_GLOBAL struct AriesIOPoints_typ IO_LastCycle;
_GLOBAL struct AriesIOPoints_typ IO;
_GLOBAL enum CreaserPrcsState_Enum ProcessState;
_GLOBAL enum AriesMachineState_Enum MachineState;
_GLOBAL struct MpAxisBasicParType AxisPar;
_GLOBAL struct MpAxisBasic AxisControl;
_GLOBAL struct ACP10AXIS_typ Axis;
_GLOBAL plcstring gVersion[81];
_GLOBAL plcstring gProjectDate[81];
_GLOBAL plcstring gMachineName[81];
_GLOBAL struct Machine_Alarms_typ gAlarms;
_GLOBAL_RETAIN struct Global_Par_typ gRecCfg;





__asm__(".section \".plc\"");

/* Used IEC files */
__asm__(".ascii \"iecfile \\\"Logical/GlobalVariables.var\\\" scope \\\"global\\\"\\n\"");
__asm__(".ascii \"iecfile \\\"Logical/Libraries/MpAxis/MpAxis.fun\\\" scope \\\"global\\\"\\n\"");

/* Exported library functions and function blocks */

__asm__(".previous");


#endif /* _BUR_1491508286_4_ */

