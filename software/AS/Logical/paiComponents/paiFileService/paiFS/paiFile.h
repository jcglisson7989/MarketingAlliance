/********************************************************************
 * COPYRIGHT -- HP
 ********************************************************************
 * File: paiFile.h
 * Author: goran
 * Created: March 19, 2014
 *******************************************************************/

#include <bur/plctypes.h>

/*
###############################################################################
PAI_CONFIGURATION_SECTION
Code below allows configuration for:
application file system 
###############################################################################
*/

/*
###############################################################################
Defines, Consts
###############################################################################
*/
/*
NOTE: Using C: disk is not the best solution considering that system files are there. 
However, using disk other then C: (i.e. D:, etc) for application stuff creates
issue with the ability to view/copy/access application files from windows (multiple partitions not supported, etc)

File structure used in this application is following:

Directory:
C://Data
is used for application specific stuff. 
This directory holds following files:
machine configuration file - "appcfg.txt"
machine factory deafult configuration file - "appcfgfactory.txt");

a subdirectory (REC) of the above directory is used for storing recipes.
C://Data/Rec

*/

#define PAI_FS_DEVICE_ROOT		"CFDISK"




/*file device name*/
//#define FILE_DEVICE_NAME	"CFDISK"
//#define FILE_DEVICE_CONF	 "/DEVICE=F:\\"
//#define FILE_DEVICE_CONF	 "/DEVICE=C:\\"
/*#define FILE_DEVICE_CONF	 "/DEVICE=D:\\Temp"*/


//IMPORTANT:
//in order for the following conditional compilation to work properly, PLC object in the Configuration view
//must contain following defintion:
//Folder: Build
//Field: Additional Build Options
//Value: -D $(AS_CONFIGURATION)
//Using the above, name of the current AS configuration (i.e. PPC820_ARwin1) becomes 
//a defined preprocessor name. As a result, it's possible to destinguish between different configurations! 
#ifdef PPC820_ARwin1
//In case of ARwin target, disk access uses networking and the disk storage is on the windows side
//CRITICAL NOTE: following IP address must match the Windows IP address within the ARWin networking configuration
//#define FILE_DEVICE_CONF "/SIP=192.168.1.15 /PROTOCOL=cifs /SHARE=abc /USER=abc /PASSWORD=abc"
#define FILE_DEVICE_CONF "/SIP=192.168.100.2 /PROTOCOL=cifs /SHARE=E_Data /USER=gainco /PASSWORD=gainco"
#warning "paiFS - ARwin target!"
#endif

#ifdef PPC820_ARwin
//In case of ARwin target, disk access uses networking and the disk storage is on the windows side
//CRITICAL NOTE: following IP address must match the Windows IP address within the ARWin networking configuration
//#define FILE_DEVICE_CONF "/SIP=192.168.1.15 /PROTOCOL=cifs /SHARE=abc /USER=abc /PASSWORD=abc"
#define FILE_DEVICE_CONF "/SIP=192.168.100.2 /PROTOCOL=cifs /SHARE=E_Data /USER=gainco /PASSWORD=gainco"
#warning "paiFS - ARwin target!"
#endif

//#ifndef FILE_DEVICE_CONF
#ifndef PAI_FS_DEVICE_ROOT_CFG
//For all other target (i.e ARsim and ARemb), storage resides on a physical disk present in the system
//#define FILE_DEVICE_CONF	 "/DEVICE=C:\\"
#define PAI_FS_DEVICE_ROOT_CFG	"/DEVICE=C:\\"
#warning "paiFS - NONE ARwin target!" 
#warning "Please verify File System configuration in paiFS.h"
#endif

//===================================================================================
//Define application directories
//Dirs are located at PAI_FS_DEVICE_ROOT
#define PAI_FS_APP_DIR_DATA		"Data"
#define PAI_FS_APP_DIR_CFG		"Data/Cfg"
#define PAI_FS_APP_DIR_REC		"Data/Rec"


//===================================================================================
//Define application devices
//Devices are dedicated dirs at PAI_FS_DEVICE_ROOT to be used for specific purpose
#define PAI_FS_DEVICE_CFG	"CONFIG"
#define PAI_FS_DEVICE_CFG_CFG "/DEVICE=C:/Data/Cfg"

#define PAI_FS_DEVICE_REC	"RECIPES"
#define PAI_FS_DEVICE_REC_CFG "/DEVICE=C:/Data/Rec"

#define PAI_FS_DEVICE_REC_PALLETE	"FILESPALLETE"
#define PAI_FS_DEVICE_REC_PALLETE_CFG "/DEVICE=C:/Data/Rec/Pallets"

#define PAI_FS_DEVICE_REC_LAYER	"FILESLAYERS"
#define PAI_FS_DEVICE_REC_LAYER_CFG "/DEVICE=C:/Data/Rec/Layers"

#define PAI_FS_DEVICE_USB	"USB"
#define PAI_FS_DEVICE_USB_CFG "/DEVICE=C:/Data/Rec"



