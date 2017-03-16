(********************************************************************
 * COPYRIGHT -- Piedmont Automation
 ********************************************************************
 * Library: wbrMemSvc
 * File: wbrMemSvc.fun
 * Author: Blanton Radford
 * Created: April 14, 2016
 ********************************************************************
 * Functions and function blocks of library wbrMemSvc
 ********************************************************************)

FUNCTION initMemSvc : BOOL
	VAR_INPUT
		partitionSize : UDINT;
	END_VAR
END_FUNCTION

FUNCTION memSvcAllocate : UDINT
	VAR_INPUT
		size : UDINT;
	END_VAR
END_FUNCTION

FUNCTION memSvcFree : UINT
	VAR_INPUT
		block : UDINT;
	END_VAR
END_FUNCTION

FUNCTION memSvcGetMemInfo : UDINT
	VAR_INPUT
		m : wbrMemService_typ;
	END_VAR
END_FUNCTION
