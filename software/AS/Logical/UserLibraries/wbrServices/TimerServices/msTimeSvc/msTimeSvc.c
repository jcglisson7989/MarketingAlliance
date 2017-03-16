/*!
 ********************************************************************
### Program : msTimeSvc
 * \file :   msTimeSvc.c
 * \author : Blanton Radford
 * \date Created: December 05, 2014
 * \copyright -- Piedmont Automation
 ********************************************************************
 * \brief Implementation of program msTimeSvc
 ********************************************************************/

#ifdef _DEFAULT_INCLUDES
  #include <AsDefault.h>
#endif

 
_LOCAL BOOL running;    //  temporary
_LOCAL UDINT  run_ms;   //  temp

msTimer_typ * t=  &msTimer;

msTmPulsePeriodDutyInOut_typ  periodDutyDurationTable[perLAST][dutyLAST + durLAST]=
{
  {
      {  100,  1.0, 0}        //  period in ms, duty cycle in Hz, output
    , {  100, 10.0, 0}
    , {  100, 20.0, 0}
    , {  100, 25.0, 0}
    , {  100, 50.0, 0}
    , {  100, 01.0, 0}        //  period in ms, duty cycle in Hz, output
    , {  100, 10.0, 0}
    , {  100, 20.0, 0}
  }
 ,{
      {  200,  1.0, 0}        //  period, duty cycle, output
    , {  200, 10.0, 0}
    , {  200, 20.0, 0}
    , {  200, 25.0, 0}
    , {  200, 50.0, 0}
    , {  200, 01.0, 0}        //  period, duration, output
    , {  200, 10.0, 0}
    , {  200, 20.0, 0}
  }
 ,{
      {  500,  1.0, 0}        //  period, duty cycle, output
    , {  500, 10.0, 0}
    , {  500, 20.0, 0}
    , {  500, 25.0, 0}
    , {  500, 50.0, 0}
    , {  500, 01.0, 0}        //  period, duration, output
    , {  500, 10.0, 0}
    , {  500, 20.0, 0}
  }
 ,{
      { 1000,  1.0, 0}        //  period, duty cycle, output
    , { 1000, 10.0, 0}
    , { 1000, 20.0, 0}
    , { 1000, 25.0, 0}
    , { 1000, 50.0, 0}
    , { 1000, 01.0, 0}        //  period, duration, output
    , { 1000, 10.0, 0}
    , { 1000, 20.0, 0}
  }
 ,{
      { 2000,  1.0, 0}        //  period, duty cycle, output
    , { 2000, 10.0, 0}
    , { 2000, 20.0, 0}
    , { 2000, 25.0, 0}
    , { 2000, 50.0, 0}
    , { 2000, 01.0, 0}        //  period, duration, output
    , { 2000, 10.0, 0}
    , { 2000, 20.0, 0}
  }
 ,{
      { 5000,  1.0, 0}        //  period, duty cycle, output
    , { 5000, 10.0, 0}
    , { 5000, 20.0, 0}
    , { 5000, 25.0, 0}
    , { 5000, 50.0, 0}
    , { 5000, 01.0, 0}        //  period, duration, output
    , { 5000, 10.0, 0}
    , { 5000, 20.0, 0}
  }
 ,{
      {10000,  1.0, 0}        //  period, duty cycle, output
    , {10000, 10.0, 0}
    , {10000, 20.0, 0}
    , {10000, 25.0, 0}
    , {10000, 50.0, 0}
    , {10000, 01.0, 0}        //  period, duration, output
    , {10000, 10.0, 0}
    , {10000, 20.0, 0}
  }
}  ;

  
  
static  BOOL  pulsePeriodDurationWithOffset(
          UDINT per     //  period in ms
        , UDINT dur     //  Duration ( pulse on time) in ms
        , UDINT off     //  offset of start of pulse in ms
        )
{
  if(per < 2)   return  0;                                                      //  Period must be at least 2ms using ms precision
                                                                                //  Period must also be at least 2 * TC cycle time
  return  (   ((t->C1ms % per) >= off)
           && ((t->C1ms % per) < dur + off));
}

BOOL  getPulseOfPeriodAndDurationWithOffset(
          UDINT per     //  period in ms
        , UDINT dur     //  Duration ( pulse on time) in ms
        , UDINT off     //  offset of start of pulse in ms
        )
{
  return  pulsePeriodDurationWithOffset(per, dur, off);
}

