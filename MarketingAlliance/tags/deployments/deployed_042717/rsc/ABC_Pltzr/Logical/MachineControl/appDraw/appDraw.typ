
TYPE
	paDrawEnums_typ : 
		(
		PADRAW_RECT_MAXIDX := 30
		);
	paCallback_typ : 	STRUCT 
		pCallback : REFERENCE TO UDINT;
		callbackValue : UDINT;
		callbackState : UDINT;
		callbackRet : UDINT;
		callbackParams : ARRAY[0..3]OF UDINT;
	END_STRUCT;
	paDrawBoxSize_typ : 	STRUCT 
		name : STRING[31];
		length_inch : REAL; (*Width (pixels) of the draw box control*)
		width_inch : REAL; (*Width (pixels) of the draw box control*)
		height_inch : REAL; (*Height (pixels) of the draw box control*)
		length_pixel : UDINT; (*Width (pixels) of the draw box control*)
		width_pixel : UDINT; (*Width (pixels) of the draw box control*)
		height_pixel : UDINT; (*Height (pixels) of the draw box control*)
	END_STRUCT;
	paDrawBoxCtrl_typ : 	STRUCT 
		state : UDINT;
		handle : UDINT; (*VISAPI handle returned from VA_Setup()*)
		nameDrawBoxCtrl : STRING[80]; (*DrawBox name for VA_Attach(). It is string with a following format "pageName/LayerName/drawBoxComponentName"*)
		nameVisu : STRING[20]; (*Visualization object name within the project (i.e."Visu", "Panel", "Hmi", etc)*)
		colorIndex : USINT; (*Background color index*)
		width : UDINT; (*Width (pixels) of the draw box control*)
		height : UDINT; (*Height (pixels) of the draw box control*)
	END_STRUCT;
	paDrawTextout_typ : 	STRUCT 
		iEnable : USINT; (*Enable text output*)
		iFontIndex : USINT; (*Text font index*)
		iFColorIndex : USINT; (*Text front color index*)
		iBColorIndex : USINT; (*Data line color index*)
		iX : REAL; (*Text x position*)
		iY : REAL; (*Text y poistion*)
		iText : STRING[80]; (*Number of samples in dataset*)
	END_STRUCT;
	paDrawRect_typ : 	STRUCT 
		iEnable : USINT; (*Enable text output*)
		iVCHandle : UDINT; (*Text font index*)
		iX : UINT; (*Text x position*)
		iY : UINT; (*Text y poistion*)
		iWidth : UINT; (*Text x position*)
		iHeight : UINT; (*Text y poistion*)
		iFillColorIndex : USINT; (*Text front color index*)
		iBorderColorIndex : USINT; (*Data line color index*)
	END_STRUCT;
	paDrawDataset_typ : 	STRUCT 
		iColorIndex : USINT; (*Data line color index*)
		iMinValue : REAL; (*Min value from the data set > will be displayed at 0% on the graph*)
		iMaxValue : REAL; (*Max value from the data set > will be displayed at 100% on the graph*)
		iSizeDataset : UDINT; (*Number of samples in dataset*)
		ipDataset : REFERENCE TO REAL; (*Reference (pointer) to the dataset*)
	END_STRUCT;
	paDrawBoxGrid_typ : 	STRUCT 
		ivColorIndex : USINT; (*Grid line color - vertical line*)
		ivLineCount : USINT; (*Number of vertical lines*)
		ivThickRepeat : USINT; (*Place a thicker (i.e. divider) grid line repeat count times - vertical*)
		ihColorIndex : USINT; (*Grid line color - horizontal line*)
		ihLineCount : USINT; (*Number of horizontal lines*)
		ihThickRepeat : USINT; (*Place a thicker (i.e. divider) grid line repeat count times - horizontal*)
	END_STRUCT;
	paDrawXZMotionProfile_typ : 	STRUCT 
		ixPhysicalRange : REAL;
		izPhysicalRange : REAL;
		ixPick : REAL;
		izPick : REAL;
		ixDrop : REAL;
		izDrop : REAL;
		iFwdClrIdx : USINT;
		iRevClrIdx : USINT;
		ixCamDataset : paDrawDataset_typ;
		izCamDataset : paDrawDataset_typ;
		idx : UDINT;
		deltaCamMaster : REAL;
		state : UDINT;
	END_STRUCT;
	paDrawBoxDrawing_typ : 	STRUCT 
		cb : paCallback_typ;
		ctrl : paDrawBoxCtrl_typ;
		grid : paDrawBoxGrid_typ;
		rect : paDrawRect_typ;
		textout : paDrawTextout_typ;
		data1 : paDrawDataset_typ;
		pRectArray : REFERENCE TO paDrawRect_typ;
		xzProfile : paDrawXZMotionProfile_typ;
	END_STRUCT;
	paCamEditApp_typ : 	STRUCT 
		btnPreview : USINT;
		state : UDINT;
		camPointsX : ARRAY[0..3]OF REAL;
		camPointsZ : ARRAY[0..3]OF REAL;
		value : USINT;
	END_STRUCT;
END_TYPE
