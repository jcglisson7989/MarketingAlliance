/********************************************************************
 * COPYRIGHT -- pai
 ********************************************************************
 * Program: hmilogic
 * File: hmiParamList.c
 * Author: goran
 * Created: September 05, 2013
 *******************************************************************/

#include <bur/plctypes.h>
#ifdef _DEFAULT_INCLUDES
	#include <AsDefault.h>
#endif

#define HMI_PARAMLIST_DECPLACES_DEFAULT  2 //default value of decimal places for any real number converted to text. Application specific.


/** 
Bit manipulaiton utility functions.
 */
//#include <../../bglib/bgBitUtilities.h>

/** 
String manipulaiton utility functions.
 */
//#include "../../paiComponents/bglib/bgsprintf.h"
#include "../../paiComponents/bglib/bgstring.h"
#include "../../paiComponents/Libraries/sprintf2/sprintf2.h"

/** 
 Timer control utility functions.
 */
//#include <../../bglib/bgTimer1ms.h>

/*
###############################################################################
HMI table editor support. Set of functions that support table based editing of the parametars.
###############################################################################
*/

/**
rouding of a floating point value to the number of required decimal positions.
\param d value
\param pp number of decimal places
\return rounded value

*/
static float roundVal(float d, int ppOffset) 
{ 

	int valInt;
	float exp10topp = 10.0;
	int count = 0;
	int pp = ppOffset;
	
	
	if(!pp){
		exp10topp = 1.0;
	}else
		if(pp<0){
		exp10topp = 0.1;
		count = (0 - pp) - 1;
	}else{
		exp10topp = 10.0;
		count = pp - 1;
	}
	

	while(count--){
		exp10topp *= exp10topp;		
	}

	
	valInt = (int) (d *  exp10topp + 0.5);
	return ( valInt  /  exp10topp  );
}

/**
ftoa (float to ascii converion) with the added support for required number of decimal places in the text ouput.
\param value value to convert
\param pp number of decimal places
\return rounded value

*/
static void ftoaEx(float value, char* pText, int decPlacesOffset)
{
	char text[32];

	int len;
	int comaPos;
	int apendZerosCount;
	int ii;
	float rnd_val;
	int decPlaces = HMI_PARAMLIST_DECPLACES_DEFAULT + decPlacesOffset;

	
	if(!pText)
		return;

	//limit max dec places
	if(decPlaces > 5)
		decPlaces = 5;

	//convert float to ascii
	//	ftoa(value, text);
	rnd_val = roundVal(value, decPlaces);
	ftoa(rnd_val , (UDINT)text);

	//get the length of the converted string
	len = brsstrlen((UDINT)text);
	if(!len){
		//0 length > don't know what to do
		brsstrcpy((UDINT)pText, (UDINT)"?");
		return;
	}
	
	//find position of the coma	
	comaPos = bgStrFind(text, ".", -1, -1);

	if(!decPlaces){
		//dec places are not needed
	
		if(comaPos>0){
			//coma is present > terminate the string at the comma position
			text[comaPos] = 0;
		}

	}else{
		//dec places are needed
	
		if(comaPos<0){
			//no coma present but it is needed
			brsstrcat((UDINT)text, (UDINT)".");
			len+=1;
			comaPos=len-1;
		}
		
		apendZerosCount = decPlaces - (len - comaPos - 1);
		
		
		if(apendZerosCount < 0){
			//too many digits after a decimal place > terminate string to a specified number of dec places	
			apendZerosCount = 0 - apendZerosCount;	
			text[len - apendZerosCount]=0;	
		}else{
			//need to add zeros to satisfy the number of dec places
			for(ii=0; ii<apendZerosCount; ii++){
				text[len+ii]='0';
			}
			text[len+ii]=0;	
		}
	}
	

	brsstrcpy((UDINT)pText, (UDINT)text);
	return;
}

static float hmiParamListTableGetPLCValue(UDINT pValue, REAL k_factor, REAL n_factor, int valueType)
{
	UDINT* pUdint = (UDINT*)pValue;
	float* pFloat = (float*)pValue;
	REAL tempReal;


	switch(valueType){
		case 1:
			if(pFloat){
				tempReal = ((float)(*pFloat)) * k_factor + n_factor;
			}else{
				tempReal = 0.0;
			}
			break;
		default:
			if(pUdint){
				tempReal = ((float)(*pUdint)) * k_factor + n_factor;
			}else{
				tempReal = 0.0;
			}
			break;
	}
	
	return tempReal;
}

