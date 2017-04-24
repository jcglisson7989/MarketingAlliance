/* Automation Studio Generated Header File, Format Version 1.00 */
/* do not change */
#ifndef ETHSOCK_H_
#define ETHSOCK_H_
#define _WEAK	__attribute__((__weak__))

#include <bur/plc.h>
#include <bur/plctypes.h>



/* Constants */
_WEAK const unsigned short ERR_ETH_2BIG = 27107;
_WEAK const unsigned short ERR_ETH_ACCESS = 27113;
_WEAK const unsigned short ERR_ETH_ADDRINUSE = 27148;
_WEAK const unsigned short ERR_ETH_ADDRNOTAVAIL = 27149;
_WEAK const unsigned short ERR_ETH_AFNOTSUP = 27147;
_WEAK const unsigned short ERR_ETH_AGAIN = 27111;
_WEAK const unsigned short ERR_ETH_ALREADY = 27169;
_WEAK const unsigned short ERR_ETH_BADF = 27109;
_WEAK const unsigned short ERR_ETH_BADMSG = 27177;
_WEAK const unsigned short ERR_ETH_BASE = 27100;
_WEAK const unsigned short ERR_ETH_BUSY = 27116;
_WEAK const unsigned short ERR_ETH_CANCELED = 27172;
_WEAK const unsigned short ERR_ETH_CHILD = 27110;
_WEAK const unsigned short ERR_ETH_CONNABORTED = 27153;
_WEAK const unsigned short ERR_ETH_CONNREFUSED = 27161;
_WEAK const unsigned short ERR_ETH_CONNRESET = 27154;
_WEAK const unsigned short ERR_ETH_DEADLK = 27133;
_WEAK const unsigned short ERR_ETH_DESTADDRREQ = 27140;
_WEAK const unsigned short ERR_ETH_DOM = 27137;
_WEAK const unsigned short ERR_ETH_EXIST = 27117;
_WEAK const unsigned short ERR_ETH_FAULT = 27114;
_WEAK const unsigned short ERR_ETH_FBIG = 27127;
_WEAK const unsigned short ERR_ETH_HOSTDOWN = 27167;
_WEAK const unsigned short ERR_ETH_HOSTUNREACH = 27165;
_WEAK const unsigned short ERR_ETH_INPROGRESS = 27168;
_WEAK const unsigned short ERR_ETH_INTR = 27104;
_WEAK const unsigned short ERR_ETH_INVAL = 27122;
_WEAK const unsigned short ERR_ETH_IO = 27105;
_WEAK const unsigned short ERR_ETH_ISCONN = 27156;
_WEAK const unsigned short ERR_ETH_ISDIR = 27121;
_WEAK const unsigned short ERR_ETH_LOOP = 27164;
_WEAK const unsigned short ERR_ETH_MAX = 27181;
_WEAK const unsigned short ERR_ETH_MFILE = 27124;
_WEAK const unsigned short ERR_ETH_MLINK = 27131;
_WEAK const unsigned short ERR_ETH_MSGSIZE = 27136;
_WEAK const unsigned short ERR_ETH_NAMETOOLONG = 27126;
_WEAK const unsigned short ERR_ETH_NETDOWN = 27162;
_WEAK const unsigned short ERR_ETH_NETRESET = 27152;
_WEAK const unsigned short ERR_ETH_NETUNREACH = 27151;
_WEAK const unsigned short ERR_ETH_NFILE = 27123;
_WEAK const unsigned short ERR_ETH_NOBUFS = 27155;
_WEAK const unsigned short ERR_ETH_NODATA = 27178;
_WEAK const unsigned short ERR_ETH_NODEV = 27119;
_WEAK const unsigned short ERR_ETH_NOENT = 27102;
_WEAK const unsigned short ERR_ETH_NOEXEC = 27108;
_WEAK const unsigned short ERR_ETH_NOLCK = 27134;
_WEAK const unsigned short ERR_ETH_NOMEM = 27112;
_WEAK const unsigned short ERR_ETH_NOMGR = 27248;
_WEAK const unsigned short ERR_ETH_NOMSG = 27180;
_WEAK const unsigned short ERR_ETH_NOPROTOOPT = 27142;
_WEAK const unsigned short ERR_ETH_NOSPC = 27128;
_WEAK const unsigned short ERR_ETH_NOSR = 27174;
_WEAK const unsigned short ERR_ETH_NOSTR = 27175;
_WEAK const unsigned short ERR_ETH_NOSYS = 27171;
_WEAK const unsigned short ERR_ETH_NOTBLK = 27166;
_WEAK const unsigned short ERR_ETH_NOTCONN = 27157;
_WEAK const unsigned short ERR_ETH_NOTDIR = 27120;
_WEAK const unsigned short ERR_ETH_NOTEMPTY = 27115;
_WEAK const unsigned short ERR_ETH_NOTSOCK = 27150;
_WEAK const unsigned short ERR_ETH_NOTSUP = 27135;
_WEAK const unsigned short ERR_ETH_NOTTY = 27125;
_WEAK const unsigned short ERR_ETH_NXIO = 27106;
_WEAK const unsigned short ERR_ETH_OPNOTSUP = 27145;
_WEAK const unsigned short ERR_ETH_PERM = 27101;
_WEAK const unsigned short ERR_ETH_PFNOTSUP = 27146;
_WEAK const unsigned short ERR_ETH_PIPE = 27132;
_WEAK const unsigned short ERR_ETH_PROTO = 27176;
_WEAK const unsigned short ERR_ETH_PROTONOTSUP = 27143;
_WEAK const unsigned short ERR_ETH_PROTOTYPE = 27141;
_WEAK const unsigned short ERR_ETH_RANGE = 27138;
_WEAK const unsigned short ERR_ETH_ROFS = 27130;
_WEAK const unsigned short ERR_ETH_SHUTDOWN = 27158;
_WEAK const unsigned short ERR_ETH_SOCKNOTSUP = 27144;
_WEAK const unsigned short ERR_ETH_SPIPE = 27129;
_WEAK const unsigned short ERR_ETH_SRCH = 27103;
_WEAK const unsigned short ERR_ETH_TIME = 27179;
_WEAK const unsigned short ERR_ETH_TIMEDOUT = 27160;
_WEAK const unsigned short ERR_ETH_TOOMANYREFS = 27159;
_WEAK const unsigned short ERR_ETH_TXTBSY = 27163;
_WEAK const unsigned short ERR_ETH_UNKNOWN = 27249;
_WEAK const unsigned short ERR_ETH_WOULDBLOCK = 27170;
_WEAK const unsigned short ERR_ETH_XDEV = 27118;
_WEAK const signed long ERR_SOCKET = -1;
_WEAK const signed long ETH_AF_APPLETALK = 16;
_WEAK const signed long ETH_AF_CCITT = 10;
_WEAK const signed long ETH_AF_CHAOS = 5;
_WEAK const signed long ETH_AF_DATAKIT = 9;
_WEAK const signed long ETH_AF_DECNET = 12;
_WEAK const signed long ETH_AF_DLI = 13;
_WEAK const signed long ETH_AF_ECMA = 8;
_WEAK const signed long ETH_AF_HYLINK = 15;
_WEAK const signed long ETH_AF_IMPLINK = 3;
_WEAK const signed long ETH_AF_INET = 2;
_WEAK const signed long ETH_AF_ISO = 7;
_WEAK const signed long ETH_AF_LAT = 14;
_WEAK const signed long ETH_AF_NS = 6;
_WEAK const signed long ETH_AF_OSI = 7;
_WEAK const signed long ETH_AF_PUP = 4;
_WEAK const signed long ETH_AF_SNA = 11;
_WEAK const signed long ETH_AF_UNIX = 1;
_WEAK const signed long ETH_AF_UNSPEC = 0;
_WEAK const signed long ETH_FIONBIO = 16;
_WEAK const signed long ETH_FIONREAD = 1;
_WEAK const signed long ETH_INADDR_ANY = 0;
_WEAK const unsigned char ETH_INET_ADDR_LEN = 18;
_WEAK const signed long ETH_IPPROTO_GGP = 3;
_WEAK const signed long ETH_IPPROTO_ICMP = 1;
_WEAK const signed long ETH_IPPROTO_IDP = 17;
_WEAK const signed long ETH_IPPROTO_IGMP = 2;
_WEAK const signed long ETH_IPPROTO_IP = 0;
_WEAK const signed long ETH_IPPROTO_MAX = 256;
_WEAK const signed long ETH_IPPROTO_PUP = 12;
_WEAK const signed long ETH_IPPROTO_RAW = 255;
_WEAK const signed long ETH_IPPROTO_TCP = 6;
_WEAK const signed long ETH_IPPROTO_UDP = 17;
_WEAK const signed long ETH_SOCK_DGRAM = 2;
_WEAK const signed long ETH_SOCK_RAW = 3;
_WEAK const signed long ETH_SOCK_RDM = 4;
_WEAK const signed long ETH_SOCK_SEQPACKET = 5;
_WEAK const signed long ETH_SOCK_STREAM = 1;
_WEAK const signed long ETH_SOL_SOCKET = 65535;
_WEAK const signed long ETH_SOMAXCONN = 5;
_WEAK const signed long ETH_SO_ACCEPTCONN = 2;
_WEAK const signed long ETH_SO_BROADCAST = 32;
_WEAK const signed long ETH_SO_DEBUG = 1;
_WEAK const signed long ETH_SO_DONTROUTE = 16;
_WEAK const signed long ETH_SO_ERROR = 4103;
_WEAK const signed long ETH_SO_KEEPALIVE = 8;
_WEAK const signed long ETH_SO_LINGER = 128;
_WEAK const signed long ETH_SO_OOBINLINE = 256;
_WEAK const signed long ETH_SO_RCVBUF = 4098;
_WEAK const signed long ETH_SO_RCVLOWAT = 4100;
_WEAK const signed long ETH_SO_RCVTIMEO = 4102;
_WEAK const signed long ETH_SO_REUSEADDR = 4;
_WEAK const signed long ETH_SO_SNDBUF = 4097;
_WEAK const signed long ETH_SO_SNDLOWAT = 4099;
_WEAK const signed long ETH_SO_SNDTIMEO = 4101;
_WEAK const signed long ETH_SO_TYPE = 4104;
_WEAK const signed long ETH_FD_SETSIZE = 256;
_WEAK const unsigned short ERR_ETH_FD_SETSIZE = 27200;


