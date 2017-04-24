
#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
	#include <AsDefault.h>
#endif

/*
16#0000	nOF: No fault code saved
16#1000	CrF: Capacitor pre-charge detected fault or
16#1000	OLF: Motor overload or
16#1000	SOF: Motor overspeed
16#2310	OCF: Overcurrent
16#2320	OCF: Impeding short-circuit or
16#2320	OCF: Power module, specific to 15kW drives
16#2330	SCF: Motor short-circuit (to ground)
16#2340	OCF: Motor short-circuit (phase to phase)
16#3110	OSF: Line supply overvoltage
16#3120	USF: Line supply undervoltage
16#3130	PHF: Line supply phase loss
16#3310	ObF: DC bus overvoltage or
16#3310	OPF: Motor phase loss or
16#3310	OPF: Motor phase loss - 3 phases
16#4210	OHF: Drive overheating
16#5520	EEF: EEPROM memory
16#6100	InF: Internal
16#6300	CFF: Incorrect configuration (parameters) or
16#6300	CFI: Invalid configuration (parameters)
16#7300	LFF: 4 - 20 mA loss
16#7510	SLF: Modbus communication interruption
16#8100	COF: Communication interruption, line 2 (CANopen)
16#9000	EPF: External fault
16#FF00	tnF: Auto-tuning was unsuccessful
16#FF01	bLF: Brake control
16#7520	ILF: Optional internal link
16#7510	CNF: Communication interruption on the communication card
*/
static void paiVFDGetFaultText(UINT faultCode, char* pDest, UDINT destSize)
{
	
	switch(faultCode){
		case 0x0:
			brsstrcpy((UDINT)pDest, (UDINT)"nOF: No fault code saved");
			break;
		case 0x1000:
			brsstrcpy((UDINT)pDest, (UDINT)"CrF or OLF or SOF");
			break;
		case 0x2310:
			brsstrcpy((UDINT)pDest, (UDINT)"OCF: Overcurrent");
			break;
		case 0x2320:
			brsstrcpy((UDINT)pDest, (UDINT)"OCF: Impeding short-circuit");
			break;
		case 0x2330:
			brsstrcpy((UDINT)pDest, (UDINT)"SCF: Motor short-circuit (to ground)");
			break;
		case 0x2340:
			brsstrcpy((UDINT)pDest, (UDINT)"OCF: Motor short-circuit (phase to phase)");
			break;
		case 0x3110:
			brsstrcpy((UDINT)pDest, (UDINT)"OSF: Line supply overvoltage");
			break;
		case 0x3120:
			brsstrcpy((UDINT)pDest, (UDINT)"USF: Line supply undervoltage");
			break;
		case 0x3130:
			brsstrcpy((UDINT)pDest, (UDINT)"PHF: Line supply phase loss");
			break;
		case 0x3310:
			brsstrcpy((UDINT)pDest, (UDINT)"ObF: DC bus overvoltage or OPF");
			break;
		case 0x4210:
			brsstrcpy((UDINT)pDest, (UDINT)"OHF: Drive overheating");
			break;
		case 0x5520:
			brsstrcpy((UDINT)pDest, (UDINT)"EEF: EEPROM memory");
			break;
		case 0x6100:
			brsstrcpy((UDINT)pDest, (UDINT)"InF: Internal");
			break;
		case 0x6300:
			brsstrcpy((UDINT)pDest, (UDINT)"CFF: Incorrect configuration or CFI");
			break;
		case 0x7300:
			brsstrcpy((UDINT)pDest, (UDINT)"LFF: 4 - 20 mA loss");
			break;
		case 0x7510:
			brsstrcpy((UDINT)pDest, (UDINT)"SLF: Modbus communication interruption");
			break;
		case 0x8100:
			brsstrcpy((UDINT)pDest, (UDINT)"COF: Communication interruption, line 2 (CANopen)");
			break;
		case 0x9000:
			brsstrcpy((UDINT)pDest, (UDINT)"EPF: External fault");
			break;
		case 0xFF00:
			brsstrcpy((UDINT)pDest, (UDINT)"tnF: Auto-tuning was unsuccessful");
			break;
		case 0xFF01:
			brsstrcpy((UDINT)pDest, (UDINT)"bLF: Brake control");
			break;
		default:
			brsstrcpy((UDINT)pDest, (UDINT)"Unknown fault");
			break;
	}
}
	
