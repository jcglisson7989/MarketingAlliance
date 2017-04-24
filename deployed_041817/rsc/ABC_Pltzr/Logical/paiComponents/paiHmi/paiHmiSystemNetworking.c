/********************************************************************
 * COPYRIGHT -- pai
 ********************************************************************
 * Program: hmilogic
 * File: hmiAlert.c
 * Author: goran
 * Created: September 05, 2013
 *******************************************************************/

#include <bur/plctypes.h>
#ifdef _DEFAULT_INCLUDES
	#include <AsDefault.h>
#endif

static void paiConvertIpAddrStrToDigits(char* ipAddr, USINT* pDigits);


/*
retrieve ip cfg from the device (current values)
*/
static int paiGetDeviceIpCfgData(paiHmiSystemNetworking_typ* p)
{
paiARNetworkAddress_typ* pNWCfg;
char errorText[32];
int ret_value = 0;

	if(!p)
		return -1;
	
	if(!p->iPtrNWConfig){
		p->oError = 1;
		brsstrcpy((UDINT)p->oErrorText, (UDINT)"iPtrNWConfig=???");
		return -1;
	}
		
	pNWCfg = p->iPtrNWConfig;	
	brsstrcpy((UDINT)p->oCurrentNWSettings.ethDevice, (UDINT)pNWCfg->ethDevice);

	p->mGetIpAddr.enable = 1;
	p->mGetIpAddr.pDevice = (UDINT)p->oCurrentNWSettings.ethDevice;
	p->mGetIpAddr.pIPAddr = (UDINT)p->oCurrentNWSettings.ipAddr;
	p->mGetIpAddr.Len = sizeof(p->oCurrentNWSettings.ipAddr);
	CfgGetIPAddr(&p->mGetIpAddr);
	
	p->mGetSubnetMask.enable = 1;
	p->mGetSubnetMask.pDevice = (UDINT)p->oCurrentNWSettings.ethDevice;
	p->mGetSubnetMask.pSubnetMask = (UDINT)p->oCurrentNWSettings.netMask;
	p->mGetSubnetMask.Len = sizeof(p->oCurrentNWSettings.netMask);
	CfgGetSubnetMask(&p->mGetSubnetMask);
	
	p->mGetBroadcastAddr.enable = 1;
	p->mGetBroadcastAddr.pDevice = (UDINT)p->oCurrentNWSettings.ethDevice;
	p->mGetBroadcastAddr.pBroadcastAddr = (UDINT)p->oCurrentNWSettings.broadcast;
	p->mGetBroadcastAddr.Len = sizeof(p->oCurrentNWSettings.broadcast);
	CfgGetBroadcastAddr(&p->mGetBroadcastAddr);
	
	p->mGetDefaultGateway.enable = 1;
	p->mGetDefaultGateway.pDevice = (UDINT)p->oCurrentNWSettings.ethDevice;
	p->mGetDefaultGateway.pGateway = (UDINT)p->oCurrentNWSettings.gateway;
	p->mGetDefaultGateway.Len = sizeof(p->oCurrentNWSettings.gateway);
	CfgGetDefaultGateway(&p->mGetDefaultGateway);
	
	
	p->mGetHostName.enable = 1;
	p->mGetHostName.pHostName = (UDINT)p->oCurrentNWSettings.hostname;
	p->mGetHostName.Len = sizeof(p->oCurrentNWSettings.hostname);
	CfgGetHostName(&p->mGetHostName);
	
	if( (p->mGetIpAddr.status == ERR_FUB_BUSY) ||
		(p->mGetSubnetMask.status == ERR_FUB_BUSY) ||
		(p->mGetBroadcastAddr.status == ERR_FUB_BUSY) ||
		(p->mGetHostName.status == ERR_FUB_BUSY) ||
		(p->mGetDefaultGateway.status == ERR_FUB_BUSY) 
	){
		return 1; //wait
	}
	
	if( (p->mGetIpAddr.status == ERR_OK) &&
		(p->mGetSubnetMask.status == ERR_OK) &&
		(p->mGetBroadcastAddr.status == ERR_OK) &&
		(p->mGetHostName.status == ERR_OK) &&
		(p->mGetDefaultGateway.status == ERR_OK) 
	){
		p->oError = 0;
		p->oErrorText[0] = 0;
		ret_value = 0; //done; no errors
		goto exit_label;
	}
	
	p->oError = 2;
	p->oErrorText[0] = 0;
	if(p->mGetIpAddr.status != ERR_OK){
		brsitoa((UDINT)p->mGetIpAddr.status , (UDINT)errorText);
		brsstrcat((UDINT)p->oErrorText, (UDINT)"ipaddr=");
		brsstrcat((UDINT)p->oErrorText, (UDINT)errorText);
		brsstrcat((UDINT)p->oErrorText, (UDINT)",");
	}
	if(p->mGetSubnetMask.status != ERR_OK){
		brsitoa((UDINT)p->mGetSubnetMask.status , (UDINT)errorText);
		brsstrcat((UDINT)p->oErrorText, (UDINT)"mask=");
		brsstrcat((UDINT)p->oErrorText, (UDINT)errorText);
		brsstrcat((UDINT)p->oErrorText, (UDINT)",");
	}
	if(p->mGetBroadcastAddr.status != ERR_OK){
		brsitoa((UDINT)p->mGetBroadcastAddr.status , (UDINT)errorText);
		brsstrcat((UDINT)p->oErrorText, (UDINT)"bcast=");
		brsstrcat((UDINT)p->oErrorText, (UDINT)errorText);
		brsstrcat((UDINT)p->oErrorText, (UDINT)",");
		brsstrcat((UDINT)p->oCurrentNWSettings.broadcast, (UDINT)"=");
		brsstrcat((UDINT)p->oCurrentNWSettings.broadcast, (UDINT)errorText);		
	}
	if(p->mGetDefaultGateway.status != ERR_OK){
		brsitoa((UDINT)p->mGetDefaultGateway.status , (UDINT)errorText);
		brsstrcat((UDINT)p->oErrorText, (UDINT)"gateway=");
		brsstrcat((UDINT)p->oErrorText, (UDINT)errorText);
		brsstrcat((UDINT)p->oErrorText, (UDINT)",");
		brsstrcat((UDINT)p->oCurrentNWSettings.gateway, (UDINT)"=");
		brsstrcat((UDINT)p->oCurrentNWSettings.gateway, (UDINT)errorText);		
	}
	if(p->mGetHostName.status != ERR_OK){
		brsitoa((UDINT)p->mGetHostName.status , (UDINT)errorText);
		brsstrcat((UDINT)p->oErrorText, (UDINT)"host=");
		brsstrcat((UDINT)p->oErrorText, (UDINT)errorText);
		brsstrcat((UDINT)p->oErrorText, (UDINT)",");
	}
	
	ret_value = -1; //done; with errors
		
exit_label:

	//turn off fbk-s
	p->mGetIpAddr.enable = 0;
	CfgGetIPAddr(&p->mGetIpAddr);
	
	p->mGetSubnetMask.enable = 0;
	CfgGetSubnetMask(&p->mGetSubnetMask);
	
	p->mGetBroadcastAddr.enable = 0;
	CfgGetBroadcastAddr(&p->mGetBroadcastAddr);
	
	p->mGetDefaultGateway.enable = 0;
	CfgGetDefaultGateway(&p->mGetDefaultGateway);
		
	p->mGetHostName.enable = 0;
	CfgGetHostName(&p->mGetHostName);
	
	//generate numerical version for all network addresses (for HMI editing)
	paiConvertIpAddrStrToDigits(p->oCurrentNWSettings.ipAddr, p->oNumericalNWSettings.ipAddr);
	paiConvertIpAddrStrToDigits(p->oCurrentNWSettings.broadcast, p->oNumericalNWSettings.broadcast);
	paiConvertIpAddrStrToDigits(p->oCurrentNWSettings.gateway, p->oNumericalNWSettings.gateway);
	paiConvertIpAddrStrToDigits(p->oCurrentNWSettings.netMask, p->oNumericalNWSettings.netMask);
	
	
	return ret_value;
}
#if 0

