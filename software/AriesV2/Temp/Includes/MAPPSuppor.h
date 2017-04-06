/* Automation Studio generated header file */
/* Do not edit ! */
/* MAPPSuppor  */

#ifndef _MAPPSUPPOR_
#define _MAPPSUPPOR_
#ifdef __cplusplus
extern "C" 
{
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
#ifdef _SG4
		#include "standard.h"
		#include "sys_lib.h"
		#include "ArTextSys.h"
		#include "wbrLogSvc.h"
#endif
#ifdef _SG3
		#include "standard.h"
		#include "sys_lib.h"
		#include "ArTextSys.h"
		#include "wbrLogSvc.h"
#endif
#ifdef _SGC
		#include "standard.h"
		#include "sys_lib.h"
		#include "ArTextSys.h"
		#include "wbrLogSvc.h"
#endif

/* Constants */
#ifdef _REPLACE_CONST
 #define DEFINE_LOGSTRING_LEN 512U
 #define MAX_CALLS_INIT_LOGBOOK 50U
 #define MAX_IDX_LANGUAGES 5U
 _WEAK const plcstring DEFINE_LANGUAGE_STRINGS[6][5] = {"en","sv","pt","de","es","fr"};
 #define DEFINE_MAX_IDX_HMI_TABLES 3U
 #define DEFINE_MAX_TABLE_ENTRIES 20U
 #define DEFINE_PAR_DESC_MAXLEN 240U
 #define DEFINE_PAR_NAME_MAXLEN 80U
 #define DEFINE_PAR_IDX_MAXLEN 4U
 #define Enum_Max_Listbox_Char 80U
 #define Enum_Max_Listbox_Items 12U
 #define HMI_ENUM_TAB_KEYS_MAX 11U
 #define HMI_ENUM_MENU_ITEMS_RT 11U
 #define HMI_ENUM_MENU_ITEMS_LT 11U
 #define HMI_PWD_MAXLEN 15U
 #define HMI_PWD_LEVELS 4U
 #define DEFINE_INDEX_TEXTTABLE_PV 0U
 #define DEFINE_INDEX_TEXTTABLE_DEFAULT 1U
 #define DEFINE_INDEX_TEXTTABLE_MIN 2U
 #define DEFINE_INDEX_TEXTTABLE_MAX 3U
 #define DEFINE_INDEX_TEXTTABLE_HIDE 4U
#else
 #ifndef _GLOBAL_CONST
   #define _GLOBAL_CONST _WEAK const
 #endif
 _GLOBAL_CONST unsigned long DEFINE_LOGSTRING_LEN;
 _GLOBAL_CONST unsigned long MAX_CALLS_INIT_LOGBOOK;
 _GLOBAL_CONST unsigned long MAX_IDX_LANGUAGES;
 _GLOBAL_CONST plcstring DEFINE_LANGUAGE_STRINGS[6][5];
 _GLOBAL_CONST unsigned long DEFINE_MAX_IDX_HMI_TABLES;
 _GLOBAL_CONST unsigned long DEFINE_MAX_TABLE_ENTRIES;
 _GLOBAL_CONST unsigned long DEFINE_PAR_DESC_MAXLEN;
 _GLOBAL_CONST unsigned long DEFINE_PAR_NAME_MAXLEN;
 _GLOBAL_CONST unsigned long DEFINE_PAR_IDX_MAXLEN;
 _GLOBAL_CONST unsigned char Enum_Max_Listbox_Char;
 _GLOBAL_CONST unsigned char Enum_Max_Listbox_Items;
 _GLOBAL_CONST unsigned char HMI_ENUM_TAB_KEYS_MAX;
 _GLOBAL_CONST unsigned char HMI_ENUM_MENU_ITEMS_RT;
 _GLOBAL_CONST unsigned char HMI_ENUM_MENU_ITEMS_LT;
 _GLOBAL_CONST unsigned long HMI_PWD_MAXLEN;
 _GLOBAL_CONST unsigned long HMI_PWD_LEVELS;
 _GLOBAL_CONST unsigned char DEFINE_INDEX_TEXTTABLE_PV;
 _GLOBAL_CONST unsigned char DEFINE_INDEX_TEXTTABLE_DEFAULT;
 _GLOBAL_CONST unsigned char DEFINE_INDEX_TEXTTABLE_MIN;
 _GLOBAL_CONST unsigned char DEFINE_INDEX_TEXTTABLE_MAX;
 _GLOBAL_CONST unsigned char DEFINE_INDEX_TEXTTABLE_HIDE;
#endif




/* Datatypes and datatypes of function blocks */
typedef enum Enum_PV_types
{	PV_REAL,
	PV_UDINT
} Enum_PV_types;

typedef enum Language_Enums
{	LANGUAGE_ENGLISH = 0,
	LANGUAGE_SWEDISH = 1,
	LANGUAGE_PORTUGESE = 2,
	LANGUAGE_GERMAN = 3,
	LANGUAGE_SPANISH = 4,
	LANGUAGE_FRENCH = 5
} Language_Enums;

typedef enum HMITableIndex_enum
{	TABLE_REC_CONTROL = 0,
	TABLE_REC_DISPENSE = 1,
	TABLE_CFG_CONTROL = 2,
	TABLE_CFG_DISPENSE = 3
} HMITableIndex_enum;

typedef struct hmiTableStatStruct_typ
{	unsigned long maxLenDesc;
	unsigned long maxLenName;
	unsigned long Param;
	unsigned long Default;
	unsigned long Min;
	unsigned long Max;
	unsigned long Hide;
} hmiTableStatStruct_typ;

typedef struct hmiTableStats_typ
{	struct hmiTableStatStruct_typ Overall;
} hmiTableStats_typ;

typedef struct PVList_Language_Texts_typ
{	plcstring PVTextLangSpecific[81];
	plcstring PVDescLangSpecific[241];
} PVList_Language_Texts_typ;

typedef struct PVListTexts_Info_typ
{	plcstring Str[81];
	plcbit isValid;
	plcbit isPV;
	plcbit isConstant;
	float Const_Value;
	unsigned long PVAdr;
	unsigned char PVLen;
	unsigned char PVDim;
	unsigned long PVTyp;
	unsigned long StrLen;
} PVListTexts_Info_typ;

typedef struct PVTable_Val_Info_typ
{	struct PVListTexts_Info_typ Param;
	struct PVListTexts_Info_typ Default;
	struct PVListTexts_Info_typ Min;
	struct PVListTexts_Info_typ Max;
	struct PVListTexts_Info_typ Hide;
} PVTable_Val_Info_typ;

typedef struct PVTableInfo
{	struct PVList_Language_Texts_typ PVText[6];
	struct PVTable_Val_Info_typ Val;
	plcbit Error;
} PVTableInfo;

typedef struct HMI_Table_Data_typ
{	struct PVTableInfo info[21];
	unsigned long Max_Idx_Entries;
	plcstring Table_Name[81];
	plcstring NameSpace[81];
	plcbit Load_OK;
} HMI_Table_Data_typ;

typedef struct hmiParamLimits_typ
{	float k_factor;
	float n_factor;
	float minValue;
	float maxValue;
	float defaultValue;
	unsigned long pEnumText;
	unsigned long pEnumVals;
	unsigned short valueType;
} hmiParamLimits_typ;

typedef struct hmiParamListTable_typ
{	plcstring listHeader[81];
	plcstring listIdText[21][5];
	plcstring listTypeText[21][81];
	plcstring listDefaultText[21][81];
	plcstring listMinText[21][81];
	plcstring listMaxText[21][81];
	plcstring listValueText[21][81];
	plcstring listName[21][81];
	plcstring listDescription[21][241];
	unsigned long listValuePtr[21];
	signed long listDecPlaces[21];
	struct hmiParamLimits_typ listLimits[21];
	plcstring selName[81];
	plcstring selDescription[241];
	unsigned long selValueEnumIndex;
	unsigned long selValueEnumIndexMax;
	float selValueREAL;
	float selValueREALOld;
	float selValueREALMax;
	float selValueREALMin;
	float selValueREALDefault;
	signed long selValueDecPlaces;
	signed long selValueDINT;
	signed long selValueDINTOld;
	signed long selValueDINTMax;
	signed long selValueDINTMin;
	signed long selValueDINTDefault;
	signed long selValueFormVisible;
	unsigned short index;
	unsigned short indexOld;
	unsigned short maxIndex;
	plcbit setDefaultRequest;
	unsigned char incDP;
	unsigned char decDP;
} hmiParamListTable_typ;

typedef struct FBK_Init_Logbook
{
	/* VAR_INPUT (analog) */
	plcstring Name[81];
	/* VAR_OUTPUT (analog) */
	unsigned long pLog;
	/* VAR (analog) */
	struct wbrLogServiceLogbookInfo_typ Logbook;
	unsigned long ii_init_calls;
	/* VAR_INPUT (digital) */
	plcbit Enable;
} FBK_Init_Logbook_typ;

typedef struct hmiTableFBK_typ
{
	/* VAR_INPUT (analog) */
	plcstring tableName[81];
	plcstring nameSpace[81];
	struct HMI_Table_Data_typ hmiStruct;
	unsigned long Logbook;
	struct hmiTableStatStruct_typ TableStats;
	struct hmiTableStatStruct_typ* pOverallStats;
} hmiTableFBK_typ_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void FBK_Init_Logbook(struct FBK_Init_Logbook* inst);
_BUR_PUBLIC void hmiTableFBK_typ(struct hmiTableFBK_typ* inst);
_BUR_PUBLIC unsigned char hmiParamListTableCyclic(unsigned long p_int);
_BUR_PUBLIC plcbit ActivateHMITable(signed long langIdx, unsigned long pHMITable, unsigned long pTableValues);


#ifdef __cplusplus
};
#endif
#endif /* _MAPPSUPPOR_ */

