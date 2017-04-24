(********************************************************************
 * COPYRIGHT -- pai
 ********************************************************************
 * Package: paiTemplate
 * File: paiMp.typ
 * Author: goran
 * Created: August 28, 2013
 ********************************************************************
 * Data types of package paiMp
 ********************************************************************)
(*########################################################################*)
(*pai specific defines for mapp objects and types*)
(*########################################################################*)

TYPE
	paiFileItemSizeAndDT_typ : 	STRUCT 
		strDT : STRING[63];
		strSize : STRING[15];
	END_STRUCT;
	paiMpTemplateFUBs_typ : 	STRUCT 
		MpAlarmBasic : MpAlarmBasic;
		MpAlarmBasicUI : MpAlarmBasicUI;
		MpAlarmRegUser : MpAlarmRegUser;
		MpComDump : MpComDump;
		MpComLoggerUI : MpComLoggerUI;
		MpComLinkToParent : MpComLinkToParent;
		MpFileManagerUI : MpFileManagerUI; (*table colum: id-s*)
		MpRecipeRegPar : MpRecipeRegPar;
		MpRecipeRegParSync : MpRecipeRegParSync;
		MpRecipeUI : MpRecipeUI;
		MpRecipeUICustom1 : MpRecipeUI;
		MpRecipeUICustom2 : MpRecipeUI;
		MpRecipeXml : MpRecipeXml;
		MpRecipeXmlCustom1 : MpRecipeXml;
		MpRecipeXmlCustom2 : MpRecipeXml;
	END_STRUCT;
	paiMpTemplateData_typ : 	STRUCT 
		MpComIdent : MpComIdentType;
		MpComLoggerUIConnect : MpComLoggerUIConnectType;
		MpRecipeUIConnect : MpRecipeUIConnectType;
		MpRecipeUIConnectCustom1 : MpRecipeUIConnectType;
		MpRecipeUIConnectCustom2 : MpRecipeUIConnectType;
		MpFileManagerUIConnect : MpFileManagerUIConnectType;
		paiFileItemSizeAndDT : ARRAY[0..9]OF paiFileItemSizeAndDT_typ;
	END_STRUCT;
	paiMpTemplate_typ : 	STRUCT 
		data : paiMpTemplateData_typ; (*table colum: id-s*)
		fub : paiMpTemplateFUBs_typ;
	END_STRUCT;
END_TYPE
