/*!
 ********************************************************************
### Program : wbrService
 * \file :   wbrUSBService.c
 * \author : Blanton Radford
 * \date Created: November 02, 2016
 * \copyright -- Piedmont Automation
 ********************************************************************
 * \brief Cyclic updates for the package WBRServices
 ********************************************************************/

#ifdef _DEFAULT_INCLUDES
  #include <AsDefault.h>
#endif

#include  <string.h>


// int   usb->nextNodeIdx=  0;
// _LOCAL  USINT stringDescriptorIndex;


/*————————————————————————————————————————————————————————————————————————————*/
/*! \brief Monitor USB device ready, destroy if false
    \pre                                                                        
                                                                                
rtyp              ƒ(x)————————¬  —argument comments—————————————————————————•••™  */

static  void  monitorNodeReady(

        wbrUSBService_typ * usb                     //!< 
      )
{
 int  i;
 
 
  for(i=0;  i < wbrusbNUM_NODES;  i++)  {
    if(   usb->node[i].deviceData.interfaceClass == asusb_CLASS_MASS_STORAGE
       && usb->node[i].isActive == 1) 
    {
      
      UsbMsDeviceReady(&usb->node[i].fbMonStorageReady);
      
      if(usb->node[i].fbMonStorageReady.status == wbrSvc_AsFBStatus_SUCCESS ) {
        usb->node[i].isReady= 1;
        usbServiceIF[i].isReady= 1;
        usbServiceIF[i].isFileIODevice= 1;
        continue;
      }
      if(usb->node[i].fbMonStorageReady.status == asusbERR_USB_NOTFOUND)   {
        memset( &usb->node[i]
              , 0
              , sizeof(usb->node[i]) - sizeof(usb->node[i].fbMonStorageReady)
              );
        memset( &usbServiceIF[i]
              , 0
              , sizeof(usbServiceIF[i])
              );
        if( i < usb->nextNodeIdx )    usb->nextNodeIdx= i;
      }
    }
  }
}
/*————————————————————————————————————————————————————————————————————————————*/

/*————————————————————————————————————————————————————————————————————————————*/
/*! \brief Monitor for changes in the USB node list from FB
    \pre                                                                        
                                                                                
rtyp              ƒ(x)————————¬  —argument comments—————————————————————————•••™  */

