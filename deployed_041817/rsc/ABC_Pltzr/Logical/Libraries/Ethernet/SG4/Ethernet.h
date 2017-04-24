/* Automation Studio Generated Header File, Format Version 1.00 */
/* do not change */
#ifndef ETHERNET_H_
#define ETHERNET_H_
#define _WEAK	__attribute__((__weak__))

#include <bur/plctypes.h>



/* Constants */
_WEAK const unsigned short ERR_ETH_DEVICE_ERROR = 27247;
_WEAK const unsigned short ERR_ETH_INVALID_ATTACHMENT = 27240;
_WEAK const unsigned short ERR_ETH_NET_SLOW = 27210;
_WEAK const unsigned short ERR_ETH_NO_DATA = 27211;
_WEAK const unsigned short ERR_ETH_PING_NORESP = 27220;
_WEAK const unsigned short ERR_ETH_PING_TIMEOUT = 27221;
_WEAK const unsigned short ERR_ETH_SMTP_MAIL_CANNOT_DELIVER = 27235;
_WEAK const unsigned short ERR_ETH_SMTP_PARSE_NO_SEMI_COLON = 27233;
_WEAK const unsigned short ERR_ETH_SMTP_RECEIVER_NOT_ACCEPT = 27234;
_WEAK const unsigned short ERR_ETH_SMTP_SERVER_NOTAVAILABLE = 27230;
_WEAK const unsigned short ERR_ETH_SMTP_TIMEOUT = 27231;
_WEAK const unsigned short ERR_ETH_SMTP_UNEXPECTED_RESPONSE = 27232;
_WEAK const unsigned char ETH_ATT_TYPE_FILE = 1;
_WEAK const unsigned char ETH_ATT_TYPE_MEM = 0;


/* Datatypes */
typedef struct TCPQ_dcmd_typ
{
	unsigned short response;
	unsigned long error;
	unsigned long buffer;
	unsigned long buflng;
	unsigned long ipaddr;
	unsigned long socket;
	unsigned short port;
	unsigned short wreserve;
	unsigned long reserve[8];
} TCPQ_dcmd_typ;

typedef struct ETHstat_typ
{
	unsigned long p_recv;
	unsigned long e_recv;
	unsigned long p_send;
	unsigned long e_send;
	unsigned long collisions;
	unsigned long b_recv;
	unsigned long b_send;
	unsigned long p_recv_mc;
	unsigned long p_send_mc;
	unsigned long iqdrops;
	unsigned long noproto;
	unsigned long lastchange;
} ETHstat_typ;

typedef struct ETHattachment_typ
{
	unsigned char type;
	unsigned long len;
	unsigned long pName;
	unsigned long pData;
} ETHattachment_typ;



/* Datatypes of function blocks */
typedef struct UDPsend
{
	/* VAR_INPUT (analogous) */
	unsigned long cident;
	unsigned long ipaddr;
	unsigned long buffer;
	unsigned short buflng;
	unsigned short port;
	/* VAR_OUTPUT (analogous) */
	unsigned short status;
	/* VAR (analogous) */
	unsigned short state;
	unsigned long tickcount;
	unsigned long initcount;
	struct TCPQ_dcmd_typ dcmd;
	/* VAR_INPUT (digital) */
	plcbit enable;
	/* VAR (digital) */
	plcbit pna_ok;
} UDPsend_typ;

typedef struct UDPrecv
{
	/* VAR_INPUT (analogous) */
	unsigned long cident;
	unsigned long buffer;
	unsigned short buflng;
	/* VAR_OUTPUT (analogous) */
	unsigned short status;
	unsigned long ipaddr;
	unsigned short rxbuflng;
	unsigned short port;
	/* VAR (analogous) */
	unsigned short state;
	unsigned long tickcount;
	unsigned long initcount;
	struct TCPQ_dcmd_typ dcmd;
	/* VAR_INPUT (digital) */
	plcbit enable;
	/* VAR (digital) */
	plcbit pna_ok;
} UDPrecv_typ;

typedef struct UDPopen
{
	/* VAR_INPUT (analogous) */
	unsigned short port;
	unsigned long pvpolladr;
	/* VAR_OUTPUT (analogous) */
	unsigned short status;
	unsigned long cident;
	/* VAR (analogous) */
	unsigned short state;
	unsigned long tickcount;
	unsigned long initcount;
	struct TCPQ_dcmd_typ dcmd;
	/* VAR_INPUT (digital) */
	plcbit enable;
	/* VAR (digital) */
	plcbit pna_ok;
} UDPopen_typ;

typedef struct UDPclose
{
	/* VAR_INPUT (analogous) */
	unsigned long cident;
	/* VAR_OUTPUT (analogous) */
	unsigned short status;
	/* VAR (analogous) */
	unsigned short state;
	unsigned long tickcount;
	unsigned long initcount;
	struct TCPQ_dcmd_typ dcmd;
	/* VAR_INPUT (digital) */
	plcbit enable;
	/* VAR (digital) */
	plcbit pna_ok;
} UDPclose_typ;

typedef struct SMTPsendmail
{
	/* VAR_INPUT (analogous) */
	unsigned long pReceiver;
	unsigned long pSender;
	unsigned long pIpaddr;
	unsigned long pSubject;
	unsigned long pText;
	unsigned short timeout;
	/* VAR_OUTPUT (analogous) */
	unsigned short status;
	/* VAR (analogous) */
	unsigned short state;
	unsigned long tickcount;
	unsigned long initcount;
	struct TCPQ_dcmd_typ dcmd;
	/* VAR_INPUT (digital) */
	plcbit enable;
	/* VAR (digital) */
	plcbit pna_ok;
} SMTPsendmail_typ;

