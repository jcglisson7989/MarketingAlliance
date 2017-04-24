#ifndef _BG_PVCOMPARE_C
#define _BG_PVCOMPARE_C

#ifdef WIN32
#include "string.h"
#else
#include <bur/plctypes.h>
#endif

//#include <string.h>
//#include <brsystem.h>
//#include <sys_lib.h>
//#include <asstring.h>
#include "bgstring.h"
#include "bgsprintf.h"
#include "bgsscanf.h"
#include "bgsscanf.c"

#define PV_SERIALIZE_ITEM_DELIM_CRLF "\r\n"
#define PV_SERIALIZE_ITEM_DELIM_COMMA ","
//#define PV_SERIALIZE_STR_MARKUP "\""
#define PV_SERIALIZE_STR_MARKUP "'"

#define PV_SERIALIZE_ERR_ZEROPTR -1
#define PV_SERIALIZE_ERR_PVNOTFOUND -2
#define PV_SERIALIZE_ERR_PVADRNOTFOUND -3
#define PV_SERIALIZE_ERR_OBUFOVERFLOW -4

#define PV_SERIALIZE_ERR_LAST -10

typedef struct bgPVSerialize_typ
{
	char* toOutStream;
	UDINT lengthOutStream;
	DINT outputCharCount;
	DINT errorCode;
	DINT arrayIndexFrom;
	DINT arrayIndexTo;
	char* pItemDelim;
	char* pStrMarkup;
	
}bgPVSerialize_typ;



static void bgPVSubStructCompare(bgPVSerialize_typ* p, char* pvNameRoot, char* pvName, UINT dimension, char* pvNameRoot2);
static void bgPVCompare(bgPVSerialize_typ* p, char* pvNameRoot, char* pvName, char* pvNameRoot2);


//#ifndef DBG
//#define DBG() ;
//#endif

#define PV_TYPE_MAX_INDEX	24
static const char *bgPVTypeStrings[PV_TYPE_MAX_INDEX + 1]={
	"STRUCT",	/*0*/
	"BOOL",		/*1*/
	"SINT",		/*2*/
	"INT",		/*3*/
	"DINT",		/*4*/
	"USINT",		/*5*/
	"UINT",		/*6*/
	"UDINT",		/*7*/
	"REAL",		/*8*/
	"STRING ",	/*9*/
	"ULINT",		/*10*/
	"DATETIME",	/*11*/
	"TIME",		/*12*/
	"DATE",		/*13*/
	"LREAL",		/*14*/
	"ARRAY",		/*15*/
	"TIME_OF_DAY",	/*16*/
	"BYTE",		/*17*/
	"WORD",		/*18*/
	"DWORD",	/*19*/
	"LWORD",	/*20*/
	"WSTRING",	/*21*/
	"?22",		/*22*/
	"LINT",		/*23*/
	};

static const char *bgGetPVTypeString(int pvTypeIndex){
	if(pvTypeIndex >= PV_TYPE_MAX_INDEX){
		return "TYPE=?";
	}

	return bgPVTypeStrings[pvTypeIndex];
}


static void bgGetPVValueText(char* pvValue, UDINT data_typ, UDINT data_len, UINT dimension, UDINT adr)
{
/*
	if( dimension != 1)
		DBG("TODO: display multidimensional values...");
*/
	switch(data_typ){
		case PB_DT_STRUCT:
			//DBG("TODO: display struct values...");
			break;	
		case PB_DT_BOOL:
			bgsprintf(pvValue, "%d", *( (char*)adr ));
			break;	
		case PB_DT_INT8:
			bgsprintf(pvValue, "%d", *( (char*)adr) );
			break;	
		case PB_DT_INT16:
			bgsprintf(pvValue, "%d", *( (short*)adr ) );
			break;	
		case PB_DT_INT32:
			bgsprintf(pvValue, "%d", *( (int*)adr ));
			break;	
		case PB_DT_BYTE:
			bgsprintf(pvValue, "%u", *( (unsigned char*)adr));
			break;	
		case PB_DT_WORD:
			bgsprintf(pvValue, "%u", *( (unsigned short*)adr));
			break;	
		case PB_DT_LONG:
			bgsprintf(pvValue, "%u", *( (unsigned int*)adr));
			break;	
		case PB_DT_FLOAT:
			{
				char temp[32];
				ftoa( *((float*)adr), (UDINT)temp);
				bgsprintf(pvValue, "%s", temp);
			}
			break;	
		case PB_DT_VIS:
			bgsprintf(pvValue, "%s", (char*)adr );
			break;	
		case PB_DT_OCTET:
			//DBG("TODO: display octet values...");
			break;	
		case PB_DT_DATE:
			//DBG("TODO: display date values...");
			break;	
		case PB_DT_TIME:
			//DBG("TODO: display time values...");
			break;	
		case PB_DT_DIFF:
			//DBG("TODO: display time-diff values...");
			break;	
		case 14://double
			{
				char temp[32];
				double value_double = *((double*)(adr));
				float value_float = (float)value_double;
				ftoa( value_float, (UDINT)temp);
				bgsprintf(pvValue, "%s", temp);
			}		
			break;	
		case PB_DT_ARRAY:
			//DBG("TODO: display array values...");
			break;	
	}
}



