
#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
	#include <AsDefault.h>
#endif


static void paiVFDX64ParNextStation()
{
	gPaiVFDX64Mgr.mCurrentEntry++;
	if(gPaiVFDX64Mgr.mCurrentEntry > paiBnRVFDX64DriveIdxMax){
		gPaiVFDX64Mgr.mCurrentEntry = 0;
	}
}

static void paiVFDX64ParNextParam()
{
	int vfdIdx = gPaiVFDX64Mgr.mCurrentEntry;
	
	gPaiVFDX64Mgr.mX64VFDs[vfdIdx].mCurrentEntry++;
	if(gPaiVFDX64Mgr.mX64VFDs[vfdIdx].mCurrentEntry > paiBnRVFDX64ParamIdxMax){
		gPaiVFDX64Mgr.mX64VFDs[vfdIdx].mCurrentEntry = 0;
		paiVFDX64ParNextStation();
	}
}

static BOOL paiVFDX64IsParamActive(int vfdIdx, int parIdx)
{
BOOL *pModuleOk = 0;
	
	//check module ok ptr
	if(gPaiVFDX64Mgr.mX64VFDs[vfdIdx].iPtrModuleOk){
		pModuleOk = (BOOL*) gPaiVFDX64Mgr.mX64VFDs[vfdIdx].iPtrModuleOk;
	}
	
	//device name not defined > skip to next station
	if(!gPaiVFDX64Mgr.mX64VFDs[vfdIdx].iDeviceName[0]){
		gPaiVFDX64Mgr.mX64VFDs[vfdIdx].mX64Params[parIdx].mState = 0;	
		paiVFDX64ParNextStation();
		return 0;		
	}
		
	//if module ok ptr defined && module is NOT OK > skip to next vfd station
	if(pModuleOk && !(*pModuleOk)){
		gPaiVFDX64Mgr.mX64VFDs[vfdIdx].mX64Params[parIdx].mState = 0;	
		paiVFDX64ParNextStation();
		return 0;
	}
	
	//if RD channel not defined > skip to next param
	if(	!gPaiVFDX64Mgr.mX64VFDs[vfdIdx].mX64Params[parIdx].iChannelNameRD[0]){
		gPaiVFDX64Mgr.mX64VFDs[vfdIdx].mX64Params[parIdx].mState = 0;	
		paiVFDX64ParNextParam();
		return 0;
	}
	
	return 1;
}

static void paiVFDX64SingleParReadCyclic(int vfdIdx, int parIdx)
{
	gPaiVFDX64Mgr.mAsIOAccRd.enable = 1;
	gPaiVFDX64Mgr.mAsIOAccRd.pDeviceName = (UDINT)&gPaiVFDX64Mgr.mX64VFDs[vfdIdx].iDeviceName;
	gPaiVFDX64Mgr.mAsIOAccRd.pChannelName = (UDINT)&gPaiVFDX64Mgr.mX64VFDs[vfdIdx].mX64Params[parIdx].iChannelNameRD;
	
	AsIOAccRead( &gPaiVFDX64Mgr.mAsIOAccRd );
	
	if(gPaiVFDX64Mgr.mAsIOAccRd.status == ERR_FUB_BUSY){
		gPaiVFDX64Mgr.mX64VFDs[vfdIdx].mX64Params[parIdx].mState = 2;
		return;
	}	
	gPaiVFDX64Mgr.mX64VFDs[vfdIdx].mX64Params[parIdx].oStatusRD = gPaiVFDX64Mgr.mAsIOAccRd.status;
	gPaiVFDX64Mgr.mX64VFDs[vfdIdx].mX64Params[parIdx].oValue = gPaiVFDX64Mgr.mAsIOAccRd.value;
	if(!gPaiVFDX64Mgr.mAsIOAccRd.status){
		gPaiVFDX64Mgr.mX64VFDs[vfdIdx].mX64Params[parIdx].mState = 1; //upon sucessful RD, go to idle	
	}else{
		gPaiVFDX64Mgr.mX64VFDs[vfdIdx].mX64Params[parIdx].mState = 2;//try read again
		paiVFDX64ParNextParam();	
	}	
}

