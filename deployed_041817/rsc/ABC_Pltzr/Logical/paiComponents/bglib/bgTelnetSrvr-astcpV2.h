#include <bur/plctypes.h>
#ifndef _BG_TELNETSERVER_V2_H
#define _BG_TELNETSERVER_V2_H

#ifdef _DEFAULT_INCLUDES
	#include <AsDefault.h>
#endif

#include "bgringbuffer.h"

void bgTelnetSrvrInit(bgSocketServer_typ* pTerm, bgRingBuffer_typ* pRB);

void bgTelnetSrvrCyclic(bgSocketServer_typ* pTerm);

#endif