static void paiVFDShutOff(paiVFD_typ* p)
{
	p->vfdOut.Control.DisableVoltage = 0;
	p->vfdOut.Control.SwitchOn = 0;
	p->vfdOut.Control.VelocitySetpoint = 0;
	p->vfdOut.Control.EnableOperation = 0;
	p->vfdOut.Control.QuickStop = 0;
	
	p->vfdCtrl.oFault = 0;
	p->vfdCtrl.oReady = 0;
	p->vfdCtrl.oRunning = 0;
	
	if(!p->vfdIn.ModuleInfo.ModuleOk){
		brsstrcpy((UDINT)p->stateText, (UDINT)"Not present");	
	}else{
		brsstrcpy((UDINT)p->stateText, (UDINT)"Off Line");		
	}
}


static void paiVFDCyclic(paiVFD_typ* p)
{
	if(!p)
		return;
	
	if(!p->vfdIn.ModuleInfo.ModuleOk || !p->vfdCtrl.iVoltageEnable){
		paiVFDShutOff(p);
		return;
	}
	
//	if(!p->vfdCtrl.iEnable){
//		paiVFDShutOff(p);
//		return;
//	}
	
	p->vfdOut.Control.DisableVoltage = 1;
	p->vfdOut.Control.QuickStop = !p->vfdCtrl.iEStop;
	p->vfdOut.Control.SwitchOn = p->vfdIn.Status.ReadyToSwitchOn;
//	p->vfdOut.Control.EnableOperation = p->vfdIn.Status.SwitchedOn & ( (p->vfdCtrl.iEnable & p->vfdCtrl.iMoveFwd) || ((p->vfdCtrl.iEnable & p->vfdCtrl.iMoveRev)) );
	
	
	//IMPORTANT: work around for getting the drive to stop very quickly. No decel would stop it!
#if 0	
	if(p->appID == 6){
		p->vfdOut.Control.EnableOperation = p->vfdIn.Status.SwitchedOn & p->vfdCtrl.iEnable & (p->vfdCtrl.iMoveFwd || p->vfdCtrl.iMoveRev /*|| (p->vfdIn.Status.CurrentVelocity != 0)*/ );	
	}else{
		p->vfdOut.Control.EnableOperation = p->vfdIn.Status.SwitchedOn & p->vfdCtrl.iEnable & (p->vfdCtrl.iMoveFwd || p->vfdCtrl.iMoveRev || (p->vfdIn.Status.CurrentVelocity != 0) );		
	}
#endif
	//Following code allows stopping very fast if dec set to 1. Otherwise, the VFD decel ramp is used; Only used for VFD2 and VFD52
	if(  ((p->appID == 6) /*&& (gPaiVFDX64Mgr.mX64VFDs[3].mX64Params[1].oValue == 1)*/) || //VFD52
		 ((p->appID == 2) && (gPaiVFDX64Mgr.mX64VFDs[1].mX64Params[1].oValue == 1)) || //VFD2
		 ((p->appID == 5) && (gPaiVFDX64Mgr.mX64VFDs[2].mX64Params[1].oValue == 1))  //VFD5
		){  
		p->vfdOut.Control.EnableOperation = p->vfdIn.Status.SwitchedOn & p->vfdCtrl.iEnable & (p->vfdCtrl.iMoveFwd || p->vfdCtrl.iMoveRev /*|| (p->vfdIn.Status.CurrentVelocity != 0)*/ );	
	}else{
		p->vfdOut.Control.EnableOperation = p->vfdIn.Status.SwitchedOn & p->vfdCtrl.iEnable & (p->vfdCtrl.iMoveFwd || p->vfdCtrl.iMoveRev || (p->vfdIn.Status.CurrentVelocity != 0) );		
	}
	
	
	
	//p->vfdOut.Control.EnableOperation = p->vfdIn.Status.SwitchedOn & p->vfdCtrl.iEnable;
	//	p->vfdOut.Control.RunAsked = p->vfdCtrl.iMoveFwd || p->vfdCtrl.iMoveRev;
	if(p->vfdCtrl.iMoveFwd){
		p->vfdOut.Control.Direction = 0;		
	}else
	if(p->vfdCtrl.iMoveRev){
		p->vfdOut.Control.Direction = 1;
	}else{
		p->vfdOut.Control.Direction = 0;			
	}
	
	if(p->vfdCtrl.iMoveRev || p->vfdCtrl.iMoveFwd){
		p->vfdOut.Control.VelocitySetpoint = p->vfdCtrl.iVelocitySetPoint;	
	}else{
		p->vfdOut.Control.VelocitySetpoint = 0;	
	}
	
	//p->vfdOut.Control.VelocitySetpoint = p->vfdCtrl.iVelocitySetPoint;
	p->vfdOut.Control.FaultReset = p->vfdCtrl.iFaultReset;
	p->vfdCtrl.oFault = p->vfdIn.Status.FaultDetection;
	p->vfdCtrl.oReady = p->vfdIn.Status.SwitchedOn;
	p->vfdCtrl.oRunning = (p->vfdIn.Status.CurrentVelocity != 0) ? 1 : 0;

	if(!p->vfdIn.Status.SwitchedOn){
		brsstrcpy((UDINT)p->stateText, (UDINT)"Not ready");			
	}else
	if(p->vfdIn.Status.FaultDetection){
		brsstrcpy((UDINT)p->stateText, (UDINT)"Fault");
		paiVFDGetFaultText(p->vfdIn.Fault.CurrentFault, &p->vfdIn.Fault.CurrentFaultTxt[0], 63);	
	}else
	if(p->vfdCtrl.oRunning){
		char velocityRpmTxt[32];
		brsitoa((UDINT)p->vfdIn.Status.CurrentVelocity, (UDINT)velocityRpmTxt);
		if(p->vfdIn.Status.CurrentVelocity > 0){
			brsstrcpy((UDINT)p->stateText, (UDINT)"MoveFwd @ ");			
			brsstrcat((UDINT)p->stateText, (UDINT)velocityRpmTxt);			
			brsstrcat((UDINT)p->stateText, (UDINT)"[rpm]");			
		}else{
			brsstrcpy((UDINT)p->stateText, (UDINT)"MoveRev @ ");			
			brsstrcat((UDINT)p->stateText, (UDINT)velocityRpmTxt);			
			brsstrcat((UDINT)p->stateText, (UDINT)"[rpm]");			
		}
	}else{
		brsstrcpy((UDINT)p->stateText, (UDINT)"Stopped");			
	}
}

