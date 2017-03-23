/********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Package: paiFileService
 * File: paFSInterface.h
 * Author: goran
 * Created: August 18, 2015
 *******************************************************************/

#include <bur/plctypes.h>

BOOL paiFSFileRequestIsBusy(paiFileService_typ* p);
BOOL paiFSFileSystemIsInit(paiFileService_typ* p);
void paiFSExeCallback(paiFileService_typ* p);
void paiFSExeCallbackCyclic(paiFileService_typ* p);
void paiFSSetCallback(paiFileService_typ* p, UDINT pCallback, UDINT pCallbackData);
void paiFSDirCreateRequest(paiFileService_typ* p, UDINT adrDeviceName, UDINT adrDirPath, UDINT pCallback, UDINT pCallbackData);
void paiFSDirInfoRequest(paiFileService_typ* p, UDINT adrDeviceName, UDINT adrDirPath, UDINT pCallback, UDINT pCallbackData);
void paiFSFileDelRequest(paiFileService_typ* p, UDINT adrDeviceName, UDINT adrFilePath, UDINT pCallback, UDINT pCallbackData);
void paiFSFileRdRequest(paiFileService_typ* p, UDINT adrDeviceName, UDINT adrFilePath, UDINT adrDst, UDINT sizeDst, UDINT pCallback, UDINT pCallbackData);
void paiFSFileWrRequest(paiFileService_typ* p, UDINT adrDeviceName, UDINT adrFilePath, UDINT adrSrc, UDINT sizeSrc, UDINT pCallback, UDINT pCallbackData);
//EOF
