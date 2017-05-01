/********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Package: paiUDPService
 * File: paiUdpService.h
 * Author: goran
 * Created: June 22, 2015
 *******************************************************************/

#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
	#include <AsDefault.h>
#endif

void paiUdpServerInit(paiUdpServer_typ *p);
void paiUdpServerCyclic(paiUdpServer_typ *p);
void paiUdpClientInit(paiUdpClient_typ *p);
void paiUdpClientCyclic(paiUdpClient_typ *p);
