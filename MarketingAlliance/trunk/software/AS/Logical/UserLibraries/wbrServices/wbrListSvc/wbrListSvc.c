/********************************************************************
 * \copyright -- Piedmont Automation
 ********************************************************************
 * Program : wbrListSvc
 * \file :   wbrListSvc.c
 * \author : Blanton Radford
 * \date Created: May 07, 2015
 ******************************************************************* /
 * Implementation of library wbrListSvc
 ********************************************************************/

#ifdef __cplusplus
  extern "C"
  {
#endif

// #include "wbrsprintf_C.h"
#include "wbrListSvc.h"
#include <string.h>
  
  
listNode_typ *  head,
             *  curr;
                     
linkedList_typ *   lists;                  //!<  the list of lists



/*! \todo - document the func

 \todo - use 2nd int argument to insert nodes, neg before, pos after, zero adds at head/tail depending on setting
 \todo
*/
static UDINT lsAddNode(linkedList_typ* l, int offset)
{
 listNode_typ * posn                                                            //!<  pointer to node holding the insert position (insert before)
            , * node=   (listNode_typ *) memSvcAllocate(sizeof(listNode_typ))   //!<  new node
            ;
  
  //! \todo   check private count var lsAddNodeInProcess - should not be needed with queues using dummy tail
  
  if(node == 0) return  0;
  //! \todo   if(!lsListExists)   return  something meaningful;
  
  l->numNodes++;
  
  
       if(offset < 0){         posn=  l->curr;
                               for( ; offset < 1; offset++)   posn=  posn->prev;
       }
  else if(offset > 0){         posn=  l->curr->next;
                               for( ; offset > 1; offset--)   posn=  posn->next;
       }
  else if(l->kind == lsSTACK)  posn=  l->head;
  else                         posn=  l->dumm;   //  lsQUEUE
  
  
  node->next=       posn;
  node->prev=       posn->prev;
  
  posn->prev->next=  node;
  posn->prev=        node;
  
  
  if(l->kind == lsSTACK)  
  {
    l->head=  node;
    return  l->head->pData= memSvcAllocate(l->size);
  }
  
  l->listProcessed= 0;
  
  return  l->dumm->prev->pData= memSvcAllocate(l->size);    //! \todo   choice to use existing mem for pData
}

/*! \todo 

    \todo   choice to use existing mem for pData
            ability to use array as data, e.g. for sorting
            allocate blocks of nodes
*/
UDINT listSvcRequestListNode(linkedList_typ* l)
{
  if((l->head->next == l->dumm) && (l->head->pData == 0))       //  i.e. the list is empty
    return  l->head->pData= memSvcAllocate(l->size);    //! \todo   choice to use existing mem for pData

  
  return  lsAddNode(l, 0);    //! \todo   choice to use existing mem for pData
}


/*! \todo 
*/
// linkedList_typ * listSvcRequestList(UDINT size, linkedListKind_typ kind)
UDINT listSvcRequestList(UDINT size, linkedListKind_typ kind)
{
  linkedList_typ * l=  (linkedList_typ *)listSvcRequestListNode(lists);                                                         //  add new node to p for a new list
  
  //! \todo   handle alloc err
  
  l->head=     (listNode_typ *) memSvcAllocate(sizeof(listNode_typ));               //  head is permanent, will not be deleted, but can hold data
  l->dumm=     (listNode_typ *) memSvcAllocate(sizeof(listNode_typ));               //  dumm is a dummy tail.  See documentation for its purpose
  
  //! \todo   handle alloc errs
  
  // return  l;                                                         //  DBG:
  
  l->head->next = l->dumm;
  l->head->prev = l->dumm;

  l->dumm->next=  l->head;
  l->dumm->prev=  l->head;
  
  l->curr=  l->head;                                         
  // l->dumm=  l->head;                                         //!  \todo  change to support dummy tail and permanent head
  
  l->size=  size;
  l->kind=  kind;
  l->numNodes= 1;
  l->listProcessed= 1;
  
  curr=     l->curr;
  
  return  (UDINT)l;                                                         //  
}

/*!
 \warning   this init must be called in the first Init-SP in TC#1
            after memory is initialized
*/
BOOL initListSvc(BOOL memValid)
{
  if(!memValid)   return  0;      //!<  \todo   report error
  
  head=   (listNode_typ *) memSvcAllocate(sizeof(listNode_typ));                  //  create node for list of lists

  head->pData=   (UDINT)memSvcAllocate(sizeof(linkedList_typ));                   //  create lists list data (header) at pData
  
  lists=  (linkedList_typ *)head->pData;                                      //  lists is listIdent for the list of lists
  
  lists->head=   lists->dumm=   lists->curr=  head;                           //  init struct lists' members
  lists->head->next=  lists->head->prev=  lists->head;
  lists->size=  sizeof(linkedList_typ);
  lists->kind=  lsSTACK;
  
  return  1;
}


UINT listSvcDeleteCurrentNode(linkedList_typ * l)
{
 UINT status;
 
 
  if(l->curr == l->dumm)    return  0;
  
  if(l->curr->pData)
  {
    status= memSvcFree((UDINT)l->curr->pData);
    //! \todo   handle free error, see later in function
    l->curr->pData= 0;
  }
  // else
  // {
    //! \todo   report no mem to free
  // }
  
  if(l->head->next == l->dumm)
  {
    l->listProcessed= 1;
    return  0;    //! \todo   return status code for attempt to delete permanent head
  }
  
  l->curr->prev->next=  l->curr->next;
  l->curr->next->prev=  l->curr->prev;
  
  if(l->curr == l->head)    l->head=  l->curr->next;          //  pop/dequeue if deleting the head

  // curr= l->curr->prev;                        //  This assignment will enable GetNextNode() to function properly
  curr= l->curr->next;                        //  Automatically get next, no need to call GetNextNode()
  
  status+= memSvcFree((UDINT)l->curr);
  
  l->curr=  curr;
  l->numNodes--;
  
  if(status != 0)
  {
    //!   \todo   possibly loop to try again n times?
    //!   \todo   handle error, flag address for later memory cleanup
  }
  
  return  status;
}


/*! \brief    Returns the head node's data address
              Also points curr to head so that listSvcDeleteCurrentNode() can delete 
    \pre      \todo
    \warning  \todo
    
*/
UDINT listSvcGetHeadData(linkedList_typ * l)
{
  if(!l->head->pData)   return  0;
  
  l->curr=  l->head;                                          //  allows listSvcDeleteCurrentNode() to delete the head once the head's data is no longer needed
  
  l->listProcessed= 0;                                        //  Reset for Get****NodeData functions
  
  return  l->curr->pData;
}


/*! \brief    Returns the current node's data address
    \pre      
    \warning  Check that pData has a valid address, e.g. != 0
    
*/
UDINT listSvcGetLastNodeData(linkedList_typ * l)
{
  return  l->dumm->prev->pData;
}

/*! \brief    Returns the current node's data address
    \pre      
    \warning  Check that pData has a valid address, e.g. != 0
    
*/
UDINT listSvcGetCurrNodeData(linkedList_typ * l)
{
  return  l->curr->pData;
}

/*! \brief    Advances to the next node and returns the data address
              This function has special conditions for the head and dumm nodes
    \pre      \todo
    \warning  \todo
    
*/
UDINT listSvcGoNextNodeAndGetData(linkedList_typ * l)
{
  if(l->curr == l->head)  l->listProcessed= 0;
  
  curr=   l->curr=  l->curr->next;
  
  if(l->curr == l->dumm)
  {
    curr= l->curr=  l->head;                                         
    l->listProcessed= 1;
  }
  
  return  l->curr->pData;
}


/*! \brief    Print list of char strings to string array
              
    \pre      An array of sufficient size to contain all strings of interest
    \warning  \todo
    \todo     Provide an index that will allow <elements> nodes to be listed starting at the index
              Allow paging by offsetting <index> by <elements> * <offsetFactor>
                Possibly show a full page if pages > 1 and the end of the list is reached
              Begin destroying nodes when memInfo.maxBlockSizeFree == tbd% of configured memory block size
                This is needed since this func is used for logging to prevent the logging from growing forever
              Option to save list to file when above todo is triggered
                Option to save list on request
              Use wbrListSvcStringList_typ as input
    
**********************************************/
UDINT listSvcCharListToStringArray(

            linkedList_typ * l        //!<  The list to be read into a string array
          , char* s                   //!<  Pointer to the string array used for viewing
          , UDINT sLength             //!<  Length of the strings
          , UDINT elements            //!<  Number of elements in the array
          , UDINT offset              //!<  Offset into the list
          , UDINT pageOffsetFactor    //!<  Additional offset into the list by n "pages" of size <elements>
          , UDINT maxNodes            //!<  Maximum number of nodes to keep in the list.  Can be less than elements.  Zero will allow unlimited nodes.
          , BOOL  direction           //!<  Direction the list is read.  See code comments for details
          , char* filterString        //!<  String used to filter the list.  Any node data which the first chars don't match will not be added to the view list.
          )
            
// ****************************************** /
{
 UDINT      i
          , o
          , elementsPrinted=  0
          , elementsCleared=  0
          , nodesSkipped=     0
          , nodesProcessed=   0
          , order=  (l->kind << 1) + direction
          ;
                
 listNode_typ * work= l->dumm;
 
  
  offset+=  pageOffsetFactor * elements;
  o=  offset;
  
  if(offset >= l->numNodes)  {
    wbrsnprintf(s, sLength, "Offset too large.  Nothing to print.");
    s+= sLength;
    for(i=  1;  i < elements ; i++, s+= sLength)
      s[0]= 0;
    return  1;
  }
  
  for(i=  0;  (elementsPrinted + elementsCleared) < elements ; i++)
  {
    nodesProcessed=  elementsPrinted + elementsCleared + nodesSkipped;
    
    switch(order)
    {
     case   0:      //  stack, FIFO   lsPRINT_CHAR_STACK_FIFO
     case   3:      //  queue, LIFO   lsPRINT_CHAR_QUEUE_LIFO
      if(maxNodes && l->numNodes > maxNodes)
      {
        l->curr=  work->next;
        while(l->numNodes > maxNodes)  {
          listSvcDeleteCurrentNode(l);
        }
      }
      
      while(o > 0)  work= work->prev, o--, nodesSkipped++;
      
      if(work->prev == l->dumm)   {
        s[0]= 0;
        elementsCleared++;
        s+= sLength;
        continue;
      }
      
      work= work->prev;
      
      break;
      
     case   1:      //  stack, LIFO   lsPRINT_CHAR_STACK_LIFO
     case   2:      //  queue, FIFO   lsPRINT_CHAR_QUEUE_FIFO
      if(maxNodes && l->numNodes > maxNodes)
      {
        l->curr=  work->prev;
        while(l->numNodes > maxNodes)  {
          listSvcDeleteCurrentNode(l);
          if(l->curr->prev != l->dumm)
            l->curr=  l->curr->prev;
        }
      }
      
      while(o > 0)  work= work->next, o--, nodesSkipped++;
      
      if(work->next == l->dumm)  {
        s[0]= 0;
        elementsCleared++;
        s+= sLength;
        continue;
      }
      
      work= work->next;
      break;
    }
    
    if(!work->pData)                        return  elementsPrinted;
    if(strncmp((char *)work->pData, filterString, strlen(filterString)))  {
      nodesSkipped++;
      continue;
    }
    
    elementsPrinted++;
    // wbrsnprintf(s, sLength, "%s", (char *)work->pData);
    // wbrsnprintf(s, sLength, "%d. %s"
              // , (elementsPrinted + offset)
              // , (char *)work->pData
             // );
    wbrsnprintf(s, sLength, "%*d. %s"
              , (elements + offset) > 99 ? 3 : 2
              , (elementsPrinted + offset)
              , (char *)work->pData
             );
    s+= sLength;
  }
  
  return  elementsPrinted;
}


/*! \brief    List node addresses for debugging
              
    \pre      An array of sufficient size to contain all addresses of interest
    \warning  \todo
    \todo     Provide an index that will allow <elements> nodes to be listed starting at the index
              Allow paging by offsetting <index> by <elements> * <offsetFactor>
              Possibly combine this with listSvcCharListToStringArray() since the code is similar.
                This will require moving this func above listSvcCharListToStringArray().
    
**********************************************/
UDINT listCurrentEntries(

            linkedList_typ * l        //!<  the list to be read into an array
          , UDINT a[]                 //!<  the array
          , UDINT elements            //!<  number of elements in the array
          , UDINT offset              //!<  offset into the list
          , UDINT pageOffsetFactor    //!<  additional offset into the list by n "pages" of size <elements>
          , BOOL  getData             //!<  if TRUE, get the address of the data.  Else, get the node address
          )
          
// ****************************************** /
{
 UDINT          i;
 
 listNode_typ * work=  l->head;
 
  
  offset+=  pageOffsetFactor * elements;
  
  for(  ;  offset > 0; work= work->next, offset--)     {  }
    
  for(i= 0; i<elements ; work= work->next, i++)
  {
    if(getData)   a[i]= (UDINT)work->pData;               //  
    else          a[i]= (UDINT)work;               //  
    if(work->next == l->dumm)  break;
  }
  
  if(i < (elements - 1))    a[++i]=  0;
  
  return  i;
}

#ifdef __cplusplus
  }
#endif
