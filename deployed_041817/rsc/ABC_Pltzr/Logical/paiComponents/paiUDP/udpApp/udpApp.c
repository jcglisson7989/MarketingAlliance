/********************************************************************
 * COPYRIGHT -- pai
 ********************************************************************
 * Program: appUDP
 * File: appUDP.c
 * Author: goran
 * Created: Jan 25, 2013
 ********************************************************************
 * Implementation of program appUDP
 ********************************************************************/

#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
	#include <AsDefault.h>
#endif

#include <../../../libraries/sscanf2/sscanf2.h>
#include <../paiUdpService/paiUdpService.h>
#include "../../libraries/sprintf2/sprintf2.h"
#include "../../libraries/bgringbuf/bgringbuffer.h"


#include <../../../ProjGlob/ipc.h>
#include "../../../ProjGlob/GlobalDec.h"

/*
###############################################################################
Utilities
###############################################################################
*/

/**
 Simple logging
 Log goes to an array of PV strings > see _LOCAL STRING log[][] variable below
 Log output is visible via Automation Studio watch window
 Example of a log statement used within the code is: 
 DBG(lgr, "This is log example. %d ", value1);
 To complety disable logging from this source file, change next line to: #if 0
IMPORTANT:
==========
DBGINIT() statement MUST BE PLACED as a first statement within the task _INIT function!
Example:
void _INIT myTaskINIT(void)
{
	//TODO: Add code here
	//init logger object
	DBGINIT(lgr, log, LOG_ENTRY_COUNT, LOG_ENTRY_LENGTH);
}
*/
#if 1
#include <../../bglib/bgPVLogger3.c>
#define LOG_ENTRY_COUNT 100	//max number of log entries
#define LOG_ENTRY_LENGTH  100 //max length of individual log message. Longer msg are truncated
_LOCAL STRING logUdpApp[LOG_ENTRY_COUNT][LOG_ENTRY_LENGTH]; //log output visible from Automation Studio!
#else
#define DBG(lgr, format, args...) ;
#define DBGINIT(lgr, logoutput, logEntryCount, logEntrySize)  ;
#endif


/**
###############################################################################
UDP Server Receive function
###############################################################################
*/
static void udpServerCallback(UDINT pRxBuffer, UDINT lenRxData)
{	

	DBG(lgr, "udpServerCallback lenRxData=%d\n\r", lenRxData);	
}


/**
###############################################################################
UDP callback functions
###############################################################################
*/
//UDP Server Receive function
static void udpServerCallbackAfterReceive(UDINT pRxBuffer, UDINT lenRxData)
{
	udpServerCallback(pRxBuffer, lenRxData);
}


//UDP Client Send Callback function
static void udpClientCallback(UDINT pTxBuffer, UDINT lenTxBuffer, UDINT* pTxDataLen)
{
//	(*pTxDataLen) = brsstrlen((UDINT)&gUdpClient.txbuf[0]);
}

//UDP Client Send Callback function
static void udpClientCallbackBeforeSend(UDINT pTxBuffer, UDINT lenTxBuffer, UDINT* pTxDataLen)
{
	udpClientCallback(pTxBuffer, lenTxBuffer, pTxDataLen);
}

/*
###############################################################################
UDP communication timeout handler 
###############################################################################
*/
static void	udpTimeOutHandler()
{
	//application logic - an example of handling a UDP receive timeout event 
	//static BOOL oldRxTimeout;
	if( gUdpRxState && bgTimerIsTimeOut(&gUdpCommTimeoutTmr) /*&& !gYPAlarms.alarmActive[APP_ALARM_DBPROXYTIMEOUT]*/){
		DBG(lgr, "udp server rx timeout");	
		//gYPAlarms.alarmActive[APP_ALARM_DBPROXYTIMEOUT] = gConfig.active.diag.disableDBProxTimeoutAlarm ? 0 : 1;
	}	
}


