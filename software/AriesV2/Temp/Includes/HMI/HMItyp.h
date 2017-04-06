/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _BUR_1491508150_18_
#define _BUR_1491508150_18_

#include <bur/plctypes.h>

/* Datatypes and datatypes of function blocks */
typedef struct hmiControlLogicKeys_typ
{	unsigned char btnRestartLoginTimer;
	unsigned char btnLoginIcon;
	plcbit menuKeyPressLT[12];
	plcbit menuKeyPressRT[12];
} hmiControlLogicKeys_typ;

typedef struct hmiNavigationLogic_typ
{	unsigned char changePage;
	unsigned char currentPage;
	plcstring htmlCurrentURL[128];
	plcstring htmlChangeURL[128];
	plcstring currentPageText[32];
	unsigned char prevPage;
	unsigned char nextPage;
	plcbit pageInit;
	plcbit pageExit;
	unsigned char state;
	plcstring currentStateText[32];
	unsigned char statePrev;
	unsigned char stateNext;
	unsigned long loginLevel;
	plcbit stateInit;
	struct TON tmr1;
	struct TON tmr2;
	struct TON tmr3;
	unsigned long tmr3RemainingTimeSec;
	unsigned long tmr3RemainingTimeMin;
	struct TON tmr4;
} hmiNavigationLogic_typ;

typedef struct hmiControlLogicStatus_typ
{	unsigned short visibleSaveCfg;
	unsigned short menuVisibleLT;
	unsigned short menuVisibleRT;
	unsigned short menuVisibleRTItems[12];
	unsigned short menuIndexLT;
	unsigned char show_motion_tab;
	unsigned char show_Aux_tab;
	unsigned short show_io_tab;
	unsigned short menuIndexRT;
	unsigned char loginVisibleGE1;
	unsigned char loginVisibleGE2;
	unsigned char loginVisibleGE3;
	struct TON menuLFHideTimer;
	struct TON menuRTHideTimer;
	unsigned char tabKeysRadioDataPoint;
	unsigned char tabKeysRadioArray[12];
	unsigned char tabKeysToggle[12];
	plcstring passwordStrings[5][16];
} hmiControlLogicStatus_typ;

typedef struct hmiRecipeLogic_typ
{	unsigned char recVisible;
	unsigned short recSelectIdx;
	unsigned short recSelectIdxMax;
	unsigned short recSaveAsIdx;
	plcstring recSelectName[81];
	unsigned char btnLockedActivate;
	unsigned char btnLockedNew;
	unsigned char btnLockedDelete;
	unsigned char btnLockedSaveAs;
	plcbit btnActivate;
	plcbit btnNew;
	plcbit btnDelete;
	plcbit btnSaveAs;
	unsigned long stateRecipes;
} hmiRecipeLogic_typ;

typedef struct hmiTableRecCfgTrigger_typ
{	plcbit Control;
	plcbit Dispense;
} hmiTableRecCfgTrigger_typ;

typedef struct hmiTableTrigger_typ
{	struct hmiTableRecCfgTrigger_typ Rec;
	struct hmiTableRecCfgTrigger_typ Cfg;
} hmiTableTrigger_typ;

typedef struct hmiTableLoad_typ
{	plcbit Trigger;
} hmiTableLoad_typ;

typedef struct hmiTables_typ
{	struct hmiTableTrigger_typ Trigger;
	struct hmiTableLoad_typ Load;
} hmiTables_typ;

typedef struct hmiControlLogic_typ
{	struct hmiControlLogicStatus_typ status;
	struct hmiControlLogicKeys_typ keys;
	struct hmiNavigationLogic_typ prv;
	struct hmiRecipeLogic_typ recipes;
	struct hmiAlert_typ alertMsg;
	struct hmiDialog_typ dialogMsg;
	struct hmiTables_typ tables;
} hmiControlLogic_typ;






__asm__(".section \".plc\"");

/* Used IEC files */
__asm__(".ascii \"iecfile \\\"Logical/HMI/HMI.typ\\\" scope \\\"global\\\"\\n\"");

/* Additional IEC dependencies */
__asm__(".ascii \"iecdep \\\"Logical/Libraries/MAPPSuppor/MAPPSuppor.var\\\" scope \\\"global\\\"\\n\"");

/* Exported library functions and function blocks */

__asm__(".previous");


#endif /* _BUR_1491508150_18_ */

