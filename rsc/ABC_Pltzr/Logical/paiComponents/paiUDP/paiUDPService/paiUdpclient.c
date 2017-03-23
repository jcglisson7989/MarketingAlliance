/********************************************************************
 * COPYRIGHT -- pai
 ********************************************************************
 * Program: udpclient
 * File: udpclient.c
 * Author: goran
 * Created: January 23, 2013
 ********************************************************************
 * Implementation of program udpclient
 ********************************************************************/

#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
	#include <AsDefault.h>
#endif



#include <../../bglib/bgstring.h>
#include "../../libraries/sprintf2/sprintf2.h"


enum{
	udpCliZero = 0,
	udpCliInit,
	udpCliOpen,
	udpCliConnect,
	udpCliIdle,
	udpCliTxData,
	udpCliDisconnect,
	udpCliClose,
	udpCliError,
	udpCliLast
}STATEMACHINE;

static const char* udpCliStateName(int state)
{
static const char* stateNames[] = {
"Zero",
"Init",
"Open",
"Connect",
"Idle",
"TxData",
"Disconnect",
"Close",
"Error",
};

	if( state >= udpCliLast)
		return "unknow";
	
	return stateNames[state];
};


/*
###############################################################################
Utilities
###############################################################################
*/

static void convertIPTextToDigits(paiUdpIPAddress_typ* p)
{
unsigned char txtbuffer[64];
bgStringList_typ list;

	brsstrcpy((UDINT)txtbuffer, (UDINT)(p->text));
	list.src = txtbuffer;

	bgStringSplitLine(&list, '.');
	if(list.itemCount != 4){
		p->digit3 = 0;
		p->digit2 = 0;
		p->digit1 = 0;
		p->digit0 = 0;
		return;
	}
	p->digit3 = (USINT)brsatoi((UDINT)list.items[0]);
	p->digit2 = (USINT)brsatoi((UDINT)list.items[1]);
	p->digit1 = (USINT)brsatoi((UDINT)list.items[2]);
	p->digit0 = (USINT)brsatoi((UDINT)list.items[3]);
}


/**
 Simple logging
 Log goes to an array of PV strings > see _LOCAL STRING log[][] variable below
 Log output is visible via Automation Studio watch window
 Example of a log statement used within the code is: 
 DBG(lgr, "This is log example. %d ", value1);
 To complety disable logging from this source file, change next line to: #if 0
*/
#if 1
#include <../../bglib/bgPVLogger3.c>
#define LOG_ENTRY_COUNT 20	//max number of log entries
#define LOG_ENTRY_LENGTH  32 //max length of individual log message. Longer msg are truncated
_LOCAL STRING logUdpClient[LOG_ENTRY_COUNT][LOG_ENTRY_LENGTH]; //log output visible from Automation Studio!
#else
#define DBG(lgr, format, args...) ;
#define DBGINIT(lgr, logoutput, logEntryCount, logEntrySize)  ;
#endif



/*
###############################################################################
Functions
###############################################################################
*/

