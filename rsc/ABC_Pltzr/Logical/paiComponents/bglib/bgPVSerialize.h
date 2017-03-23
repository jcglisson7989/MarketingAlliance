/**\file: bgPVSerialize.h
*Serialize/deserialize a PV to/from text stream.
*/
#include <bur/plctypes.h>
#ifndef _BG_PVSERIALIZE_H
#define _BG_PVSERIALIZE_H

/**
Serialize a PV (*pvNameRoot) to an output stream (* toOutStream) with a max length of (lengthOutStream). 
\param pvNameRoot ptr to a PV name
\param toOutStream ptr to an output stream (i.e. char buffer)
\param lengthOutStream max length of the output stream in bytes
\return -1 error
\return >=0 number of bytes written to the output stream 
*/
DINT bgPVStructSerialize(char* pvNameRoot, char* toOutStream, UDINT lengthOutStream);


/**
Deserialize a PV (*pvNameRoot) from an input stream (* fromStream) that contains (lengthStream) of valid text data. 
\param pvNameRoot ptr to a PV name
\param fromStream ptr to an input stream (i.e. char buffer)
\param lengthStream length of the content in the input stream in bytes
\return -1 error
\return >=0 TODO 
*/
DINT bgPVStructDeserialize(char* pvNameRoot, char* fromStream, UDINT lengthStream);


/**
Compare two instances of the same structure type using PV services and provide diff report into the given output stream (* toOutStream) with a max length of (lengthOutStream). 
\param pvNameRoot ptr to an instance 1 of the PV structure
\param pvNameRoot2 ptr to an instance 2 of the PV structure
\param toOutStream ptr to an output stream (i.e. char buffer)
\param lengthOutStream max length of the output stream in bytes
\return -1 error
\return >=0 number of bytes written to the output stream 
*/
DINT bgPVStructCompare(char* pvNameRoot, char* pvNameRoot2, char* toOutStream, UDINT lengthOutStream);

#endif