static void paiVFDX64SingleParWriteCyclic(int vfdIdx, int parIdx)
{
	gPaiVFDX64Mgr.mAsIOAccWr.enable = 1;
	gPaiVFDX64Mgr.mAsIOAccWr.pDeviceName = (UDINT)&gPaiVFDX64Mgr.mX64VFDs[vfdIdx].iDeviceName;
	gPaiVFDX64Mgr.mAsIOAccWr.pChannelName = (UDINT)&gPaiVFDX64Mgr.mX64VFDs[vfdIdx].mX64Params[parIdx].iChannelNameWR;
	gPaiVFDX64Mgr.mAsIOAccWr.value = (UDINT)gPaiVFDX64Mgr.mX64VFDs[vfdIdx].mX64Params[parIdx].iValueWR;
	
	AsIOAccWrite( &gPaiVFDX64Mgr.mAsIOAccWr );
	
	if(gPaiVFDX64Mgr.mAsIOAccWr.status == ERR_FUB_BUSY){
		gPaiVFDX64Mgr.mX64VFDs[vfdIdx].mX64Params[parIdx].mState = 3;
		return;
	}	
	gPaiVFDX64Mgr.mX64VFDs[vfdIdx].mX64Params[parIdx].oStatusWR = gPaiVFDX64Mgr.mAsIOAccWr.status;
	if(!gPaiVFDX64Mgr.mAsIOAccWr.status){
		gPaiVFDX64Mgr.mX64VFDs[vfdIdx].mX64Params[parIdx].mState = 2;//upon successful WR trigger RD
		paiVFDX64ParNextParam();	
	}else{
		gPaiVFDX64Mgr.mX64VFDs[vfdIdx].mX64Params[parIdx].mState = 1;	
	}	
}

static void paiVFDX64ParamRWCyclic()
{
	int vfdIdx = gPaiVFDX64Mgr.mCurrentEntry;
	int parIdx = gPaiVFDX64Mgr.mX64VFDs[vfdIdx].mCurrentEntry;
	
	if( !paiVFDX64IsParamActive(vfdIdx, parIdx) ){
		return;
	} 
		
	//Param access state machine
	//0-init not completed, RD needed
	//1-idle
	//2-rd in progress
	//3-wr in progress
	switch(gPaiVFDX64Mgr.mX64VFDs[vfdIdx].mX64Params[parIdx].mState){
		case 0:
			//init
			gPaiVFDX64Mgr.mX64VFDs[vfdIdx].mX64Params[parIdx].mState = 2;//activate RD
			break;
		case 1:
			//idle(rd not required)
			gPaiVFDX64Mgr.mAsIOAccRd.enable = 0;
			AsIOAccRead( &gPaiVFDX64Mgr.mAsIOAccRd );
			
			gPaiVFDX64Mgr.mAsIOAccWr.enable = 0;
			AsIOAccWrite( &gPaiVFDX64Mgr.mAsIOAccWr );		
			
			//check if write required?
			if(gPaiVFDX64Mgr.mX64VFDs[vfdIdx].mX64Params[parIdx].oValue != gPaiVFDX64Mgr.mX64VFDs[vfdIdx].mX64Params[parIdx].iValueWR){
				//write is required
				gPaiVFDX64Mgr.mX64VFDs[vfdIdx].mX64Params[parIdx].mState = 3;//activate WR
			}		
			//process next item
			paiVFDX64ParNextParam();
			return;
			break;
		case 2:
			//read in progress
			paiVFDX64SingleParReadCyclic(vfdIdx, parIdx);
			break;
		case 3:
			//write in progress
			paiVFDX64SingleParWriteCyclic(vfdIdx, parIdx);
			break;
		default:
			return;
			break;
	}		
}

