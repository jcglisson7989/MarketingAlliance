
TYPE
	USB_Global_SM_Enum : 
		(
		STEP_GET_NODE_LIST := 0,
		STEP_READ_DEVICE_DATA := 1,
		STEP_USB_ERROR := 2,
		STEP_CHECK_MOUNT_STATUS := 3,
		STEP_MOUNT_DISMOUNT := 4,
		STEP_WAIT_NODE_RESCAN := 5
		);
	Dev_Mount_Statuses : 
		(
		DEVICE_NOT_CONNECTED := 0,
		DEVICE_NOT_MOUNTED := 1,
		DEVICE_MOUNTING := 2,
		DEVICE_MOUNTED := 3,
		DEVICE_DISCON_WHILE_MOUNTED := 4,
		DEVICE_UNMOUNTING := 5,
		DEVICE_UNMOUNTED_CONNECTED := 6,
		DEVICE_NOT_MOUNTABLE := 7,
		DEVICE_DISMOUNT_ERROR := 8,
		DEVICE_MOUNT_ERROR := 9,
		DEVICE_IS_TECHGUARD_DONGLE := 10
		);
	USB_FBK_typ : 	STRUCT 
		Link_Device : DevLink;
		Unlink_Device : DevUnlink;
	END_STRUCT;
	USB_Data_typ : 	STRUCT 
		usb_node_info_connected : usbNode_typ;
		usb_node_info_to_connect : usbNode_typ;
		device_descriptor : usbDeviceDescr_typ;
		device_param : STRING[80];
		device_name : STRING[80];
	END_STRUCT;
	USB_Object_typ : 	STRUCT 
		FBK : USB_FBK_typ;
		Data : USB_Data_typ;
		Err : BOOL;
		Force_Dismount : BOOL;
		Status : Dev_Mount_Statuses;
		Mounted : BOOL;
	END_STRUCT;
END_TYPE
