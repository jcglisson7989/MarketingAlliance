TYPE
	CSV_ListFileOption_typ : STRUCT
		SearchVarName	:STRING[80];	
		FileLenToRead	:UINT;	
		MaxNrLen	:USINT;	
		MaxNameLen	:USINT;	
	END_STRUCT;
			_csv_exfilelist_internal : STRUCT
		Step	:USINT;	
		DownLines	:UINT;	
		UpLines	:UINT;	
		PosFirstLine	:UINT;	
		FileNumOnDisk	:UINT;	
		FileNumAct	:UINT;	
		Offset	:UDINT;	
		TmpExtension	:STRING[4];	
		FileInfo	:fiDIR_READ_DATA;	
		i	:UINT;	
		result1	:DINT;	
		result2	:DINT;	
		OptionStruct	:CSV_ListFileOption_typ;	
		TmpString	:ARRAY[0..50] OF USINT;	
		dateandtime	:DTStructure;	
		status_alloc	:UINT;	
		pFileData	:UDINT;	
		FileIdent	:UDINT;	
		FileFound	:BOOL;	
		PositionFound	:BOOL;	
		FirstSeperatorFound	:BOOL;	
		SecondSeperatorFound	:BOOL;	
		EndPositionFound	:BOOL;	
		StartPositionName	:UDINT;	
		EndPositionName	:UDINT;	
		CRLF	:ARRAY[0..2] OF USINT;	
		InternalFileName	:ARRAY[0..254] OF USINT;	
		VarNameSearch	:ARRAY[0..5] OF USINT;	
		CompleteEntry	:ARRAY[0..254] OF USINT;	
	END_STRUCT;
			_csv_filelist_Internal : STRUCT
		MaxFileNum	:UINT;	
		EntriesOnDisp	:USINT;	
		pFileDevice	:UDINT;	
		pFilelist	:UDINT;	
		pActName	:UDINT;	
		pTeeList	:UDINT;	
		Offset	:UDINT;	
		MemTempOffset	:UDINT;	
		TempMemLng	:UDINT;	
		ListboxPos	:UINT;	
		FilePosCounter	:UINT;	
		FileNumAct	:UINT;	
		FileNumOnDisk	:UINT;	
		AllocStatus	:UINT;	
	END_STRUCT;
			_csv_init_Internal : STRUCT
		PV_xgetadrStatus	:UINT;	
		PV_ninfoStatus	:UINT;	
		PV_itemStatus	:UINT;	
		TMP_allocStatus	:UINT;	
		Dimension	:UINT;	
		ItemNrSoll	:ARRAY[0..49] OF UINT;	
		ItemNrIst	:ARRAY[0..49] OF UINT;	
		i	:UINT;	
		CRLF	:ARRAY[0..2] OF USINT;	
		Ebene	:USINT;	
		Step	:USINT;	
		FoundChar	:USINT;	
		Counter_Usint	:USINT;	
		NameCounter	:USINT;	
		Merker	:USINT;	
		MerkerArray	:ARRAY[0..49] OF BOOL;	
		DataLenght	:UDINT;	
		Datatyp	:UDINT;	
		PV_Adress	:UDINT;	
		Lenght	:UDINT;	
		TmpValue	:UDINT;	
		StartVarName	:ARRAY[0..79] OF USINT;	
		FullStrukturName	:ARRAY[0..299] OF USINT;	
		StrukturName	:ARRAY[0..299] OF USINT;	
		Index	:ARRAY[0..6] OF USINT;	
		VarItemName	:ARRAY[0..299] OF USINT;	
		ItemName	:ARRAY[0..79] OF USINT;	
		ArrayName	:ARRAY[0..79] OF USINT;	
		Value	:ARRAY[0..79] OF USINT;	
		UsintArray	:ARRAY[0..79] OF USINT;	
		DintTime	:DINT;	
		NextItemReady	:BOOL;	
		ArrayStructure	:BOOL;	
		ArrayVariable	:BOOL;	
		VariableCounter	:UDINT;	
	END_STRUCT;
			_csv_read_internal : STRUCT
		OnlyArray	:BOOL;	
		OnlyArrayInStruct	:BOOL;	
		DateAndTime	:BOOL;	
		HeaderLine	:BOOL;	
		DynamicVariable	:BOOL;	
		Step	:USINT;	
		NameEntered	:USINT;	
		ArrayStructureStarts	:USINT;	
		level	:USINT;	
		TmpDateTime	:ARRAY[0..79] OF USINT;	
		TmpDataTyp	:ARRAY[0..79] OF USINT;	
		Value	:ARRAY[0..79] OF USINT;	
		TmpName	:ARRAY[0..149] OF USINT;	
		StructName	:ARRAY[0..149] OF USINT;	
		DataTyp	:ARRAY[0..79] OF USINT;	
		DateTime	:ARRAY[0..79] OF USINT;	
		VarName	:ARRAY[0..149] OF USINT;	
		y	:UINT;	
		status_alloc	:UINT;	
		status_free	:UINT;	
		temp_status	:UINT;	
		PV_xgetadrStatus	:UINT;	
		j	:UDINT;	
		i	:UDINT;	
		FileIdent	:UDINT;	
		pFileData	:UDINT;	
		Offset	:UDINT;	
		OffsetOld	:UDINT;	
		CharPerCyclic	:UDINT;	
		SpacesCounter	:UDINT;	
		Merker	:UDINT;	
		SpacesLastRow	:UDINT;	
		nextPV	:UDINT;	
		Counter	:UDINT;	
		PV_Adress	:UDINT;	
		data_len	:UDINT;	
		FileName	:STRING[80];	
		Path	:STRING[80];	
		DateTimeStruct	:DTStructure;	
		Separator	:USINT;	
	END_STRUCT;
			_csv_search_internal : STRUCT
		PV_xgetadrStatus	:UINT;	
		PV_ninfoStatus	:UINT;	
		PV_itemStatus	:UINT;	
		TMP_allocStatus	:UINT;	
		Dimension	:UINT;	
		ItemNrSoll	:ARRAY[0..49] OF UINT;	
		ItemNrIst	:ARRAY[0..49] OF UINT;	
		i	:UINT;	
		y	:UINT;	
		FullStrukturName	:ARRAY[0..299] OF USINT;	
		StrukturName	:ARRAY[0..299] OF USINT;	
		ArrayName	:ARRAY[0..79] OF USINT;	
		UsintArray	:ARRAY[0..79] OF USINT;	
		CRLF	:ARRAY[0..2] OF USINT;	
		Separator	:ARRAY[0..1] OF USINT;	
		Ebene	:USINT;	
		Step	:USINT;	
		NameCounter	:USINT;	
		FoundChar	:USINT;	
		Counter_Usint	:USINT;	
		Merker	:USINT;	
		MerkerArray	:ARRAY[0..49] OF BOOL;	
		DataLenght	:UDINT;	
		Datatyp	:UDINT;	
		PV_Adress	:UDINT;	
		Offset	:UDINT;	
		TmpValue	:UDINT;	
		Lenght	:UDINT;	
		Date_and_Time	:DATE_AND_TIME;	
		DintTime	:DINT;	
		Index	:ARRAY[0..6] OF USINT;	
		StartVarName	:ARRAY[0..79] OF USINT;	
		VarItemName	:ARRAY[0..299] OF USINT;	
		ItemName	:ARRAY[0..79] OF USINT;	
		Value	:ARRAY[0..79] OF USINT;	
		NextItemReady	:BOOL;	
		ArrayStructure	:BOOL;	
		ArrayVariable	:BOOL;	
		VariableCounter	:UDINT;	
	END_STRUCT;
END_TYPE