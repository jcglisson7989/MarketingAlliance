(********************************************************************
 * COPYRIGHT -- pai
 ********************************************************************
 * Package: paiHMI
 * File: paiHmiSystemNetworking.typ
 * Author: goran
 * Created: August 28, 2013
 *********************************************************************)
(*########################################################################*)
(*HMI object - System Time*)
(*########################################################################*)

TYPE
	paiHmiNumericalNetworkAddr_typ : 	STRUCT 
		ipAddr : ARRAY[0..3]OF USINT;
		netMask : ARRAY[0..3]OF USINT;
		broadcast : ARRAY[0..3]OF USINT;
		gateway : ARRAY[0..3]OF USINT;
	END_STRUCT;
	paiHmiSystemNetworking_typ : 	STRUCT 
		iChangeNWSettings : BOOL;
		iConfigIsValid : BOOL;
		iPtrNWConfig : REFERENCE TO paiARNetworkAddress_typ;
		oCurrentNWSettings : paiARNetworkAddress_typ;
		oNumericalNWSettings : paiHmiNumericalNetworkAddr_typ;
		oError : UDINT;
		oErrorText : STRING[63];
		oState : UDINT;
		mGetIpAddr : CfgGetIPAddr;
		mSetIpAddr : CfgSetIPAddr;
		mGetSubnetMask : CfgGetSubnetMask;
		mSetSubnetMask : CfgSetSubnetMask;
		mGetBroadcastAddr : CfgGetBroadcastAddr;
		mSetBroadcastAddr : CfgSetBroadcastAddr;
		mGetDefaultGateway : CfgGetDefaultGateway;
		mSetDefaultGateway : CfgSetDefaultGateway;
		mGetHostName : CfgGetHostName;
		mSetHostHame : CfgSetHostName;
		New_Member1 : USINT;
		New_Member : USINT;
		New_Member2 : USINT;
	END_STRUCT;
END_TYPE
