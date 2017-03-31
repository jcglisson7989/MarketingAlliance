(*** /*****************************************************************
 * \copyright -- Piedmont Automation
 ********************************************************************
 * Program : wbrListSvc
 * \file :   wbrListSvc.typ
 * \author : Blanton Radford
 * \date Created: May 07, 2015
 ********************************************************************
 * Data types of library wbrListSvc
 ****************************************************************/ ****)

TYPE
	linkedListKind_typ : 
		(
		lsSTACK,
		lsQUEUE
		);
	listEntry_typ : 	STRUCT 
		iter : USINT;
		val : USINT;
		pData : UDINT;
		next : REFERENCE TO listEntry_typ;
	END_STRUCT;
	listNode_typ : 	STRUCT 
		pData : UDINT;
		prev : REFERENCE TO listNode_typ;
		next : REFERENCE TO listNode_typ;
	END_STRUCT;
	linkedList_typ : 	STRUCT 
		head : REFERENCE TO listNode_typ;
		curr : REFERENCE TO listNode_typ;
		dumm : REFERENCE TO listNode_typ;
		kind : linkedListKind_typ;
		size : UDINT; (*size of the data to be allocated for <node>->pData*)
		numNodes : UDINT;
		listProcessed : BOOL;
	END_STRUCT;
	treeNode_typ : 	STRUCT 
		pData : UDINT;
		less : REFERENCE TO treeNode_typ;
		grtr : REFERENCE TO treeNode_typ;
	END_STRUCT;
	wbrListSvcStringListInput_typ : 	STRUCT 
		offset : UDINT; (*Offset into the log list*)
		pageOffset : UDINT; (*Additional offset into the log list by n "pages" of size BGSSM_MAX_LOG_ENTRY_INDEX*)
		direction : BOOL;
		filterString : STRING[7]; (*Filter string declaration needs to be outside this lib and pointer passed here*)
	END_STRUCT;
	wbrListSvcStringList_typ : 	STRUCT 
		list : REFERENCE TO linkedList_typ;
		sLength : UDINT; (*Length of the strings in the string array*)
		elements : UDINT; (*Additional offset into the log list by n "pages" of size BGSSM_MAX_LOG_ENTRY_INDEX*)
		i : wbrListSvcStringListInput_typ;
	END_STRUCT;
END_TYPE
