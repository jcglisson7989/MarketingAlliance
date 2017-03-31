(********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Package: HMI_Visu
 * File: HMI_Visu.typ
 * Author: John
 * Created: February 03, 2015
 ********************************************************************
 * Data types of package HMI_Visu
 ********************************************************************)

TYPE
	Generic_HMI_Ctrl : 	STRUCT 
		Ctrl : HMI_Ctrl_typ;
		Data : HMI_Data_typ;
END_STRUCT;
	HMI_Ctrl_typ : 	STRUCT 
		KeyLevel : HMI_Control_Change_Current;
		Language : HMI_Control_Change_Current;
		Page : HMI_Control_Change_Current;
		Screensaver : HMI_Control_ScreenTimer;
		Backlight : HMI_Control_ScreenTimer;
		Calibration : HMI_Control_Calibration;
END_STRUCT;
	HMI_Control_Calibration : 	STRUCT 
		State : USINT;
		DataPoint : USINT;
END_STRUCT;
	HMI_Control_ScreenTimer : 	STRUCT 
		Time_Remaining : UDINT;
		Time_Until_Display : UDINT;
END_STRUCT;
	HMI_Data_typ : 	STRUCT 
		Wheel : HMI_Data_Wheel_typ;
END_STRUCT;
	HMI_Data_Wheel_typ : 	STRUCT 
		Enter : BOOL;
		Counts : DINT;
END_STRUCT;
	HMI_Control_Change_Current : 	STRUCT 
		Change : DINT;
		Current : DINT;
END_STRUCT;
	Listbox_Option_Enum : 
		(
		ALLOW := 0,
		DISALLOW := 1,
		HIDDEN := 2
);
	GenericListbox_typ : 	STRUCT 
		Strings : ARRAY[0..Enum_Max_Listbox_Items]OF STRING[Enum_Max_Listbox_Char];
		Index : DINT;
		maxidx : USINT;
		minidx : USINT;
		status : USINT;
		option : ARRAY[0..Enum_Max_Listbox_Items]OF USINT;
END_STRUCT;
	GenericButton_typ : 	STRUCT 
		datapoint : USINT;
		status : USINT;
		text : STRING[64];
END_STRUCT;
END_TYPE
