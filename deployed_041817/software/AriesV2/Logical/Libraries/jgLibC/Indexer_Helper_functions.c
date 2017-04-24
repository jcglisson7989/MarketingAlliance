/********************************************************************
 * COPYRIGHT -- Microsoft
 ********************************************************************
 * Library: jgLibC
 * File: Indexer_Helper_functions.c
 * Author: Admin
 * Created: May 11, 2015
 *******************************************************************/

#include <bur/plctypes.h>
#include <jgLibC.h>
UDINT Tms(REAL in){
	UDINT var_return = 0;
	
	var_return = (UDINT) (1000 * in);
	
	return var_return;
}