/* Datatypes */
typedef struct ETH_sockaddr_typ
{
	unsigned short sin_family;
	unsigned short sin_port;
	unsigned long sin_addr;
	unsigned char sin_zero[8];
} ETH_sockaddr_typ;

typedef struct ETH_fd_set_typ
{
	signed long fds_bits[8];
} ETH_fd_set_typ;

typedef struct ETH_timeval_typ
{
	signed long tv_sec;
	signed long tv_usec;
} ETH_timeval_typ;



/* Datatypes of function blocks */


/* Prototyping of functions and function blocks */
unsigned short inet_ntoa_b(unsigned long ipaddr, unsigned long pString);
unsigned long inet_addr(unsigned long pString);
unsigned short EthGetError();
signed long sock_select(signed long width, unsigned long pReadFds, unsigned long pWriteFds, unsigned long pExceptFds, unsigned long pTimeOut);
signed long close(signed long s);
signed long ioctl(signed long s, signed long cmd, unsigned long arg);
signed long shutdown(signed long s, signed long how);
signed long sendto(signed long s, unsigned long buf, signed long buflen, signed long flags, unsigned long to, signed long tolen);
signed long send(signed long s, unsigned long buf, signed long buflen, signed long flags);
signed long recvfrom(signed long s, unsigned long buf, signed long buflen, signed long flags, unsigned long from, unsigned long fromlen);
signed long recv(signed long s, unsigned long buf, signed long buflen, signed long flags);
signed long listen(signed long s, signed long backlog);
signed long getpeername(signed long s, unsigned long name, unsigned long namelen);
signed long getsockname(signed long s, unsigned long name, unsigned long namelen);
signed long setsockopt(signed long s, signed long level, signed long optname, unsigned long optval, signed long optlen);
signed long getsockopt(signed long s, signed long level, signed long optname, unsigned long optval, unsigned long optlen);
signed long connect(signed long s, unsigned long name, signed long namelen);
signed long bind(signed long s, unsigned long name, signed long namelen);
signed long accept(signed long s, unsigned long addr, unsigned long addrlen);
signed long socket(signed long domain, signed long type, signed long protocol);
unsigned short fd_set(signed long n, unsigned long p);
unsigned short fd_clr(signed long n, unsigned long p);
unsigned short fd_isset(signed long n, unsigned long p);
unsigned short fd_zero(unsigned long p);