static void udpClientSMCyclic(paiUdpClient_typ *p)
{
bgSSM_typ* pSm = &p->sm;


	//operate timer(s)
	bgTimerCyclic(&pSm->timer_x1ms[0]); // delay timer

	//TimerExecute(&pSm->timer2x1ms); // update rate timer (in continues mode)
	//IMPORANT: for high speed, can't use TON block > rather, use cycle time
	if(pSm->timer_x1ms[1].ET)
		pSm->timer_x1ms[1].ET--;
	
	bgTimerCyclic(&pSm->timer_x1ms[2]); // 1sec stats timer

	//stats timers
	if( bgTimerIsTimeOut(&pSm->timer_x1ms[2]) ){
		bgTimerStart(&pSm->timer_x1ms[2], 1000);

		//values for cummulative (per min) calculations for datagrams
		p->txStats.datagramPerSec = pSm->counter[0];
		pSm->counter[0] = 0;
		if(p->txStats.datagramPerSec > p->txStats.datagramPerSecMax){
			p->txStats.datagramPerSecMax = p->txStats.datagramPerSec;
		}
		
		//values for cummulative (per min) calculations for bytes
		p->txStats.bytesPerSec = pSm->counter[1];
		pSm->counter[1] = 0;
		if(p->txStats.bytesPerSec > p->txStats.bytesPerSecMax){
			p->txStats.bytesPerSecMax = p->txStats.bytesPerSec;
		}
	}



	/*execute control state machine cyclic handler*/		
	bgSSMCyclic(pSm);
	
	//show change of state in a log
	if( bgSSMIsStateInit(pSm) ){
		DBG(lgr, "sm=%s(%d)", bgSSMGetStateText(pSm), bgSSMGetState(pSm));
	}
		
	switch( bgSSMGetState(pSm) ){
		//========================================
		case udpCliZero:
			bgSSMStateNext(pSm, udpCliInit);
		break;
		//========================================
		case udpCliInit:
			if(p->clientIf.iConnect){
				bgSSMStateNext(pSm, udpCliOpen);
			}			
		break;
		//========================================
		case udpCliOpen:

			if( bgSSMIsStateInit(pSm) ){				
				p->client.open.enable = 1;
				p->client.open.port = 0;
				p->client.open.pIfAddr = 0;
//IMPORTANT:
//in order for the following conditional compilation to work properly, PLC object in the Configuration view
//must contain following defintion:
//Folder: Build
//Field: Additional Build Options
//Value: -D $(AS_CONFIGURATION)
//Using the above, name of the current AS configuration (i.e. realhw1 or testsim or else) becomes 
//a defined preprocessor name. As a result, it's possible to destinguish between different configurations! 
//#ifdef testsim
#ifdef Simulation
				//In case of testsim (ARsim) target, don't use socket options
				p->client.open.options = 0;
#warning "UDP Client - ARsim target!"
#else
				//For all other (real) targets, use socket options
				p->client.open.options = udpOPT_REUSEPORT | udpOPT_BROADCAST;
#warning "UDP Client - real target!"
#endif
				return;
			}			

			if(p->client.open.status == ERR_FUB_BUSY)
				return;

			p->client.open.enable = 0;
			
			if(p->client.open.status == ERR_OK){
				p->client.recv.ident = p->client.open.ident;
				p->client.send.ident = p->client.open.ident;
				p->client.close.ident = p->client.open.ident;
				p->client.connect.ident = p->client.open.ident;
				p->client.disconnect.ident = p->client.open.ident;
				p->client.ioctl.ident = p->client.open.ident;
				bgSSMStateNext(pSm, udpCliConnect);
				return;
			}

			DBG(lgr,"Err udp.open=%d", p->client.open.status);
			bgSSMStateNext(pSm, udpCliError);
			
		break;
		//========================================
		case udpCliConnect:

			if( bgSSMIsStateInit(pSm) ){				
				p->client.connect.enable = 1;
				p->client.connect.port = p->clientIf.iRmtUdpPort;
				p->client.connect.pHost = (UDINT)p->clientIf.iRmtIPAddr;
				return;
			}			

			if(p->client.connect.status == ERR_FUB_BUSY)
				return;

			//p->client.connect.enable = 0;
			
			if(p->client.connect.status == ERR_OK){
				brsstrcpy((UDINT)p->clientIf.oRmtIpAddr, (UDINT)p->clientIf.iRmtIPAddr);
				p->clientIf.oRmtUdpPort = p->clientIf.iRmtUdpPort;
				
				bgSSMStateNext(pSm, udpCliIdle);
				return;
			}

			DBG(lgr,"Err udp.connect=%d", p->client.connect.status);
			bgSSMStateNext(pSm, udpCliError);
			
		break;
		//========================================
		case udpCliIdle:

			if( bgSSMIsStateInit(pSm) ){				
				
			}			


			//udp client in echo mode!? 
			//check for iSendEcho set by the server upon it receives a message > client sends out to the same host
			if(!p->clientIf.iMode && p->clientIf.iSendEcho){
				p->clientIf.iSendEcho = 0;
				p->clientIf.iSend = 1;
				brsstrcpy((UDINT)p->clientIf.iRmtIPAddr, (UDINT)p->clientIf.iSendEchoRmtIpAddr);
			}
			
			//udp client in continues mode!? 
			//trigger send update at a configured rate to a defined (sipplied to the inputs) remote host/port
			if(p->clientIf.iMode){


				if(!pSm->timer_x1ms[1].ET){
					int updateTimeMs;
					
					if( p->clientIf.iUpdateRate ){
						updateTimeMs = 1000 /  p->clientIf.iUpdateRate;
					}else{
						updateTimeMs = 1000;
					}

					if(updateTimeMs < 10)
						updateTimeMs = 12;
					
					if(updateTimeMs > 1000)
						updateTimeMs = 1000;
					
					if(p->clientIf.iTaskCycleTimeXms){
						pSm->timer_x1ms[1].ET= updateTimeMs / p->clientIf.iTaskCycleTimeXms;
					}else{
						pSm->timer_x1ms[1].ET= updateTimeMs / gUdpClient_TaskCycleTimeXms; // devide by task clas time to find out increments					
					}
						
					p->clientIf.iSend = 1;
				}


			}


			//monitor for change in remote host settings
			//in case of a change > reconnect (disconncet then connect)
			if((p->clientIf.oRmtUdpPort != p->clientIf.iRmtUdpPort) ||
				brsstrcmp((UDINT)p->clientIf.oRmtIpAddr, (UDINT)p->clientIf.iRmtIPAddr)
			){
				DBG(lgr,"rmt settings changed. Triggering reconnect.");
				bgSSMStateNext(pSm, udpCliDisconnect);
				return;
			}

			//monitor request to send 
			if(p->clientIf.iSend){
				p->clientIf.iSend = 0;


				if(p->clientIf.iTxDataLen > UDP_CLIENT_TXBUF_SIZE){
					p->clientIf.iTxDataLen = UDP_CLIENT_TXBUF_SIZE;
				}

				if(!p->clientIf.iTxDataAdr && !p->clientIf.iTxCallback){
					DBG(lgr,"udp.send nothing to tx");
					return;
				}

				
				//execute memcpy if datasource is defined
				if(p->clientIf.iTxDataAdr){
					brsmemcpy((UDINT)(p->txbuf), (UDINT)(p->clientIf.iTxDataAdr), p->clientIf.iTxDataLen);
				}

				//execute callback to enable app to populate data before sending
				//NOTE: callback will overwrite effect of the above memcpy if both a defined!!!
				if(p->clientIf.iTxCallback){
					void (*txCallback)(UDINT pBuf, UDINT lenTxBuf, UDINT* pLenData) =  ( void(*) (UDINT, UDINT, UDINT*) ) p->clientIf.iTxCallback;
					(*txCallback)( (UDINT)&p->txbuf[0], UDP_CLIENT_TXBUF_SIZE, &p->clientIf.iTxDataLen);
				}

				p->client.send.enable = 1;
				p->client.send.pData = (UDINT)&p->txbuf[0];
				p->client.send.datalen = p->clientIf.iTxDataLen;

				//stats
				p->txStats.datagramCountTotal++;
				p->txStats.bytesTotal += p->client.send.datalen;

				//values for cummulative (per min) calculations
				pSm->counter[0]++;
				pSm->counter[1] +=p->client.send.datalen;


				
				bgSSMStateNext(pSm, udpCliTxData);
				return;
			}
			
		break;
		//========================================
		case udpCliTxData:
			if( bgSSMIsStateInit(pSm) ){				
				
			}			

			if(p->client.send.status == ERR_FUB_BUSY)
				return;

			p->client.send.enable = 0;
			
			if(p->client.send.status == ERR_OK){
				p->clientIf.oSendDone = 1;
				DBG(lgr,"udp.send OK");
				bgSSMStateNext(pSm, udpCliIdle);
				return;
			}
		

			DBG(lgr,"Err udp.send=%d", p->client.send.status);
			bgSSMStateNext(pSm, udpCliError);
			
		break;
		//========================================
		case udpCliDisconnect:

			if( bgSSMIsStateInit(pSm) ){				
				p->client.connect.enable = 0;
				p->client.disconnect.enable = 1;
				return;				
			}			

			if(p->client.disconnect.status == ERR_FUB_BUSY)
				return;

			p->client.disconnect.enable = 0;
			
			if(p->client.disconnect.status == ERR_OK){
				bgSSMStateNext(pSm, udpCliClose);
				return;
			}


			DBG(lgr,"Err udp.disconnect=%d", p->client.disconnect.status);
			bgSSMStateNext(pSm, udpCliClose);
			
		break;
		//========================================
		case udpCliClose:
			
			if( bgSSMIsStateInit(pSm) ){				
				DBG(lgr,"UDP Client close");
				p->client.close.enable = 1;				
				return;
			}


			if(p->client.close.status == ERR_FUB_BUSY)
				return;

			if(p->client.close.status){
				DBG(lgr,"Err udp.close=%d", p->client.close.status);
			}

			p->client.close.enable = 0;				

			bgSSMStateNext(pSm, udpCliZero);			
		break;
		//========================================
		case udpCliError:


			if( bgSSMIsStateInit(pSm) ){
				DBG(lgr,"UDP Client Error State");
				
				//start error recovery timer
				bgTimerStart(&pSm->timer_x1ms[0], 5000);
			}


			if( bgTimerIsTimeOut(&pSm->timer_x1ms[0]) ){
				//after timer exp > try to close the port and see if it recovers
				bgSSMStateNext(pSm, udpCliDisconnect);			
			}
			
		break;
		//========================================
		default:
		break;
	}
	
}


