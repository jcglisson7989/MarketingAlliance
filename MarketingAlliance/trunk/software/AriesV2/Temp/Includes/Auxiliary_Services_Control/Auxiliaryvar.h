/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _BUR_1493049543_10_
#define _BUR_1493049543_10_

#include <bur/plctypes.h>

/* Constants */
#ifdef _REPLACE_CONST
 #define DEFINE_CONSTANT_MAGIC_SUFFIX 2271560481U
 #define DEFINE_CONSTANT_MAGIC_PREFIX 305419896U
 #define MAX_IDX_USB_PORTS 1U
#else
 _GLOBAL_CONST unsigned long DEFINE_CONSTANT_MAGIC_SUFFIX;
 _GLOBAL_CONST unsigned long DEFINE_CONSTANT_MAGIC_PREFIX;
 _GLOBAL_CONST unsigned char MAX_IDX_USB_PORTS;
#endif


/* Variables */
_GLOBAL struct MpAlarmBasicUI Alarm_Data_UI;
_GLOBAL struct MpAlarmBasicUIConnect20Type Alarm_Data;
_GLOBAL struct MpComLoggerUIConnectType Com_Logger_UIConnect;
_GLOBAL struct MpComLoggerUI Com_Logger_UI;
_GLOBAL struct MpAlarmBasicUI Alarm_File_UI;
_GLOBAL struct MpAlarmBasicUIConnect20Type Alarm_File;
_GLOBAL struct MpFileManagerUIConnectType File_Manager_UIConnect;
_GLOBAL struct MpFileManagerUI File_Manager_Control;
_GLOBAL struct MpAlarmBasicUI Alarm_Config_UI;
_GLOBAL struct MpAlarmBasicUIConnect20Type Alarm_Config;
_GLOBAL struct MpRecipeUIConnectType gConfig_CSV_UIConnect;
_GLOBAL struct MpRecipeUI Config_CSV_UI;
_GLOBAL struct MpRecipeRegPar Config_CSV_RegPar;
_GLOBAL struct MpRecipeCsvHeaderType Config_CSV_Header;
_GLOBAL struct MpRecipeCsv Config_CSV_Control;
_GLOBAL struct MpAlarmBasicUI Alarm_Recipe_UI;
_GLOBAL struct MpAlarmBasicUIConnect20Type Alarm_Recipe;
_GLOBAL struct MpRecipeUIConnectType gRecipe_CSV_UIConnect;
_GLOBAL struct MpRecipeUI Recipe_CSV_UI;
_GLOBAL struct MpRecipeRegPar Recipe_CSV_RegPar;
_GLOBAL struct MpRecipeCsvHeaderType Recipe_CSV_Header;
_GLOBAL struct MpRecipeCsv Recipe_CSV_Control;
_GLOBAL_RETAIN plcstring gRecipeName[256];
_GLOBAL_RETAIN plcstring gConfigName[256];
_GLOBAL struct USB_Object_typ USB_Object[2];
_GLOBAL enum USB_Global_SM_Enum gUSB_Step;





__asm__(".section \".plc\"");

/* Used IEC files */
__asm__(".ascii \"iecfile \\\"Logical/Auxiliary_Services_Control/Auxiliary.var\\\" scope \\\"global\\\"\\n\"");
__asm__(".ascii \"iecfile \\\"Logical/Libraries/MpAlarm/MpAlarm.fun\\\" scope \\\"global\\\"\\n\"");
__asm__(".ascii \"iecfile \\\"Logical/Libraries/MpCom/MpCom.fun\\\" scope \\\"global\\\"\\n\"");
__asm__(".ascii \"iecfile \\\"Logical/Libraries/MpFile/MpFile.fun\\\" scope \\\"global\\\"\\n\"");
__asm__(".ascii \"iecfile \\\"Logical/Libraries/MpRecipe/MpRecipe.fun\\\" scope \\\"global\\\"\\n\"");

/* Exported library functions and function blocks */

__asm__(".previous");


#endif /* _BUR_1493049543_10_ */