/* structure and symbol definitions only for i386-Targets (VxWorks) */


/*
 * An option specification consists of an opthdr, followed by the value of
 * the option.  An options buffer contains one or more options.  The len
 * field of opthdr specifies the length of the option value in bytes.  This
 * length must be a multiple of sizeof (long) (use OPTLEN macro).
 */

struct opthdr {
	long 	level;			/* protocol level affected */
	long	name;			/* option to modify */
	long	len;			/* length of option value */
};

#define OPTLEN(x) ((((x) + sizeof (long) - 1) / sizeof (long)) * sizeof (long))
#define OPTVAL(opt) ((char *)(opt + 1))

/*
 * Structure used for manipulating linger option.
 */
struct	linger {
	int	l_onoff;		/* option on/off */
	int	l_linger;		/* linger time */
};

#define	MSG_OOB			0x1			/* process out-of-band data */
#define	MSG_PEEK		0x2			/* peek at incoming message */
#define	MSG_DONTROUTE	0x4			/* send without using routing tables */
#define MSG_NO_UIO		0x8			/* for system use only */
#define	MSG_EOR			0x8			/* data completes record */
#define	MSG_TRUNC		0x10		/* data discarded before delivery */
#define	MSG_CTRUNC		0x20		/* control data lost before delivery */
#define	MSG_WAITALL		0x40		/* wait for full request or error */
#define	MSG_DONTWAIT	0x80		/* this message should be nonblocking */
#define MSG_MBUF		0x10000		/* mbuf interface - WRS ext. */
#define MSG_IGNORE_SB	0x20000		/* ignore socket write buf - WRS ext. */

