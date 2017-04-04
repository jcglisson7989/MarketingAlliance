/* Automation Studio generated header file */
/* Do not edit ! */
/* jgLibC  */

#ifndef _JGLIBC_
#define _JGLIBC_
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
#endif
#ifdef _SG3
		#include "standard.h"
#endif
#ifdef _SGC
		#include "standard.h"
#endif

/* Datatypes and datatypes of function blocks */
typedef struct Debounce_Config_Struct
{	float Timer_On;
	float Timer_Off;
} Debounce_Config_Struct;

typedef struct cfgCompileVersionInfo_typ
{	plcstring projVersion[64];
	plcstring AR_Version[16];
	plcstring AS_config[64];
	plcstring date[32];
	plcstring AS_version[64];
	plcstring user[64];
	plcstring company[64];
	plcstring info[64];
	plcstring Revision[64];
	plcstring Modified[64];
	plcstring Date[64];
	plcstring TimeNow[64];
	plcstring RevRange[64];
	plcstring Mixed[64];
	plcstring IsTagged[64];
	plcstring URL[256];
	plcstring isInSVN[64];
	plcstring lockdate[64];
	plcstring Rev_Number[64];
} cfgCompileVersionInfo_typ;

typedef struct Debounce_Signal
{
	/* VAR_INPUT (analog) */
	unsigned char input;
	struct Debounce_Config_Struct* pConfigVals;
	/* VAR_OUTPUT (analog) */
	unsigned char Signal_Debounced;
	/* VAR (analog) */
	struct TON Ton;
	struct TOF Tof;
} Debounce_Signal_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void Debounce_Signal(struct Debounce_Signal* inst);
_BUR_PUBLIC unsigned long Tms(float in);


#ifdef __cplusplus
};
#endif
#endif /* _JGLIBC_ */