static void hmiParamListTableDisplayToValue(float value, UDINT pValue, char* pOutputText,  int decPlaces, REAL k_factor, REAL n_factor, int valueType)
{
/*
scaling
y=kx + n
y=display value
x=plc value

x = (y- n)*(1/k)

value types:
0-UDINT
1-REAL

*/

	UDINT* pUdint = (UDINT*)pValue;
	float *pFloat = (float*)pValue;

	if(!k_factor){
		brsstrcpy((UDINT)pOutputText, (UDINT)"ERR: div by 0");
		return;
	}

	switch(valueType){
		case 1:
			*pFloat = (float)((value - n_factor) / k_factor);
			break;
		default:
			*pUdint = (UDINT)((value - n_factor) / k_factor);
			break;
	}


	ftoaEx(value, pOutputText, decPlaces);
}
		

static void hmiParamListTableValueToDisplay(UDINT pValue, char* pOutputText, float* pOutputFloat, int decPlaces, REAL k_factor, REAL n_factor, int valueType)
{
/*
scaling
y=kx + n
y=display value
x=plc value
*/
	REAL tempReal = hmiParamListTableGetPLCValue(pValue, k_factor, n_factor, valueType);

	if(pOutputFloat)
		*pOutputFloat = tempReal;
	
	ftoaEx(tempReal, pOutputText, decPlaces);
}

 void hmiParamListTableAddEntryNext(hmiParamListTable_typ* p, UDINT pValue, char* pName,  
REAL valDefault, REAL valMin, REAL valMax, int decPlaces, REAL k_factor, REAL n_factor, UINT valueType, char* pDescription)
{
	if(!p)
		return;
	
	if(p->index >= hmiTableMAXENTRIES){
		brsstrcpy((UDINT)p->listValueText[p->index], (UDINT)"table overflow!");
		return;
	}

	p->listValuePtr[p->index] = pValue;
	sprintf2(p->listIdText[p->index], "%d", p->index);
	if(pDescription){
		bgStrCpyN(p->listDescription[p->index], pDescription, sizeof(p->listDescription[0]));	
	}else{
		bgStrCpyN(p->listDescription[p->index], "no description", sizeof(p->listDescription[0]));
	}
	if(pName){
		bgStrCpyN(p->listName[p->index], pName, sizeof(p->listName[0]));
	}else{
		bgStrCpyN(p->listName[p->index], "no name", sizeof(p->listName[0]));
	}
	p->listDecPlaces[p->index] = decPlaces;
	
	p->listLimits[p->index].defaultValue = valDefault;
	p->listLimits[p->index].minValue= valMin;
	p->listLimits[p->index].maxValue= valMax;
	p->listLimits[p->index].k_factor= k_factor;
	p->listLimits[p->index].n_factor= n_factor;
	p->listLimits[p->index].valueType= valueType;
	
	hmiParamListTableValueToDisplay(p->listValuePtr[p->index], 
		p->listValueText[p->index], 0, p->listDecPlaces[p->index], p->listLimits[p->index].k_factor, p->listLimits[p->index].n_factor, p->listLimits[p->index].valueType);

	p->index++;
	p->maxIndex++;
}


void hmiParamListTableEntryFirst(hmiParamListTable_typ* p, char* pListName)
{
	int ii;
	
	p->maxIndex = 0;
	p->index = 0;
	bgStrCpyN(p->listHeader, pListName, sizeof(p->listHeader));
	
	//clear all names from the list
	for(ii=0; ii<=hmiTableMAXENTRIES;ii++){
		brsstrcpy((UDINT)p->listIdText[ii], (UDINT)"");	
		brsstrcpy((UDINT)p->listName[ii], (UDINT)"");	
		brsstrcpy((UDINT)p->listValueText[ii], (UDINT)"");	
	}	
}