void udpClientInit(paiUdpClient_typ *p)
{
	bgSSM_typ* pSm = &p->sm;
	
	bgTimerStart(&p->sm.timer_x1ms[2], 1000);
	
	bgSSMInit(pSm, (UDINT)udpCliStateName, 0);
	
}


void udpClientCyclic(paiUdpClient_typ *p)
{

	//udp client state machine
	udpClientSMCyclic(p);


	//udp client fbk-s
	UdpOpen(&p->client.open);
	UdpClose(&p->client.close);
	UdpConnect(&p->client.connect);
	UdpDisconnect(&p->client.disconnect);
	UdpSend(&p->client.send);
	UdpRecv(&p->client.recv);
	UdpIoctl(&p->client.ioctl);
}
/*
###############################################################################
Main entry: Init & Cyclic Functions
###############################################################################
*/


void paiUdpClientInit(paiUdpClient_typ *p)
{
	/* TODO: Add code here */
	
	//init logger object
	DBGINIT(lgr, logUdpClient, LOG_ENTRY_COUNT, LOG_ENTRY_LENGTH);
	DBG(lgr, "INIT: paiUdpClientInit");

	udpClientInit(p);

	//upd client application specific init
	p->clientIf.iConnect = 1;
#if 0

	//RESTORE SETTINGS FROM THE REMANENT STORAGE
	//sanity check for remote host ip address
	convertIPTextToDigits(&gUdpSystemCfg.udpRemoteHostIpAddress);
	
	if(!gUdpSystemCfg.udpRemoteHostIpAddress.digit0 ||
		!gUdpSystemCfg.udpRemoteHostIpAddress.digit1 ||
		!gUdpSystemCfg.udpRemoteHostIpAddress.digit2 ||
		!gUdpSystemCfg.udpRemoteHostIpAddress.digit3
	){
		brsstrcpy((UDINT)gUdpSystemCfg.udpRemoteHostIpAddress.text, (UDINT)gUdpClient_DefaultHostAdr);
		convertIPTextToDigits(&gUdpSystemCfg.udpRemoteHostIpAddress);		
	}
	brsstrcpy((UDINT)gUdpClient.clientIf.iRmtIPAddr, (UDINT)gUdpSystemCfg.udpRemoteHostIpAddress.text);

	//sanity check for remote host UDP port number
	if(!gUdpSystemCfg.udpRemoteHostPortNumber){
		gUdpSystemCfg.udpRemoteHostPortNumber = gUdpClient_DefaultPort;
	}
	gUdpClient.clientIf.iRmtUdpPort = gUdpSystemCfg.udpRemoteHostPortNumber;

	// udpClientMode
	// 0-echo mode (send status after receiving a command from the host. Uses received IP address and UDP port number configured here.
	// 1-continues mode (send status independantly to configured 	remoteIpAddress. remoteUDP port at the configure UDP rate
	if(gUdpSystemCfg.udpClientMode > 1){
		gUdpSystemCfg.udpClientMode = 0;
	}
	gUdpClient.clientIf.iMode = gUdpSystemCfg.udpClientMode;


	// udpClientUpdateRate
	// rate to send outgoing status to remote host in case of UDP client mode 1
	// 
	if(gUdpSystemCfg.udpClientUpdateRate < 1){
		gUdpSystemCfg.udpClientUpdateRate  = 1;
	}
	if(gUdpSystemCfg.udpClientUpdateRate > 100){
		gUdpSystemCfg.udpClientUpdateRate  = 100;
	}
	gUdpClient.clientIf.iUpdateRate = gUdpSystemCfg.udpClientUpdateRate;

	
	gUdpClient.clientIf.iSend = 0;

#endif	
	//dgsUdpClientInit();	
}