static void paiVFDX64ParamConfigWrite()
{
	//Copy configuration parameters from the config to the VFD WR parameter channel
	
#if 0	
	//VFD accelration
	gPaiVFDX64Mgr.mX64VFDs[0].mX64Params[0].iValueWR = gConfigApp.vfd[1].acc;
	gPaiVFDX64Mgr.mX64VFDs[1].mX64Params[0].iValueWR = gConfigApp.vfd[2].acc;
	gPaiVFDX64Mgr.mX64VFDs[2].mX64Params[0].iValueWR = gConfigApp.vfd[5].acc;
	gPaiVFDX64Mgr.mX64VFDs[3].mX64Params[0].iValueWR = gConfigApp.vfd[6].acc;
	gPaiVFDX64Mgr.mX64VFDs[4].mX64Params[0].iValueWR = gConfigApp.vfd[11].acc;
	gPaiVFDX64Mgr.mX64VFDs[5].mX64Params[0].iValueWR = gConfigApp.vfd[12].acc;
	

	//VFD deceleration
	gPaiVFDX64Mgr.mX64VFDs[0].mX64Params[1].iValueWR = gConfigApp.vfd[1].dec;
	gPaiVFDX64Mgr.mX64VFDs[1].mX64Params[1].iValueWR = gConfigApp.vfd[2].dec;
	gPaiVFDX64Mgr.mX64VFDs[2].mX64Params[1].iValueWR = gConfigApp.vfd[5].dec;
	gPaiVFDX64Mgr.mX64VFDs[3].mX64Params[1].iValueWR = gConfigApp.vfd[6].dec;
	gPaiVFDX64Mgr.mX64VFDs[4].mX64Params[1].iValueWR = gConfigApp.vfd[11].dec;
	gPaiVFDX64Mgr.mX64VFDs[5].mX64Params[1].iValueWR = gConfigApp.vfd[12].dec;
#endif
	
	//VFD accelration
	gPaiVFDX64Mgr.mX64VFDs[0].mX64Params[0].iValueWR = gPallete.palCfg.palSettings.vfd[1].acc;
	gPaiVFDX64Mgr.mX64VFDs[1].mX64Params[0].iValueWR = gPallete.palCfg.palSettings.vfd[2].acc;
	gPaiVFDX64Mgr.mX64VFDs[2].mX64Params[0].iValueWR = gPallete.palCfg.palSettings.vfd[5].acc;
	gPaiVFDX64Mgr.mX64VFDs[3].mX64Params[0].iValueWR = gPallete.palCfg.palSettings.vfd[6].acc;
	gPaiVFDX64Mgr.mX64VFDs[4].mX64Params[0].iValueWR = gPallete.palCfg.palSettings.vfd[11].acc;
	gPaiVFDX64Mgr.mX64VFDs[5].mX64Params[0].iValueWR = gPallete.palCfg.palSettings.vfd[12].acc;
	

	//VFD deceleration
	gPaiVFDX64Mgr.mX64VFDs[0].mX64Params[1].iValueWR = gPallete.palCfg.palSettings.vfd[1].dec;
	gPaiVFDX64Mgr.mX64VFDs[1].mX64Params[1].iValueWR = gPallete.palCfg.palSettings.vfd[2].dec;
	gPaiVFDX64Mgr.mX64VFDs[2].mX64Params[1].iValueWR = gPallete.palCfg.palSettings.vfd[5].dec;
	gPaiVFDX64Mgr.mX64VFDs[3].mX64Params[1].iValueWR = gPallete.palCfg.palSettings.vfd[6].dec;
	gPaiVFDX64Mgr.mX64VFDs[4].mX64Params[1].iValueWR = gPallete.palCfg.palSettings.vfd[11].dec;
	gPaiVFDX64Mgr.mX64VFDs[5].mX64Params[1].iValueWR = gPallete.palCfg.palSettings.vfd[12].dec;
	
	
}


