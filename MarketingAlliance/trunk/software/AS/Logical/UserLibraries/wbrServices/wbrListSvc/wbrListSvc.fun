(********************************************************************
 * COPYRIGHT -- Piedmont Automation
 ********************************************************************
 * Library: wbrListSvc
 * File: wbrListSvc.fun
 * Author: Blanton Radford
 * Created: May 07, 2015
 ********************************************************************
 * Functions and function blocks of library wbrListSvc
 ********************************************************************)

FUNCTION listSvcRequestListNode : UDINT
	VAR_INPUT
		l : linkedList_typ;
	END_VAR
END_FUNCTION

FUNCTION listSvcRequestList : UDINT
	VAR_INPUT
		size : UDINT;
		kind : linkedListKind_typ;
	END_VAR
END_FUNCTION

FUNCTION initListSvc : BOOL
	VAR_INPUT
		memValid : BOOL;
	END_VAR
END_FUNCTION

FUNCTION listSvcDeleteCurrentNode : UINT
	VAR_INPUT
		l : linkedList_typ;
	END_VAR
END_FUNCTION

FUNCTION listSvcGetHeadData : UDINT
	VAR_INPUT
		l : linkedList_typ;
	END_VAR
END_FUNCTION

FUNCTION listSvcGetCurrNodeData : UDINT
	VAR_INPUT
		l : linkedList_typ;
	END_VAR
END_FUNCTION

FUNCTION listSvcGetLastNodeData : UDINT
	VAR_INPUT
		l : linkedList_typ;
	END_VAR
END_FUNCTION

FUNCTION listSvcGoNextNodeAndGetData : UDINT
	VAR_INPUT
		l : linkedList_typ;
	END_VAR
END_FUNCTION

FUNCTION listSvcCharListToStringArray : UDINT
	VAR_INPUT
		l : linkedList_typ;
		s : STRING[7];
		sLength : UDINT;
		elements : UDINT;
		offset : UDINT;
		pageOffsetFactor : UDINT;
		maxNodes : UDINT;
		direction : BOOL;
		filterString : STRING[7];
	END_VAR
END_FUNCTION

FUNCTION listCurrentEntries : UDINT
	VAR_INPUT
		l : linkedList_typ;
		a : REFERENCE TO UDINT;
		elements : UDINT;
		offset : UDINT;
		pageOffsetFactor : UDINT;
		getData : BOOL;
	END_VAR
END_FUNCTION
