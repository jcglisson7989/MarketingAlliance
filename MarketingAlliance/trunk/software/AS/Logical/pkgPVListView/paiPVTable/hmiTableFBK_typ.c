/// IAUTOMATION CONFIDENTIAL
/// Unpublished Copyright (c) 2016 iAutomation, All Rights Reserved.
///
/// NOTICE:  All information contained herein is, and remains the property of iAutomation. The intellectual and technical concepts contained
/// herein are proprietary to iAutomation and may be covered by U.S. and Foreign Patents, patents in process, and are protected by trade secret or copyright law.
/// Dissemination of this information or reproduction of this material is strictly forbidden unless prior written permission is obtained
/// from iAutomation.  Access to the source code contained herein is hereby forbidden to anyone except current iAutomation employees, managers or contractors who have executed 
/// Confidentiality and Non-disclosure agreements explicitly covering such access.
///
/// The copyright notice above does not evidence any actual or intended publication or disclosure  of  this source code, which includes  
/// information that is confidential and/or proprietary, and is a trade secret, of  iAutomation.   ANY REPRODUCTION, MODIFICATION, DISTRIBUTION, PUBLIC  PERFORMANCE, 
/// OR PUBLIC DISPLAY OF OR THROUGH USE  OF THIS  SOURCE CODE  WITHOUT  THE EXPRESS WRITTEN CONSENT OF COMPANY IS STRICTLY PROHIBITED, AND IN VIOLATION OF APPLICABLE 
/// LAWS AND INTERNATIONAL TREATIES.  THE RECEIPT OR POSSESSION OF  THIS SOURCE CODE AND/OR RELATED INFORMATION DOES NOT CONVEY OR IMPLY ANY RIGHTS  
/// TO REPRODUCE, DISCLOSE OR DISTRIBUTE ITS CONTENTS, OR TO MANUFACTURE, USE, OR SELL ANYTHING THAT IT  MAY DESCRIBE, IN WHOLE OR IN PART.                
///
/// Programmer: John C. Glisson
/// Date: 20. October 2016

#include <bur/plctypes.h>
#ifdef __cplusplus
	extern "C"
	{
#endif
	#include "paiPVTable.h"
#ifdef __cplusplus
	};
#endif

#include "hmiParamList.h"
#include "ArTextSys.h"

static void Update_Stats_Table(UDINT * pMaxVal, char * pText, UDINT * pOverallMaxVal){
	UDINT TextLen = 0;
	
	TextLen = brsstrlen((UDINT) pText);

	if(*pMaxVal < TextLen){
		*pMaxVal = TextLen;
	}
	if(*pOverallMaxVal < TextLen){
		*pOverallMaxVal = TextLen;
	}
	return;
}

static DINT writeText(char * pNameSpace, char * pText, char * pLangCode, char * pParName, UDINT Buffer_Size, UDINT * pTextLen){
	STRING Buffer[Buffer_Size];
	ArTextSysGetText_typ FBK;
	FBK.Namespace = (UDINT) pNameSpace;
	FBK.SearchMode = arTEXTSYS_SEARCH_LANGUAGE_ONLY;
	FBK.TextID = (UDINT) pText;
	brsstrcpy((UDINT) &FBK.LanguageCode, (UDINT) pLangCode);
	FBK.TextBuffer =(UDINT) &Buffer;
	FBK.TextBufferSize = Buffer_Size;
	
	FBK.Execute = 0;
	ArTextSysGetText(&FBK);
	FBK.Execute = 1;
	ArTextSysGetText(&FBK);
	
	if(FBK.StatusID == 0){
		brsstrcpy((UDINT) pParName, (UDINT) &Buffer);
		*pTextLen = brsstrlen((UDINT) &Buffer);
	}else{
		brsstrcpy((UDINT) pParName,(UDINT)  &"Err");
	}
	return FBK.StatusID;
}


