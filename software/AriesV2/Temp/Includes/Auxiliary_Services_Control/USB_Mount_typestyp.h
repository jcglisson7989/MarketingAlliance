/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _BUR_1491590275_9_
#define _BUR_1491590275_9_

#include <bur/plctypes.h>

/* Datatypes and datatypes of function blocks */
typedef enum USB_Global_SM_Enum
{	STEP_GET_NODE_LIST = 0,
	STEP_READ_DEVICE_DATA = 1,
	STEP_USB_ERROR = 2,
	STEP_CHECK_MOUNT_STATUS = 3,
	STEP_MOUNT_DISMOUNT = 4,
	STEP_WAIT_NODE_RESCAN = 5
} USB_Global_SM_Enum;

typedef enum Dev_Mount_Statuses
{	DEVICE_NOT_CONNECTED = 0,
	DEVICE_NOT_MOUNTED = 1,
	DEVICE_MOUNTING = 2,
	DEVICE_MOUNTED = 3,
	DEVICE_DISCON_WHILE_MOUNTED = 4,
	DEVICE_UNMOUNTING = 5,
	DEVICE_UNMOUNTED_CONNECTED = 6,
	DEVICE_NOT_MOUNTABLE = 7,
	DEVICE_DISMOUNT_ERROR = 8,
	DEVICE_MOUNT_ERROR = 9,
	DEVICE_IS_TECHGUARD_DONGLE = 10
} Dev_Mount_Statuses;

typedef struct USB_FBK_typ
{	struct DevLink Link_Device;
	struct DevUnlink Unlink_Device;
} USB_FBK_typ;

typedef struct USB_Data_typ
{	struct usbNode_typ usb_node_info_connected;
	struct usbNode_typ usb_node_info_to_connect;
	struct usbDeviceDescr_typ device_descriptor;
	plcstring device_param[81];
	plcstring device_name[81];
} USB_Data_typ;

typedef struct USB_Object_typ
{	struct USB_FBK_typ FBK;
	struct USB_Data_typ Data;
	plcbit Err;
	plcbit Force_Dismount;
	enum Dev_Mount_Statuses Status;
	plcbit Mounted;
} USB_Object_typ;






__asm__(".section \".plc\"");

/* Used IEC files */
__asm__(".ascii \"iecfile \\\"Logical/Auxiliary_Services_Control/USB_Mount_types.typ\\\" scope \\\"global\\\"\\n\"");

/* Exported library functions and function blocks */

__asm__(".previous");


#endif /* _BUR_1491590275_9_ */