static void bgSetPVValueText(char* pvValue, UDINT data_typ, UDINT data_len, UINT dimension, UDINT adr)
{
/*
	if( dimension != 1)
		DBG("TODO: display multidimensional values...");
*/
	switch(data_typ){
		case PB_DT_STRUCT:
			//DBG("TODO: set struct values...");
			break;	
		case PB_DT_BOOL:
			bgsscanf(pvValue, "%d", (char*)adr );
			break;	
		case PB_DT_INT8:
			bgsscanf(pvValue, "%d", (char*)adr );
			break;	
		case PB_DT_INT16:
			bgsscanf(pvValue, "%d", (short*)adr  );
			break;	
		case PB_DT_INT32:
			bgsscanf(pvValue, "%d", (int*)adr );
			break;	
		case PB_DT_BYTE:
			bgsscanf(pvValue, "%u", (unsigned char*)adr);
			break;	
		case PB_DT_WORD:
			bgsscanf(pvValue, "%u", (unsigned short*)adr);
			break;	
		case PB_DT_LONG:
			bgsscanf(pvValue, "%u", (unsigned int*)adr);
			break;	
		case PB_DT_FLOAT:
			{
				*((float*)adr) = atof((UDINT)pvValue);
			}
			break;	
		case PB_DT_VIS:
			{
				int ii=0;
				//copy string
				//don't copy over the size of the dest buffer!
				//terminate properly
				char* src=(char*)pvValue;
				char* dst=(char*)adr;			
				//DBG("GBTST= %s len=%d", src, data_len);
				for(ii=0; ii<data_len; ii++){
					dst[ii] = src[ii];
					//if end of src string > exit
					if(!src[ii])
						break;
				}
				//src longer than dst > terminate dst
				dst[data_len-1] = 0;
			}
			break;	
		case PB_DT_OCTET:
			//DBG("TODO: display octet values...");
			break;	
		case PB_DT_DATE:
			//DBG("TODO: display date values...");
			break;	
		case PB_DT_TIME:
			//DBG("TODO: display time values...");
			break;	
		case PB_DT_DIFF:
			//DBG("TODO: display time-diff values...");
			break;	
		case 14://double
			{
				float value_float = atof((UDINT)pvValue); 
				double value_double = (double)value_float;
				*((double*)adr) = value_double;
			}
			break;	
		case PB_DT_ARRAY:
			//DBG("TODO: display array values...");
			break;	
	}
}

static bgPVWriteOutStream(bgPVSerialize_typ* p, char* pvName, char* pvTextValue)
{
	if(!p || !p->toOutStream || !pvName || !pvTextValue || !p->pItemDelim)
		return;
	
	strcat(p->toOutStream, pvName);
	strcat(p->toOutStream, "=");
	strcat(p->toOutStream, pvTextValue);		
	strcat(p->toOutStream, p->pItemDelim);	// delimiter "\r\n" or ","	
		
	p->outputCharCount += strlen(pvName);
	p->outputCharCount += strlen(pvTextValue);
	p->outputCharCount += strlen(p->pItemDelim) + 1; //  '=' + sizeof the delimiter string 
		
	if(p->outputCharCount >= (p->lengthOutStream - 100) ){//TODO: needs to be a better way to handle output buffer overflow
		p->errorCode = PV_SERIALIZE_ERR_OBUFOVERFLOW;
		return;
	}
}

