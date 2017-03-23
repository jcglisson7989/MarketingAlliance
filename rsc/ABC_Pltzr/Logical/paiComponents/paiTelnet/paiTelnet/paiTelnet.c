/********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Program: paiTelnet
 * File: paiTelnet.c
 * Author: goran
 * Created: June 23, 2015
 ********************************************************************
 * Implementation of program paiTelnet
 ********************************************************************/

#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
	#include <AsDefault.h>
#endif

//#include "../../bglib/bgringbuffer.h"
#include "../../libraries/bgringbuf/bgringbuffer.h"
#include "../../bglib/bgTelnetSrvr-astcpV2.h"

_GLOBAL bgRingBuffer_typ gRingBuffer;

void _INIT paiTelnetInit(void)
{
//	DefineRingBuff(&gRingBuffer);

	/* TODO: Add code here */
	bgTelnetSrvrInit(&dbgTerm, &gRingBuffer);
	
}

void _CYCLIC paiTelnetCyclic(void)
{
	/* TODO: Add code here */
	bgTelnetSrvrCyclic(&dbgTerm);
}