/*
set device ip cfg data
*/
static int paiCfgSetDeviceIpCfgData(paiHmiSystemNetworking_typ* p)
{
	return 0;
  if(cfg->setIpAddr.status == 0xFFFF)   {               //  WBR:  set in previous state if cfgIP != devIP
  // if( cfg->cfgIP->addr[0] ){
    cfg->setIpAddr.enable = 1;
    cfg->setIpAddr.pDevice = (UDINT)cfg->ethDevice;
    cfg->setIpAddr.pIPAddr = (UDINT)&cfg->cfgIP->addr[0];
    cfg->setIpAddr.Option = 1;
    CfgSetIPAddr(&cfg->setIpAddr);
    
    if(cfg->setIpAddr.status == 0xFFFF)   return  1;
  }

  if(cfg->setBroadcastAddr.status == 0xFFFF)   {
  // if( cfg->cfgIP->broadcast[0] ){
    cfg->setBroadcastAddr.enable = 1;
    cfg->setBroadcastAddr.pDevice = (UDINT)cfg->ethDevice;
    cfg->setBroadcastAddr.pBroadcastAddr = (UDINT)&cfg->cfgIP->broadcast[0];       // WBR:  disable for CP1382 until CfgSetBroadcastAddr is fixed in the AR > 4.0
    cfg->setBroadcastAddr.Option = 1;
    CfgSetBroadcastAddr(&cfg->setBroadcastAddr);
    
    if(cfg->setBroadcastAddr.status == 0xFFFF)   return  1;
  }

  if(cfg->setDefaultGateway.status == 0xFFFF)   {
  // if( cfg->cfgIP->gateway[0] ){
    cfg->setDefaultGateway.enable = 1;
    cfg->setDefaultGateway.pDevice = (UDINT)cfg->ethDevice;
    cfg->setDefaultGateway.pGateway= (UDINT)&cfg->cfgIP->gateway[0];
    cfg->setDefaultGateway.Option = 1;
    CfgSetDefaultGateway(&cfg->setDefaultGateway);
    
    if(cfg->setDefaultGateway.status == 0xFFFF)   return  1;
  }

  if(cfg->setSubnetMask.status == 0xFFFF)   {
  // if( cfg->cfgIP->subnet[0] ){
    cfg->setSubnetMask.enable = 1;
    cfg->setSubnetMask.pDevice = (UDINT)cfg->ethDevice;
    cfg->setSubnetMask.pSubnetMask = (UDINT)&cfg->cfgIP->subnet[0];
    cfg->setSubnetMask.Option = 1;
    CfgSetSubnetMask(&cfg->setSubnetMask);
    
    if(cfg->setSubnetMask.status == 0xFFFF)   return  1;
  }

  if  (   (cfg->setIpAddr.status == 65535) ||
      (cfg->setSubnetMask.status == 65535) ||
      (cfg->setBroadcastAddr.status == 65535) ||
      (cfg->setDefaultGateway.status == 65535)
    ){
    return 1;
  }


  if  (   !cfg->getIpAddr.status &&
      !cfg->setSubnetMask.status &&
      !cfg->setBroadcastAddr.status &&
      !cfg->setDefaultGateway.status
    ){

    // DBG("setDeviceIpCfg: IpAddr='%s'\r\n", cfg->cfgIP->addr);
    // DBG("setDeviceIpCfg: SubnetMask='%s'\r\n", cfg->cfgIP->subnet);
    // DBG("setDeviceIpCfg: BroadcastAddr='%s'\r\n", cfg->cfgIP->broadcast);
    // DBG("setDeviceIpCfg: DefaultGateway='%s'\r\n", cfg->cfgIP->gateway);

    return 0;
  }


  // DBG("setDeviceIpCfg: ERROR\r\n");
  // DBG("setDeviceIpCfg: IpAddr='%s'  st=%d\r\n", cfg->cfgIP->addr, cfg->getIpAddr.status);
  // DBG("setDeviceIpCfg: SubnetMask='%s'  st=%d\r\n", cfg->cfgIP->subnet, cfg->setSubnetMask.status);
  // DBG("setDeviceIpCfg: BroadcastAddr='%s'  st=%d\r\n", cfg->cfgIP->broadcast, cfg->setBroadcastAddr.status);
  // DBG("setDeviceIpCfg: DefaultGateway='%s'  st=%d\r\n", cfg->cfgIP->gateway, cfg->setDefaultGateway.status);

  return -1;
}
#endif 
#if 0