/*
###############################################################################
Init, Cyclic, Exit
###############################################################################
*/
void _INIT vfdControlInit(void)
{
	int ii;
	
	//on power up > remove all VFD-s, make them "not present"
	for(ii=0; ii<=APP_VFD_IDXLAST;ii++){
		gMachineVFD[ii].vfdCtrl.iVoltageEnable = 0;
		brsstrcpy((UDINT)gMachineVFD[ii].description, (UDINT)"unused VFD control entry");
	}
	
	
	//define, designate and allow operation for VFD-s that are used in this application 
	
	//IMPORTANT: VFD1 is configured to automaticaly control VFD DO (digital output) as a break control output
	//see VFD configuration; param BLC is set to DO
//	gMachineVFD[1].vfdCtrl.iVoltageEnable = 1;
	brsstrcpy((UDINT)gMachineVFD[1].description, (UDINT)"VFD1-Elevator");
	
	//IMPORTANT: VFD2 is configured to automaticaly control VFD DO (digital output) as a break control output
	//see VFD configuration; param BLC is set to DO
//	gMachineVFD[2].vfdCtrl.iVoltageEnable = 1;
	brsstrcpy((UDINT)gMachineVFD[2].description, (UDINT)"VFD2-Transfer Table");
	
	//IMPORTANT: VFD4 is configured to automaticaly control VFD DO (digital output) as a break control output
	//see VFD configuration; param BLC is set to DO
//	gMachineVFD[4].vfdCtrl.iVoltageEnable = 1;
//	brsstrcpy((UDINT)gMachineVFD[4].description, (UDINT)"VFD4-Row Pusher");
	brsstrcpy((UDINT)gMachineVFD[5].description, (UDINT)"VFD5-RowFormingRollers");
	brsstrcpy((UDINT)gMachineVFD[6].description, (UDINT)"VFD52-RowFormingRollers");
	
//	gMachineVFD[11].vfdCtrl.iVoltageEnable = 1;
	brsstrcpy((UDINT)gMachineVFD[11].description, (UDINT)"VFD11-Palletizing Mesh CV");
	brsstrcpy((UDINT)gMachineVFD[12].description, (UDINT)"VFD11-Discharge Mesh CV");
}

