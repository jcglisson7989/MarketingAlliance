/********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Program: paiFile
 * File: paiDevDirConfigure.c
 * Author: goran_2
 * Created: August 05, 2011
 ********************************************************************
 * Implementation of program paiDevDirConfigure
 ********************************************************************/

#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
 #include <AsDefault.h>
#endif

#include "paiFile.h"


/*
###############################################################################
PAI_CONFIGURATION_SECTION
Code below allows configuration of the devices and folders used in the 
application.
###############################################################################
*/
#warning "pai Configuration: application File Devices and Folders"
void paiFSDeviceAndDirConfig( void )
{		
	int idx=0;	
	//If .deviceConfiguration is NOT empty string, entry is related to device link at powerup
	//If .deviceConfiguration is empty string, entry is related to directory check/create at powerup
	
	brsstrcpy((UDINT)paiFSDevices.listDevsDirs[idx].deviceName, (UDINT)PAI_FS_DEVICE_ROOT);
	brsstrcpy((UDINT)paiFSDevices.listDevsDirs[idx].dirName, (UDINT)"");
	brsstrcpy((UDINT)paiFSDevices.listDevsDirs[idx].deviceConfiguration, (UDINT)PAI_FS_DEVICE_ROOT_CFG);

	idx++;
	brsstrcpy((UDINT)paiFSDevices.listDevsDirs[idx].deviceName, (UDINT)PAI_FS_DEVICE_ROOT);
	brsstrcpy((UDINT)paiFSDevices.listDevsDirs[idx].dirName, (UDINT)PAI_FS_APP_DIR_DATA);//i.e. Data
	brsstrcpy((UDINT)paiFSDevices.listDevsDirs[idx].deviceConfiguration, (UDINT)"");
	
	idx++;
	brsstrcpy((UDINT)paiFSDevices.listDevsDirs[idx].deviceName, (UDINT)PAI_FS_DEVICE_ROOT);
	brsstrcpy((UDINT)paiFSDevices.listDevsDirs[idx].dirName, (UDINT)PAI_FS_APP_DIR_CFG);//i.e. Data/Cfg
	brsstrcpy((UDINT)paiFSDevices.listDevsDirs[idx].deviceConfiguration, (UDINT)"");
	
	idx++;
	brsstrcpy((UDINT)paiFSDevices.listDevsDirs[idx].deviceName, (UDINT)PAI_FS_DEVICE_ROOT);
	brsstrcpy((UDINT)paiFSDevices.listDevsDirs[idx].dirName, (UDINT)PAI_FS_APP_DIR_REC);//i.e. Data/Rec
	brsstrcpy((UDINT)paiFSDevices.listDevsDirs[idx].deviceConfiguration, (UDINT)"");

	idx++;
	brsstrcpy((UDINT)paiFSDevices.listDevsDirs[idx].deviceName, (UDINT)PAI_FS_DEVICE_ROOT);
	brsstrcpy((UDINT)paiFSDevices.listDevsDirs[idx].dirName, (UDINT)"Data/Rec/Layers");//i.e. Data/Rec/Layers
	brsstrcpy((UDINT)paiFSDevices.listDevsDirs[idx].deviceConfiguration, (UDINT)"");

	idx++;
	brsstrcpy((UDINT)paiFSDevices.listDevsDirs[idx].deviceName, (UDINT)PAI_FS_DEVICE_ROOT);
	brsstrcpy((UDINT)paiFSDevices.listDevsDirs[idx].dirName, (UDINT)"Data/Rec/Pallets");//i.e. Data/Rec/Pallets
	brsstrcpy((UDINT)paiFSDevices.listDevsDirs[idx].deviceConfiguration, (UDINT)"");
	
	idx++;
	brsstrcpy((UDINT)paiFSDevices.listDevsDirs[idx].deviceName, (UDINT)PAI_FS_DEVICE_ROOT);
	brsstrcpy((UDINT)paiFSDevices.listDevsDirs[idx].dirName, (UDINT)"Data/Test");
	brsstrcpy((UDINT)paiFSDevices.listDevsDirs[idx].deviceConfiguration, (UDINT)"");
	
	idx++;
	brsstrcpy((UDINT)paiFSDevices.listDevsDirs[idx].deviceName, (UDINT)PAI_FS_DEVICE_CFG);
	brsstrcpy((UDINT)paiFSDevices.listDevsDirs[idx].dirName, (UDINT)"");
	brsstrcpy((UDINT)paiFSDevices.listDevsDirs[idx].deviceConfiguration, (UDINT)PAI_FS_DEVICE_CFG_CFG);

	idx++;
	brsstrcpy((UDINT)paiFSDevices.listDevsDirs[idx].deviceName, (UDINT)PAI_FS_DEVICE_REC);
	brsstrcpy((UDINT)paiFSDevices.listDevsDirs[idx].dirName, (UDINT)"");
	brsstrcpy((UDINT)paiFSDevices.listDevsDirs[idx].deviceConfiguration, (UDINT)PAI_FS_DEVICE_REC_CFG);
	
	idx++;
	brsstrcpy((UDINT)paiFSDevices.listDevsDirs[idx].deviceName, (UDINT)PAI_FS_DEVICE_REC_LAYER);
	brsstrcpy((UDINT)paiFSDevices.listDevsDirs[idx].dirName, (UDINT)"");
	brsstrcpy((UDINT)paiFSDevices.listDevsDirs[idx].deviceConfiguration, (UDINT)PAI_FS_DEVICE_REC_LAYER_CFG);

	idx++;
	brsstrcpy((UDINT)paiFSDevices.listDevsDirs[idx].deviceName, (UDINT)PAI_FS_DEVICE_REC_PALLETE);
	brsstrcpy((UDINT)paiFSDevices.listDevsDirs[idx].dirName, (UDINT)"");
	brsstrcpy((UDINT)paiFSDevices.listDevsDirs[idx].deviceConfiguration, (UDINT)PAI_FS_DEVICE_REC_PALLETE_CFG);
	
	
	idx++;
	brsstrcpy((UDINT)paiFSDevices.listDevsDirs[idx].deviceName, (UDINT)"USB1");
	brsstrcpy((UDINT)paiFSDevices.listDevsDirs[idx].dirName, (UDINT)"");
	brsstrcpy((UDINT)paiFSDevices.listDevsDirs[idx].deviceConfiguration, (UDINT)"/DEVICE=IF3.ST1");

	idx++;
	brsstrcpy((UDINT)paiFSDevices.listDevsDirs[idx].deviceName, (UDINT)"USB2");
	brsstrcpy((UDINT)paiFSDevices.listDevsDirs[idx].dirName, (UDINT)"");
	brsstrcpy((UDINT)paiFSDevices.listDevsDirs[idx].deviceConfiguration, (UDINT)"/DEVICE=IF4.ST1");
	
}
//eof
