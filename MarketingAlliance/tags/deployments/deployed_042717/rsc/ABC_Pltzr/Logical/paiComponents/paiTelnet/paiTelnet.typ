(********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Package: paiTelnet
 * File: paiTelnet.typ
 * Author: goran
 * Created: June 23, 2015
 ********************************************************************
 * Data types of package paiTelnet
 ********************************************************************)

TYPE
	bgSocketServerCounter_typ : 	STRUCT 
		recv_frames : UDINT;
		iac : UDINT;
		lines : UDINT;
		send_frames : UDINT;
	END_STRUCT;
	bgSocketServer_typ : 	STRUCT 
		sockStateData : UINT;
		telnetRecvState : UINT;
		telnetSendState : UINT;
		sockSendOk : UINT;
		cmdError : INT;
		isConnected : BOOL;
		isLoggedIn : BOOL;
		isDataPortReady : BOOL;
		isEcho : BOOL;
		sockData_Timer : UINT;
		sockData_TimerTime : INT;
		sockData_TimerCounter : INT;
		dataRecvBuf : REFERENCE TO SINT;
		dataSendBuf : REFERENCE TO SINT;
		lineRecvBuf : REFERENCE TO SINT;
		ringDataBuffer : UDINT;
		sendRecvBuffer : UDINT;
		iacRecvBuf : ARRAY[0..9]OF SINT;
		New_Member3 : USINT;
		lineIndex : DINT;
		lineIndexPrev : DINT;
		TCPopen_1 : TcpOpen;
		TCPserv_1 : TcpServer;
		TCPsend_1 : TcpSend;
		TCPrecv_1 : TcpRecv;
		TCPclose_1 : TcpClose;
		TCPioctl_1 : TcpIoctl;
		MEMInfo : MEMInfo;
		memAllocStatus1 : UINT;
		memAllocStatus2 : UINT;
		counter : bgSocketServerCounter_typ;
		clientIpAddr : STRING[32];
		delayCounter : INT;
		test : INT;
		testCounter : INT;
		pRB : UDINT;
		New_Member : USINT;
	END_STRUCT;
END_TYPE
