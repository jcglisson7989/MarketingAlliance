/********************************************************************
 * \copyright -- Piedmont Automation
 ********************************************************************
 * Program : wbrService
 * \file :   wbrServiceCyclic.c
 * \author : Blanton Radford
 * \date Created: May 18, 2015
 ********************************************************************
 * \brief Implementation of program wbrService
 ********************************************************************/

#ifdef _DEFAULT_INCLUDES
  #include <AsDefault.h>
#endif

/*! \brief Cyclic task for ?
*   \pre   Place in TC#?
*/
void _CYCLIC wbrServiceCyclic(void)
{
  //! \todo   check available mem and set flags to increase partition size if needed
  memService.status.blockFree=  memSvcGetMemInfo();
  
  
  if(logService.busy)  writeMessagesToLog();
  
  
  wbrPingStation(&genericPing);
}

void _EXIT wbrServiceExit(void)
{
  if(logService.busy)  writeMessagesToLog();
}
