
PROGRAM _CYCLIC
	(* Insert code here *)
	
	//Convert DT values to string for use in VC
	FOR ii := 0 TO 9 DO
		IF(gPaiMp.data.MpFileManagerUIConnect.File.List.Items[ii].LastModified > DT#1970-01-01-00:00:00) THEN
			gPaiMp.data.paiFileItemSizeAndDT[ii].strDT := DT_TO_STRING(gPaiMp.data.MpFileManagerUIConnect.File.List.Items[ii].LastModified);
		ELSE
			gPaiMp.data.paiFileItemSizeAndDT[ii].strDT := WSTRING_TO_STRING(" ");
		END_IF
		IF(gPaiMp.data.MpFileManagerUIConnect.File.List.Items[ii].ItemType >= mpFILE_ITEM_TYPE_FILE) THEN
			gPaiMp.data.paiFileItemSizeAndDT[ii].strSize := UDINT_TO_STRING(gPaiMp.data.MpFileManagerUIConnect.File.List.Items[ii].Size);
		ELSE
			gPaiMp.data.paiFileItemSizeAndDT[ii].strSize := WSTRING_TO_STRING(" ");
		END_IF		
	END_FOR;
END_PROGRAM
