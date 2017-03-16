(********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Library: AsHost
 * File: AsHost.typ
 * Author: B+R
 ********************************************************************
 * Data types of library AsHost
 ********************************************************************)
                                                                      
TYPE
	ASHOST_LOCAL_OBJ : STRUCT			(*internal use*)
		StateMan		: UINT;		
		ErrMan			: UINT;		
		Init			: UDINT;	
		END_STRUCT;
END_TYPE
