#ifndef _BG_SERIALIZE_C
#define _BG_SERIALIZE_C

#ifdef WIN32
#include "string.h"
#else
#include <bur/plctypes.h>
#include <sys_lib.h>
#endif

#include <AsBrStr.h>

//#include <string.h>
//#include <brsystem.h>
//#include <sys_lib.h>
//#include <asstring.h>
#include "bgstring.h"
//#include "bgsprintf.h"
#include "bgsscanf.h"
#include "bgsscanf.c"
#include "../Libraries/sprintf2/sprintf2.h"

#define PV_SERIALIZE_ITEM_DELIM_CRLF "\r\n"
#define PV_SERIALIZE_ITEM_DELIM_COMMA ","
//#define PV_SERIALIZE_STR_MARKUP "\""
#define PV_SERIALIZE_STR_MARKUP "'"

#define PV_SERIALIZE_ERR_ZEROPTR -1
#define PV_SERIALIZE_ERR_PVNOTFOUND -2
#define PV_SERIALIZE_ERR_PVADRNOTFOUND -3
#define PV_SERIALIZE_ERR_OBUFOVERFLOW -4
#define PV_SERIALIZE_ERR_NOCOMPARE -5 //comparison is not possible (i.e. different data structures)

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



static void bgPVSubStructSerialize(bgPVSerialize_typ* p, char* pvNameRoot, char* pvName, UINT dimension);
static void bgPVSerialize(bgPVSerialize_typ* p, char* pvNameRoot, char* pvName);
static void bgPVSubStructCompare(bgPVSerialize_typ* p, char* pvNameRoot, char* pvName, UINT dimension, char* pvNameRoot2);
static void bgPVCompare(bgPVSerialize_typ* p, char* pvNameRoot, char* pvName, char* pvNameRoot2);


//#ifndef DBG
//#define DBG() ;
//#endif

#define PV_TYPE_MAX_INDEX	24
#if 0
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
#endif

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
			sprintf2(pvValue, "%d", *( (char*)adr ));
			break;	
		case PB_DT_INT8:
			sprintf2(pvValue, "%d", *( (char*)adr) );
			break;	
		case PB_DT_INT16:
			sprintf2(pvValue, "%d", *( (short*)adr ) );
			break;	
		case PB_DT_INT32:
			sprintf2(pvValue, "%d", *( (int*)adr ));
			break;	
		case PB_DT_BYTE:
			sprintf2(pvValue, "%u", *( (unsigned char*)adr));
			break;	
		case PB_DT_WORD:
			sprintf2(pvValue, "%u", *( (unsigned short*)adr));
			break;	
		case PB_DT_LONG:
			sprintf2(pvValue, "%u", *( (unsigned int*)adr));
			break;	
		case PB_DT_FLOAT:
			{
				char temp[32];
				brsftoa( *((float*)adr), (UDINT)temp);
				sprintf2(pvValue, "%s", temp);
			}
			break;	
		case PB_DT_VIS:
			sprintf2(pvValue, "%s", (char*)adr );
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
				brsftoa( value_float, (UDINT)temp);
				sprintf2(pvValue, "%s", temp);
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
				*((float*)adr) = brsatof((UDINT)pvValue);
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
				float value_float = brsatof((UDINT)pvValue); 
				double value_double = (double)value_float;
				*((double*)adr) = value_double;
			}
			break;	
		case PB_DT_ARRAY:
			//DBG("TODO: display array values...");
			break;	
	}
}

static void bgPVWriteOutStream(bgPVSerialize_typ* p, char* pvName, char* pvTextValue)
{
	if(!p || !p->toOutStream || !pvName || !pvTextValue || !p->pItemDelim)
		return;
	
	brsstrcat((UDINT)p->toOutStream, (UDINT)pvName);
	brsstrcat((UDINT)p->toOutStream, (UDINT)"=");
	brsstrcat((UDINT)p->toOutStream, (UDINT)pvTextValue);
	brsstrcat((UDINT)p->toOutStream, (UDINT)p->pItemDelim);	// delimiter "\r\n" or ","
		
	p->outputCharCount += brsstrlen((UDINT)pvName);
	p->outputCharCount += brsstrlen((UDINT)pvTextValue);
	p->outputCharCount += brsstrlen((UDINT)p->pItemDelim) + 1; //  '=' + sizeof the delimiter string 
		
	if(p->outputCharCount >= (p->lengthOutStream - 100) ){//TODO: needs to be a better way to handle output buffer overflow
		p->errorCode = PV_SERIALIZE_ERR_OBUFOVERFLOW;
		return;
	}
}