static bgTxtWriteOutStream(bgPVSerialize_typ* p, char* pTxt)
{
	if(!p || !p->toOutStream || !pTxt)
		return;
		
	strcat(p->toOutStream, pTxt);
		
	p->outputCharCount += strlen(pTxt);
		
	if(p->outputCharCount >= (p->lengthOutStream - 100) ){//TODO: needs to be a better way to handle output buffer overflow
		p->errorCode = PV_SERIALIZE_ERR_OBUFOVERFLOW;
		return;
	}
}

static int bgPVSerializeIsArray(int data_typ, int data_len, int dimension)
{
	if(data_typ && (dimension > 1)){
		return 1;
	}
	return 0;
}

static void bgPVArrayCompare(bgPVSerialize_typ* p, char* pvNameRoot, char* pvName, int dimension, char* pvNameRoot2)
{
	int ii = 0;
	// TODO: checking for max size of the strings that are copied to these arrays
	char structName[256];
	char structItemName[32];
	char structName2[256];
	char structItemName2[32];

	for(ii=0; ii < dimension; ii++){
		// NOTE: verify why PV_item destroys content of the buffer supplied as 1st param
		if( !pvName){
			strcpy(structName, pvNameRoot);
			strcpy(structName2, pvNameRoot2);
		}else{
			strcpy(structName, pvNameRoot);
			strcpy(structName2, pvNameRoot2);
			//strcat(structName, ".");
			//strcat(structName, pvName);
		}
		
		{
			char arrayIndexTxt[10];
			strcpy(structItemName, pvName);
			strcat(structItemName, "[");
			itoa(ii, (UDINT)arrayIndexTxt);
			strcat(structItemName, arrayIndexTxt);
			strcat(structItemName, "]");
			
			strcpy(structItemName2, pvName);
			strcat(structItemName2, "[");
			itoa(ii, (UDINT)arrayIndexTxt);
			strcat(structItemName2, arrayIndexTxt);
			strcat(structItemName2, "]");
			
		}
		
		bgPVCompare(p, structName, structItemName, structName2);
		
		if(p->errorCode)
			return;	
		
	}	
}


static void bgPVArrayCompareRootToFrom(bgPVSerialize_typ* p, char* pvNameRoot, int dimension, char* pvNameRoot2)
{
	int ii = 0;
	// TODO: checking for max size of the strings that are copied to these arrays
	char structName[256];
	char structItemName[32];
	
	char structName2[256];
	char structItemName2[32];

	
	for(ii = p->arrayIndexFrom; (ii < dimension) && (ii <= p->arrayIndexTo); ii++){
		// NOTE: verify why PV_item destroys content of the buffer supplied as 1st param
		{
			char arrayIndexTxt[10];
			strcpy(structItemName, pvNameRoot);
			strcat(structItemName, "[");
			itoa(ii, (UDINT)arrayIndexTxt);
			strcat(structItemName, arrayIndexTxt);
			strcat(structItemName, "]");
			
			strcpy(structItemName2, pvNameRoot2);
			strcat(structItemName2, "[");
			itoa(ii, (UDINT)arrayIndexTxt);
			strcat(structItemName2, arrayIndexTxt);
			strcat(structItemName2, "]");
			
			
		}
		//bgTxtWriteOutStream(p, structItemName);	
		//bgTxtWriteOutStream(p, "=[");	
		bgPVCompare(p, structItemName, 0, structItemName2);
		//bgTxtWriteOutStream(p, "]\r\n");	
		//bgTxtWriteOutStream(p, "],");	
		
		if(p->errorCode)
			return;	
	}	
}