/*
###############################################################################
Task execution entry points: Init & Cyclic Functions
###############################################################################
*/
void _INIT udpAppINIT(void)
{
	
	/* TODO: Add code here */
	//init logger object
	DBGINIT(lgr, logUdpApp, LOG_ENTRY_COUNT, LOG_ENTRY_LENGTH);
	DBG(lgr, "INIT: udpAppINIT");
	
	//Init UDP server object	
	//======================
	paiUdpServerInit(&gUdpServer);
	//Set UDP server related parameters
	//Define application specific UDP server rx callback function 
	gUdpServer.serverIf.iRxCallback = (UDINT)udpServerCallbackAfterReceive;
	gUdpServer.serverIf.oRxDataLenMax = UDP_SERVER_RXBUF_SIZE;
	gUdpServer.serverIf.iEnable = 1;
	gUdpServer.serverIf.iUdpServerPort = 9999;
	
	
	
	
	//Init UDP client object	
	//======================
	paiUdpClientInit(&gUdpClient);

	//Define application specific UDP client tx callback function 
	gUdpClient.clientIf.iTxCallback = (UDINT)udpClientCallbackBeforeSend;

		
	//Adjust UDP client/server settings according to the application needs (i.e. use HMI if needed)
	//For other defaults see:
	//paiUDPService.var (i.e. defined UDP related const)
	//udpserv.c/udpservINIT() and udpclient.c/udpclientINIT()
	gUdpSystemCfg.udpClientMode = 0;//not continues mode
	gUdpSystemCfg.udpClientUpdateRate = 10;//[Hz]
	//strcpy(gUdpSystemCfg.udpRemoteHostIpAddress.text, "192.168.100.31");
	//strcpy(gUdpSystemCfg.udpRemoteHostIpAddress.text, "192.168.100.171");
	brsstrcpy((UDINT)gUdpSystemCfg.udpRemoteHostIpAddress.text, (UDINT)"192.168.100.255");
	//strcpy(gUdpSystemCfg.udpRemoteHostIpAddress.text, "192.168.100.10");
	//strcpy(gUdpSystemCfg.udpRemoteHostIpAddress.text, "127.0.0.1");
	//strcpy(gUdpSystemCfg.udpRemoteHostIpAddress.text, "192.168.100.255");
	gUdpClient.clientIf.iTaskCycleTimeXms = 1;//udp client runs under 10ms cycle time
	gUdpServer.serverIf.iRxTimeoutXms = 4000;//udp server rx timeout time

	//bgTimerStart(&gUdpCommTimeoutTmr, gConfig.active.hmi.dbProxyCommTimeout * 1000.0);//start response timeout timer
	bgTimerStart(&gUdpCommTimeoutTmr, 5000);//start response timeout timer
	
}

//typedef union TAppIpcMsgXXX
//{
//    UDINT gen;
//    USINT rw_shm;
//    DINT  errMsg;
//}TAppIpcMsgXXX_typ;
//

void _CYCLIC udpAppCYCLIC(void)
{
	/* TODO: Add code here */
	
	//operate timer
	bgTimerCyclic(&gUdpCommTimeoutTmr) ;
	
	//application logic - on send complete, copy status into last statusSent
	if(gUdpClient.clientIf.oSendDone){
		gUdpClient.clientIf.oSendDone = 0;	

		overheadIpcUDPTxClientCyclic( &gIpcCommFifoMem );
					
		//preset response timeout timer
//		gUdpRxState = 1; //need to receive a response
		if( bgTimerIsTimeOut(&gUdpCommTimeoutTmr) ){
			//bgTimerStart(&gUdpCommTimeoutTmr, gConfig.active.hmi.dbProxyCommTimeout * 1000.0);//start response timeout timer
			bgTimerStart(&gUdpCommTimeoutTmr, 5000);//start response timeout timer
		}
	}

	
	//application logic - en example of handling a UDP rx event	
	if(gUdpServer.serverIf.oRxReady){
		//gUdpServer.serverIf.oRxReady = 0; //Consumer of the message shall clear this bit
		gUdpRxState = 0; //response received		
		//gYPAlarms.alarmActive[APP_ALARM_DBPROXYTIMEOUT] = 0;//clear DB proxy alarm
	}
	
	//handle a UDP rx timeout
	udpTimeOutHandler();

	//cyclic execution of the UDP related services
	paiUdpServerCyclic(&gUdpServer);
	paiUdpClientCyclic(&gUdpClient);
}
//EOF