static  BOOL  monitorChangesInNodeList(

        wbrUSBService_typ * usb                     //!< 
      )
{
 int  i, j;
 
 BOOL   
        idExists= 0;
      ;
 
 
  usb->list.fb.enable = 1;
  usb->list.fb.pBuffer = (UDINT)&usb->list.listCurr;
  usb->list.fb.bufferSize = sizeof(usb->list.listCurr);
  usb->list.fb.filterInterfaceClass = 0;
  usb->list.fb.filterInterfaceSubClass = 0;
  UsbNodeListGet(&usb->list.fb);
  
  switch(usb->list.fb.status)    {
   case 32900:   // case asusbERR_USB_NOTFOUND:
    monitorNodeReady(usb);
    return  0;
    
   case wbrSvc_AsFBStatus_SUCCESS:
    for(i=0;  i < wbrusbNUM_NODES;  i++)  {
      if(usb->list.listCurr[i] != usb->list.listPrev[i])  {
        for(j=0;  j < wbrusbNUM_NODES; j++)
          if(usb->list.listCurr[i] == usb->list.listPrev[j])  {
            
            idExists= 1;
            break;    //  nodeID already in list
          }
        if(idExists)  {
          idExists= 0;
          usb->list.listPrev[i]=  usb->list.listCurr[i];
          continue;
        }
        usb->list.listPrev[i]=  usb->list.listCurr[i];
        usb->list.newNodeDetected=  1;
        
        usb->node[usb->nextNodeIdx].string[0].isWorking=
              usb->node[usb->nextNodeIdx].string[1].isWorking=
              usb->node[usb->nextNodeIdx].string[2].isWorking=
              usb->node[usb->nextNodeIdx].string[3].isWorking=
            usb->node[usb->nextNodeIdx].isWorking= 1;
        
        usb->node[usb->nextNodeIdx].fbGetNode.nodeId=
              usb->node[usb->nextNodeIdx].fbGetDescDev.nodeId=
              usb->node[usb->nextNodeIdx].string[0].fb.nodeId=
              usb->node[usb->nextNodeIdx].string[1].fb.nodeId=
              usb->node[usb->nextNodeIdx].string[2].fb.nodeId=
              usb->node[usb->nextNodeIdx].string[3].fb.nodeId=
            usb->list.listCurr[i];
        usb->node[usb->nextNodeIdx].isNew= 1;
        
        
        usb->node[usb->nextNodeIdx].fbGetNode.enable=      1;
        usb->node[usb->nextNodeIdx].fbGetNode.pBuffer=
            (UDINT)&usb->node[usb->nextNodeIdx].deviceData;
        usb->node[usb->nextNodeIdx].fbGetNode.bufferSize=
            sizeof(usb->node[usb->nextNodeIdx].deviceData);
        
        UsbNodeGet(&usb->node[usb->nextNodeIdx].fbGetNode);
        
        
        usb->node[usb->nextNodeIdx].string[0].fb.enable=
            usb->node[usb->nextNodeIdx].fbGetDescDev.enable=      1;
        usb->node[usb->nextNodeIdx].fbGetDescDev.requestType=     asusb_USB_RT_DEVICE;
        usb->node[usb->nextNodeIdx].fbGetDescDev.descriptorType=  asusb_USB_DESCR_DEVICE;
        usb->node[usb->nextNodeIdx].string[0].fb.requestType=     asusb_USB_RT_DEVICE;
        usb->node[usb->nextNodeIdx].string[0].fb.descriptorType=  asusb_USB_DESCR_STRING;
        usb->node[usb->nextNodeIdx].string[0].fb.descriptorIndex=
            usb->node[usb->nextNodeIdx].fbGetDescDev.descriptorIndex= 0;
        usb->node[usb->nextNodeIdx].string[0].fb.languageId=
            usb->node[usb->nextNodeIdx].fbGetDescDev.languageId=      0;
        usb->node[usb->nextNodeIdx].fbGetDescDev.pBuffer=
            (UDINT)&usb->node[usb->nextNodeIdx].deviceDescriptor;
        usb->node[usb->nextNodeIdx].fbGetDescDev.bufferSize=
            sizeof(usb->node[usb->nextNodeIdx].deviceDescriptor);
        usb->node[usb->nextNodeIdx].string[0].fb.pBuffer=
            (UDINT)&usb->node[usb->nextNodeIdx].string[0].descriptor;
        usb->node[usb->nextNodeIdx].string[0].fb.bufferSize=
              sizeof(usb->node[usb->nextNodeIdx].string[0].descriptor)
            + sizeof(usb->node[usb->nextNodeIdx].string[0].descContainer);
        
        UsbDescriptorGet(&usb->node[usb->nextNodeIdx].fbGetDescDev);
        UsbDescriptorGet(&usb->node[usb->nextNodeIdx].string[0].fb);
        
        
        //  find next empty node
        usb->nextNodeIdx++;
        for(  ; usb->node[usb->nextNodeIdx].isActive; usb->nextNodeIdx++) {}
        
        
      }
    }
    break;
    
   case 32901:   // case asusbERR_BUFSIZE:
   case 32902:   // case asusbERR_NULLPOINTER:
    /* Error Handling */
   default:
    break;
  }

  return  (BOOL)usb->list.fb.listNodes;
}
/*————————————————————————————————————————————————————————————————————————————*/

/*————————————————————————————————————————————————————————————————————————————*/
/*! \brief Get node data using FBs, publish device name
    \pre                                                                        
                                                                                
rtyp              ƒ(x)————————¬  —argument comments—————————————————————————•••™  */