static void bgPVCompare(bgPVSerialize_typ* p, char* pvNameRoot, char* pvName, char* pvNameRoot2)
{
	UINT status;
	UDINT data_typ;
	UDINT data_len;
	UINT dimension;
	UDINT adr;
	UINT status2;
	UDINT data_typ2;
	UDINT data_len2;
	UINT dimension2;
	UDINT adr2;
	char structItemPVName[256];
	char structItemPVName2[256];

	if( !pvName){
		strcpy(structItemPVName, pvNameRoot);
		strcpy(structItemPVName2, pvNameRoot2);
		
	}else{
		strcpy(structItemPVName, pvNameRoot);
		strcat(structItemPVName, ".");		
		strcat(structItemPVName, pvName);
		
		strcpy(structItemPVName2, pvNameRoot2);
		strcat(structItemPVName2, ".");		
		strcat(structItemPVName2, pvName);
	}


	status = PV_ninfo(structItemPVName, &data_typ, &data_len, &dimension);
	status2 = PV_ninfo(structItemPVName2, &data_typ2, &data_len2, &dimension2);

	if( status ){
		p->errorCode = status;
		return;
	}
	if( status2 ){
		p->errorCode = status2;
		return;
	}
	
	if( bgPVSerializeIsArray(data_typ, data_len, dimension) ){
		bgPVArrayCompare(p, pvNameRoot, pvName, dimension, pvNameRoot2);
		return;
	}
	
		
	status = PV_xgetadr(structItemPVName, &adr, &data_len);
	status2 = PV_xgetadr(structItemPVName2, &adr2, &data_len2);
	
	if( status ){
		p->errorCode = status;
		return;
	}
	if( status2 ){
		p->errorCode = status2;
		return;
	}

	if(data_typ == PB_DT_STRUCT){
		//DBG("PV='%s' Typ=%s Len=%d Dim=%d" , pvnamecomplete, bgGetPVTypeString(data_typ), data_len, dimension);	
		bgPVSubStructCompare(p, pvNameRoot, pvName, dimension, pvNameRoot2);
	}else{
		char pvTextValue[256];
		char pvTextValue2[256];
		int len = 0;
		
		if(data_typ == PB_DT_VIS){//STRING VALUES ONLY > marked with a special markup at the begining and end
			strcpy(pvTextValue, p->pStrMarkup);//set string begining markup (i.e. "\"")
			strcpy(pvTextValue2, p->pStrMarkup);//set string begining markup (i.e. "\"")
			len = strlen(pvTextValue);
		}
		
		bgGetPVValueText(&pvTextValue[len], data_typ, data_len, dimension, adr);	
		bgGetPVValueText(&pvTextValue2[len], data_typ2, data_len2, dimension2, adr2);	
		
		if(data_typ == PB_DT_VIS){//STRING VALUES ONLY > marked with a special markup at the begining and end
			strcat(pvTextValue, p->pStrMarkup);//set string ending markup (i.e. "\"")
			strcat(pvTextValue2, p->pStrMarkup);//set string ending markup (i.e. "\"")
		}
		
		if(strcmp(pvTextValue, pvTextValue2) != 0){
			char buf[255];
			bgsprintf(buf, "%s changed. OldValue=%s, NewValue=%s\n", structItemPVName, pvTextValue, pvTextValue2);
			bgTxtWriteOutStream(p, buf);			
		}
		
		//DBG("stritemPV='%s' Typ=%s Len=%d Dim=%d Val=%s" , pvName, bgGetPVTypeString(data_typ), data_len, dimension, pvTextValue);
		//bgPVWriteOutStream(p, pvName, pvTextValue);
	}

}


