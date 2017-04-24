
#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
	#include <AsDefault.h>
#endif

#include "../../paiFileService/paiFS/paiFile.h"

/*
###############################################################################
PAI_CONFIGURATION_SECTION
Code below allows configuration for:
mapp components used in this application
###############################################################################
*/

#warning "pai Configuration: mapp Components"

//=============================================================================
//MpCom support
//=============================================================================
static void paiMpComInit()
{
	
	MpComIdentType link;
	link.Internal[0] = mpCOM_MAIN_INT;
	
	gPaiMp.fub.MpComLoggerUI.Enable = 1;
//	gPaiMp.data.MpComIdent.Internal[0] = mpCOM_MAIN_INT;
//	gPaiMp.data.MpComIdent.Internal[1] = 0;
//	gPaiMp.fub.MpComLoggerUI.MpLink = &link;
	gPaiMp.fub.MpComLoggerUI.UIConnect = &gPaiMp.data.MpComLoggerUIConnect;
		
	
	gPaiMp.fub.MpComLoggerUI.UISetup.LoggerListSize = 8;
	gPaiMp.fub.MpComLoggerUI.UISetup.LoggerScrollWindow = 1;
	
	gPaiMp.fub.MpComLoggerUI.Scope = mpCOM_CONFIG_SCOPE_BRANCH;

}

static void paiMpComCyclic()
{
	
	MpComLoggerUI(&gPaiMp.fub.MpComLoggerUI);
	
}

//=============================================================================
//MpAlarm support
//=============================================================================
static void paiMpAlarmInit()
{

}

static void paiMpAlarmCyclic()
{
	MpAlarmBasicUI(&gPaiMp.fub.MpAlarmBasicUI);
}


static void paiMpRecipeInit()
{
	gPaiMp.fub.MpRecipeXml.Enable = 1;
	gPaiMp.fub.MpRecipeXml.MpLink = &gMpLinkMpRecipeXml;
	gPaiMp.fub.MpRecipeXml.DeviceName = PAI_FS_DEVICE_REC;
	gPaiMp.fub.MpRecipeXml.FileName = "recipe";
	
	
	gPaiMp.fub.MpRecipeRegPar.Enable = 1;
	gPaiMp.fub.MpRecipeRegPar.MpLink = &gMpLinkMpRecipeXml;
	gPaiMp.fub.MpRecipeRegPar.PVName = "gRecipe";
	
	gPaiMp.fub.MpRecipeUI.Enable = 1;
	gPaiMp.fub.MpRecipeUI.MpLink = &gMpLinkMpRecipeXml;
	gPaiMp.fub.MpRecipeUI.UISetup.RecipeListSize = 10;
	gPaiMp.fub.MpRecipeUI.UISetup.RecipeListScrollWindow = 1;
	gPaiMp.fub.MpRecipeUI.UISetup.Confirmation.RecipeCreate = 1;
	gPaiMp.fub.MpRecipeUI.UISetup.Confirmation.RecipeLoad = 1;
	gPaiMp.fub.MpRecipeUI.UISetup.Confirmation.RecipeSave = 1;
	
	gPaiMp.fub.MpRecipeUI.UIConnect = &gPaiMp.data.MpRecipeUIConnect;
}

static void paiMpRecipeCustom1Init()
{
	gPaiMp.fub.MpRecipeXmlCustom1.Enable = 1;
	gPaiMp.fub.MpRecipeXmlCustom1.MpLink = &gMpLinkMpRecipeXmlCustom1;
	gPaiMp.fub.MpRecipeXmlCustom1.DeviceName = PAI_FS_DEVICE_REC_LAYER;
	gPaiMp.fub.MpRecipeXmlCustom1.FileName = "recLayer";
	
		
	gPaiMp.fub.MpRecipeUICustom1.Enable = 1;
	gPaiMp.fub.MpRecipeUICustom1.MpLink = &gMpLinkMpRecipeXmlCustom1;
	gPaiMp.fub.MpRecipeUICustom1.UISetup.RecipeListSize = 10;
	gPaiMp.fub.MpRecipeUICustom1.UISetup.RecipeListScrollWindow = 1;
	gPaiMp.fub.MpRecipeUICustom1.UISetup.Confirmation.RecipeCreate = 1;
	gPaiMp.fub.MpRecipeUICustom1.UISetup.Confirmation.RecipeLoad = 1;
	gPaiMp.fub.MpRecipeUICustom1.UISetup.Confirmation.RecipeSave = 1;
	
	gPaiMp.fub.MpRecipeUICustom1.UIConnect = &gPaiMp.data.MpRecipeUIConnectCustom1;
}