#define	MSG_MAXIOVLEN	16

#define	NBBY	8		/* number of bits in a byte */
typedef long	fd_mask;
#define NFDBITS	(sizeof(fd_mask) * NBBY)	/* bits per mask */


/* socket i/o controls */
/*
 * Ioctl's have the command encoded in the lower word,
 * and the size of any in or out parameters in the upper
 * word.  The high 2 bits of the upper word are used
 * to encode the in/out status of the parameter; for now
 * we restrict parameters to at most 128 bytes.
 */
#define	IOCPARM_MASK	0x7f		/* parameters must be < 128 bytes */
#define	IOC_VOID	0x20000000	/* no parameters */
#define	IOC_OUT		0x40000000	/* copy out parameters */
#define	IOC_IN		0x80000000	/* copy in parameters */
#define	IOC_INOUT	(IOC_IN|IOC_OUT)

/* had to change macros from 'x' to (x) and had to pass in litterals as 'i'
 * rather than i, because ANSIc doesn't behave in the same manner as
 * the traditional c compilers
 */
#define	_IO(x,y)		(IOC_VOID|((x)<<8)|y)
#define	_IOR(x,y,t)		(IOC_OUT|((sizeof(t)&IOCPARM_MASK)<<16)|((x)<<8)|y)
#define	_IOW(x,y,t)		(IOC_IN|((sizeof(t)&IOCPARM_MASK)<<16)|((x)<<8)|y)
#define	_IOWR(x,y,t)	(IOC_INOUT|((sizeof(t)&IOCPARM_MASK)<<16)|((x)<<8)|y)

