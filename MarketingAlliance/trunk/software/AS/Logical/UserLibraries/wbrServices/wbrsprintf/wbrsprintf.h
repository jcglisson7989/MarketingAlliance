/*!
 ********************************************************************
### Library : wbrsprintf
 *  Package : WBRServices
 * \file :   wbrsprintf.h
 * \author : Blanton Radford
 * \date Created: May 3, 2016
 * \copyright -- Piedmont Automation
 *******************************************************************
 * \brief Header file for snprintf functions.
          Use of sprintf functions discouraged as snprintf is guaranteed to
          stop writing once buf_size is filled.
 ********************************************************************/

#include <stdarg.h>


/*! These are not included by default to strongly discourage the use of sprintf
    If they are uncommented, please uncomment the warning as well
*/
// #warning  "Consider using snprintf function for safety"
// int wbrvsprintf(char *s, const char *fmt, va_list ap);
// int  wbrsprintf(char *s, const char *fmt, ...);


int wbrvsnprintf(char *s, int buf_size, const char *fmt, va_list ap);
int  wbrsnprintf(char *s, int buf_size, const char *fmt, ...);