static void paiMpRecipeCustom2Init()
{
	gPaiMp.fub.MpRecipeXmlCustom2.Enable = 1;
	gPaiMp.fub.MpRecipeXmlCustom2.MpLink = &gMpLinkMpRecipeXmlCustom2;
	gPaiMp.fub.MpRecipeXmlCustom2.DeviceName = PAI_FS_DEVICE_REC_PALLETE;
	gPaiMp.fub.MpRecipeXmlCustom2.FileName = "recPallete";
	
		
	gPaiMp.fub.MpRecipeUICustom2.Enable = 1;
	gPaiMp.fub.MpRecipeUICustom2.MpLink = &gMpLinkMpRecipeXmlCustom2;
	gPaiMp.fub.MpRecipeUICustom2.UISetup.RecipeListSize = 10;
	gPaiMp.fub.MpRecipeUICustom2.UISetup.RecipeListScrollWindow = 1;
	gPaiMp.fub.MpRecipeUICustom2.UISetup.Confirmation.RecipeCreate = 1;
	gPaiMp.fub.MpRecipeUICustom2.UISetup.Confirmation.RecipeLoad = 1;
	gPaiMp.fub.MpRecipeUICustom2.UISetup.Confirmation.RecipeSave = 1;
	
	gPaiMp.fub.MpRecipeUICustom2.UIConnect = &gPaiMp.data.MpRecipeUIConnectCustom2;
}

static void paiMpRecipeCyclic()
{
	MpRecipeXml(&gPaiMp.fub.MpRecipeXml);
	
	MpRecipeRegPar(&gPaiMp.fub.MpRecipeRegPar);
	
	MpRecipeUI(&gPaiMp.fub.MpRecipeUI);
}

static void paiMpRecipeCustom1Cyclic()
{
	MpRecipeXml(&gPaiMp.fub.MpRecipeXmlCustom1);
	
	//MpRecipeRegPar(&gPaiMp.fub.MpRecipeRegPar);
	
	MpRecipeUI(&gPaiMp.fub.MpRecipeUICustom1);
}

static void paiMpRecipeCustom2Cyclic()
{
	MpRecipeXml(&gPaiMp.fub.MpRecipeXmlCustom2);
	
	//MpRecipeRegPar(&gPaiMp.fub.MpRecipeRegPar);
	
	MpRecipeUI(&gPaiMp.fub.MpRecipeUICustom2);
}

//=============================================================================

static void paiMpFileManagerInit()
{
	brsstrcpy((UDINT)gPaiMp.data.MpFileManagerUIConnect.DeviceList.DeviceNames[0], (UDINT)PAI_FS_DEVICE_ROOT);
	brsstrcpy((UDINT)gPaiMp.data.MpFileManagerUIConnect.DeviceList.DeviceNames[1], (UDINT)PAI_FS_DEVICE_CFG);
	brsstrcpy((UDINT)gPaiMp.data.MpFileManagerUIConnect.DeviceList.DeviceNames[2], (UDINT)PAI_FS_DEVICE_REC);
	brsstrcpy((UDINT)gPaiMp.data.MpFileManagerUIConnect.DeviceList.DeviceNames[3], (UDINT)"USB1");
	brsstrcpy((UDINT)gPaiMp.data.MpFileManagerUIConnect.DeviceList.DeviceNames[4], (UDINT)"USB2");
	
	gPaiMp.fub.MpFileManagerUI.Enable = 1;
	gPaiMp.fub.MpFileManagerUI.MpLink = &gMpLinkMpFileManagerUI;
	gPaiMp.fub.MpFileManagerUI.UIConnect = &gPaiMp.data.MpFileManagerUIConnect;
	gPaiMp.fub.MpFileManagerUI.UISetup.FileListScrollWindow = 1;
	gPaiMp.fub.MpFileManagerUI.UISetup.FileListSize = 8;
	
}

static void paiMpFileManagerCyclic()
{
	MpFileManagerUI(&gPaiMp.fub.MpFileManagerUI);
}
//=============================================================================


void _INIT paiMpInit(void)
{
	paiMpComInit();
	
	paiMpFileManagerInit();
	
	paiMpRecipeInit();
	paiMpRecipeCustom1Init();
	paiMpRecipeCustom2Init();
	
	paiMpAlarmInit();
	
	
}

void _CYCLIC paiMpCyclic(void)
{
	paiMpComCyclic();
	
	paiMpFileManagerCyclic();

	paiMpRecipeCyclic();
	paiMpRecipeCustom1Cyclic();
	paiMpRecipeCustom2Cyclic();
	
	paiMpAlarmCyclic();
	
}
//EOF



