/********************************************************************
 * COPYRIGHT -- HP
 ********************************************************************
 * Program: cfgFS
 * File: cfgFSApp.h
 * Author: goran
 * Created: March 19, 2014
 *******************************************************************/

#include <bur/plctypes.h>

/*
###############################################################################
Defines, Consts
###############################################################################
*/
/*
NOTE: Using C: disk is not the best solution considering that system files are there. 
However, using disk other then C: (i.e. D:, etc) for application stuff creates
issue with the ability to view/copy/access application files from windows (multiple partitions not supported, etc)

File structure used in this application is following:

Directory:
C://Data
is used for application specific stuff. 
This directory holds following files:
machine configuration file - "appcfg.txt"
machine factory deafult configuration file - "appcfgfactory.txt");

a subdirectory (REC) of the above directory is used for storing recipes.
C://Data/Rec

*/

#define APP_FILE_SIZE_MAX  30000 //max file size for any recipe or config file

#define APP_DIR_NAME "Data" //root app directory; Example: C://Data
#define APP_REC_DIR_NAME "Rec" // recipes directory; Example "C://Data/Rec"

#define APP_FILENAME_CFG "appcfg.txt"
#define APP_FILENAME_CFGDEFAULT "appcfgfactory.txt"
#define APP_FILENAME_CURRECIPE "apprec.txt"


