/* Automation Studio generated header file */
/* Do not edit ! */
/* MpData 1.40.1 */

#ifndef _MPDATA_
#define _MPDATA_
#ifdef __cplusplus
extern "C" 
{
#endif
#ifndef _MpData_VERSION
#define _MpData_VERSION 1.40.1
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
#ifdef _SG4
		#include "MpCom.h"
		#include "astime.h"
		#include "sys_lib.h"
		#include "brsystem.h"
		#include "FileIO.h"
		#include "DataObj.h"
#endif

#ifdef _SG3
		#include "MpCom.h"
		#include "astime.h"
		#include "sys_lib.h"
		#include "brsystem.h"
		#include "FileIO.h"
		#include "DataObj.h"
#endif

#ifdef _SGC
		#include "MpCom.h"
		#include "astime.h"
		#include "sys_lib.h"
		#include "brsystem.h"
		#include "FileIO.h"
		#include "DataObj.h"
#endif

/* Datatypes and datatypes of function blocks */
typedef enum MpDataRecordModeEnum
{	mpDATA_RECORD_MODE_TIME = 0,
	mpDATA_RECORD_MODE_TRIGGER = 1,
	mpDATA_RECORD_MODE_VALUE = 2,
	mpDATA_RECORD_MODE_TIME_TRIGGER = 3,
	mpDATA_RECORD_MODE_TIME_VALUE = 4,
	mpDATA_RECORD_MODE_TRIGGER_VALUE = 5,
	mpDATA_RECORD_MODE_TIME_TRIG_VAL = 6
} MpDataRecordModeEnum;

typedef enum MpDataPVItemLimitEnum
{	mpDATA_NO_LIMITS_CONFIGURED = 0,
	mpDATA_WITHIN_LIMITS = 1,
	mpDATA_UPPER_LIMIT_VIOLATED = 2,
	mpDATA_LOWER_LIMIT_VIOLATED = 3
} MpDataPVItemLimitEnum;

typedef enum MpDataUIStatusEnum
{	mpDATA_UI_STATUS_IDLE = 0,
	mpDATA_UI_STATUS_REFRESH = 1,
	mpDATA_UI_STATUS_ERROR = 99
} MpDataUIStatusEnum;

typedef enum MpDataErrorEnum
{	mpDATA_NO_ERROR = 0,
	mpDATA_ERR_ACTIVATION = -1064239103,
	mpDATA_ERR_MPLINK_NULL = -1064239102,
	mpDATA_ERR_MPLINK_INVALID = -1064239101,
	mpDATA_ERR_MPLINK_CHANGED = -1064239100,
	mpDATA_ERR_MPLINK_CORRUPT = -1064239099,
	mpDATA_ERR_MPLINK_IN_USE = -1064239098,
	mpDATA_ERR_CONFIG_NULL = -1064239096,
	mpDATA_ERR_CONFIG_NO_PV = -1064239095,
	mpDATA_ERR_CONFIG_LOAD = -1064239094,
	mpDATA_WRN_CONFIG_LOAD = -2137980917,
	mpDATA_ERR_CONFIG_SAVE = -1064239092,
	mpDATA_ERR_CONFIG_INVALID = -1064239091,
	mpDATA_ERR_REGISTERING_PV = -1064124416,
	mpDATA_ERR_NO_PV_REGISTERED = -1064124415,
	mpDATA_ERR_INVALID_PV_NAME = -1064124414,
	mpDATA_ERR_PV_NAME_NULL = -1064124413,
	mpDATA_ERR_PV_REGISTERED = -1064124412,
	mpDATA_ERR_FILE_SYSTEM = -1064124411,
	mpDATA_WRN_SAMPLING_TIME = -2137866234,
	mpDATA_ERR_INVALID_FILE_DEV = -1064124409,
	mpDATA_ERR_DATAREC_NOT_FOUND = -1064124408,
	mpDATA_WRN_SAVE_INTERVAL = -2137866231,
	mpDATA_ERR_RECORD_FAILURE = -1064124406,
	mpDATA_WRN_SAMPLING_TIME_MULTIP = -2137866229,
	mpDATA_INF_WAIT_RECORDER_FB = 1083359244,
	mpDATA_ERR_MISSING_UICONNECT = -1064124403,
	mpDATA_ERR_INVALID_LIMITS = -1064124399
} MpDataErrorEnum;

typedef enum MpDataRecorderAlarmEnum
{	mpDATA_ALM_RECORDING_COMPLETED = 0,
	mpDATA_ALM_RECORDING_ABORTED = 1,
	mpDATA_ALM_LIMIT_VIOLATED = 2
} MpDataRecorderAlarmEnum;

typedef struct MpDataRecorderHeaderType
{	plcstring Name[101];
	plcstring Description[256];
} MpDataRecorderHeaderType;

typedef struct MpDataStatusIDType
{	enum MpDataErrorEnum ID;
	MpComSeveritiesEnum Severity;
	unsigned short Code;
} MpDataStatusIDType;

typedef struct MpDataDiagType
{	struct MpDataStatusIDType StatusID;
} MpDataDiagType;

typedef struct MpDataInfoType
{	struct MpDataDiagType Diag;
} MpDataInfoType;

typedef struct MpDataRecorderInfoType
{	unsigned short FileCount;
	plcstring CurrentFileName[51];
	unsigned long CurrentFileSize;
	unsigned short CurrentBufferSize;
	unsigned short RegisteredPVCount;
	unsigned long TotalSamples;
	plcbit ValueOutsideLimits;
	struct MpDataDiagType Diag;
} MpDataRecorderInfoType;

typedef struct MpDataRecorderConfigType
{	unsigned short MaxNumberOfFiles;
	unsigned long MaxFileSize;
	unsigned short DecimalDigits;
	plctime SaveInterval;
	unsigned short BufferSize;
	plcbit PowerFailSafe;
	plcstring FileNamePattern[51];
	plcstring TimeStampPattern[51];
	plcstring ColumnSeparator[2];
	plcstring DecimalMark[2];
	plcbit AutoSave;
	plcbit OverwriteOldestFile;
	plcbit SaveInitialValues;
} MpDataRecorderConfigType;

typedef struct MpDataTableUISetupType
{	unsigned short ValueListSize;
	unsigned char ValueListScrollWindow;
	unsigned short PVListSize;
	unsigned char PVListScrollWindow;
} MpDataTableUISetupType;

typedef struct MpDataTableUIPVItemType
{	plcstring Name[101];
	plcstring Description[51];
	unsigned short DescriptionIndex;
	plcstring Unit[21];
	double Value[20];
	enum MpDataPVItemLimitEnum LimitMonitor[20];
} MpDataTableUIPVItemType;

typedef struct MpDataTableType
{	struct MpDataTableUIPVItemType PV[10];
	unsigned long Index[20];
	plcstring TimeStamp[20][51];
	plcbit StepUp;
	plcbit PageUp;
	plcbit StepDown;
	plcbit PageDown;
	plcbit StepLeft;
	plcbit PageLeft;
	plcbit StepRight;
	plcbit PageRight;
	float RangeStartRows;
	float RangeEndRows;
	float RangeStartColumns;
	float RangeEndColumns;
} MpDataTableType;

typedef struct MpDataTableUIConnectType
{	struct MpDataTableType Table;
	enum MpDataUIStatusEnum Status;
	plcbit AutoRefresh;
	plcbit Refresh;
} MpDataTableUIConnectType;

typedef struct MpDataStatisticsUISetupType
{	unsigned short PVListSize;
	unsigned char PVListScrollWindow;
} MpDataStatisticsUISetupType;

typedef struct MpDataStatisticsUIPVItemType
{	plcstring Name[101];
	plcstring Description[51];
	plcstring Unit[21];
	double Minimum;
	double Maximum;
	double Mean;
	double Range;
	double StandardDeviation;
} MpDataStatisticsUIPVItemType;

typedef struct MpDataStatisticsUITableType
{	struct MpDataStatisticsUIPVItemType Data[20];
	plcbit StepLeft;
	plcbit PageLeft;
	plcbit StepRight;
	plcbit PageRight;
	float RangeStart;
	float RangeEnd;
} MpDataStatisticsUITableType;

typedef struct MpDataStatisticsUIConnectType
{	struct MpDataStatisticsUITableType Table;
	enum MpDataUIStatusEnum Status;
} MpDataStatisticsUIConnectType;

typedef struct MpDataRecorder
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	struct MpDataRecorderHeaderType* Header;
	plcstring (*DeviceName);
	plctime SamplingTime;
	enum MpDataRecordModeEnum RecordMode;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpDataRecorderInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Record;
	plcbit Trigger;
	plcbit SnapShot;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit CommandBusy;
	plcbit Recording;
	plcbit RecordDone;
	plcbit SnapShotDone;
} MpDataRecorder_typ;