static  void  getNodeDataAndPublishDeviceLinkInfo(

        wbrUSBService_typ * usb                     //!< 
      )
{
 int  i, j;
 
 
  usb->list.newNodeDetected=  0;
  
  for(i=0;  i < wbrusbNUM_NODES;  i++)  {
    /// \todo  if node empty && usb->nextNodeIdx > i, usb->nextNodeIdx=  i;
    if(usb->node[i].isNew == 0)   continue;
    
  
    switch(usb->node[i].fbGetNode.status)      {
     case wbrSvc_AsFBStatus_BUSY:
      
      UsbNodeGet(&usb->node[i].fbGetNode);
      
      if(usb->node[i].fbGetNode.status  == wbrSvc_AsFBStatus_BUSY)
        break;
    
     case wbrSvc_AsFBStatus_SUCCESS:
      usb->node[i].isActive=  1;
      
      if(usb->node[i].deviceData.interfaceClass == asusb_CLASS_MASS_STORAGE) {
        wbrsnprintf(usbServiceIF[i].fileIODeviceParam
                  , sizeof(usbServiceIF[i].fileIODeviceParam)
                  , "/DEVICE=%s"
                  , usb->node[i].deviceData.ifName
                  );
        usb->node[i].fbMonStorageReady.enable=  1;
        usb->node[i].fbMonStorageReady.pIfName= (UDINT)usb->node[i].deviceData.ifName;
      }
      usb->node[i].fbGetNode.status++;
      break;
      
     case 32900:   // case asusbERR_USB_NOTFOUND:
     case 32901:   // case asusbERR_BUFSIZE:
     case 32902:   // case asusbERR_NULLPOINTER:
      break;
    }
    
    
    switch(usb->node[i].fbGetDescDev.status)      {
     case wbrSvc_AsFBStatus_BUSY:
      
      UsbDescriptorGet(&usb->node[i].fbGetDescDev);
    
      if(usb->node[i].fbGetDescDev.status  == wbrSvc_AsFBStatus_BUSY)
        break;
    
     case wbrSvc_AsFBStatus_SUCCESS:
      usb->node[i].string[1].fb.descriptorIndex=
          usb->node[i].deviceDescriptor.manufacturerIndex;
      usb->node[i].string[2].fb.descriptorIndex=
          usb->node[i].deviceDescriptor.productIndex;
      usb->node[i].string[3].fb.descriptorIndex=
          usb->node[i].deviceDescriptor.serialNumberIndex;
      
      
      for(j=1;  j < 4;  j++)  {
        usb->node[i].string[j].fb.enable=          1;
        usb->node[i].string[j].fb.requestType=     asusb_USB_RT_DEVICE;
        usb->node[i].string[j].fb.descriptorType=  asusb_USB_DESCR_STRING;
        usb->node[i].string[j].fb.languageId=      0;
        usb->node[i].string[j].fb.pBuffer=
            (UDINT)&usb->node[i].string[j].descriptor;
        usb->node[i].string[j].fb.bufferSize=
              sizeof(usb->node[i].string[j].descriptor)
            + sizeof(usb->node[i].string[j].descContainer);
        
        UsbDescriptorGet(&usb->node[i].string[j].fb);
      }
      usb->node[i].isWorking= 0;
      usb->node[i].fbGetDescDev.status++;
      break;
      
     case 32900:   // case asusbERR_USB_NOTFOUND:
     case 32901:   // case asusbERR_BUFSIZE:
     case 32902:   // case asusbERR_NULLPOINTER:
      break;
    }
    
    for(j=0;  j < 4;  j++)  {
      switch(usb->node[i].string[j].fb.status)      {
       case wbrSvc_AsFBStatus_BUSY:
      
          UsbDescriptorGet(&usb->node[i].string[j].fb);
    
        if(usb->node[i].string[j].fb.status  == wbrSvc_AsFBStatus_BUSY)
          break;
      
       case wbrSvc_AsFBStatus_SUCCESS:
        usb->node[i].string[j].isWorking= 0;
        break;
      
       case 32900:   // case asusbERR_USB_NOTFOUND:
       case 32901:   // case asusbERR_BUFSIZE:
       case 32902:   // case asusbERR_NULLPOINTER:
        break;
      }
    }
    
    if(   usb->node[i].isWorking            == NO
       && usb->node[i].string[0].isWorking  == NO
       && usb->node[i].string[1].isWorking  == NO
       && usb->node[i].string[2].isWorking  == NO
       && usb->node[i].string[3].isWorking  == NO)
    {
      usb->node[i].isNew= 0;
    }
    else  {
      usb->list.newNodeDetected=  1;
    }
  }
}
/*————————————————————————————————————————————————————————————————————————————*/

/*————————————————————————————————————————————————————————————————————————————*/
/*! \brief Monitor USB device ready, destroy if false
    \pre                                                                        
                                                                                
rtyp              ƒ(x)————————¬  —argument comments—————————————————————————•••™  */

void  wbrUSBMonitor(

        // usbNode_typ usbNode                     //!< 
      )
{
  if(!monitorChangesInNodeList(&usbService))   return;
  
  if(usbService.list.newNodeDetected)  {
    // for(i=0; i< ; i++){
      getNodeDataAndPublishDeviceLinkInfo(&usbService);
      
    // }
  }
  
  monitorNodeReady(&usbService);
}
/*————————————————————————————————————————————————————————————————————————————*/