void hmiParamListTableEntryLast(hmiParamListTable_typ* p)
{	
	if(p->maxIndex)
		p->maxIndex--;

	//init index value
	p->index = 0;

	//update text fields according to the currently selected table element
	bgStrCpyN(p->selName, p->listName[p->index], sizeof(p->selName));
	bgStrCpyN(p->selDescription, p->listDescription[p->index], sizeof(p->selDescription));		
		
	//set limits on the HMI input control that coresponds to the currently selected table element
	p->selValueREALMin = p->listLimits[p->index].minValue;
	p->selValueREALMax= p->listLimits[p->index].maxValue;
	p->selValueREALDefault = p->listLimits[p->index].defaultValue;
	p->selValueDecPlaces = p->listDecPlaces[p->index];
	
	//display selected table element
	hmiParamListTableValueToDisplay(p->listValuePtr[p->index], 
		p->listValueText[p->index], &p->selValueREAL, p->listDecPlaces[p->index], p->listLimits[p->index].k_factor, p->listLimits[p->index].n_factor, p->listLimits[p->index].valueType);

	
}

//
//void hmiParamListTableCyclic(hmiParamListTable_typ* p)
//{
//	if(!p)
//		return;
//	
//	//limit index to max index value (up arrow)
//	if(p->index >= p->maxIndex){
//		p->index = p->maxIndex;
//	}
//
//	//keep checking if index changes (i.e. user changes entry selection)
//	if(p->index != p->indexOld){
//		//index change > update selected value for user entry
//		p->indexOld = p->index;
//		hmiParamListTableValueToDisplay(p->listValuePtr[p->index], p->listValueText[p->index], 
//			&p->selValueREAL, p->listDecPlaces[p->index], p->listLimits[p->index].k_factor, p->listLimits[p->index].n_factor, p->listLimits[p->index].valueType);				
//		//store value for change detection
//		p->selValueREALOld = p->selValueREAL;	
//
//		//update text fields
//		bgStrCpyN(p->selName, p->listName[p->index], sizeof(p->selName));
//		bgStrCpyN(p->selDescription, p->listDescription[p->index], sizeof(p->selDescription));		
//
//		//set limits for the selected element
//		p->selValueREALMin = p->listLimits[p->index].minValue;
//		p->selValueREALMax= p->listLimits[p->index].maxValue;
//		p->selValueREALDefault = p->listLimits[p->index].defaultValue;
//		p->selValueDecPlaces = p->listDecPlaces[p->index];
//
//	}
//
//
//	//keep checking if currently selected value changes(i.e. user enteres new value)
//	if(p->selValueREALOld != p->selValueREAL){
//		if(p->selValueREALMin < p->selValueREALMax){
//			//enforce limits
//			if(p->selValueREAL < p->selValueREALMin)
//				p->selValueREAL = p->selValueREALMin;
//			
//			if(p->selValueREAL > p->selValueREALMax)
//				p->selValueREAL = p->selValueREALMax;
//		}
//		p->selValueREALOld = p->selValueREAL;	
//		hmiParamListTableDisplayToValue(p->selValueREAL, p->listValuePtr[p->index], p->listValueText[p->index], 
//			p->listDecPlaces[p->index], p->listLimits[p->index].k_factor, p->listLimits[p->index].n_factor, p->listLimits[p->index].valueType);
//	}
//
//	//keep checking if the source of the currently selected value changes on a PLC(i.e. PLC location gets updated, etc)
//	{
//		float tempVal = hmiParamListTableGetPLCValue(p->listValuePtr[p->index], p->listLimits[p->index].k_factor, p->listLimits[p->index].n_factor, p->listLimits[p->index].valueType);
//		if(p->selValueREAL != tempVal){
//			//PLC value changed > update displayed value
//			p->selValueREAL = tempVal;
//			p->selValueREALOld = p->selValueREAL;	
//			hmiParamListTableDisplayToValue(p->selValueREAL, p->listValuePtr[p->index], p->listValueText[p->index], 
//				p->listDecPlaces[p->index], p->listLimits[p->index].k_factor, p->listLimits[p->index].n_factor, p->listLimits[p->index].valueType);
//
//		}
//	}
//
//	//set default value request?
//	if(p->setDefaultRequest){
//		p->setDefaultRequest = 0;
//		p->selValueREAL = p->selValueREALDefault;
//	}
//	
//}

//eof