void _INIT paiVFDX64ParRWInit(void)
{
	// Insert code here 

	brsstrcpy((UDINT)&gPaiVFDX64Mgr.mX64VFDs[0].iDeviceName, (UDINT)"IF5.ST9");
	brsstrcpy((UDINT)&gPaiVFDX64Mgr.mX64VFDs[0].iDescription, (UDINT)"VFD1");
	gPaiVFDX64Mgr.mX64VFDs[0].iPtrModuleOk = (UDINT)&gHWModules[9].ModuleOk;
	brsstrcpy((UDINT)&gPaiVFDX64Mgr.mX64VFDs[0].mX64Params[0].iChannelNameRD , (UDINT)"ACC_Input");
	brsstrcpy((UDINT)&gPaiVFDX64Mgr.mX64VFDs[0].mX64Params[0].iChannelNameWR , (UDINT)"ACC_Output");
	brsstrcpy((UDINT)&gPaiVFDX64Mgr.mX64VFDs[0].mX64Params[1].iChannelNameRD , (UDINT)"DEC_Input");
	brsstrcpy((UDINT)&gPaiVFDX64Mgr.mX64VFDs[0].mX64Params[1].iChannelNameWR , (UDINT)"DEC_Output");
	
	brsstrcpy((UDINT)&gPaiVFDX64Mgr.mX64VFDs[1].iDeviceName, (UDINT)"IF5.ST10");
	brsstrcpy((UDINT)&gPaiVFDX64Mgr.mX64VFDs[1].iDescription, (UDINT)"VFD2");
	gPaiVFDX64Mgr.mX64VFDs[1].iPtrModuleOk = (UDINT)&gHWModules[10].ModuleOk;
	brsstrcpy((UDINT)&gPaiVFDX64Mgr.mX64VFDs[1].mX64Params[0].iChannelNameRD , (UDINT)"ACC_Input");
	brsstrcpy((UDINT)&gPaiVFDX64Mgr.mX64VFDs[1].mX64Params[0].iChannelNameWR , (UDINT)"ACC_Output");
	brsstrcpy((UDINT)&gPaiVFDX64Mgr.mX64VFDs[1].mX64Params[1].iChannelNameRD , (UDINT)"DEC_Input");
	brsstrcpy((UDINT)&gPaiVFDX64Mgr.mX64VFDs[1].mX64Params[1].iChannelNameWR , (UDINT)"DEC_Output");

	brsstrcpy((UDINT)&gPaiVFDX64Mgr.mX64VFDs[2].iDeviceName, (UDINT)"IF5.ST11");
	brsstrcpy((UDINT)&gPaiVFDX64Mgr.mX64VFDs[2].iDescription, (UDINT)"VFD5");
	gPaiVFDX64Mgr.mX64VFDs[2].iPtrModuleOk = (UDINT)&gHWModules[11].ModuleOk;
	brsstrcpy((UDINT)&gPaiVFDX64Mgr.mX64VFDs[2].mX64Params[0].iChannelNameRD , (UDINT)"ACC_Input");
	brsstrcpy((UDINT)&gPaiVFDX64Mgr.mX64VFDs[2].mX64Params[0].iChannelNameWR , (UDINT)"ACC_Output");
	brsstrcpy((UDINT)&gPaiVFDX64Mgr.mX64VFDs[2].mX64Params[1].iChannelNameRD , (UDINT)"DEC_Input");
	brsstrcpy((UDINT)&gPaiVFDX64Mgr.mX64VFDs[2].mX64Params[1].iChannelNameWR , (UDINT)"DEC_Output");

	brsstrcpy((UDINT)&gPaiVFDX64Mgr.mX64VFDs[3].iDeviceName, (UDINT)"IF5.ST12");
	brsstrcpy((UDINT)&gPaiVFDX64Mgr.mX64VFDs[3].iDescription, (UDINT)"VFD52");
	gPaiVFDX64Mgr.mX64VFDs[3].iPtrModuleOk = (UDINT)&gHWModules[12].ModuleOk;
	brsstrcpy((UDINT)&gPaiVFDX64Mgr.mX64VFDs[3].mX64Params[0].iChannelNameRD , (UDINT)"ACC_Input");
	brsstrcpy((UDINT)&gPaiVFDX64Mgr.mX64VFDs[3].mX64Params[0].iChannelNameWR , (UDINT)"ACC_Output");
	brsstrcpy((UDINT)&gPaiVFDX64Mgr.mX64VFDs[3].mX64Params[1].iChannelNameRD , (UDINT)"DEC_Input");
	brsstrcpy((UDINT)&gPaiVFDX64Mgr.mX64VFDs[3].mX64Params[1].iChannelNameWR , (UDINT)"DEC_Output");

	brsstrcpy((UDINT)&gPaiVFDX64Mgr.mX64VFDs[4].iDeviceName, (UDINT)"IF5.ST13");
	brsstrcpy((UDINT)&gPaiVFDX64Mgr.mX64VFDs[4].iDescription, (UDINT)"VFD11");
	gPaiVFDX64Mgr.mX64VFDs[4].iPtrModuleOk = (UDINT)&gHWModules[13].ModuleOk;
	brsstrcpy((UDINT)&gPaiVFDX64Mgr.mX64VFDs[4].mX64Params[0].iChannelNameRD , (UDINT)"ACC_Input");
	brsstrcpy((UDINT)&gPaiVFDX64Mgr.mX64VFDs[4].mX64Params[0].iChannelNameWR , (UDINT)"ACC_Output");
	brsstrcpy((UDINT)&gPaiVFDX64Mgr.mX64VFDs[4].mX64Params[1].iChannelNameRD , (UDINT)"DEC_Input");
	brsstrcpy((UDINT)&gPaiVFDX64Mgr.mX64VFDs[4].mX64Params[1].iChannelNameWR , (UDINT)"DEC_Output");

	brsstrcpy((UDINT)&gPaiVFDX64Mgr.mX64VFDs[5].iDeviceName, (UDINT)"IF5.ST14");
	brsstrcpy((UDINT)&gPaiVFDX64Mgr.mX64VFDs[5].iDescription, (UDINT)"VFD12");
	gPaiVFDX64Mgr.mX64VFDs[5].iPtrModuleOk = (UDINT)&gHWModules[14].ModuleOk;
	brsstrcpy((UDINT)&gPaiVFDX64Mgr.mX64VFDs[5].mX64Params[0].iChannelNameRD , (UDINT)"ACC_Input");
	brsstrcpy((UDINT)&gPaiVFDX64Mgr.mX64VFDs[5].mX64Params[0].iChannelNameWR , (UDINT)"ACC_Output");
	brsstrcpy((UDINT)&gPaiVFDX64Mgr.mX64VFDs[5].mX64Params[1].iChannelNameRD , (UDINT)"DEC_Input");
	brsstrcpy((UDINT)&gPaiVFDX64Mgr.mX64VFDs[5].mX64Params[1].iChannelNameWR , (UDINT)"DEC_Output");
}

void _CYCLIC paiVFDX64ParRWCyclic(void)
{
	// Insert code here 
	
		
	paiVFDX64ParamConfigWrite();
	
	
	paiVFDX64ParamRWCyclic();
}
//eof
