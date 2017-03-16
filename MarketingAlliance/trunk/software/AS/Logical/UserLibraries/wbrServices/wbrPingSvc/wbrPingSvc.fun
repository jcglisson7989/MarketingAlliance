(********************************************************************
 * COPYRIGHT -- Piedmont Automation
 ********************************************************************
 * Library: wbrPingSvc
 * File: wbrPingSvc.fun
 * Author: Blanton Radford
 * Created: June 22, 2015
 ********************************************************************
 * Functions and function blocks of library wbrPingSvc
 ********************************************************************)

FUNCTION wbrPingSvcInit : DINT
	VAR_INPUT
		p : wbrPingService_typ;
	END_VAR
END_FUNCTION

FUNCTION wbrPingStation : DINT
	VAR_INPUT
		p : wbrPingService_typ;
	END_VAR
END_FUNCTION

FUNCTION wbrSQL_DT2_ISOFmtdStringFromDT : DINT
	VAR_INPUT
		pDT : DTStructure;
		pDst : STRING[31];
		dstSize : UDINT;
	END_VAR
END_FUNCTION
