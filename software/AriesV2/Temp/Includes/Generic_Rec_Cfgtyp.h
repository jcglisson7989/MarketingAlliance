/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _BUR_1491508286_3_
#define _BUR_1491508286_3_

#include <bur/plctypes.h>

/* Datatypes and datatypes of function blocks */
typedef struct HMIConfig_typ
{	plcstring passwordSetup[16];
	plcstring passwordEngineer[16];
	plcstring passwordFactory[16];
	unsigned long MachineLang;
} HMIConfig_typ;

typedef struct Global_Rec_typ
{	unsigned long MagicPrefix;
	float FeedVelocity;
	struct AriesCreaserParams_typ Crease;
	unsigned long MagicSuffix;
} Global_Rec_typ;

typedef struct Global_Cfg_typ
{	unsigned long MagicPrefix;
	struct CreaserConfig_typ Creaser;
	struct HMIConfig_typ HMI;
	struct wbrMemService_typ wbrMemService;
	struct cfgCompileVersionInfo_typ cfgCompile;
	unsigned long MagicSuffix;
} Global_Cfg_typ;

typedef struct Global_Rec_Cfg_typ
{	struct Global_Rec_typ Rec;
	struct Global_Cfg_typ Cfg;
} Global_Rec_Cfg_typ;

typedef struct Global_RecCfg_Public_In_typ
{	unsigned char Copy_default_to_save;
	unsigned char Copy_default_to_active;
	unsigned char Copy_save_to_active;
	unsigned char Copy_save_to_default;
	unsigned char Copy_active_to_save;
	unsigned char Copy_active_to_default;
	unsigned char Copy_internal_to_default;
	plcstring FileName[256];
} Global_RecCfg_Public_In_typ;

typedef struct Global_RecCfg_Public_Out_typ
{	unsigned char save_differs_from_active;
	unsigned char default_differs_from_save;
	unsigned char active_differs_from_default;
} Global_RecCfg_Public_Out_typ;

typedef struct Global_Rec_Cfg_Info_typ
{	struct Global_RecCfg_Public_Out_typ O;
	struct Global_RecCfg_Public_In_typ I;
} Global_Rec_Cfg_Info_typ;

typedef struct Global_Rec_Cfg_IO_typ
{	struct Global_Rec_Cfg_Info_typ Rec;
	struct Global_Rec_Cfg_Info_typ Cfg;
} Global_Rec_Cfg_IO_typ;

typedef struct Global_Par_typ
{	struct Global_Rec_Cfg_typ save;
	struct Global_Rec_Cfg_typ active;
	struct Global_Rec_Cfg_typ defaultvals;
	struct Global_Rec_Cfg_IO_typ IO;
} Global_Par_typ;






__asm__(".section \".plc\"");

/* Used IEC files */
__asm__(".ascii \"iecfile \\\"Logical/Generic_Rec_Cfg.typ\\\" scope \\\"global\\\"\\n\"");

/* Exported library functions and function blocks */

__asm__(".previous");


#endif /* _BUR_1491508286_3_ */

