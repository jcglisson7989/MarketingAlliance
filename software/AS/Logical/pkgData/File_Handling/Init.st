

PROGRAM _INIT
	File_Manager_Control.MpLink := ADR(File_Manager_MpLink);
	File_Manager_Control.Enable := TRUE;
	File_Manager_Control.UIConnect := ADR(File_Manager_UIConnect);
	
	File_Manager_UIConnect.DeviceList.DeviceNames[0] := 'ROOT';
	File_Manager_UIConnect.DeviceList.DeviceNames[1] := 'Config';
	File_Manager_UIConnect.DeviceList.DeviceNames[2] := 'Recipe';
	File_Manager_UIConnect.DeviceList.DeviceNames[3] := 'Data_Log';
	File_Manager_UIConnect.DeviceList.DeviceNames[4] := 'USB1';
	File_Manager_UIConnect.DeviceList.DeviceNames[5] := 'USB2';
	
	File_Manager_Control.UISetup.FileListSize := 8;
	File_Manager_Control.UISetup.FileListScrollWindow := 5;
	
	File_Manager_Control;
	 
END_PROGRAM