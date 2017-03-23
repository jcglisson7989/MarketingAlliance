/********************************************************************
 * COPYRIGHT -- piedmont
 ********************************************************************
 * Program: cfgFS
 * File: cfgFS.c
 * Author: admin
 * Created: Jan 20, 2014
 ********************************************************************
 * Implementation of program cfgFS
 ********************************************************************/

#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
 #include <AsDefault.h>
#endif

#include "../../paiComponents/bglib/bgPVSerialize.h"
#include "../appCfgRecDefault.h"
#include "../../paiComponents/paiFileService/paiPVSerDesMgr.h"
#include "../../paiComponents/paiFileService/paiFSInterface.h"
#include "../../paiComponents/paiFileService/paiFS/paiFile.h"

void gConfigAppDefaults();
void gPalletCfgDefaults();

/*
###############################################################################
PAI_CONFIGURATION_SECTION
Code below allows configuration of the PV serialization / deserialization
manager.
###############################################################################
*/
#warning "pai Configuration: Serialization/Deserialization"

void paiPVSerDesMgrConfigure()
{
	int itemIndex = 0;

	gPVSerDesMgr.pPaiFS = (UDINT)&paiFS;

	//add items as needed
	itemIndex = 0;	
	brsstrcpy((UDINT)gPVSerDesMgr.pvItems[itemIndex].iPVName, (UDINT)"gConfigApp");
	brsstrcpy((UDINT)gPVSerDesMgr.pvItems[itemIndex].iDevicename, (UDINT)PAI_FS_DEVICE_CFG);
	brsstrcpy((UDINT)gPVSerDesMgr.pvItems[itemIndex].iFilename, (UDINT)"gConfigApp.txt");
	gPVSerDesMgr.pvItems[itemIndex].pPV = (UDINT)&gConfigApp;
	gPVSerDesMgr.pvItems[itemIndex].iPVSize = sizeof(gConfigApp);
	gPVSerDesMgr.pvItems[itemIndex].pFilebuffer = (UDINT)&fileRWBuffer[0];
	gPVSerDesMgr.pvItems[itemIndex].iFilebufferSize = sizeof(fileRWBuffer);
	gPVSerDesMgr.pvItems[itemIndex].pCallbackSer = (UDINT)paiCBWriteFileSerPV;
	gPVSerDesMgr.pvItems[itemIndex].pCallbackDes = (UDINT)paiCBReadFileDesPV;
	gPVSerDesMgr.pvItems[itemIndex].pCallbackDefault = (UDINT)gConfigAppDefaults;
	//Option: HMI interaction with PV read/write/changed; Allows PV changes to be accepted/rejected
	gPVSerDesMgr.pvItems[itemIndex].optPtrHMIData = &gSerDesHMI_gConfigApp;
	//Option: Monitor PV changes
	gPVSerDesMgr.pvItems[itemIndex].optChangeMonitor.iChngEnable = 1;
	gPVSerDesMgr.pvItems[itemIndex].optChangeMonitor.pChangeMonitorMem = &gSerDesMem_gConfigApp;
	gPVSerDesMgr.pvItems[itemIndex].optChangeMonitor.iChangeMonitorMemSize = sizeof(gSerDesMem_gConfigApp);
	//Option: Init PV at Power Up
	gPVSerDesMgr.pvItems[itemIndex].optInitAtPowerUp.iPowerUpConfig = PAI_FS_SERDESMGR_PWRUP_DFLT_fRD;
	gPVSerDesMgr.pvItems[itemIndex].optInitAtPowerUp.iTestData = 0x55555555;
	gPVSerDesMgr.pvItems[itemIndex].optInitAtPowerUp.pTestDataStorage = &gConfigApp.magicNumber;
	
	
	
	//add items as needed
	itemIndex = 1;	
	brsstrcpy((UDINT)gPVSerDesMgr.pvItems[itemIndex].iPVName, (UDINT)"gPaiConfigSys");
	brsstrcpy((UDINT)gPVSerDesMgr.pvItems[itemIndex].iDevicename, (UDINT)PAI_FS_DEVICE_CFG);
	brsstrcpy((UDINT)gPVSerDesMgr.pvItems[itemIndex].iFilename, (UDINT)"gPaiConfigSys.txt");
	gPVSerDesMgr.pvItems[itemIndex].pPV = (UDINT)&gPaiConfigSys;
	gPVSerDesMgr.pvItems[itemIndex].iPVSize = sizeof(gPaiConfigSys);
	gPVSerDesMgr.pvItems[itemIndex].pFilebuffer = (UDINT)&fileRWBuffer[0];
	gPVSerDesMgr.pvItems[itemIndex].iFilebufferSize = sizeof(fileRWBuffer);
	gPVSerDesMgr.pvItems[itemIndex].pCallbackSer = (UDINT)paiCBWriteFileSerPV;
	gPVSerDesMgr.pvItems[itemIndex].pCallbackDes = (UDINT)paiCBReadFileDesPV;
	
	
	
	//add items as needed
	itemIndex = 2;	
	brsstrcpy((UDINT)gPVSerDesMgr.pvItems[itemIndex].iPVName, (UDINT)"gLayerEditor");
	brsstrcpy((UDINT)gPVSerDesMgr.pvItems[itemIndex].iDevicename, (UDINT)PAI_FS_DEVICE_REC_LAYER);
	brsstrcpy((UDINT)gPVSerDesMgr.pvItems[itemIndex].iFilename, (UDINT)"recLayer.txt");
	gPVSerDesMgr.pvItems[itemIndex].pPV = (UDINT)&gLayerEditor;
	gPVSerDesMgr.pvItems[itemIndex].iPVSize = sizeof(gLayerEditor);
	gPVSerDesMgr.pvItems[itemIndex].pFilebuffer = (UDINT)&fileRWBuffer[0];
	gPVSerDesMgr.pvItems[itemIndex].iFilebufferSize = sizeof(fileRWBuffer);
	gPVSerDesMgr.pvItems[itemIndex].pCallbackSer = (UDINT)paiCBWriteFileSerPV;
	gPVSerDesMgr.pvItems[itemIndex].pCallbackDes = (UDINT)paiCBReadFileDesPV;
	gPVSerDesMgr.pvItems[itemIndex].pCallbackDefault = (UDINT)0;
	//Option: HMI interaction with PV read/write/changed; Allows PV changes to be accepted/rejected
	//gPVSerDesMgr.pvItems[itemIndex].optPtrHMIData = &gSerDesHMI_gConfigApp;
	//Option: Monitor PV changes
	gPVSerDesMgr.pvItems[itemIndex].optChangeMonitor.iChngEnable = 1;
	gPVSerDesMgr.pvItems[itemIndex].optChangeMonitor.pChangeMonitorMem = &gSerDesMem_gLayerEditor;
	gPVSerDesMgr.pvItems[itemIndex].optChangeMonitor.iChangeMonitorMemSize = sizeof(gSerDesMem_gLayerEditor);
	//Option: Init PV at Power Up
	gPVSerDesMgr.pvItems[itemIndex].optInitAtPowerUp.iPowerUpConfig = PAI_FS_SERDESMGR_PWRUP_DFLT_fRD;
	gPVSerDesMgr.pvItems[itemIndex].optInitAtPowerUp.iTestData = 0x55555555;
	gPVSerDesMgr.pvItems[itemIndex].optInitAtPowerUp.pTestDataStorage = &gDummy;
	
	
	//add items as needed
	itemIndex = 3;	
	brsstrcpy((UDINT)gPVSerDesMgr.pvItems[itemIndex].iPVName, (UDINT)"gPallete.palCfg");
	brsstrcpy((UDINT)gPVSerDesMgr.pvItems[itemIndex].iDevicename, (UDINT)PAI_FS_DEVICE_REC_PALLETE);
	brsstrcpy((UDINT)gPVSerDesMgr.pvItems[itemIndex].iFilename, (UDINT)"recPallete.txt");
	gPVSerDesMgr.pvItems[itemIndex].pPV = (UDINT)&gPallete.palCfg;
	gPVSerDesMgr.pvItems[itemIndex].iPVSize = sizeof(gPallete.palCfg);
	gPVSerDesMgr.pvItems[itemIndex].pFilebuffer = (UDINT)&fileRWBuffer[0];
	gPVSerDesMgr.pvItems[itemIndex].iFilebufferSize = sizeof(fileRWBuffer);
	gPVSerDesMgr.pvItems[itemIndex].pCallbackSer = (UDINT)paiCBWriteFileSerPV;
	gPVSerDesMgr.pvItems[itemIndex].pCallbackDes = (UDINT)paiCBReadFileDesPV;
	gPVSerDesMgr.pvItems[itemIndex].pCallbackDefault = (UDINT)gPalletCfgDefaults;
	//Option: HMI interaction with PV read/write/changed; Allows PV changes to be accepted/rejected
	gPVSerDesMgr.pvItems[itemIndex].optPtrHMIData = &gSerDesHMI_gPalletCfg;
	//Option: Monitor PV changes
	gPVSerDesMgr.pvItems[itemIndex].optChangeMonitor.iChngEnable = 1;
	gPVSerDesMgr.pvItems[itemIndex].optChangeMonitor.pChangeMonitorMem = &gSerDesMem_gPallete_palCfg;
	gPVSerDesMgr.pvItems[itemIndex].optChangeMonitor.iChangeMonitorMemSize = sizeof(gSerDesMem_gPallete_palCfg);
	//Option: Init PV at Power Up
	gPVSerDesMgr.pvItems[itemIndex].optInitAtPowerUp.iPowerUpConfig = PAI_FS_SERDESMGR_PWRUP_DFLT_fRD;
	gPVSerDesMgr.pvItems[itemIndex].optInitAtPowerUp.iTestData = 0x55555555;
	//gPVSerDesMgr.pvItems[itemIndex].optInitAtPowerUp.pTestDataStorage = &gPallete.palCfg.magicNumber;
	gPVSerDesMgr.pvItems[itemIndex].optInitAtPowerUp.pTestDataStorage = &gMagicRecipe;
	

	//add items as needed
	itemIndex = 4;	
	brsstrcpy((UDINT)gPVSerDesMgr.pvItems[itemIndex].iPVName, (UDINT)"gLayer_L0");
	brsstrcpy((UDINT)gPVSerDesMgr.pvItems[itemIndex].iDevicename, (UDINT)PAI_FS_DEVICE_REC_LAYER);
	brsstrcpy((UDINT)gPVSerDesMgr.pvItems[itemIndex].iFilename, (UDINT)"recLayer.txt");
	gPVSerDesMgr.pvItems[itemIndex].pPV = (UDINT)&gLayer_L0;
	gPVSerDesMgr.pvItems[itemIndex].iPVSize = sizeof(gLayer_L0);
	gPVSerDesMgr.pvItems[itemIndex].pFilebuffer = (UDINT)&fileRWBuffer[0];
	gPVSerDesMgr.pvItems[itemIndex].iFilebufferSize = sizeof(fileRWBuffer);
	gPVSerDesMgr.pvItems[itemIndex].pCallbackSer = (UDINT)paiCBWriteFileSerPV;
	gPVSerDesMgr.pvItems[itemIndex].pCallbackDes = (UDINT)paiCBReadFileDesPV;
	gPVSerDesMgr.pvItems[itemIndex].pCallbackDefault = (UDINT)0;
	//Option: HMI interaction with PV read/write/changed; Allows PV changes to be accepted/rejected
	//gPVSerDesMgr.pvItems[itemIndex].optPtrHMIData = &gSerDesHMI_gConfigApp;
	//Option: Monitor PV changes
	//gPVSerDesMgr.pvItems[itemIndex].optChangeMonitor.iChngEnable = 1;
	//gPVSerDesMgr.pvItems[itemIndex].optChangeMonitor.pChangeMonitorMem = &gSerDesMem_gLayerEditor;
	//gPVSerDesMgr.pvItems[itemIndex].optChangeMonitor.iChangeMonitorMemSize = sizeof(gSerDesMem_gLayerEditor);
	//Option: Init PV at Power Up
	//gPVSerDesMgr.pvItems[itemIndex].optInitAtPowerUp.iPowerUpConfig = PAI_FS_SERDESMGR_PWRUP_DFLT_fRD;
	//gPVSerDesMgr.pvItems[itemIndex].optInitAtPowerUp.iTestData = 0x55555555;
	//gPVSerDesMgr.pvItems[itemIndex].optInitAtPowerUp.pTestDataStorage = &gDummy;
	
	
	//add items as needed
	itemIndex = 5;	
	brsstrcpy((UDINT)gPVSerDesMgr.pvItems[itemIndex].iPVName, (UDINT)"gLayer_L1");
	brsstrcpy((UDINT)gPVSerDesMgr.pvItems[itemIndex].iDevicename, (UDINT)PAI_FS_DEVICE_REC_LAYER);
	brsstrcpy((UDINT)gPVSerDesMgr.pvItems[itemIndex].iFilename, (UDINT)"recLayer.txt");
	gPVSerDesMgr.pvItems[itemIndex].pPV = (UDINT)&gLayer_L1;
	gPVSerDesMgr.pvItems[itemIndex].iPVSize = sizeof(gLayer_L1);
	gPVSerDesMgr.pvItems[itemIndex].pFilebuffer = (UDINT)&fileRWBuffer[0];
	gPVSerDesMgr.pvItems[itemIndex].iFilebufferSize = sizeof(fileRWBuffer);
	gPVSerDesMgr.pvItems[itemIndex].pCallbackSer = (UDINT)paiCBWriteFileSerPV;
	gPVSerDesMgr.pvItems[itemIndex].pCallbackDes = (UDINT)paiCBReadFileDesPV;
	gPVSerDesMgr.pvItems[itemIndex].pCallbackDefault = (UDINT)0;
	//Option: HMI interaction with PV read/write/changed; Allows PV changes to be accepted/rejected
	//gPVSerDesMgr.pvItems[itemIndex].optPtrHMIData = &gSerDesHMI_gConfigApp;
	//Option: Monitor PV changes
	//gPVSerDesMgr.pvItems[itemIndex].optChangeMonitor.iChngEnable = 1;
	//gPVSerDesMgr.pvItems[itemIndex].optChangeMonitor.pChangeMonitorMem = &gSerDesMem_gLayerEditor;
	//gPVSerDesMgr.pvItems[itemIndex].optChangeMonitor.iChangeMonitorMemSize = sizeof(gSerDesMem_gLayerEditor);
	//Option: Init PV at Power Up
	//gPVSerDesMgr.pvItems[itemIndex].optInitAtPowerUp.iPowerUpConfig = PAI_FS_SERDESMGR_PWRUP_DFLT_fRD;
	//gPVSerDesMgr.pvItems[itemIndex].optInitAtPowerUp.iTestData = 0x55555555;
	//gPVSerDesMgr.pvItems[itemIndex].optInitAtPowerUp.pTestDataStorage = &gDummy;
	
	
	//Set number of active items for PVSerDes Mgr
	gPVSerDesMgr.iItemCount = itemIndex + 1;

	//invoke paiSerDesMgr init routine
	paiPVSerDesMgrInit(&gPVSerDesMgr);
}
//EOF
