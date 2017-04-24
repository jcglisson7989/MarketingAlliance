/********************************************************************
 * \copyright -- Piedmont Automation
 ********************************************************************
 * Program : runFirst
 * \file :   runFirstInit.c
 * \author : Blanton Radford
 * \date Created: May 07, 2015
 ********************************************************************
 * \brief Implementation of program runFirst
 ********************************************************************/

#ifdef _DEFAULT_INCLUDES
  #include <AsDefault.h>
#endif

char *Revision;
char *Modified;
char *Date;
char *TimeNow;
char *RevRange;
char *Mixed;
char *IsTagged;
char *URL;
char *isInSVN;
char *lockdate;

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
  wbrsnprintf(gConfig.cfgCompile.info, sizeof(gConfig.cfgCompile.info), "No info");
  /* Copy the line below into Project->Change Runtime Versions->Build->ANSI C Build Options to define
         -D "str(x)=#x" -D AS_PROJ=str($(AS_PROJECT_NAME)) -D AS_CFG=str($(AS_CONFIGURATION)) -D "AS_VERS=str($(AS_VERSION))" -D "AS_USER=str($(AS_USER_NAME))" -D "AS_CMPNY=str($(AS_COMPANY_NAME))"
     */
#else
  // These macro names are defined in Project->Change Runtime Versions->
  //    Build->ANSI C Build Options

	wbrsnprintf(gRecCfg.active.Cfg.cfgCompile.projVersion,  sizeof(gRecCfg.active.Cfg.cfgCompile.projVersion),  "%s, ",  AS_PROJ);
	wbrsnprintf(gRecCfg.active.Cfg.cfgCompile.AS_config,    sizeof(gRecCfg.active.Cfg.cfgCompile.AS_config),    "%s",           AS_CFG);
	wbrsnprintf(gRecCfg.active.Cfg.cfgCompile.date,         sizeof(gRecCfg.active.Cfg.cfgCompile.date),         "%s @ %s",      __DATE__, __TIME__);
	wbrsnprintf(gRecCfg.active.Cfg.cfgCompile.AS_version,   sizeof(gRecCfg.active.Cfg.cfgCompile.AS_version),   "%s",           AS_VERS);
	wbrsnprintf(gRecCfg.active.Cfg.cfgCompile.user,         sizeof(gRecCfg.active.Cfg.cfgCompile.user),         "%s,",   AS_USER);
	wbrsnprintf(gRecCfg.active.Cfg.cfgCompile.company,      sizeof(gRecCfg.active.Cfg.cfgCompile.company),      "%s",     AS_CMPNY);  // WBR:  future  \todone
	wbrsnprintf(gRecCfg.active.Cfg.cfgCompile.info,         sizeof(gRecCfg.active.Cfg.cfgCompile.info),         "Compile info complete");
	
	wbrsnprintf(gRecCfg.active.Cfg.cfgCompile.Revision,         sizeof(gRecCfg.active.Cfg.cfgCompile.Revision),         "Source Revision %s",   Revision);
	wbrsnprintf(gRecCfg.active.Cfg.cfgCompile.Rev_Number,         sizeof(gRecCfg.active.Cfg.cfgCompile.Rev_Number),         "R%s",   Revision);
	wbrsnprintf(gRecCfg.active.Cfg.cfgCompile.Modified,         sizeof(gRecCfg.active.Cfg.cfgCompile.Modified),         "Modified Status: %s",   Modified);
	wbrsnprintf(gRecCfg.active.Cfg.cfgCompile.Date,         sizeof(gRecCfg.active.Cfg.cfgCompile.Date),         "Last Pushed %s ",   Date);
	wbrsnprintf(gRecCfg.active.Cfg.cfgCompile.TimeNow,         sizeof(gRecCfg.active.Cfg.cfgCompile.TimeNow),         "Compiled %s",   TimeNow);
	wbrsnprintf(gRecCfg.active.Cfg.cfgCompile.RevRange,         sizeof(gRecCfg.active.Cfg.cfgCompile.RevRange),         "%s",   RevRange);
	wbrsnprintf(gRecCfg.active.Cfg.cfgCompile.Mixed,         sizeof(gRecCfg.active.Cfg.cfgCompile.Mixed),         "%s",   Mixed);
	wbrsnprintf(gRecCfg.active.Cfg.cfgCompile.IsTagged,         sizeof(gRecCfg.active.Cfg.cfgCompile.IsTagged),         "%s",   IsTagged);
	wbrsnprintf(gRecCfg.active.Cfg.cfgCompile.URL,         sizeof(gRecCfg.active.Cfg.cfgCompile.URL),         "Repo URL: <%s>",   URL);
	wbrsnprintf(gRecCfg.active.Cfg.cfgCompile.isInSVN,         sizeof(gRecCfg.active.Cfg.cfgCompile.isInSVN),         "Version Status: %s",   isInSVN);
	wbrsnprintf(gRecCfg.active.Cfg.cfgCompile.lockdate,         sizeof(gRecCfg.active.Cfg.cfgCompile.lockdate),         "Lock Date: %s",   lockdate);
	////IMPORTANTTODO: Uncomment out here and below
	wbrsnprintf(gRecCfg.active.Cfg.cfgCompile.AR_Version,   sizeof(gRecCfg.active.Cfg.cfgCompile.AR_Version),   "%s",           osVers);

