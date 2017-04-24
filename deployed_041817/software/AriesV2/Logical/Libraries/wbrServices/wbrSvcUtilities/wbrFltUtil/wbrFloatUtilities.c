/********************************************************************
 * \copyright -- Piedmont Automation
 ********************************************************************
 * Program : wbrFltUtil
 * \file :   wbrFloatUtilities.c
 * \author : Blanton Radford
 * \date Created: August 18, 2015
 *******************************************************************/

#include <bur/plctypes.h>


BOOL  wbrDoubleInRange(double lo, double v1, double hi)
{
  return  ((lo < v1) && (v1 < hi));
}

BOOL  wbrDoubleCompare(double v1, double v2, double tol)
{
  return  wbrDoubleInRange(v2-tol,  v1,   v2+tol);
}