static void bgPVSubStructCompare(bgPVSerialize_typ* p, char* pvNameRoot, char* pvName, UINT dimension, char* pvNameRoot2)
{

	int ii = 0;
	// TODO: checking for max size of the strings that are copied to these arrays
	char structName[256];
	char structName2[256];
	char structItemName[32];
	char structItemName2[32];
	char structItemPVNameNoRoot[256];
	char structItemPVNameNoRoot2[256];
	UINT status;
	UINT status2;
	UDINT data_typ;
	UDINT data_typ2;
	UDINT data_len;
	UDINT data_len2;
	UDINT adr;
	UDINT adr2;
	UINT dimension2;

	for(ii=0; ii < dimension; ii++){
		// NOTE: verify why PV_item destroys concent of the buffer supplied as 1st param
		if( !pvName){
			strcpy(structName, pvNameRoot);
			strcpy(structName2, pvNameRoot2);
		}else{
			strcpy(structName, pvNameRoot);
			strcat(structName, ".");
			strcat(structName, pvName);
			
			strcpy(structName2, pvNameRoot2);
			strcat(structName2, ".");
			strcat(structName2, pvName);
		}
		
		
		status = PV_item(structName, ii, structItemName);
		status2 = PV_item(structName2, ii, structItemName2);
		
		if(status && (status != 14713)){
			// TODO: error handling
			//DBG("bgPVSubStr.. ii=%d str=%s item=%s err=%d", ii, structName, structItemName, status);
			p->errorCode = status;
			return;
		}
		if(status2 && (status2 != 14713)){
			// TODO: error handling
			//DBG("bgPVSubStr.. ii=%d str=%s item=%s err=%d", ii, structName, structItemName, status);
			p->errorCode = status2;
			return;
		}
		
		
		
		//DBG("item=%d, name=%s", ii, structItemName);
		// TODO: check for max length of the PV name
		if(!pvName){
			strcpy(structItemPVNameNoRoot, structItemName);
			strcpy(structItemPVNameNoRoot2, structItemName2);
		}else{
			if(status == 14713){//14713 is to handle enum type??? find out if there is a better solutiuon
				//following code is to handle an enum type that is reported as a structure (type 0). However, there are no structure elements and is not clear how to access values???
				char pvTextValue[64];
				char pvTextValue2[64];
		
				status = PV_ninfo(structName, &data_typ, &data_len, &dimension);
				status = PV_xgetadr(structName, &adr, &data_len);
				
				status2 = PV_ninfo(structName2, &data_typ2, &data_len2, &dimension2);
				status2 = PV_xgetadr(structName2, &adr2, &data_len2);
				
				
				//based on the reported lenght, try to guess the type of the enum
				if(data_len == 1){
					data_typ = PB_DT_BYTE;	
				}else
					if(data_len == 2){
					data_typ = PB_DT_WORD;					
				}else{
					data_typ = PB_DT_LONG;					
				}
				bgGetPVValueText(&pvTextValue[0], data_typ, data_len, dimension, adr);
				bgGetPVValueText(&pvTextValue2[0], data_typ2, data_len2, dimension2, adr2);
				if(strcmp(&pvTextValue[0], &pvTextValue2[0]) != 0){
					char buf[255];
					bgsprintf(buf, "%s changed. OldValue=%s, NewValue=%s\n", structName, &pvTextValue[0], &pvTextValue2[0]);
					bgTxtWriteOutStream(p, buf);	
				}
				return;				
			}	
			
			strcpy(structItemPVNameNoRoot, pvName);
			strcat(structItemPVNameNoRoot, ".");
			strcat(structItemPVNameNoRoot, structItemName);	
			
			strcpy(structItemPVNameNoRoot2, pvName);
			strcat(structItemPVNameNoRoot2, ".");
			strcat(structItemPVNameNoRoot2, structItemName2);	
					
		}

		bgPVCompare(p, pvNameRoot, structItemPVNameNoRoot, pvNameRoot2);
		
		if(p->errorCode)
			return;
	}
}


DINT bgPVRootArrayCompare(char* pvNameRoot, char* toOutStream, UDINT lengthOutStream, UDINT begIndex, UDINT endIndex, char* pvNameRoot2)
{
	UINT status;
	UDINT data_typ;
	UDINT data_len;
	UINT dimension;
	UDINT adr;
	DINT outputCharCount = 0;

	
	bgPVSerialize_typ pvSerObj;
	
	if(!pvNameRoot || !toOutStream){
		return PV_SERIALIZE_ERR_ZEROPTR;
	}
	
	if(toOutStream){
		strcpy(toOutStream, "");
	}
	pvSerObj.toOutStream = toOutStream;
	pvSerObj.lengthOutStream = lengthOutStream;
	pvSerObj.outputCharCount = 0;
	pvSerObj.errorCode = 0;
	pvSerObj.arrayIndexFrom = begIndex;
	pvSerObj.arrayIndexTo = endIndex;
	pvSerObj.pItemDelim =  PV_SERIALIZE_ITEM_DELIM_COMMA;
	pvSerObj.pStrMarkup =  PV_SERIALIZE_STR_MARKUP;
	
	status = PV_ninfo(pvNameRoot, &data_typ, &data_len, &dimension);
	if( status ){
		return PV_SERIALIZE_ERR_PVNOTFOUND;
	}

	
	status = PV_xgetadr(pvNameRoot, &adr, &data_len);
	if( status ){
		return PV_SERIALIZE_ERR_PVADRNOTFOUND;
	}

	if(data_typ == PB_DT_STRUCT){
		//DBG("TOPPV='%s' Typ=%s Len=%d Dim=%d" , pvNameRoot, bgGetPVTypeString(data_typ), data_len, dimension);
		bgPVSubStructCompare(&pvSerObj, pvNameRoot, 0, dimension, pvNameRoot2);
	}else
	if(data_typ == PB_DT_ARRAY){
		bgPVArrayCompareRootToFrom(&pvSerObj, pvNameRoot, dimension, pvNameRoot2);
	}
	else{
		char pvTextValue[64];		
		bgGetPVValueText(&pvTextValue[0], data_typ, data_len, dimension, adr);		
		//DBG("TOPPV NOT A STRUCT! PV='%s' Typ=%s Len=%d Dim=%d Val=%s" , pvNameRoot, bgGetPVTypeString(data_typ), data_len, dimension, pvTextValue);	
	}

	if(pvSerObj.errorCode){
		if(pvSerObj.errorCode < 0){
			return pvSerObj.errorCode;
		}
		return (pvSerObj.errorCode * (-1));
	}
	
	return pvSerObj.outputCharCount;
}


