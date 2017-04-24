(********************************************************************
 * COPYRIGHT -- pai
 ********************************************************************
 * Package: HMI
 * File: HMI.typ
 * Author: goran
 * Created: August 28, 2013
 ********************************************************************
 * Data types of package HMI
 ********************************************************************)

TYPE
	hmiParamListEnums_typ : 
		(
		hmiTableMAXENUMS := 10, (*Max number of items in an enum list when property type is enum*)
		hmiTableMAXENUMTEXT := 15, (*Max len of each enum text*)
		hmiTableMAXENTRIES := 50, (*Max number of supported properties in the property list*)
		hmiTableMAXDESCRIPTION := 255, (*Max length of the description text for each property*)
		hmiTableMAXNAME := 31 (*Max name of a property*)
		);
END_TYPE

(*########################################################################*)
(*HMI object - PARAMETER LIST - LIMITS*)
(*########################################################################*)

TYPE
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
END_TYPE

(*########################################################################*)
(*HMI object - PARAMETER LIST*)
(*########################################################################*)

TYPE
	hmiParamListTable_typ : 	STRUCT 
		listHeader : STRING[hmiTableMAXNAME]; (*name of the list (header text)*)
		listIdText : ARRAY[0..hmiTableMAXENTRIES]OF STRING[7]; (*table colum: id-s*)
		listValueText : ARRAY[0..hmiTableMAXENTRIES]OF STRING[15]; (*table colum: value*)
		listName : ARRAY[0..hmiTableMAXENTRIES]OF STRING[hmiTableMAXNAME]; (*table colum: name*)
		listDescription : ARRAY[0..hmiTableMAXENTRIES]OF STRING[hmiTableMAXDESCRIPTION]; (*table colum: description*)
		listValuePtr : ARRAY[0..hmiTableMAXENTRIES]OF UDINT; (*list of ptrs to parametars*)
		listDecPlaces : ARRAY[0..hmiTableMAXENTRIES]OF DINT; (*list of dec places for each parametar*)
		listLimits : ARRAY[0..hmiTableMAXENTRIES]OF hmiParamLimits_typ;
		selName : STRING[hmiTableMAXNAME]; (*name of the currently selected/active parametar*)
		selDescription : STRING[hmiTableMAXDESCRIPTION]; (*description of the currently selected/active parametar*)
		listSelValueEnumText : ARRAY[0..hmiTableMAXENUMS]OF STRING[hmiTableMAXENUMTEXT]; (*list of available enum text for a property that is of type ENUM*)
		listSelValueEnum : ARRAY[0..hmiTableMAXENUMS]OF UDINT; (*list of available enum text for a property that is of type ENUM*)
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
	END_STRUCT;
END_TYPE