static DINT Get_PV_Table_Item_Info(char * pNameSpace, char * pTextID, char * pLangCode, PVListTexts_Info_typ * p){
	DINT status = 0;
	
	status = writeText(pNameSpace,pTextID,pLangCode,(char *) &p->Str, DEFINE_PAR_NAME_MAXLEN, &p->StrLen);

	if(status==0){
		p->isValid = 1;
	}else{
		p->isValid = 0;
		return status;	
	}
	
	status = PV_xgetadr((UDINT) &p->Str,(UDINT) &p->PVAdr,(UDINT) &p->PVLen);
	
	if(status==0){
		p->isPV = 1;
		p->isConstant = 0;
	}else{
		p->isPV = 0;
		p->isConstant = 1;
		p->Const_Value = brsatof((UDINT) &p->Str);
		return status;	
	}
	
	status = PV_ninfo((UDINT) &p->Str,(UDINT) &p->PVTyp,(UDINT) &p->PVLen,(UDINT) &p->PVDim);
	return status;
}

static void GetPVTableInfo(char * pNameSpace, UDINT pvTableIdx, PVTableInfo * p, BOOL * pErrorFlag){
	char strPVID[DEFINE_PAR_NAME_MAXLEN] = "PV."; 
	char strPVIdx[DEFINE_PAR_IDX_MAXLEN];
	DINT status = 0;
	
	brsitoa(pvTableIdx,(UDINT)  &strPVIdx);
	brsstrcat((UDINT) &strPVID, (UDINT) &strPVIdx);

	status = Get_PV_Table_Item_Info(pNameSpace,		(char *) &strPVID,		(char *) &DEFINE_LANGUAGE_STRINGS[DEFINE_INDEX_TEXTTABLE_PV], 		&p->Val.Param);
	status = Get_PV_Table_Item_Info(pNameSpace,		(char *) &strPVID,		(char *) &DEFINE_LANGUAGE_STRINGS[DEFINE_INDEX_TEXTTABLE_MIN], 		&p->Val.Min);
	status = Get_PV_Table_Item_Info(pNameSpace,		(char *) &strPVID,		(char *) &DEFINE_LANGUAGE_STRINGS[DEFINE_INDEX_TEXTTABLE_MAX], 		&p->Val.Max);
	status = Get_PV_Table_Item_Info(pNameSpace,		(char *) &strPVID,		(char *) &DEFINE_LANGUAGE_STRINGS[DEFINE_INDEX_TEXTTABLE_DEFAULT], 	&p->Val.Default);
	status = Get_PV_Table_Item_Info(pNameSpace,		(char *) &strPVID,		(char *) &DEFINE_LANGUAGE_STRINGS[DEFINE_INDEX_TEXTTABLE_HIDE], 	&p->Val.Hide);
	return;
}


static void GetPVNameInfo(char * pNameSpace, UDINT idxLanguage, UDINT idxPV, char * pParName, char * pParDesc, BOOL * pErrorFlag){
	ArTextSysLanguageCodeType strTmpLang;
	brsstrcpy((UDINT) &strTmpLang, (UDINT) &DEFINE_LANGUAGE_STRINGS[idxLanguage]);
	char strPVName[DEFINE_PAR_NAME_MAXLEN] = "Title."; 
	char strPVDesc[DEFINE_PAR_DESC_MAXLEN] = "Desc."; 
	char strPVIdx[DEFINE_PAR_IDX_MAXLEN];
	brsitoa((DINT) idxPV, (UDINT) &strPVIdx);
	brsstrcat((UDINT) &strPVName, (UDINT) &strPVIdx);
	brsstrcat((UDINT) &strPVDesc, (UDINT) &strPVIdx);
	UDINT TextLen = 0;
	
	writeText(pNameSpace, (char *) &strPVName, (char *) &strTmpLang, pParName, DEFINE_PAR_NAME_MAXLEN, &TextLen);
	writeText(pNameSpace, (char *) &strPVDesc, (char *) &strTmpLang, pParDesc, DEFINE_PAR_DESC_MAXLEN, &TextLen);
}


