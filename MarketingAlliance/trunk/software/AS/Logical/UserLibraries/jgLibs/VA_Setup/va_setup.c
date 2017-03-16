#include <bur/plc.h>
#include <bur/plctypes.h>
#include <visapi.h>

unsigned short VA_SetupSt(plcbit enable, unsigned long* VcHandle, plcstring* pProjectName)
{
    return VA_SetupX(enable,(UDINT)(VCHANDLE*)VcHandle,pProjectName);
}