static int paiCfgCompareDeviceAndFileCfgData(paiHmiSystemNetworking_typ* p)
{
	return 0;
 int update = 0;     //! \todo   assign update with flags to indicate settings that need to change
 

  if(cfg->cfgIP->addr[0] && ( strcmp(&cfg->cfgIP->addr[0], &cfg->devIP.addr[0]) ))  {
    // DBGINF("Cfg update needed: cfgIP->addr='%s' devIP.addr='%s'\r\n", &cfg->cfgIP->addr[0], &cfg->devIP.addr[0]);
    cfg->setIpAddr.status=  0xFFFF;
    update = 1;
  }

  if(cfg->cfgIP->subnet[0] && ( strcmp(&cfg->cfgIP->subnet[0], &cfg->devIP.subnet[0]) ))  {
    // DBGINF("Cfg update needed: cfgIP->subnet='%s' devIP.subnet='%s'\r\n", &cfg->cfgIP->subnet[0], &cfg->devIP.subnet[0]);
    cfg->setSubnetMask.status=  0xFFFF;
    update = 1;
  }

#ifdef  AS_CFG
  if(!strcmp("PP420_1043_K27", AS_CFG))   {
    if(cfg->cfgIP->broadcast[0] && ( strcmp(&cfg->cfgIP->broadcast[0], &cfg->devIP.broadcast[0]) ))   {
      // DBGINF("Cfg update needed: cfgIP->broadcast='%s' devIP.broadcast='%s'\r\n", &cfg->cfgIP->broadcast[0], &cfg->devIP.broadcast[0]);
      cfg->setBroadcastAddr.status=  0xFFFF;
      update = 1;
    }
  }
#endif

  if(cfg->cfgIP->gateway[0] && ( strcmp(&cfg->cfgIP->gateway[0], &cfg->devIP.gateway[0]) ))   {
    // DBGINF("Cfg update needed: cfgIP->gateway='%s' devIP.gateway='%s'\r\n", &cfg->cfgIP->gateway[0], &cfg->devIP.gateway[0]);
    cfg->setDefaultGateway.status=  0xFFFF;
    update = 1;
  }

  return update;
}
#endif  

