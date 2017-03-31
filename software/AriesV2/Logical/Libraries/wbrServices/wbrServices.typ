(*** /*****************************************************************
 * \copyright -- Piedmont Automation
 ********************************************************************
 * Program : wbrServices
 * \file :   wbrServices.typ
 * \author : Blanton Radford
 * \date Created: July 17, 2015
 ********************************************************************
 * Data types of package wbrServices
 ***************************************************************/ *****)

TYPE
	wbrSvcBool_enum : 
		(
		NO := 0,
		YES,
		OFF := 0,
		ON,
		STOP := 0,
		START,
		UNCHECK := 0,
		CHECK
		);
	cfgFileInfo_typ : 	STRUCT 
		timestamp : STRING[63];
		path : STRING[127];
		machineNumber : UDINT;
		machineName : STRING[31];
	END_STRUCT;
END_TYPE