void  paiUdpClientCyclic(paiUdpClient_typ *p)
{
	/* TODO: Add code here */

	//udp client cyclic
	udpClientCyclic(p);

#if 0
	//in continues client mode, use localy configured settings!
	if(/*gUdpSystemCfg.udpClientMode &&*/
		((gUdpSystemCfg.udpClientMode != gUdpClient.clientIf.iMode) ||
		(gUdpClient.clientIf.iUpdateRate != gUdpSystemCfg.udpClientUpdateRate) ||
		brsstrcmp((UDINT)gUdpClient.clientIf.iRmtIPAddr, (UDINT)gUdpSystemCfg.udpRemoteHostIpAddress.text))
	){
		gUdpClient.clientIf.iMode = gUdpSystemCfg.udpClientMode;
		gUdpClient.clientIf.iUpdateRate = gUdpSystemCfg.udpClientUpdateRate;
 		brsstrcpy((UDINT)gUdpClient.clientIf.iRmtIPAddr, (UDINT)gUdpSystemCfg.udpRemoteHostIpAddress.text);
	}

	//in echo mode, just monitor for iMode change
	if(!gUdpSystemCfg.udpClientMode &&
		((gUdpSystemCfg.udpClientMode != gUdpClient.clientIf.iMode) )
	){
		gUdpClient.clientIf.iMode = gUdpSystemCfg.udpClientMode;
	}


	//in both modes use configured port number for the remote UDP host
	gUdpClient.clientIf.iRmtUdpPort = gUdpSystemCfg.udpRemoteHostPortNumber;


	//udp client cyclic
	//dgsUdpClientCyclic();
#endif	
}
