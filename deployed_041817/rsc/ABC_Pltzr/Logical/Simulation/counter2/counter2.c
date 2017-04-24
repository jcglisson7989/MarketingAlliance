/********************************************************************
 * COPYRIGHT -- HP
 ********************************************************************
 * Program: counter2
 * File: counter2.c
 * Author: goran
 * Created: March 07, 2013
 ********************************************************************
 * Implementation of program counter2
 ********************************************************************/

#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
	#include <AsDefault.h>
#endif

_LOCAL int counter2;

void _INIT counter2INIT(void)
{
	/* TODO: Add code here */
}

void _CYCLIC counter2CYCLIC(void)
{
	/* TODO: Add code here */
	counter2++;
}