static void bgTxtWriteOutStream(bgPVSerialize_typ* p, char* pTxt)
{
	if(!p || !p->toOutStream || !pTxt)
		return;
		
	brsstrcat((UDINT)p->toOutStream, (UDINT)pTxt);
		
	p->outputCharCount += brsstrlen((UDINT)pTxt);
		
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

static void bgPVArraySerialize(bgPVSerialize_typ* p, char* pvNameRoot, char* pvName, int dimension)
{
	int ii = 0;
	// TODO: checking for max size of the strings that are copied to these arrays
	char structName[256];
	char structItemName[32];

	for(ii=0; ii < dimension; ii++){
		// NOTE: verify why PV_item destroys content of the buffer supplied as 1st param
		if( !pvName){
			brsstrcpy((UDINT)structName, (UDINT)pvNameRoot);
		}else{
			brsstrcpy((UDINT)structName, (UDINT)pvNameRoot);
			//strcat(structName, ".");
			//strcat(structName, pvName);
		}
		
		{
			char arrayIndexTxt[10];
			brsstrcpy((UDINT)structItemName, (UDINT)pvName);
			brsstrcat((UDINT)structItemName, (UDINT)"[");
			brsitoa(ii, (UDINT)arrayIndexTxt);
			brsstrcat((UDINT)structItemName, (UDINT)arrayIndexTxt);
			brsstrcat((UDINT)structItemName, (UDINT)"]");
		}
		
		bgPVSerialize(p, structName, structItemName);
		
		if(p->errorCode)
			return;	
		
	}	
}


static void bgPVArraySerializeRootToFrom(bgPVSerialize_typ* p, char* pvNameRoot, int dimension)
{
	int ii = 0;
	// TODO: checking for max size of the strings that are copied to these arrays
	char structItemName[32];

	
	for(ii = p->arrayIndexFrom; (ii < dimension) && (ii <= p->arrayIndexTo); ii++){
		// NOTE: verify why PV_item destroys content of the buffer supplied as 1st param
		{
			char arrayIndexTxt[10];
			brsstrcpy((UDINT)structItemName, (UDINT)pvNameRoot);
			brsstrcat((UDINT)structItemName, (UDINT)"[");
			brsitoa(ii, (UDINT)arrayIndexTxt);
			brsstrcat((UDINT)structItemName, (UDINT)arrayIndexTxt);
			brsstrcat((UDINT)structItemName, (UDINT)"]");
		}
		bgTxtWriteOutStream(p, structItemName);	
		bgTxtWriteOutStream(p, "=[");	
		bgPVSerialize(p, structItemName, 0);
		//bgTxtWriteOutStream(p, "]\r\n");	
		bgTxtWriteOutStream(p, "],");	
		
		if(p->errorCode)
			return;	
	}	
}

static void bgPVSerialize(bgPVSerialize_typ* p, char* pvNameRoot, char* pvName)
{
	UINT status;
	UDINT data_typ;
	UDINT data_len;
	UINT dimension;
	UDINT adr;
	char structItemPVName[256];

	if( !pvName){
		brsstrcpy((UDINT)structItemPVName, (UDINT)pvNameRoot);
		
	}else{
		brsstrcpy((UDINT)structItemPVName, (UDINT)pvNameRoot);
		brsstrcat((UDINT)structItemPVName, (UDINT)".");
		brsstrcat((UDINT)structItemPVName, (UDINT)pvName);
	}


	status = PV_ninfo(structItemPVName, &data_typ, &data_len, &dimension);

	if( status ){
		p->errorCode = status;
		return;
	}
	
	if( bgPVSerializeIsArray(data_typ, data_len, dimension) ){
		bgPVArraySerialize(p, pvNameRoot, pvName, dimension);
		return;
	}
	
	status = PV_xgetadr(structItemPVName, &adr, &data_len);
	
	if( status ){
		p->errorCode = status;
		return;
	}

	if(data_typ == PB_DT_STRUCT){
		//DBG("PV='%s' Typ=%s Len=%d Dim=%d" , pvnamecomplete, bgGetPVTypeString(data_typ), data_len, dimension);	
		bgPVSubStructSerialize(p, pvNameRoot, pvName, dimension);
	}else{
		char pvTextValue[256];
		int len = 0;
		
		if(data_typ == PB_DT_VIS){//STRING VALUES ONLY > marked with a special markup at the begining and end
			brsstrcpy((UDINT)pvTextValue, (UDINT)p->pStrMarkup);//set string begining markup (i.e. "\"")
			len = brsstrlen((UDINT)pvTextValue);
		}
		
		bgGetPVValueText(&pvTextValue[len], data_typ, data_len, dimension, adr);	
		
		if(data_typ == PB_DT_VIS){//STRING VALUES ONLY > marked with a special markup at the begining and end
			brsstrcat((UDINT)pvTextValue, (UDINT)p->pStrMarkup);//set string ending markup (i.e. "\"")
		}
		
		//DBG("stritemPV='%s' Typ=%s Len=%d Dim=%d Val=%s" , pvName, bgGetPVTypeString(data_typ), data_len, dimension, pvTextValue);
		bgPVWriteOutStream(p, pvName, pvTextValue);
	}

}


static void bgPVSubStructSerialize(bgPVSerialize_typ* p, char* pvNameRoot, char* pvName, UINT dimension)
{
/*
Example:
typedef struct str1_typ{
UINT val1;
UINT val2;
}str1_typ;

typedef struct str2_typ{
UINT val3;
}str2_typ;

typedef struct str3_typ{
UINT val4;
struct str1_typ s1;
struct str2_typ s2;
}str3_typ;

_GLOBAL str3_typ test;

All available PV Names are:
test.val4
test.s1.val1
test.s1.val2
test.s2.val3;

Top PV Name (pvNameRoot):
test

During iteration, followin values will appear for 'structItemName':
s1
s2
val4

During iteration, following values will appear for 'structItemPVNameNoRoot':
val4
s1.val1
s1.val2
s2.val3

*/
	int ii = 0;
	// TODO: checking for max size of the strings that are copied to these arrays
	char structName[256];
	char structItemName[32];
	char structItemPVNameNoRoot[256];
	UINT status;
	UDINT data_typ;
	UDINT data_len;
	UDINT adr;


	for(ii=0; ii < dimension; ii++){
		// NOTE: verify why PV_item destroys concent of the buffer supplied as 1st param
		if( !pvName){
			brsstrcpy((UDINT)structName, (UDINT)pvNameRoot);
		}else{
			brsstrcpy((UDINT)structName, (UDINT)pvNameRoot);
			brsstrcat((UDINT)structName, (UDINT)".");
			brsstrcat((UDINT)structName, (UDINT)pvName);
		}
		
		//DBG("1)bgPVSubStr.. ii=%d str=%s item=%s", ii, structName, structItemName);
		status = PV_item(structName, ii, structItemName);
		//DBG("2)bgPVSubStr.. ii=%d str=%s item=%s", ii, structName, structItemName);
		
		if(status && (status != 14713)){
			// TODO: error handling
			//DBG("bgPVSubStr.. ii=%d str=%s item=%s err=%d", ii, structName, structItemName, status);
			p->errorCode = status;
			return;
		}
		
		//DBG("item=%d, name=%s", ii, structItemName);
		// TODO: check for max length of the PV name
		if(!pvName){
			brsstrcpy((UDINT)structItemPVNameNoRoot, (UDINT)structItemName);
		}else{
			if(status == 14713){//14713 is to handle enum type??? find out if there is a better solutiuon
				//following code is to handle an enum type that is reported as a structure (type 0). However, there are no structure elements and is not clear how to access values???
				char pvTextValue[64];
		
				status = PV_ninfo(structName, &data_typ, &data_len, &dimension);
				status = PV_xgetadr(structName, &adr, &data_len);
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
				bgPVWriteOutStream(p, pvName, pvTextValue);
				return;				
			}	
			
			brsstrcpy((UDINT)structItemPVNameNoRoot, (UDINT)pvName);
			brsstrcat((UDINT)structItemPVNameNoRoot, (UDINT)".");
			brsstrcat((UDINT)structItemPVNameNoRoot, (UDINT)structItemName);
		}

		bgPVSerialize(p, pvNameRoot, structItemPVNameNoRoot);
		
		if(p->errorCode)
			return;
	}
}


DINT bgPVRootArraySerialize(char* pvNameRoot, char* toOutStream, UDINT lengthOutStream, UDINT begIndex, UDINT endIndex)
{
	UINT status;
	UDINT data_typ;
	UDINT data_len;
	UINT dimension;
	UDINT adr;

	
	bgPVSerialize_typ pvSerObj;
	
	if(!pvNameRoot || !toOutStream){
		return PV_SERIALIZE_ERR_ZEROPTR;
	}
	
	if(toOutStream){
		brsstrcpy((UDINT)toOutStream, (UDINT)"");
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
		bgPVSubStructSerialize(&pvSerObj, pvNameRoot, 0, dimension);
	}else
	if(data_typ == PB_DT_ARRAY){
		bgPVArraySerializeRootToFrom(&pvSerObj, pvNameRoot, dimension);
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


DINT bgPVStructSerialize(char* pvNameRoot, char* toOutStream, UDINT lengthOutStream)
{
	UINT status;
	UDINT data_typ;
	UDINT data_len;
	UINT dimension;
	UDINT adr;
	bgPVSerialize_typ pvSerObj;
	
	if(!pvNameRoot || !toOutStream){
		return PV_SERIALIZE_ERR_ZEROPTR;
	}
	
	if(toOutStream){
		brsstrcpy((UDINT)toOutStream, (UDINT)"");
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

		
	if(data_typ == PB_DT_STRUCT){
		//DBG("TOPPV='%s' Typ=%s Len=%d Dim=%d" , pvNameRoot, bgGetPVTypeString(data_typ), data_len, dimension);
		bgPVSubStructSerialize(&pvSerObj, pvNameRoot, 0, dimension);
	}else
	if(data_typ == PB_DT_ARRAY){
		pvSerObj.arrayIndexFrom = 0;
		pvSerObj.arrayIndexTo = dimension - 1;		
		bgPVArraySerializeRootToFrom(&pvSerObj, pvNameRoot, dimension);
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

//Maximum number of PV-s per file that can be deserialized!!!
#define BGPV_DESER_MAXPVCOUNT 1000

DINT bgPVStructDeserialize(char* pvNameRoot, char* fromStream, UDINT lengthStream)
{
	UDINT ii;
	bgStringListEx_typ lineList1;
	bgStringListEx_typ lineSplit1;
	char* memLineList[BGPV_DESER_MAXPVCOUNT];
	char* memLineSplit[10];
	char structItemPVName[256];

	UINT status;
	UDINT data_typ;
	UDINT data_len;
	UINT dimension;
	UDINT adr;
	UDINT errorCounter = 0;

	bgStringListLinesEx(&lineList1, fromStream, (char*)memLineList, BGPV_DESER_MAXPVCOUNT*sizeof(char*));
	for(ii=0; ii<lineList1.itemCount; ii++){
		//DBG("ln%d: %s", ii, lineList1.items[ii]);		
		bgStringSplitLineEx(&lineSplit1, '=',  (char*)lineList1.items[ii], (char*)memLineSplit, (int)10*sizeof(char*));
		//DBG("ln%d: key=%s val=%s", ii, lineSplit1.items[0], lineSplit1.items[1]);
		
		brsstrcpy((UDINT)structItemPVName, (UDINT)pvNameRoot);
		brsstrcat((UDINT)structItemPVName, (UDINT)".");
		brsstrcat((UDINT)structItemPVName, (UDINT)lineSplit1.items[0]);
		
		//DBG("PV=%s Val=%s", structItemPVName, lineSplit1.items[1]);
		status = PV_ninfo(structItemPVName, &data_typ, &data_len, &dimension);


		if( status ){
			// TODO: error handling
			//DBG("bgPVStructDes. PV='%s'; Error#=%d", structItemPVName, status);
			errorCounter++;
			continue;
		}

	
		status = PV_xgetadr(structItemPVName, &adr, &data_len);
	
		if( status ){
			// TODO: error handling
			//DBG("bgPVStructDes. Address for PV='%s'; Error=%d", structItemPVName, status);
			errorCounter++;
			continue;
		}

		bgSetPVValueText((char*)lineSplit1.items[1], data_typ, data_len, dimension, adr);		
	}


	// TODO: return value in case of errors; detected version changes, etc.

	return errorCounter;
	
}

/**
###############################################################################
###############################################################################
bgPVCompare routines
- these routines are derived/based upon the bgPVSeriliaze routines and are 
used to compare two instances of the same PV type for differences
- such routine could be used, for example, when detecting a change
within a machine configuration structure or recipe
###############################################################################
###############################################################################
*/
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
			brsstrcpy((UDINT)structName, (UDINT)pvNameRoot);
			brsstrcpy((UDINT)structName2, (UDINT)pvNameRoot2);
		}else{
			brsstrcpy((UDINT)structName, (UDINT)pvNameRoot);
			brsstrcpy((UDINT)structName2, (UDINT)pvNameRoot2);
			//strcat(structName, ".");
			//strcat(structName, pvName);
		}
		
		{
			char arrayIndexTxt[10];
			brsstrcpy((UDINT)structItemName, (UDINT)pvName);
			brsstrcat((UDINT)structItemName, (UDINT)"[");
			brsitoa(ii, (UDINT)arrayIndexTxt);
			brsstrcat((UDINT)structItemName, (UDINT)arrayIndexTxt);
			brsstrcat((UDINT)structItemName, (UDINT)"]");
			
			brsstrcpy((UDINT)structItemName2, (UDINT)pvName);
			brsstrcat((UDINT)structItemName2, (UDINT)"[");
			brsitoa(ii, (UDINT)arrayIndexTxt);
			brsstrcat((UDINT)structItemName2, (UDINT)arrayIndexTxt);
			brsstrcat((UDINT)structItemName2, (UDINT)"]");
			
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
	char structItemName[32];
	
	char structItemName2[32];

	
	for(ii = p->arrayIndexFrom; (ii < dimension) && (ii <= p->arrayIndexTo); ii++){
		// NOTE: verify why PV_item destroys content of the buffer supplied as 1st param
		{
			char arrayIndexTxt[10];
			brsstrcpy((UDINT)structItemName, (UDINT)pvNameRoot);
			brsstrcat((UDINT)structItemName, (UDINT)"[");
			brsitoa(ii, (UDINT)arrayIndexTxt);
			brsstrcat((UDINT)structItemName, (UDINT)arrayIndexTxt);
			brsstrcat((UDINT)structItemName, (UDINT)"]");
			
			brsstrcpy((UDINT)structItemName2, (UDINT)pvNameRoot2);
			brsstrcat((UDINT)structItemName2, (UDINT)"[");
			brsitoa(ii, (UDINT)arrayIndexTxt);
			brsstrcat((UDINT)structItemName2, (UDINT)arrayIndexTxt);
			brsstrcat((UDINT)structItemName2, (UDINT)"]");
			
			
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
		brsstrcpy((UDINT)structItemPVName, (UDINT)pvNameRoot);
		brsstrcpy((UDINT)structItemPVName2, (UDINT)pvNameRoot2);
		
	}else{
		brsstrcpy((UDINT)structItemPVName, (UDINT)pvNameRoot);
		brsstrcat((UDINT)structItemPVName, (UDINT)".");
		brsstrcat((UDINT)structItemPVName, (UDINT)pvName);
		
		brsstrcpy((UDINT)structItemPVName2, (UDINT)pvNameRoot2);
		brsstrcat((UDINT)structItemPVName2, (UDINT)".");
		brsstrcat((UDINT)structItemPVName2, (UDINT)pvName);
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
			brsstrcpy((UDINT)pvTextValue, (UDINT)p->pStrMarkup);//set string begining markup (i.e. "\"")
			brsstrcpy((UDINT)pvTextValue2, (UDINT)p->pStrMarkup);//set string begining markup (i.e. "\"")
			len = brsstrlen((UDINT)pvTextValue);
		}
		
		bgGetPVValueText(&pvTextValue[len], data_typ, data_len, dimension, adr);	
		bgGetPVValueText(&pvTextValue2[len], data_typ2, data_len2, dimension2, adr2);	
		
		if(data_typ == PB_DT_VIS){//STRING VALUES ONLY > marked with a special markup at the begining and end
			brsstrcat((UDINT)pvTextValue, (UDINT)p->pStrMarkup);//set string ending markup (i.e. "\"")
			brsstrcat((UDINT)pvTextValue2, (UDINT)p->pStrMarkup);//set string ending markup (i.e. "\"")
		}
		
		if(brsstrcmp((UDINT)pvTextValue, (UDINT)pvTextValue2) != 0){
			char buf[255];
			sprintf2(buf, "%s changed; Old=%s, New=%s\n", structItemPVName, pvTextValue2, pvTextValue);
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
			brsstrcpy((UDINT)structName, (UDINT)pvNameRoot);
			brsstrcpy((UDINT)structName2, (UDINT)pvNameRoot2);
		}else{
			brsstrcpy((UDINT)structName, (UDINT)pvNameRoot);
			brsstrcat((UDINT)structName, (UDINT)".");
			brsstrcat((UDINT)structName, (UDINT)pvName);
			
			brsstrcpy((UDINT)structName2, (UDINT)pvNameRoot2);
			brsstrcat((UDINT)structName2, (UDINT)".");
			brsstrcat((UDINT)structName2, (UDINT)pvName);
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
			brsstrcpy((UDINT)structItemPVNameNoRoot, (UDINT)structItemName);
			brsstrcpy((UDINT)structItemPVNameNoRoot2, (UDINT)structItemName2);
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
				if(brsstrcmp((UDINT)&pvTextValue[0], (UDINT)&pvTextValue2[0]) != 0){
					char buf[255];
					sprintf2(buf, "%s changed; Old=%s, New=%s\n", structName, &pvTextValue2[0], &pvTextValue[0]);
					bgTxtWriteOutStream(p, buf);	
				}
				return;				
			}	
			
			brsstrcpy((UDINT)structItemPVNameNoRoot, (UDINT)pvName);
			brsstrcat((UDINT)(UDINT)structItemPVNameNoRoot, (UDINT)".");
			brsstrcat((UDINT)(UDINT)structItemPVNameNoRoot, (UDINT)structItemName);
			
			brsstrcpy((UDINT)structItemPVNameNoRoot2, (UDINT)pvName);
			brsstrcat((UDINT)structItemPVNameNoRoot2, (UDINT)".");
			brsstrcat((UDINT)structItemPVNameNoRoot2, (UDINT)structItemName2);
					
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

	
	bgPVSerialize_typ pvSerObj;
	
	if(!pvNameRoot || !toOutStream){
		return PV_SERIALIZE_ERR_ZEROPTR;
	}
	
	if(toOutStream){
		brsstrcpy((UDINT)toOutStream, (UDINT)"");
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
	bgPVSerialize_typ pvSerObj;
	
	if(!pvNameRoot || !pvNameRoot2 || !toOutStream){
		return PV_SERIALIZE_ERR_ZEROPTR;
	}
	
	if(toOutStream){
		brsstrcpy((UDINT)toOutStream, (UDINT)"");
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
	if((data_typ != data_typ2) || (dimension != dimension2) || (data_len != data_len2)){
		return PV_SERIALIZE_ERR_NOCOMPARE;
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
