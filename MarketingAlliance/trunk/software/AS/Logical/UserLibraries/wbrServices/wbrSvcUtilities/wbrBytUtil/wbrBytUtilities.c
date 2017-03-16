/*!
 ********************************************************************
### Library : wbrBytUtil
 * \file :   wbrBytUtilities.c
 * \author : Blanton Radford
 * \date Created: Friday, October 14, 2016
 * \copyright  Piedmont Automation
 ********************************************************************
 * \brief Utilities for extracting bytes from or packing bytes into words,
          ints, etc.
 ********************************************************************/

/*! \mainpage Example logbook manager to create, get info from, and write to user created logbooks using \e wbrLogSvc functions    
    
#   A main heading
    
    Some text
    
##  A subheading

    More text
    
    A separator
    -----------
    
    Even more txt
    
##  See \e Files selection above for more info on the functions and how to 
##  use them.
*/

#include "wbrBytUtil.h"




/*覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧*/
/*! \brief Get the high 16-bit word from a 32-bit double word 
    \pre                                                                        
                                                                                
rtyp  �(x)覧覧流  覧覧覧覧覧覧預rgument comments覧覧覧覧覧覧覧覧覧覧覧覧覧覧封蕗  */

UINT  getHiWord(

        UDINT dword                     //!< 32-bit unsigned int or word input
      )
{
 UINT hi=  (UINT)(dword >> 16);

  return  hi;
}
/*覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧*/

/*覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧*/
/*! \brief Split 32-bit Dword or integer into two 16-bit words
    \pre                                                                        
                                                                                
rtyp              �(x)覧覧覧覧ｬ  預rgument comments覧覧覧覧覧覧覧覧覧覧覧覧藍封�  */

dwordToWords_typ  dwordToWords(

        UDINT dword                     //!< 32-bit unsigned int or word input
      )
{
 dwordToWords_typ word;
 
 
  word.lo=  (UINT)dword;
  word.hi=  (UINT)(dword >> 16);

  return  word;
}
/*覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧*/

/*覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧*/
/*! \brief Split 16-bit Dword or integer into two 8-bit bytes
    \pre                                                                        
                                                                                
rtyp              �(x)覧覧覧流  覧覧覧覧覧覧覧覧覧argument comments覧覧覧覧覧覧覧藍封�  */

wordToBytes_typ   wordToBytes(

        UDINT word                     //!< 32-bit unsigned int or word input
      )
{
 wordToBytes_typ byte;
 
 
  byte.lo=  (UINT)word;
  byte.hi=  (UINT)(word >> 8);

  return  byte;
}
/*覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧*/

