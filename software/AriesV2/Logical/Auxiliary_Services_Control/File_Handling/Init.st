

PROGRAM _INIT
	File_Manager_Control.MpLink := ADR(File_Manager_MpLink);
	File_Manager_Control.Enable := TRUE;
	File_Manager_Control.UIConnect := ADR(File_Manager_UIConnect);
	
	File_Manager_UIConnect.DeviceList.DeviceNames[0] := 'ROOT';
	File_Manager_UIConnect.DeviceList.DeviceNames[1] := 'Config';
	File_Manager_UIConnect.DeviceList.DeviceNames[2] := 'Recipe';
	File_Manager_UIConnect.DeviceList.DeviceNames[3] := 'Process';
	File_Manager_UIConnect.DeviceList.DeviceNames[4] := 'USB1';
	File_Manager_UIConnect.DeviceList.DeviceNames[5] := 'USB2';
	
	File_Manager_Control.UISetup.FileListSize := 8;
	File_Manager_Control.UISetup.FileListScrollWindow := 5;
	
	File_Manager_Control;
	
	Alarm_File_UI.MpLink := ADR(File_Manager_MpLink);
	Alarm_File_UI.Enable := TRUE;
	Alarm_File_UI.Mode := mpALARM_BASIC_UI_MODE_ALL;
	
	Alarm_File_UI.UISetup.ImageSize := 20;
	Alarm_File_UI.UISetup.AlarmImage := ADR(Alarm_File.AlarmImage[0]);
	Alarm_File_UI.UISetup.AcknowledgeImage := ADR(Alarm_File.AcknowledgeImage[0]);
	Alarm_File_UI.UISetup.AddInfoStringSize := 100;
	Alarm_File_UI.UISetup.AddInfo := ADR(Alarm_File.AddInfo[0]);
	
	Alarm_File;
	Alarm_File_UI();
	 
END_PROGRAM