typedef struct MpDataRecorderConfig
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	struct MpDataRecorderConfigType* Configuration;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpDataInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Load;
	plcbit Save;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit CommandBusy;
	plcbit CommandDone;
} MpDataRecorderConfig_typ;

typedef struct MpDataRegParLimits
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	plcstring (*PVName);
	plcstring (*Unit);
	plcstring (*Description);
	float ScaleFactor;
	double UpperLimit;
	double LowerLimit;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	enum MpDataPVItemLimitEnum LimitMonitor;
	struct MpDataInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
} MpDataRegParLimits_typ;

typedef struct MpDataRegPar
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	plcstring (*PVName);
	plcstring (*Unit);
	plcstring (*Description);
	float ScaleFactor;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpDataInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
} MpDataRegPar_typ;

typedef struct MpDataStatisticsUI
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	struct MpDataStatisticsUISetupType UISetup;
	struct MpDataStatisticsUIConnectType* UIConnect;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpDataInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
} MpDataStatisticsUI_typ;

typedef struct MpDataTableUI
{
	/* VAR_INPUT (analog) */
	struct MpComIdentType* MpLink;
	struct MpDataTableUISetupType UISetup;
	struct MpDataTableUIConnectType* UIConnect;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	struct MpDataInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
} MpDataTableUI_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void MpDataRecorder(struct MpDataRecorder* inst);
_BUR_PUBLIC void MpDataRecorderConfig(struct MpDataRecorderConfig* inst);
_BUR_PUBLIC void MpDataRegParLimits(struct MpDataRegParLimits* inst);
_BUR_PUBLIC void MpDataRegPar(struct MpDataRegPar* inst);
_BUR_PUBLIC void MpDataStatisticsUI(struct MpDataStatisticsUI* inst);
_BUR_PUBLIC void MpDataTableUI(struct MpDataTableUI* inst);


#ifdef __cplusplus
};
#endif
#endif /* _MPDATA_ */

