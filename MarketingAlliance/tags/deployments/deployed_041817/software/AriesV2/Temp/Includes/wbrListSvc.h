/* Automation Studio generated header file */
/* Do not edit ! */
/* wbrListSvc  */

#ifndef _WBRLISTSVC_
#define _WBRLISTSVC_
#ifdef __cplusplus
extern "C" 
{
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
#ifdef _SG4
		#include "wbrsprintf.h"
		#include "wbrMemSvc.h"
#endif
#ifdef _SG3
		#include "wbrsprintf.h"
		#include "wbrMemSvc.h"
#endif
#ifdef _SGC
		#include "wbrsprintf.h"
		#include "wbrMemSvc.h"
#endif

/* Datatypes and datatypes of function blocks */
typedef enum linkedListKind_typ
{	lsSTACK,
	lsQUEUE
} linkedListKind_typ;

typedef struct listEntry_typ
{	unsigned char iter;
	unsigned char val;
	unsigned long pData;
	struct listEntry_typ* next;
} listEntry_typ;

typedef struct listNode_typ
{	unsigned long pData;
	struct listNode_typ* prev;
	struct listNode_typ* next;
} listNode_typ;

typedef struct linkedList_typ
{	struct listNode_typ* head;
	struct listNode_typ* curr;
	struct listNode_typ* dumm;
	enum linkedListKind_typ kind;
	unsigned long size;
	unsigned long numNodes;
	plcbit listProcessed;
} linkedList_typ;

typedef struct treeNode_typ
{	unsigned long pData;
	struct treeNode_typ* less;
	struct treeNode_typ* grtr;
} treeNode_typ;

typedef struct wbrListSvcStringListInput_typ
{	unsigned long offset;
	unsigned long pageOffset;
	plcbit direction;
	plcstring filterString[8];
} wbrListSvcStringListInput_typ;

typedef struct wbrListSvcStringList_typ
{	struct linkedList_typ* list;
	unsigned long sLength;
	unsigned long elements;
	struct wbrListSvcStringListInput_typ i;
} wbrListSvcStringList_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC unsigned long listSvcRequestListNode(struct linkedList_typ* l);
_BUR_PUBLIC unsigned long listSvcRequestList(unsigned long size, enum linkedListKind_typ kind);
_BUR_PUBLIC plcbit initListSvc(plcbit memValid);
_BUR_PUBLIC unsigned short listSvcDeleteCurrentNode(struct linkedList_typ* l);
_BUR_PUBLIC unsigned long listSvcGetHeadData(struct linkedList_typ* l);
_BUR_PUBLIC unsigned long listSvcGetCurrNodeData(struct linkedList_typ* l);
_BUR_PUBLIC unsigned long listSvcGetLastNodeData(struct linkedList_typ* l);
_BUR_PUBLIC unsigned long listSvcGoNextNodeAndGetData(struct linkedList_typ* l);
_BUR_PUBLIC unsigned long listSvcCharListToStringArray(struct linkedList_typ* l, plcstring* s, unsigned long sLength, unsigned long elements, unsigned long offset, unsigned long pageOffsetFactor, plcbit direction, plcstring* filterString);
_BUR_PUBLIC unsigned long listCurrentEntries(struct linkedList_typ* l, unsigned long* a, unsigned long elements, unsigned long offset, unsigned long pageOffsetFactor, plcbit getData);


#ifdef __cplusplus
};
#endif
#endif /* _WBRLISTSVC_ */