DINT bgPVStructCompare(char* pvNameRoot, char* pvNameRoot2, char* toOutStream, UDINT lengthOutStream)
{
	UINT status;
	UDINT data_typ, data_typ2;
	UDINT data_len, data_len2;
	UINT dimension, dimension2;
	UDINT adr, adr2;
	DINT outputCharCount = 0;
	bgPVSerialize_typ pvSerObj;
	
	if(!pvNameRoot || !pvNameRoot2 || !toOutStream){
		return PV_SERIALIZE_ERR_ZEROPTR;
	}
	
	if(toOutStream){
		strcpy(toOutStream, "");
	}
	pvSerObj.toOutStream = toOutStream;
	pvSerObj.lengthOutStream = lengthOutStream;
	pvSerObj.outputCharCount = 0;
	pvSerObj.errorCode = 0;
	pvSerObj.pItemDelim =  PV_SERIALIZE_ITEM_DELIM_CRLF;
	pvSerObj.pStrMarkup =  "";
	
	status = PV_ninfo(pvNameRoot, &data_typ, &data_len, &dimension);
	if( status ){
		return PV_SERIALIZE_ERR_PVNOTFOUND;
	}
	status = PV_xgetadr(pvNameRoot, &adr, &data_len);
	if( status ){
		return PV_SERIALIZE_ERR_PVADRNOTFOUND;
	}
	
	status = PV_ninfo(pvNameRoot2, &data_typ2, &data_len2, &dimension2);
	if( status ){
		return PV_SERIALIZE_ERR_PVNOTFOUND;
	}
	status = PV_xgetadr(pvNameRoot2, &adr2, &data_len2);
	if( status ){
		return PV_SERIALIZE_ERR_PVADRNOTFOUND;
	}

	//struct must be equvalenet to compare them
	if((data_typ != data_typ2) || (dimension != dimension2)){
		return PV_SERIALIZE_ERR_PVNOTFOUND;
	}
	
		
	if(data_typ == PB_DT_STRUCT){
		//DBG("TOPPV='%s' Typ=%s Len=%d Dim=%d" , pvNameRoot, bgGetPVTypeString(data_typ), data_len, dimension);
		bgPVSubStructCompare(&pvSerObj, pvNameRoot, 0, dimension, pvNameRoot2);
	}else
	if(data_typ == PB_DT_ARRAY){
		pvSerObj.arrayIndexFrom = 0;
		pvSerObj.arrayIndexTo = dimension - 1;		
		bgPVArrayCompareRootToFrom(&pvSerObj, pvNameRoot, dimension, pvNameRoot2);
	}
	else{
		char pvTextValue[64];		
		bgGetPVValueText(&pvTextValue[0], data_typ, data_len, dimension, adr);		
		//DBG("TOPPV NOT A STRUCT! PV='%s' Typ=%s Len=%d Dim=%d Val=%s" , pvNameRoot, bgGetPVTypeString(data_typ), data_len, dimension, pvTextValue);	
	}

	if(pvSerObj.errorCode){
		if(pvSerObj.errorCode < 0){
			return pvSerObj.errorCode;
		}
		return (pvSerObj.errorCode * (-1));
	}
	
	return pvSerObj.outputCharCount;
}

#endif //_BG_SERIALIZE_C
/*EOF*/
