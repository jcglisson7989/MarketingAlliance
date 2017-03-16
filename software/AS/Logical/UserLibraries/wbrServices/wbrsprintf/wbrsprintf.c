/*!
 ********************************************************************
### Library : wbrsprintf
 *  Package : WBRServices
 * \file :   wbrsprintf.c
 * \author : Blanton Radford, Wes Buchanan (B&R), others
 * \date Created: Approximately 2013
 * \copyright -- Piedmont Automation
 *******************************************************************
 * \brief Header file for snprintf functions.
          Use of sprintf functions discouraged as snprintf is guaranteed to
          stop writing once buf_size is filled.
          Write a printf-formatted string to memory at "line"
 ********************************************************************/

#include <stdarg.h>
#include <stdio.h>
#include <limits.h>

#include "wbrsprintf.h"


int __ofmt(FILE *stream, char *line, int buf_size,
                                     const char *format, va_list ap);


int wbrvsprintf(char *s, const char *fmt, va_list ap)
{
  return __ofmt(0, s, INT_MAX, fmt, ap);
}

int wbrvsnprintf(char *s, int buf_size, const char *fmt, va_list ap)
{
  return __ofmt(0, s, buf_size, fmt, ap);
}

int wbrsprintf(char *s, const char *fmt, ...)
{
 int num;
 va_list ap;

  va_start(ap, fmt);
  num = wbrvsprintf(s, fmt, ap);
  va_end(ap);
  return num;
}

int wbrsnprintf(char *s, int buf_size, const char *fmt, ...)
{
 int num;
 va_list ap;

  va_start(ap, fmt);
  num = wbrvsnprintf(s, buf_size, fmt, ap);
  va_end(ap);
  return num;
}