BOOL  pulsePeriodDuration(
          UDINT per     //  period in ms
        , UDINT dur     //  Duration ( pulse on time) in ms
        )
{
  return  pulsePeriodDurationWithOffset(per, dur, 0);
}

BOOL  pulsePeriodDuty(
          UDINT per     //  period in ms
        , REAL  duty    //  duty cycle in %
        )
{
  if(duty <= 0.0)      return  0;                                                  //  Duty cycle must be greater than zero
  if(duty >= 100.0)    return  1;                                                  //  Signal always on if duty greater than 100%
  
  return  pulsePeriodDurationWithOffset(
                        per
                      , (UDINT)((REAL)per * duty / 100.0)
                      , 0
                      );
}

BOOL  pulseFreqDuty(
          REAL  f       //  frequency in Hz
        , REAL  d       //  duty cycle in %
        )
{
  if(d <= 0.0)      return  0;                                                  //  Duty cycle must be greater than zero
  if(f <= 0.0)      return  0;                                                  //  Prevent divide by zero
  if(f > 500.0)     return  0;                                                  //  Can't process higher frequencies using ms precision
  
  if(d >= 100.0)    return  1;                                                  //  Signal always on if duty greater than 100%
  
  return  pulsePeriodDurationWithOffset(
                        (UDINT)(1000.0 / f)
                      , ((UDINT)(1000.0 / f) * d / 100.0)
                      , 0
                      );
}

BOOL  pulseFreqDutyWithOffset(
          REAL  f       //  frequency in Hz
        , REAL  d       //  duty cycle in %
        , REAL  o       //  offset of start of pulse in %
        )
{
  if(d <= 0.0)      return  0;                                                  //  Duty cycle must be greater than zero
  if(f <= 0.0)      return  0;                                                  //  Prevent divide by zero
  if(f > 500.0)     return  0;                                                  //  Can't process higher frequencies using ms precision
  
  if(d >= 100.0)                  return  1;                                    //  Signal always on if duty greater than 100%
  if(o >= 100.0)                  return  0;                                    //  Signal always off if offset greater than 100%
  
  return  pulsePeriodDurationWithOffset(
                        (UDINT)(1000.0 / f)
                      , ((UDINT)(1000.0 / f) * d / 100.0)
                      , ((UDINT)(1000.0 / f) * o / 100.0)
                      );
}

BOOL  pulseFreqDuration(
          REAL  f       //  frequency in Hz
        , UDINT dur     //  Duration ( pulse on time) in ms
        )
{
  if((f <= 0.0) || (f > 500.0))   return  0;
  
  return  pulsePeriodDurationWithOffset(
                        (UDINT)(1000.0 / f)
                      , dur
                      , 0
                      );
}

BOOL  pulseFreqDurationWithOffset(
          REAL  f       //  frequency in Hz
        , UDINT dur     //  Duration ( pulse on time) in ms
        , UDINT off     //  offset of start of pulse in ms
        )
{
  if((f <= 0.0) || (f > 333.33))   return  0;
  
  return  pulsePeriodDurationWithOffset(
                        (UDINT)(1000.0 / f)
                      , dur
                      , off
                      );
}


/*! \brief Init-SP for millisecond timer services
*   \pre   Place in TC#1 or first used TC
*/
void _INIT msTimeSvcInit(void)
{
  
}