#define	SIOCSHIWAT		_IOW('s',  0, int)		/* set high watermark */
#define	SIOCGHIWAT		_IOR('s',  1, int)		/* get high watermark */
#define	SIOCSLOWAT		_IOW('s',  2, int)		/* set low watermark */
#define	SIOCGLOWAT		_IOR('s',  3, int)		/* get low watermark */
#define	SIOCATMARK		_IOR('s',  7, int)		/* at oob mark? */
#define	SIOCSPGRP		_IOW('s',  8, int)		/* set process group */
#define	SIOCGPGRP		_IOR('s',  9, int)		/* get process group */

#define	SIOCADDRT		_IOW('r', 10, struct ortentry)	/* add route */
#define	SIOCDELRT		_IOW('r', 11, struct ortentry)	/* delete route */

#define	SIOCSIFADDR		_IOW('i', 12, struct ifreq)	/* set ifnet address */
#define	OSIOCGIFADDR	_IOWR('i', 13, struct ifreq)	/* get ifnet address */
#define	SIOCGIFADDR		_IOWR('i', 33, struct ifreq)	/* get ifnet address */
#define	SIOCSIFDSTADDR	 _IOW('i', 14, struct ifreq)	/* set p-p address */
#define	OSIOCGIFDSTADDR	_IOWR('i', 15, struct ifreq)	/* get p-p address */
#define	SIOCGIFDSTADDR	_IOWR('i', 34, struct ifreq)	/* get p-p address */
#define	SIOCSIFFLAGS	 _IOW('i', 16, struct ifreq)	/* set ifnet flags */
#define	SIOCGIFFLAGS	_IOWR('i', 17, struct ifreq)	/* get ifnet flags */
#define	OSIOCGIFBRDADDR	_IOWR('i', 18, struct ifreq)	/* get broadcast addr */
#define	SIOCGIFBRDADDR	_IOWR('i', 35, struct ifreq)	/* get broadcast addr */
#define	SIOCSIFBRDADDR	 _IOW('i', 19, struct ifreq)	/* set broadcast addr */
#define	SIOCSARP		_IOW('i', 30, struct arpreq)	/* set arp entry */
#define	SIOCGARP		_IOWR('i',31, struct arpreq)	/* get arp entry */
#define	SIOCDARP		_IOW('i', 32, struct arpreq)	/* delete arp entry */

#define	OSIOCGIFCONF	_IOWR('i', 20, struct ifconf)	/* get ifnet list */
#define	SIOCGIFCONF		_IOWR('i', 36, struct ifconf)	/* get ifnet list */
#define	OSIOCGIFNETMASK	_IOWR('i', 21, struct ifreq)	/* get net addr mask */
#define	SIOCGIFNETMASK	_IOWR('i', 37, struct ifreq)	/* get net addr mask */
#define	SIOCSIFNETMASK	_IOW('i', 22, struct ifreq)	/* set net addr mask */
#define	SIOCGIFMETRIC	_IOWR('i', 23, struct ifreq)	/* get IF metric */
#define	SIOCSIFMETRIC	_IOW('i', 24, struct ifreq)	/* set IF metric */
#define	SIOCDIFADDR		_IOW('i', 25, struct ifreq)	/* delete IF addr */
#define	SIOCAIFADDR		_IOW('i', 26, struct ifaliasreq)/* add/chg IF alias */

#define	SIOCADDMULTI	_IOW('i', 49, struct ifreq)	/* add m'cast addr */
#define	SIOCDELMULTI	_IOW('i', 50, struct ifreq)	/* del m'cast addr */
#define SIOCGETMULTI    _IOWR('i', 51, struct ifmreq)  /* get m'cast addr */


#define	SIOCSIFMTU		_IOW('i', 127, struct ifreq)	/* set ifnet mtu */
#define	SIOCGIFMTU		_IOWR('i', 126, struct ifreq)	/* get ifnet mtu */
#define	SIOCSIFASYNCMAP _IOW('i', 125, struct ifreq)	/* set ppp asyncmap */
#define	SIOCGIFASYNCMAP _IOWR('i', 124, struct ifreq)	/* get ppp asyncmap */


#endif /* ETHSOCK_H_ */