static void paiConvertIpAddrStrToDigits(char* ipAddr, USINT* pDigits)
{
//"127.0.0.1" --> digit[0]=127; digit[1]=0; digit[2]=0; digit[3]=1
char txtIpAddr[32];
char txtDigit[4][8];
int ii;
int jj;
char* pBeg;

	brsstrcpy((UDINT)txtIpAddr, (UDINT)ipAddr);
	txtDigit[0][0] = 0;
	txtDigit[1][0] = 0;
	txtDigit[2][0] = 0;
	txtDigit[3][0] = 0;
	
	pBeg = txtIpAddr;
	for(ii=0, jj=0; jj < 32; jj++){
		if(txtIpAddr[jj] == '.'){
			txtIpAddr[jj] = 0;
			brsstrcpy((UDINT)txtDigit[ii++], (UDINT)pBeg);
			pBeg = &txtIpAddr[jj+1];			
			if(ii >= 3){
				brsstrcpy((UDINT)txtDigit[ii], (UDINT)pBeg);
				break;		
			}			
		}
	}

	for(ii=0; ii < 4; ii++){
		*pDigits = (USINT)brsatoi((UDINT)txtDigit[ii]);
		pDigits++;
	}
}
#if 0
static void paiConvertIpDigitsToIpAddrStr(char* ipAddr, USINT* pDigits)
{
char txtDigit[8];
char txtIpAddr[32];

	if(!ipAddr || !pDigits)
		return;
		
	txtIpAddr[0] = 0;
	
	brsitoa((UDINT)pDigits[0], (UDINT)txtDigit);
	brsstrcat((UDINT)txtIpAddr, (UDINT)txtDigit);		
	brsstrcat((UDINT)txtIpAddr, (UDINT)".");	
	
	brsitoa((UDINT)pDigits[1], (UDINT)txtDigit);
	brsstrcat((UDINT)txtIpAddr, (UDINT)txtDigit);		
	brsstrcat((UDINT)txtIpAddr, (UDINT)".");	
	
	brsitoa((UDINT)pDigits[2], (UDINT)txtDigit);
	brsstrcat((UDINT)txtIpAddr, (UDINT)txtDigit);		
	brsstrcat((UDINT)txtIpAddr, (UDINT)".");	
	
	brsitoa((UDINT)pDigits[3], (UDINT)txtDigit);
	brsstrcat((UDINT)txtIpAddr, (UDINT)txtDigit);		
		
}
#endif


void paiHmiSystemNetworkingInit(paiHmiSystemNetworking_typ* p)
{
	p->oError = 0; //no errors
	p->oErrorText[0] = 0; //no errors
	p->oState = 1; //get current settings	
}

void paiHmiSystemNetworkingCyclic(paiHmiSystemNetworking_typ* p)
{
	switch(p->oState){
		case 1:
			if( paiGetDeviceIpCfgData(p) == 1 )
				return; //wait
				
			p->oState = 0;//done					
		break;
		default:
			p->oState = 0;
		break;
	}
}
//eof