/*! \brief Cyclic task for millisecond timer services
*   \pre   Place in TC#1 or first used TC
*/
void _CYCLIC msTimeSvcCyclic(void)
{
 int  i, j;
  
  if(t->clock_ms == 0)    t->initVal= (UDINT)clock_ms();
  
  // if(<use external clock>)
  // t->clock_external=  <count from external source>;  i.e. a TC of < 1ms duration
  
  t->clock_ms=  (UDINT)clock_ms();
  
  t->diff_ms= t->clock_ms - t->C1ms - t->initVal;   //  Will this work at rollover?
  
  t->C1ms=  t->clock_ms - t->initVal; // + <rolloverVal>
  
  //! \todo   update C1ms in case task class runs into its tolerance \
              do this using a diff calc so that the function will continue to operate even if C1ms rolls over \
              OR just use clock_ms time and live with the rollover or implement a rollover counter
  
  /*! \todo
      if(<rolloverActive>)
        <rolloverVal>=  t->clock_ms - t->initVal + <prevRolloverVal> - 4294920000U;
        
      if( !<rolloverActive> && (t->C1ms > 4294920000U))
        <prevRolloverVal>=  <rolloverVal>;
        <rolloverVal>=  t->C1ms - 4294920000U;
        XX t->C1ms=  t->clock_ms=  0;      //  Keep absolute minute count accurate - WBR: check to see if this works
        XX -- OR --
        t->C1ms=  <rolloverVal>;      //  Keep absolute minute count accurate - WBR: check to see if this works
        t->C01sAbs++;
        t->C60sAbs++;
        rolloverActive= 1;
        
      //  This code will likely need to move ahead of t->diff_ms assignment
      if(t->clock_ms < t->C1ms)     //  rolled over
        t->initVal= (UDINT)clock_ms();
        <rolloverVal>+= t->diff_ms;  // assuming diff_ms works at rollover
        rolloverActive= 0;
        assign t->C1ms as above
  */
  // t->C1ms++;                                // inc ms counter
                                            // this will roll over after
                                            // 49.7102 days of continuous
                                            // running - WBR
                                            // resets with Start button
 
  /// Calculate Other Counters
  t->C10ms=   t->C1ms /   10;
  t->C100ms=  t->C1ms /  100;
  t->C1s=     t->C1ms / 1000;
  t->C10s=    t->C1ms / 10000;
  t->C60s=    t->C1ms / 60000;
  
  if(t->C1s  > t->prev01s)    t->C01sAbs++;       //  Rolls over after 136.193 years
  if(t->C60s > t->prev60s)    t->C60sAbs++;       //  Rolls over after 8171.55 years
  
  t->prev01s=  t->C1s;
  t->prev60s=  t->C60s;
  
  ///  Calc pulse trains
  //  <boolean>=    ((t->C1ms % <period>) < <duration>);      //  example - period and duration are in ms
  
  for(i=0; i<perLAST; i++)
  {
    for(j=0; j<dutyLAST; j++)
    {
      t->pulse.periodDutyDurationTable[i].duty[j]=
      periodDutyDurationTable[i][j].oPulse= 
        pulsePeriodDuty(
            periodDutyDurationTable[i][j].iPeriodValue
          , periodDutyDurationTable[i][j].iDutyValue
          );
    }
    for( ; j < durLAST + dutyLAST; j++)
    {
      t->pulse.periodDutyDurationTable[i].duration[j - dutyLAST]=
      periodDutyDurationTable[i][j].oPulse= 
        pulsePeriodDuration(
            periodDutyDurationTable[i][j].iPeriodValue
          , periodDutyDurationTable[i][j].iDutyValue
          );
    }
  }
  
  //  new
  t->pulse01Hz100ms= pulsePeriodDuration(1000, 100);                              //  add these in the application as needed, or put frequently used ones here
  t->pulse1day100ms= pulsePeriodDuration((24*3600*1000), 100);                    //  comes on once per day for 100ms

  t->pulse.sos.msgEnable=   pulseFreqDuty(0.25, 75.0);
  t->pulse.sos.shortEnable= pulseFreqDuty(0.50,  35.0);
  t->pulse.sos.longEnable=  pulseFreqDutyWithOffset(0.25, 17.5, 25.0);
  t->pulse.sos.shortPulse=  pulseFreqDuty( 4.0,  20.0);
  t->pulse.sos.longPulse=   pulseFreqDuty( 4.0,  60.0);
  
  t->pulse.sos.codeSignal=
    (   (t->pulse.sos.msgEnable && t->pulse.sos.shortEnable && t->pulse.sos.shortPulse)
     || (t->pulse.sos.msgEnable && t->pulse.sos.longEnable && t->pulse.sos.longPulse)) ;

  //  legacy
  t->F100ms=  pulsePeriodDurationWithOffset(  100,   50, 0);
  t->F500ms=  pulsePeriodDurationWithOffset(  500,  250, 0);
  t->F1s=     pulsePeriodDurationWithOffset( 1000,  500, 0);
  t->F2s=     pulsePeriodDurationWithOffset( 2000, 1000, 0);
  t->F10s=    pulsePeriodDurationWithOffset(10000, 5000, 0);
  
  //  TODO: add configurable, periodic pulse(s), i.e. an (n)s pulse every (nn)min or (nn)day(s) or ???
  //  TODO: add hour meter(s)
  if(running)
  {
    run_ms+=  t->diff_ms;
  }
}
