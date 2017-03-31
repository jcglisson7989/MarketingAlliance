/********************************************************************
 * \copyright -- Piedmont Automation
 ********************************************************************
 * Program : msTimeSvc
 * \file :   msTimeSvc.c
 * \author : Blanton Radford
 * \date Created: May 07, 2015
 ********************************************************************
 * \brief Implementation of program msTimeSvc
 ********************************************************************/

/********************************************************************
 * COPYRIGHT -- Piedmont Automation
 ********************************************************************
 * Program: msTimeSvc
 * File: msTimeSvc.c
 * Author: Blanton Radford
 * Created: December 05, 2014
 ********************************************************************
 * Implementation of program msTimeSvc
 ********************************************************************/

#ifdef _DEFAULT_INCLUDES
  #include <AsDefault.h>
#endif

 
_LOCAL BOOL running;    //  temporary
_LOCAL UDINT  run_ms;   //  temp


/*! \brief Init-SP for millisecond timer services
*   \pre   Place in TC#1 or first used TC
*/
void _INIT msTimeSvcInit(void)
{
  /* TODO: Add code here */
}

/*! \brief Cyclic task for millisecond timer services
*   \pre   Place in TC#1 or first used TC
*/
void _CYCLIC msTimeSvcCyclic(void)
{
 msTimer_typ * t=  &msTimer;
  
  
  t->clock_ms=  (UDINT)clock_ms();
  
  t->diff_ms= t->clock_ms - t->C1ms;
  
  t->C1ms=  t->clock_ms;
  
  
  // if(t->C1ms > 4294920000U)   t->C1ms=  0;      //  Keep absolute minute count accurate - WBR: check to see if this works
  if(t->C1ms > 4294920000U)   t->C1ms-= 4294920000U;      //  Keep absolute minute count accurate - WBR: check to see if this works
  //! \todo   inc t->C60sAbs?

  /// Calculate Other Counters
  t->C10ms=   t->C1ms / 10;
  t->C1s=     t->C1ms / 1000;
  t->C10s=    t->C1ms / 10000;
  t->C60s=    t->C1ms / 60000;
  
  // if(t->C60s > t->_old60s) t->C60sAbs++;
  if(t->C60s != t->_old60s) t->C60sAbs++;       //  should handle rollover
  t->_old60s=  t->C60s;

  
  ///  Calc pulse trains
  //  <boolean>=  ((t->C1ms % <period>) < <duration>);                          //  example - period and duration shall be in ms
  
  //  legacy
  t->F100ms=      ((t->C1ms %      100) <      50);
  t->F500ms=      ((t->C1ms %      500) <     250);
  t->F1s=         ((t->C1ms %     1000) <     500);
  t->F2s=         ((t->C1ms %     2000) <    1000);
  t->F10s=        ((t->C1ms %    10000) <    5000);
  
  //  new
  t->pulse01Hz100ms= ((t->C1ms % 1000) < 100);                                  //  WBR:  add these in the application as needed, or put frequently used ones here
  t->pulse1day100ms= ((t->C1ms % (24*3600*1000)) < 100);                        //  WBR:  comes on once per day for 100ms

  
  //! \todo   add configurable, periodic pulse(s), i.e. an (n)s pulse every (nn)min or (nn)day(s) or ???
  //! \todo   add hour meter(s)
  if(running)
  {
    run_ms+=  t->diff_ms;
  }
}
