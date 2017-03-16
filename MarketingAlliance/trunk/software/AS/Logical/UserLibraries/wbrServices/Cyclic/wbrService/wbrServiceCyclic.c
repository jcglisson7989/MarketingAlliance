/*!
 ********************************************************************
### Program : wbrService
 * \file :   wbrServiceCyclic.c
 * \author : Blanton Radford
 * \date Created: May 18, 2015
 * \copyright -- Piedmont Automation
 ********************************************************************
 * \brief Cyclic updates for the package WBRServices
 ********************************************************************/

#ifdef _DEFAULT_INCLUDES
  #include <AsDefault.h>
#endif

/*! \brief Cyclic task for WBRServices
*   \pre   Place in TC#8 after most if not all other tasks
*/
void _CYCLIC wbrServiceCyclic(void)
{
  //! \todo   check available mem and set flags to increase partition size if needed
  memService.status.blockFree=  memSvcGetMemInfo(&memService);
  
  
  if(logService.busy)  writeMessagesToLog();
  
  
  wbrPingStation(&genericPing);
  
  wbrUSBMonitor();
}

void _EXIT wbrServiceExit(void)
{
  if(logService.busy)  writeMessagesToLog();
}