void _CYCLIC vfdControlCyclic(void)
{
	int ii;
	
	//cyclicly copy VFD HW status to the VFD control structure
	//Note:
	//VFD1 (designated in the schematic under that name) has an X2X address 8 (station 8). See X2X network diagram
	//VFD2 (designated in the schematic under that name) has an X2X address 9 (station 9). See X2X network diagram
	//etc
	brsmemcpy((UDINT)&gMachineVFD[1].vfdIn.ModuleInfo, (UDINT)&gHWModules[9], sizeof(gMachineVFD[1].vfdIn.ModuleInfo));
	brsmemcpy((UDINT)&gMachineVFD[2].vfdIn.ModuleInfo, (UDINT)&gHWModules[10], sizeof(gMachineVFD[1].vfdIn.ModuleInfo));
	//brsmemcpy((UDINT)&gMachineVFD[4].vfdIn.ModuleInfo, (UDINT)&gHWModules[11], sizeof(gMachineVFD[1].vfdIn.ModuleInfo));
	brsmemcpy((UDINT)&gMachineVFD[5].vfdIn.ModuleInfo, (UDINT)&gHWModules[11], sizeof(gMachineVFD[1].vfdIn.ModuleInfo));
	brsmemcpy((UDINT)&gMachineVFD[6].vfdIn.ModuleInfo, (UDINT)&gHWModules[12], sizeof(gMachineVFD[1].vfdIn.ModuleInfo));
	brsmemcpy((UDINT)&gMachineVFD[11].vfdIn.ModuleInfo, (UDINT)&gHWModules[13], sizeof(gMachineVFD[1].vfdIn.ModuleInfo));
	brsmemcpy((UDINT)&gMachineVFD[12].vfdIn.ModuleInfo, (UDINT)&gHWModules[14], sizeof(gMachineVFD[1].vfdIn.ModuleInfo));
	
	gMachineVFD[1].vfdCtrl.iVoltageEnable = gCtrl.main.EStopOk;
	gMachineVFD[2].vfdCtrl.iVoltageEnable = gCtrl.main.EStopOk;
	//gMachineVFD[4].vfdCtrl.iVoltageEnable = gCtrl.main.EStopOk;
	gMachineVFD[5].vfdCtrl.iVoltageEnable = gCtrl.main.EStopOk;
	gMachineVFD[6].vfdCtrl.iVoltageEnable = gCtrl.main.EStopOk;
	gMachineVFD[11].vfdCtrl.iVoltageEnable = gCtrl.main.EStopOk;
	gMachineVFD[12].vfdCtrl.iVoltageEnable = gCtrl.main.EStopOk;
	
	//operate IO for all VFD-s
	for(ii=0; ii<=APP_VFD_IDXLAST;ii++){
		paiVFDCyclic(&gMachineVFD[ii]);	
	}
}
