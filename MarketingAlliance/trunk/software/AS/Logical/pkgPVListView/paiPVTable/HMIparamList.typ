(********************************************************************
 * COPYRIGHT -- piedmont
 ********************************************************************
 * Package: HMI
 * File: HMI.typ
 * Author: goran
 * Created: August 28, 2013
 ********************************************************************
 * Data types of package HMI
 ********************************************************************)
(*########################################################################*)
(*HMI object - PARAMETER LIST - LIMITS*)
(*########################################################################*)
(*########################################################################*)
(*HMI object - PARAMETER LIST*)
(*########################################################################*)

TYPE
	hmiTableStatStruct_typ : 	STRUCT 
		maxLenDesc : UDINT;
		maxLenName : UDINT;
		Param : UDINT;
		Default : UDINT;
		Min : UDINT;
		Max : UDINT;
		Hide : UDINT;
	END_STRUCT;
	hmiTableStats_typ : 	STRUCT 
		Overall : hmiTableStatStruct_typ;
	END_STRUCT;
	PVList_Language_Texts_typ : 	STRUCT 
		PVTextLangSpecific : STRING[DEFINE_PAR_NAME_MAXLEN];
		PVDescLangSpecific : STRING[DEFINE_PAR_DESC_MAXLEN];
	END_STRUCT;
	PVListTexts_Info_typ : 	STRUCT 
		Str : STRING[DEFINE_PAR_NAME_MAXLEN];
		isValid : BOOL;
		isPV : BOOL;
		isConstant : BOOL;
		Const_Value : REAL;
		PVAdr : {REDUND_UNREPLICABLE} UDINT;
		PVLen : USINT;
		PVDim : USINT;
		PVTyp : UDINT;
		StrLen : UDINT;
	END_STRUCT;
	PVTable_Val_Info_typ : 	STRUCT 
		Param : PVListTexts_Info_typ;
		Default : PVListTexts_Info_typ;
		Min : PVListTexts_Info_typ;
		Max : PVListTexts_Info_typ;
		Hide : PVListTexts_Info_typ;
	END_STRUCT;
	PVTableInfo : 	STRUCT 
		PVText : ARRAY[0..MAX_IDX_LANGUAGES]OF PVList_Language_Texts_typ;
		Val : PVTable_Val_Info_typ;
		Error : BOOL;
	END_STRUCT;
	HMI_Table_Data_typ : 	STRUCT 
		info : ARRAY[0..DEFINE_MAX_TABLE_ENTRIES]OF PVTableInfo;
		Max_Idx_Entries : UDINT;
		Table_Name : STRING[DEFINE_PAR_NAME_MAXLEN];
		NameSpace : STRING[DEFINE_PAR_NAME_MAXLEN];
		Load_OK : BOOL;
	END_STRUCT;
	hmiParamLimits_typ : 	STRUCT 
		k_factor : REAL; (*scaling k factor (y=kx + n, where y=dsiplay value, x=plc value)*)
		n_factor : REAL; (*scaling n factor (y=kx + n, where y=dsiplay value, x=plc value)*)
		minValue : REAL; (*min value*)
		maxValue : REAL; (*max value*)
		defaultValue : REAL; (*default value*)
		pEnumText : UDINT; (*ptr to a string of comma delimited enum texts*)
		pEnumVals : UDINT; (*ptr to a string of comma delimited enum values*)
		valueType : UINT; (*type of the paramvalue (0-DINT, 1-REAL, 2-ENUM)*)
	END_STRUCT;
	hmiParamListTable_typ : 	STRUCT 
		listHeader : STRING[DEFINE_PAR_NAME_MAXLEN]; (*name of the list (header text)*)
		listIdText : ARRAY[0..DEFINE_MAX_TABLE_ENTRIES]OF STRING[DEFINE_PAR_IDX_MAXLEN]; (*table colum: id-s*)
		listTypeText : ARRAY[0..DEFINE_MAX_TABLE_ENTRIES]OF STRING[DEFINE_PAR_NAME_MAXLEN]; (*table colum: value*)
		listDefaultText : ARRAY[0..DEFINE_MAX_TABLE_ENTRIES]OF STRING[DEFINE_PAR_NAME_MAXLEN]; (*table colum: value*)
		listMinText : ARRAY[0..DEFINE_MAX_TABLE_ENTRIES]OF STRING[DEFINE_PAR_NAME_MAXLEN]; (*table colum: value*)
		listMaxText : ARRAY[0..DEFINE_MAX_TABLE_ENTRIES]OF STRING[DEFINE_PAR_NAME_MAXLEN]; (*table colum: value*)
		listValueText : ARRAY[0..DEFINE_MAX_TABLE_ENTRIES]OF STRING[DEFINE_PAR_NAME_MAXLEN]; (*table colum: value*)
		listName : ARRAY[0..DEFINE_MAX_TABLE_ENTRIES]OF STRING[DEFINE_PAR_NAME_MAXLEN]; (*table colum: name*)
		listDescription : ARRAY[0..DEFINE_MAX_TABLE_ENTRIES]OF STRING[DEFINE_PAR_DESC_MAXLEN]; (*table colum: description*)
		listValuePtr : ARRAY[0..DEFINE_MAX_TABLE_ENTRIES]OF UDINT; (*list of ptrs to parametars*)
		listDecPlaces : ARRAY[0..DEFINE_MAX_TABLE_ENTRIES]OF DINT; (*list of dec places for each parametar*)
		listLimits : ARRAY[0..DEFINE_MAX_TABLE_ENTRIES]OF hmiParamLimits_typ;
		selName : {REDUND_UNREPLICABLE} STRING[DEFINE_PAR_NAME_MAXLEN]; (*name of the currently selected/active parametar*)
		selDescription : STRING[DEFINE_PAR_DESC_MAXLEN]; (*description of the currently selected/active parametar*)
		selValueEnumIndex : UDINT; (*value of the currently selected/active parametar for type enum*)
		selValueEnumIndexMax : UDINT; (*value of the currently selected/active parametar for type enum*)
		selValueREAL : REAL; (*value of the currently selected/active parametar*)
		selValueREALOld : REAL; (*value of the currently selected/active parametar (previous value for change detection*)
		selValueREALMax : REAL; (*max value of the currently selected/active parametar*)
		selValueREALMin : REAL; (*min value of the currently selected/active parametar*)
		selValueREALDefault : REAL; (*default value of the currently selected/active parametar*)
		selValueDecPlaces : DINT; (*default value of the currently selected/active parametar*)
		selValueDINT : DINT; (*value of the currently selected/active parametar*)
		selValueDINTOld : DINT; (*value of the currently selected/active parametar (previous value for change detection*)
		selValueDINTMax : DINT; (*max value of the currently selected/active parametar*)
		selValueDINTMin : DINT; (*min value of the currently selected/active parametar*)
		selValueDINTDefault : DINT; (*default value of the currently selected/active parametar*)
		selValueFormVisible : DINT; (*visibility control of the form / controls for setting parametar value*)
		index : UINT; (*index of the currently selected/active parametar*)
		indexOld : UINT; (*index of the currently selected/active parametar (previous value for change detection)*)
		maxIndex : UINT; (*max index / number of items in the table. Must be less then hmiTableMAXDESCRIPTION!!!*)
		setDefaultRequest : BOOL; (*set default request flag*)
		incDP : USINT;
		decDP : USINT;
	END_STRUCT;
END_TYPE