typedef struct ICMPping
{
	/* VAR_INPUT (analogous) */
	unsigned long ipaddr;
	unsigned short timeout;
	/* VAR_OUTPUT (analogous) */
	unsigned short status;
	/* VAR (analogous) */
	unsigned short state;
	unsigned long tickcount;
	unsigned long initcount;
	struct TCPQ_dcmd_typ dcmd;
	/* VAR_INPUT (digital) */
	plcbit enable;
	/* VAR (digital) */
	plcbit pna_ok;
} ICMPping_typ;

typedef struct TCPserv
{
	/* VAR_INPUT (analogous) */
	unsigned short porta;
	/* VAR_OUTPUT (analogous) */
	unsigned short status;
	unsigned long ipaddr;
	unsigned short portb;
	unsigned long cident;
	/* VAR (analogous) */
	unsigned short state;
	unsigned long tickcount;
	unsigned long initcount;
	struct TCPQ_dcmd_typ dcmd;
	/* VAR_INPUT (digital) */
	plcbit enable;
	/* VAR (digital) */
	plcbit pna_ok;
} TCPserv_typ;

typedef struct TCPclient
{
	/* VAR_INPUT (analogous) */
	unsigned short porta;
	unsigned long ipaddr;
	unsigned short portb;
	/* VAR_OUTPUT (analogous) */
	unsigned short status;
	unsigned long cident;
	/* VAR (analogous) */
	unsigned short state;
	unsigned long tickcount;
	unsigned long initcount;
	struct TCPQ_dcmd_typ dcmd;
	/* VAR_INPUT (digital) */
	plcbit enable;
	/* VAR (digital) */
	plcbit pna_ok;
} TCPclient_typ;

typedef struct TCPsend
{
	/* VAR_INPUT (analogous) */
	unsigned long cident;
	unsigned long buffer;
	unsigned long buflng;
	/* VAR_OUTPUT (analogous) */
	unsigned short status;
	/* VAR (analogous) */
	unsigned short state;
	unsigned long tickcount;
	unsigned long initcount;
	struct TCPQ_dcmd_typ dcmd;
	/* VAR_INPUT (digital) */
	plcbit enable;
	/* VAR (digital) */
	plcbit pna_ok;
} TCPsend_typ;

typedef struct TCPrecv
{
	/* VAR_INPUT (analogous) */
	unsigned long cident;
	unsigned long buffer;
	unsigned long mxbuflng;
	/* VAR_OUTPUT (analogous) */
	unsigned short status;
	unsigned long rxbuflng;
	/* VAR (analogous) */
	unsigned short state;
	unsigned long tickcount;
	unsigned long initcount;
	struct TCPQ_dcmd_typ dcmd;
	/* VAR_INPUT (digital) */
	plcbit enable;
	/* VAR (digital) */
	plcbit pna_ok;
} TCPrecv_typ;

typedef struct TCPclose
{
	/* VAR_INPUT (analogous) */
	unsigned long cident;
	/* VAR_OUTPUT (analogous) */
	unsigned short status;
	/* VAR (analogous) */
	unsigned short state;
	unsigned long tickcount;
	unsigned long initcount;
	struct TCPQ_dcmd_typ dcmd;
	/* VAR_INPUT (digital) */
	plcbit enable;
	/* VAR (digital) */
	plcbit pna_ok;
} TCPclose_typ;

typedef struct ETHxinfo
{
	/* VAR_INPUT (analogous) */
	unsigned long pDevice;
	/* VAR_OUTPUT (analogous) */
	unsigned long statadr;
	unsigned long ethadr;
	unsigned short status;
	/* VAR (analogous) */
	unsigned char mac[6];
	/* VAR_INPUT (digital) */
	plcbit enable;
} ETHxinfo_typ;

typedef struct SMTPxsendmail
{
	/* VAR_INPUT (analogous) */
	unsigned long pReceiver;
	unsigned long pSender;
	unsigned long pIpaddr;
	unsigned long pSubject;
	unsigned long pText;
	unsigned long pAttachment;
	unsigned char AttachmentCount;
	unsigned short timeout;
	/* VAR_OUTPUT (analogous) */
	unsigned short status;
	/* VAR (analogous) */
	unsigned short state;
	unsigned long tickcount;
	unsigned long initcount;
	struct TCPQ_dcmd_typ dcmd;
	/* VAR_INPUT (digital) */
	plcbit enable;
	/* VAR (digital) */
	plcbit pna_ok;
} SMTPxsendmail_typ;

typedef struct ETHinfo
{
	/* VAR_OUTPUT (analogous) */
	unsigned long statadr;
	unsigned long ethadr;
	unsigned short status;
	/* VAR_INPUT (digital) */
	plcbit enable;
} ETHinfo_typ;



/* Prototyping of functions and function blocks */
void UDPsend(UDPsend_typ* inst);
void UDPrecv(UDPrecv_typ* inst);
void UDPopen(UDPopen_typ* inst);
void UDPclose(UDPclose_typ* inst);
void SMTPsendmail(SMTPsendmail_typ* inst);
void ICMPping(ICMPping_typ* inst);
void TCPserv(TCPserv_typ* inst);
void TCPclient(TCPclient_typ* inst);
void TCPsend(TCPsend_typ* inst);
void TCPrecv(TCPrecv_typ* inst);
void TCPclose(TCPclose_typ* inst);
void ETHxinfo(ETHxinfo_typ* inst);
void SMTPxsendmail(SMTPxsendmail_typ* inst);
void ETHinfo(ETHinfo_typ* inst);



#endif /* ETHERNET_H_ */