void hmiTableFBK_typ(struct hmiTableFBK_typ* p)
{
	//Really going to try hard to do this all in one cycle.
	UDINT ii_entries=0;
	UDINT ii_languages=0;
	
	BOOL flagError = 0;
	
	STRING LogString[DEFINE_LOGSTRING_LEN];

	brsstrcpy((UDINT) &p->hmiStruct.Table_Name,(UDINT)  &p->tableName);
	brsstrcpy((UDINT) &p->hmiStruct.NameSpace,(UDINT)  &p->nameSpace);
	
	for(ii_entries = 0; ii_entries <= DEFINE_MAX_TABLE_ENTRIES; ii_entries++){
		GetPVTableInfo(p->nameSpace, ii_entries, &p->hmiStruct.info[ii_entries], &flagError);
		
		if(p->hmiStruct.info[ii_entries].Val.Param.PVAdr == 0){//If there isn't a PV at that index, return from the function...
			p->hmiStruct.Max_Idx_Entries = ii_entries - 1;
			p->hmiStruct.Load_OK = (flagError == 0);
			
			wbrsnprintf((char *) &LogString, DEFINE_LOGSTRING_LEN, "TableInfo:<Table=%s><Count=%d><err=%d>", &p->tableName, ii_entries, (UDINT) flagError);
			requestMessageToLog((char *) &LogString, p->Logbook, arlogLEVEL_INFO, 50000, 0, 0);
			
			return;
		}//...Otherwise load its texts
		
		wbrsnprintf((char *) &LogString, DEFINE_LOGSTRING_LEN, "TableItem:<PVName=%s><Def=%s><Min=%s><Max=%s>", &p->hmiStruct.info[ii_entries].Val.Param.Str, &p->hmiStruct.info[ii_entries].Val.Default.Str, &p->hmiStruct.info[ii_entries].Val.Min.Str, &p->hmiStruct.info[ii_entries].Val.Max.Str);
		requestMessageToLog((char *) &LogString, p->Logbook, arlogLEVEL_INFO, 50000, 0, 0);
		
		Update_Stats_Table(&p->TableStats.Param,(char *) &p->hmiStruct.info[ii_entries].Val.Param.Str, &p->pOverallStats->Param);
		Update_Stats_Table(&p->TableStats.Default,(char *) &p->hmiStruct.info[ii_entries].Val.Default.Str, &p->pOverallStats->Default);
		Update_Stats_Table(&p->TableStats.Min,(char *) &p->hmiStruct.info[ii_entries].Val.Min.Str, &p->pOverallStats->Min);
		Update_Stats_Table(&p->TableStats.Max,(char *) &p->hmiStruct.info[ii_entries].Val.Max.Str, &p->pOverallStats->Max);
		Update_Stats_Table(&p->TableStats.Hide,(char *) &p->hmiStruct.info[ii_entries].Val.Hide.Str, &p->pOverallStats->Hide);
		
		for(ii_languages = 0; ii_languages <= MAX_IDX_LANGUAGES; ii_languages++){
			GetPVNameInfo((char *) &p->nameSpace, ii_languages, ii_entries,(char *) &p->hmiStruct.info[ii_entries].PVText[ii_languages].PVTextLangSpecific,(char *)  &p->hmiStruct.info[ii_entries].PVText[ii_languages].PVDescLangSpecific, &flagError);
			
			Update_Stats_Table(&p->TableStats.maxLenDesc,(char *) &p->hmiStruct.info[ii_entries].PVText[ii_languages].PVDescLangSpecific, &p->pOverallStats->maxLenDesc);
			Update_Stats_Table(&p->TableStats.maxLenName,(char *) &p->hmiStruct.info[ii_entries].PVText[ii_languages].PVTextLangSpecific, &p->pOverallStats->maxLenName);
		}
	}
}
