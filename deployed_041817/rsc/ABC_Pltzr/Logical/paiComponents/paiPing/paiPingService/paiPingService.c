/********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Program: paiPingService
 * File: paiPingService.c
 * Author: goran
 * Created: August 17, 2015
 ********************************************************************
 * Implementation of program paiPingService
 ********************************************************************/

#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
	#include <AsDefault.h>
#endif

void paiPingInit(paiPing_typ* p, UDINT pingIntervalXms, UDINT pingTimeoutXms);
void paiPingCyclic(paiPing_typ* p);

void _INIT paiPingServiceInit(void)
{
	/* TODO: Add code here */
	brsstrcpy((UDINT)gPaiPing.iIPAddrStr, (UDINT)gPaiConfigSys.paiSys.ethernet.ipAddr);	
	paiPingInit(&gPaiPing, 3000, 1000);
}

void _CYCLIC paiPingServiceCyclic(void)
{
	/* TODO: Add code here */
	paiPingCyclic(&gPaiPing);
}
