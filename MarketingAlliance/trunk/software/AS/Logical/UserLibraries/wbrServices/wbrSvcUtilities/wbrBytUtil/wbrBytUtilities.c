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




/*————————————————————————————————————————————————————————————————————————————*/
/*! \brief Get the high 16-bit word from a 32-bit double word 
    \pre                                                                        
                                                                                
rtyp  ƒ(x)—————¬  —————————————argument comments————————————————————————————•••™  */

UINT  getHiWord(

        UDINT dword                     //!< 32-bit unsigned int or word input
      )
{
 UINT hi=  (UINT)(dword >> 16);

  return  hi;
}
/*————————————————————————————————————————————————————————————————————————————*/

/*————————————————————————————————————————————————————————————————————————————*/
/*! \brief Split 32-bit Dword or integer into two 16-bit words
    \pre                                                                        
                                                                                
rtyp              ƒ(x)————————¬  —argument comments—————————————————————————•••™  */

dwordToWords_typ  dwordToWords(

        UDINT dword                     //!< 32-bit unsigned int or word input
      )
{
 dwordToWords_typ word;
 
 
  word.lo=  (UINT)dword;
  word.hi=  (UINT)(dword >> 16);

  return  word;
}
/*————————————————————————————————————————————————————————————————————————————*/

/*————————————————————————————————————————————————————————————————————————————*/
/*! \brief Split 16-bit Dword or integer into two 8-bit bytes
    \pre                                                                        
                                                                                
rtyp              ƒ(x)———————¬  ——————————————————argument comments———————————————•••™  */

wordToBytes_typ   wordToBytes(

        UDINT word                     //!< 32-bit unsigned int or word input
      )
{
 wordToBytes_typ byte;
 
 
  byte.lo=  (UINT)word;
  byte.hi=  (UINT)(word >> 8);

  return  byte;
}
/*————————————————————————————————————————————————————————————————————————————*/

