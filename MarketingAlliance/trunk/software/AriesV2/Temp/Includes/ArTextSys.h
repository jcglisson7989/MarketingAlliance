/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _ARTEXTSYS_H_INCLUDED_
#define _ARTEXTSYS_H_INCLUDED_
#ifdef __cplusplus
extern "C" {
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif

/**
 * @addtogroup IEC-Lib
 * @{
 */

/* Constants */
#if defined(_REPLACE_CONST) || defined(BUILD_TEXTSYSTEM)
#define arTEXTSYS_ERR_OUT_OF_MEMORY 	((long)0xC030280AL) /*!< fatal error: out of memory*/
#define arTEXTSYS_ERR_INVALID_ARG		((long)0x8030280BL) /*!< provided argument is invalid*/
#define arTEXTSYS_ERR_FAILED			((long)0x8030280CL) /*!< internal operation failure*/
#define arTEXTSYS_ERR_ACCESS_DENIED 	((long)0x8030280DL) /*!< resource-access denied*/
#define arTEXTSYS_ERR_INVALID_HANDLE	((long)0x8030280EL) /*!< invalid handle detected*/

#define arTEXTSYS_ERR_CANT_OPEN_TEXTDB	((long)0x80302811L) /*!< opening of text-db failed*/
#define arTEXTSYS_INF_ALREADY_OPENED	((long)0x40302812L) /*!< text-db is open and ready*/
#define arTEXTSYS_ERR_TEXTDB_SCHEMA 	((long)0x80302813L) /*!< unrecognised text-db schema or structure*/
#define arTEXTSYS_ERR_TEXTDB_READER 	((long)0x80302814L) /*!< read of open text-db failed*/
#define arTEXTSYS_ERR_TEXTDB_INTERNAL	((long)0x80302815L) /*!< other kind of text-db error*/
#define arTEXTSYS_INF_NOT_SET_DURABLE	((long)0x40302816L) /*!< configuration-change is not durable*/

#define arTEXTSYS_ERR_NO_TEXT_FOUND 	((long)0x80302818L) /*!< no requested text found*/
#define arTEXTSYS_INF_LANGUAGE_DIFFERS	((long)0x4030281AL) /*!< text-language differs; not in requested language*/
#define arTEXTSYS_INF_SUBSTITUTE_TEXT	((long)0x4030281BL) /*!< no text found, but substitute-text provided*/
#define arTEXTSYS_ERR_NOT_EXISTS		((long)0x8030281CL) /*!< record not found; doesn't exist*/
#define arTEXTSYS_ERR_END_REACHED		((long)0x8030281DL) /*!< no further suitable entry found*/
#else
 #ifndef _GLOBAL_CONST
	#define _GLOBAL_CONST _WEAK const
 #endif
 _GLOBAL_CONST long 	arTEXTSYS_ERR_FAILED;
 _GLOBAL_CONST long 	arTEXTSYS_ERR_ACCESS_DENIED;
 _GLOBAL_CONST long 	arTEXTSYS_ERR_OUT_OF_MEMORY;
 _GLOBAL_CONST long 	arTEXTSYS_ERR_INVALID_ARG;
 _GLOBAL_CONST long 	arTEXTSYS_ERR_INVALID_HANDLE;
 _GLOBAL_CONST long 	arTEXTSYS_ERR_UNEXPECTED;
 _GLOBAL_CONST long 	arTEXTSYS_ERR_CANT_OPEN_TEXTDB;
 _GLOBAL_CONST long 	arTEXTSYS_ERR_TEXTDB_SCHEMA;
 _GLOBAL_CONST long 	arTEXTSYS_ERR_TEXTDB_READER;
 _GLOBAL_CONST long 	arTEXTSYS_ERR_TEXTDB_INTERNAL;
 _GLOBAL_CONST long 	arTEXTSYS_INF_NOT_SET_DURABLE;
 _GLOBAL_CONST long 	arTEXTSYS_ERR_NO_TEXT_FOUND;
 _GLOBAL_CONST long 	arTEXTSYS_INF_LANGUAGE_DIFFERS;
 _GLOBAL_CONST long 	arTEXTSYS_INF_SUBSTITUTE_TEXT;
 _GLOBAL_CONST long 	arTEXTSYS_ERR_NOT_EXISTS;
 _GLOBAL_CONST long 	arTEXTSYS_ERR_END_REACHED;
#endif	/*_REPLACE_CONST*/

/* Datatypes and datatypes of function blocks */

typedef enum ArTextSysSearchModeEnum
{
	arTEXTSYS_SEARCH_FALLBACK_SUBST,
	arTEXTSYS_SEARCH_LANGUAGE_ONLY,
	arTEXTSYS_SEARCH_FALLBACK
} ArTextSysSearchModeEnum;

typedef struct ArTextSysFormatArgumentType
{
	unsigned short Datatype;
	unsigned long Data;
	unsigned long UnitNamespace;
	unsigned long UnitID;
} ArTextSysFormatArgumentType;

/** @cond HIDDEN_INTERNALS */
struct ArTextSysExec1InternalType
{
	unsigned short	i_serno;
	unsigned short	i_state;
	signed long int Result;
};

struct ArTextSysIter1InternalType
{
	struct ArTextSysExec1InternalType i_base;
	signed long int m_iter;
};
/** @endcond */

typedef plcstring ArTextSysLanguageCodeType[19];

typedef struct ArTextSysGetSystemLanguage
{
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	ArTextSysLanguageCodeType LanguageCode;
	/* VAR (analog) */
	struct ArTextSysExec1InternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} ArTextSysGetSystemLanguage_typ;

typedef struct ArTextSysSetSystemLanguage
{
	/* VAR_INPUT (analog) */
	ArTextSysLanguageCodeType LanguageCode;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	/* VAR (analog) */
	struct ArTextSysExec1InternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} ArTextSysSetSystemLanguage_typ;

typedef struct ArTextSysGetNamespaceLanguages
{
	/* VAR_INPUT (analog) */
	unsigned long Namespace;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	ArTextSysLanguageCodeType LanguageCode;
	/* VAR (analog) */
	struct ArTextSysIter1InternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	plcbit First;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
	plcbit EndOfList;
} ArTextSysGetNamespaceLanguages_typ;

typedef struct ArTextSysGetText
{
	/* VAR_INPUT (analog) */
	unsigned long Namespace;
	unsigned long TextID;
	ArTextSysLanguageCodeType LanguageCode;
	unsigned long TextBufferSize;
	unsigned long TextBuffer;
	enum ArTextSysSearchModeEnum SearchMode;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	unsigned long TextSize;
	/* VAR (analog) */
	struct ArTextSysExec1InternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} ArTextSysGetText_typ;

typedef struct ArTextSysFormatString
{
	/* VAR_INPUT (analog) */
	unsigned long FormatString;
	unsigned short ArgumentCount;
	struct ArTextSysFormatArgumentType ArgumentList[10];
	ArTextSysLanguageCodeType LanguageCode;
	unsigned long MeasurementCode;
	unsigned long TextBufferSize;
	unsigned long TextBuffer;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	unsigned long TextSize;
	/* VAR (analog) */
	struct ArTextSysExec1InternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} ArTextSysFormatString_typ;

typedef struct ArTextSysGetFormattedText
{
	/* VAR_INPUT (analog) */
	unsigned long Namespace;
	unsigned long TextID;
	unsigned short ArgumentCount;
	struct ArTextSysFormatArgumentType ArgumentList[10];
	ArTextSysLanguageCodeType LanguageCode;
	unsigned long MeasurementCode;
	unsigned long TextBufferSize;
	unsigned long TextBuffer;
	enum ArTextSysSearchModeEnum SearchMode;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	unsigned long TextSize;
	/* VAR (analog) */
	struct ArTextSysExec1InternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} ArTextSysGetFormattedText_typ;

/* Prototyping of functions and function blocks */
_BUR_PUBLIC void ArTextSysGetSystemLanguage(struct ArTextSysGetSystemLanguage* inst);
_BUR_PUBLIC void ArTextSysSetSystemLanguage(struct ArTextSysSetSystemLanguage* inst);
_BUR_PUBLIC void ArTextSysGetNamespaceLanguages(struct ArTextSysGetNamespaceLanguages* inst);
_BUR_PUBLIC void ArTextSysGetText(struct ArTextSysGetText* inst);
_BUR_PUBLIC void ArTextSysFormatString(struct ArTextSysFormatString* inst);
_BUR_PUBLIC void ArTextSysGetFormattedText(struct ArTextSysGetFormattedText* inst);

#ifdef __cplusplus
}	// End of C-Linkage
#endif /*__cplusplus*/

/** @}*/
#endif /* _ARTEXTSYS_H_INCLUDED_ */

