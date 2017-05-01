/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _ASUPS_
#define _ASUPS_
#ifdef __cplusplus
extern "C" 
{
#endif

#include <bur/plctypes.h>

#include <brsystem.h>
#include <dvframe.h>
#include <runtime.h>
#include <sys_lib.h>

#ifndef _IEC_CONST
#define _IEC_CONST _WEAK const
#endif

/* Constants */
#ifdef _REPLACE_CONST
 #define err_STARTSHUTDOWN 28260U
 #define SHUTDOWNWARMSTART 17U
 #define SHUTDOWNCOLDSTART 18U
 #define RESTARTWARMSTART 1U
 #define RESTARTCOLDSTART 2U
 #define ERR_LOWCYCLETIME 28259U
 #define INVALID_STRING "invalid"
 #define ERR_NOTDEFINED 28257U
 #define ERR_NOSHUTDOWN 28258U
 #define ERR_UPSANSWER 28252U
 #define ERR_SHUTDOWN 28251U
 #define ERR_PROGRAMM 28253U
 #define ERR_RESTART 28250U
 #define ERR_NOTINIT 28256U
 #define ERR_NOINPUT 60U
 #define ERR_ENABLE0 65534U
 #define UPS_STRING "USV"
 #define UPG_STRING "UPG"
 #define ERR_STRING "err"
 #define err_UPSOK 28261U
 #define OK_STRING "OK!"
 #define ERR_READY 0U
 #define ERR_BUSY 65535U
 #define ERR_DCD 28254U
 #define ERR_CTS 28255U
#else
 _IEC_CONST unsigned short err_STARTSHUTDOWN = 28260U;
 _IEC_CONST unsigned char SHUTDOWNWARMSTART = 17U;
 _IEC_CONST unsigned char SHUTDOWNCOLDSTART = 18U;
 _IEC_CONST unsigned char RESTARTWARMSTART = 1U;
 _IEC_CONST unsigned char RESTARTCOLDSTART = 2U;
 _IEC_CONST unsigned short ERR_LOWCYCLETIME = 28259U;
 _IEC_CONST plcstring INVALID_STRING[21] = "invalid";
 _IEC_CONST unsigned short ERR_NOTDEFINED = 28257U;
 _IEC_CONST unsigned short ERR_NOSHUTDOWN = 28258U;
 _IEC_CONST unsigned short ERR_UPSANSWER = 28252U;
 _IEC_CONST unsigned short ERR_SHUTDOWN = 28251U;
 _IEC_CONST unsigned short ERR_PROGRAMM = 28253U;
 _IEC_CONST unsigned short ERR_RESTART = 28250U;
 _IEC_CONST unsigned short ERR_NOTINIT = 28256U;
 _IEC_CONST unsigned short ERR_NOINPUT = 60U;
 _IEC_CONST unsigned short ERR_ENABLE0 = 65534U;
 _IEC_CONST plcstring UPS_STRING[21] = "USV";
 _IEC_CONST plcstring UPG_STRING[21] = "UPG";
 _IEC_CONST plcstring ERR_STRING[21] = "err";
 _IEC_CONST unsigned short err_UPSOK = 28261U;
 _IEC_CONST plcstring OK_STRING[21] = "OK!";
 _IEC_CONST unsigned short ERR_READY = 0U;
 _IEC_CONST unsigned short ERR_BUSY = 65535U;
 _IEC_CONST unsigned short ERR_DCD = 28254U;
 _IEC_CONST unsigned short ERR_CTS = 28255U;
#endif




/* Datatypes and datatypes of function blocks */
typedef struct ups_comm
{
	/* VAR_INPUT (analog) */
	plcstring user_command[129];
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	plcstring ups_answer[129];
	/* VAR_INPUT (digital) */
	plcbit enable;
} ups_comm_typ;

typedef struct ups_init
{
	/* VAR_INPUT (analog) */
	unsigned long device;
	unsigned long mode;
	signed long ShutDownTime;
	unsigned char ShutDownMode;
	unsigned char ShutDownDCD;
	plcstring TWL[11];
	plcstring LCS[11];
	plcstring SDT[11];
	plcstring POT[11];
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	plcstring UPS_OS[129];
	/* VAR_INPUT (digital) */
	plcbit enable;
} ups_init_typ;

typedef struct ups_getcomstate
{
	/* VAR_OUTPUT (analog) */
	unsigned short status;
	float ShutDownTime;
	/* VAR_INPUT (digital) */
	plcbit enable;
	/* VAR_OUTPUT (digital) */
	plcbit DCD;
	plcbit CTS;
	/* VAR (digital) */
	plcbit DCD_old;
	plcbit CTS_old;
} ups_getcomstate_typ;



/* Prototyping of functions and function blocks */
void ups_comm(struct ups_comm* inst);
void ups_init(struct ups_init* inst);
void ups_getcomstate(struct ups_getcomstate* inst);
unsigned short ups_ar_shutdown(plcbit enable, unsigned char ShutDownMode);
unsigned short ups_deinit(plcbit enable);


#ifdef __cplusplus
};
#endif
#endif /* _ASUPS_ */

                                                           
