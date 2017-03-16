/*!
 ********************************************************************
 * Program : runFirst
 * \file :   runFirstInit.c
 * \author : Blanton Radford
 * \date Created: May 07, 2015
 * \copyright -- Piedmont Automation
 ********************************************************************
 * \brief Initializations for package WBRServices
 ********************************************************************/

#ifdef _DEFAULT_INCLUDES
  #include <AsDefault.h>
#endif


/*! \brief Init project compile info
*   called only from runFirstInit
*/
static void wbrServiceInitProgramCompileInfo()
{
 char osVers[12];
 TARGETInfo_typ TInfo;
 

  TInfo.enable = 1;
  TInfo.pOSVersion = (UDINT) &osVers;        

  do {
    TARGETInfo(&TInfo);
  } while(TInfo.status == 0xFFFF);
    
  
#ifndef AS_PROJ
  #warning Macro names for program complile info not defined \
           -- code located just below this warning
  wbrsnprintf(gConfig.cfgDefault.cfgCompile.info, sizeof(gConfig.cfgDefault.cfgCompile.info), "No compile info");
  //* Copy the line below into Project->Change Runtime Versions->Build->ANSI C Build Options to define \
         -D "str(x)=#x" -D AS_PROJ=str($(AS_PROJECT_NAME)) -D AS_CFG=str($(AS_CONFIGURATION)) -D "AS_VERS=str($(AS_VERSION))" -D "AS_USER=str($(AS_USER_NAME))" -D "AS_CMPNY=str($(AS_COMPANY_NAME))" -D "AS_BUILD_MODE=str($(AS_BUILD_MODE))"

#else
  // These macro names are defined in Project->Change Runtime Versions->
  //    Build->ANSI C Build Options
  wbrsnprintf(gConfig.cfgDefault.cfgCompile.projVersion,  sizeof(gConfig.cfgDefault.cfgCompile.projVersion),  "%s, V1.0.00.6",  AS_PROJ);
  wbrsnprintf(gConfig.cfgDefault.cfgCompile.AS_config,    sizeof(gConfig.cfgDefault.cfgCompile.AS_config),    "%s",             AS_CFG);
  wbrsnprintf(gConfig.cfgDefault.cfgCompile.AS_configID,  sizeof(gConfig.cfgDefault.cfgCompile.AS_configID),  "%s_%s",          AS_PROJ, AS_CFG);
  wbrsnprintf(gConfig.cfgDefault.cfgCompile.AS_build,     sizeof(gConfig.cfgDefault.cfgCompile.AS_build),     "%s",             AS_BUILD_MODE);
  wbrsnprintf(gConfig.cfgDefault.cfgCompile.date,         sizeof(gConfig.cfgDefault.cfgCompile.date),         "%s @ %s",        __DATE__, __TIME__);
  wbrsnprintf(gConfig.cfgDefault.cfgCompile.AS_version,   sizeof(gConfig.cfgDefault.cfgCompile.AS_version),   "%s",             AS_VERS);
  wbrsnprintf(gConfig.cfgDefault.cfgCompile.user,         sizeof(gConfig.cfgDefault.cfgCompile.user),         "%s",             AS_USER);
  wbrsnprintf(gConfig.cfgDefault.cfgCompile.company,      sizeof(gConfig.cfgDefault.cfgCompile.company),      "%s, Inc.",       AS_CMPNY);
  wbrsnprintf(gConfig.cfgDefault.cfgCompile.info,         sizeof(gConfig.cfgDefault.cfgCompile.info),         "Compile info complete");
#endif
  wbrsnprintf(gConfig.cfgDefault.cfgCompile.AR_Version,   sizeof(gConfig.cfgDefault.cfgCompile.AR_Version),   "%s",           osVers);
  //! \todo   add WBRServices version, drawing name and revision, SVN revision
}
      

/*! \brief Init machine configuration defaults
*   called only from runFirstInit
*/
void  wbrMemServiceFirstInitSetDefaults(wbrMemSvcStoredConfig_typ* cfg)
{
  cfg->memRequestSize=   0xFFFFFF;
  
//  if(gREMMEMPostfix == 0x55555555)                                                 //  if storage has data, ...
//    cfg->memRequestSize=  (gRemanentData.activeCfg.wbrMemService.memRequestSize > 0xFFFFFF) ? gRemanentData.activeCfg.wbrMemService.memRequestSize : 0xFFFFFF;
  // if(magic == 0x55555555)                          //  if storage has data, ...
    // cfg->memRequestSize=  stored.wbrMemService.memRequestSize;
}



/*! \brief Init-SP for AsMem heap memory and linked list services
*   \pre   Place in TC#1 in front of most if not all other tasks
*/
void _INIT runFirstInit(void)
{
  wbrServiceInitProgramCompileInfo();
  
  //! \todo init AsMem as a separate service
  //! \todo what to do with appConfigAndRec - switch to MAPP?
  
  /// Init cfgDefault with hardcoded defaults
  if(&gConfig.cfgDefault.wbrMemService != 0)                   //  mcfgWBR: skip if this address is null    TODO: log this for debug
    memService.config= &gConfig.cfgDefault.wbrMemService;                //  mcfgWBR: this needs to run before the Config & Recipe task to insure the defaults are set
  
    // memService.config= &config.wbrMemService;                               //  mcfgWBR: used only for testing package independently
  
  wbrMemServiceFirstInitSetDefaults(memService.config);
  
  memService.status.memInitValid= initMemSvc(memService.config->memRequestSize);

  
  initListSvc(memService.status.memInitValid);
  
  
  setLogServiceDataAddress(&logService);
  
  if(memService.status.memInitValid)       initLogService();
  
  requestMessageToLogDefault( (UDINT)gConfig.cfgDefault.cfgCompile.projVersion);
  requestMessageToLogDefault( (UDINT)gConfig.cfgDefault.cfgCompile.AS_config);
  requestMessageToLogDefault( (UDINT)gConfig.cfgDefault.cfgCompile.AS_configID);
  requestMessageToLogDefault( (UDINT)gConfig.cfgDefault.cfgCompile.AS_build);
  requestMessageToLogDefault( (UDINT)gConfig.cfgDefault.cfgCompile.date);
  requestMessageToLogDefault( (UDINT)gConfig.cfgDefault.cfgCompile.AS_version);
  requestMessageToLogDefault( (UDINT)gConfig.cfgDefault.cfgCompile.AR_Version);
  requestMessageToLogDefault( (UDINT)gConfig.cfgDefault.cfgCompile.user);
  requestMessageToLogDefault( (UDINT)gConfig.cfgDefault.cfgCompile.company);
  requestMessageToLogDefault( (UDINT)gConfig.cfgDefault.cfgCompile.info);
  requestMessageToLogDefault( (UDINT)"wbrServices v0.12.0 initialized");
  requestSuccessEventToLog(
                        (UDINT)__FUNCTION__
                      , getSystemUserLogIdent()
                      , 0
                      , 50000
                      , 0
                      , (UDINT)"wbrServices v0.12.0 initialized"
                      , sizeof("wbrServices vn.nn.n initialized")
                      );
  
  
  wbrPingSvcInit(&genericPing);
}
