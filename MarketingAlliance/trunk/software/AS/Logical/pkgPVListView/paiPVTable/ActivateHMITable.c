
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
/* TODO: Add your comment here */


REAL PVStructInfo(PVListTexts_Info_typ * p){

	UDINT val_int = 0;
	REAL val_real = 0;
	
	if(!p || !(p->isValid)){
		return 0;
	}else if(p->isConstant){
		return p->Const_Value;	
	}
	
	switch(p->PVTyp){
		case 7: //UDINT
			val_int = *((UDINT *)(p->PVAdr));
			val_real = (REAL) val_int;
			break;
		case 8: //REAL
			val_real = *((REAL * )(p->PVAdr));
			break;
	}
	
	return val_real;
	
}

plcbit ActivateHMITable(DINT langIdx, UDINT pHMITable_int, UDINT pTableValues_int)
{
	hmiParamListTable_typ * pHMITable = pHMITable_int;
	HMI_Table_Data_typ * pTableValues = pTableValues_int;
	UDINT ii_entries = 0;
	UINT valtype;
	DINT dec_places;
	REAL val_min;
	REAL val_max;
	REAL val_def;
	UDINT * val_hide_int;
	
	BOOL val_hide_bool = 0;
	
	if(pTableValues->Max_Idx_Entries >= DEFINE_MAX_TABLE_ENTRIES) return 0;
	
	hmiParamListTableEntryFirst(pHMITable, (char *) &pTableValues->Table_Name);
	for(ii_entries = 0; ii_entries <= pTableValues->Max_Idx_Entries; ii_entries++){
		if(pTableValues->info[ii_entries].Val.Hide.isValid==1){
			val_hide_int = ((UDINT *) (pTableValues->info[ii_entries].Val.Hide.PVAdr));
			val_hide_bool = (BOOL) (*val_hide_int);
		}else{
			val_hide_bool = 0;
		}
		
		if(val_hide_bool==0 && pTableValues->info[ii_entries].Val.Param.PVAdr){
			val_min = PVStructInfo(&pTableValues->info[ii_entries].Val.Min);
			val_max = PVStructInfo(&pTableValues->info[ii_entries].Val.Max);
			val_def = PVStructInfo(&pTableValues->info[ii_entries].Val.Default);

				switch(pTableValues->info[ii_entries].Val.Param.PVTyp){
					case 7: //UDINT
						valtype=0;
						dec_places=-2; //no decimals
						break;
					case 8: //REAL
						valtype=1;
						dec_places=1;
						break;
				}	
		
				hmiParamListTableAddEntryNext(pHMITable, 
					pTableValues->info[ii_entries].Val.Param.PVAdr,
					&pTableValues->info[ii_entries].PVText[langIdx].PVTextLangSpecific,
					val_def,val_min,val_max,
					dec_places,1,0,valtype,
					&pTableValues->info[ii_entries].PVText[langIdx].PVDescLangSpecific
					);
			}
		}
	hmiParamListTableEntryLast(pHMITable);
}
