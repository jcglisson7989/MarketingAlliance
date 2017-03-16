(********************************************************************
 * COPYRIGHT (C) BERNECKER + RAINER, AUSTRIA, A-5142 EGGELSBERG
 ********************************************************************
 * Library: VCLIB
 * File: VCLIB.typ
 * Created: 16.01.2007
 ********************************************************************
 * Global data types of library VCLIB
 ********************************************************************)
TYPE
	VCDPInfo : STRUCT
		iAddFractionDigits	: DINT ;
		uiElement	: UDINT ;
		uiRequiredUnit	: UDINT ;
		uiStringSize	: UDINT ;
		uiFlags	: UDINT ;
	END_STRUCT;
	VCPVInfo : STRUCT
		uiUpdateMsecs	: UINT ;
		uiUserID	: UINT ;
	END_STRUCT;
END_TYPE
