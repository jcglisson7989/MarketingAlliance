/********************************************************************
 * \copyright -- Piedmont Automation
 ********************************************************************
 * Program : wbrMemSvc
 * \file :   wbrMemSvc.c
 * \author : Blanton Radford
 * \date Created: April 14, 2016
 ******************************************************************* /
 * Implementation of library wbrListSvc
 ********************************************************************/

#include "wbrMemSvc.h"
  
  
AsMemPartAllocClear_typ   allocate;
AsMemPartFree_typ         freeMem;
AsMemPartRealloc_typ      reAllocate;
AsMemPartInfo_typ         memInfo;


/*! \todo 
*/
UDINT memSvcAllocate(UDINT size)
{
  allocate.len=     size;
  AsMemPartAllocClear(&allocate);
  if(allocate.status == 0)  return  allocate.mem;
  
  //! \todo   handle errors
  return  0;
}


/*! \brief Init-SP for AsMem heap memory and linked list services
    \warning   This init must be called in the first Init-SP in TC#1
*/
BOOL initMemSvc(UDINT partitionSize)
{
 AsMemPartCreate_typ  getMem;
 
 
  getMem.ident= 0;    //  Init to zero for return value - see below
  
  getMem.enable=
      allocate.enable=
      freeMem.enable=
      reAllocate.enable= 
      memInfo.enable=         1;
  
  getMem.len=     partitionSize;

  
  AsMemPartCreate(&getMem);
  
  allocate.ident=
      freeMem.ident= 
      reAllocate.ident= 
      memInfo.ident=          getMem.ident;

  // return  (BOOL)allocate.ident;    //  WBR:  appears to cause an illegal bool value
  return  allocate.ident != 0;
}


/*! \brief    Frees a block of heap memory
               
    \pre      \todo
    \warning  \todo
    
*/
UINT  memSvcFree(UDINT block)
{
  if(!block)
  {
    //! \todo   report null address
    return  0xAAAA;
  }

  freeMem.mem=  block;
  AsMemPartFree(&freeMem);
  
  if(freeMem.status != 0)
  {
    //!   \todo   possibly loop to try again n times?
    //!   \todo   handle error, flag address for later memory cleanup
  }
  
  return  freeMem.status;
}


/*! \brief    Returns size of the largest available memory block
              
    \pre      \todo
    \warning  \todo
    \todo     
    
**/
UDINT memSvcGetMemInfo(wbrMemService_typ * m)
{
  AsMemPartInfo(&memInfo);
  
  m->status.alloc.status= allocate.status;
  m->status.free.status=  freeMem.status;
  
  return   memInfo.maxBlockSizeFree;
}