#endif
//  wbrsnprintf(gConfig.cfgCompile.AR_Version,   sizeof(gConfig.cfgCompile.AR_Version),   "%s",           osVers);
  //! \todo   add WBRServices version, drawing name and revision
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
*   \pre   Place in TC#1
*/
void _INIT runFirstInit(void)
{
  wbrServiceInitProgramCompileInfo();
//  
//  //! \todo init AsMem as a separate service
//  //! \todo what to do with appConfigAndRec - switch to MAPP?
//  
//  /// Init cfgDefault with hardcoded defaults
  if(&gRecCfg.active.Cfg.wbrMemService != 0)                   //  mcfgWBR: skip if this address is null    TODO: log this for debug
    memService.config= &gRecCfg.active.Cfg.wbrMemService;                //  mcfgWBR: this needs to run before the Config & Recipe task to insure the defaults are set
  
    // memService.config= &config.wbrMemService;                               //  mcfgWBR: used only for testing package independently
  
  wbrMemServiceFirstInitSetDefaults(memService.config);
  
  memService.status.memInitValid= initMemSvc(memService.config->memRequestSize);

  initListSvc(memService.status.memInitValid);
  
  setLogServiceDataAddress(&logService);
  
	if(memService.status.memInitValid){
		initLogService();
	}else{
//		SYSreset(1,1);	
	}

	requestMessageToLog( (UDINT)gRecCfg.active.Cfg.cfgCompile.projVersion, arlogBASE_USER_LOG_IDENT, 0, 0, 0, 0);
	requestMessageToLog( (UDINT)gRecCfg.active.Cfg.cfgCompile.AS_config, arlogBASE_USER_LOG_IDENT, 0, 0, 0, 0);
	requestMessageToLog( (UDINT)gRecCfg.active.Cfg.cfgCompile.AS_version, arlogBASE_USER_LOG_IDENT, 0, 0, 0, 0);
	requestMessageToLog( (UDINT)gRecCfg.active.Cfg.cfgCompile.AR_Version, arlogBASE_USER_LOG_IDENT, 0, 0, 0, 0);
	requestMessageToLog( (UDINT)gRecCfg.active.Cfg.cfgCompile.isInSVN, arlogBASE_USER_LOG_IDENT, 0, 0, 0, 0);
	requestMessageToLog( (UDINT)gRecCfg.active.Cfg.cfgCompile.URL, arlogBASE_USER_LOG_IDENT, 0, 0, 0, 0);
	requestMessageToLog( (UDINT)gRecCfg.active.Cfg.cfgCompile.Revision, arlogBASE_USER_LOG_IDENT, 0, 0, 0, 0);
	requestMessageToLog( (UDINT)gRecCfg.active.Cfg.cfgCompile.Modified, arlogBASE_USER_LOG_IDENT, 0, 0, 0, 0);
	requestMessageToLog( (UDINT)gRecCfg.active.Cfg.cfgCompile.IsTagged, arlogBASE_USER_LOG_IDENT, 0, 0, 0, 0);
	requestMessageToLog( (UDINT)gRecCfg.active.Cfg.cfgCompile.TimeNow, arlogBASE_USER_LOG_IDENT, 0, 0, 0, 0);
	requestMessageToLog( (UDINT)gRecCfg.active.Cfg.cfgCompile.info, arlogBASE_USER_LOG_IDENT, 0, 0, 0, 0);
	requestMessageToLog( (UDINT)"wbrServices initialized", arlogBASE_USER_LOG_IDENT, 0, 0, 0, 0);

}
