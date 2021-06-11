#include "sniffex.h"


int main(int argc, char **argv)
{
	char *dev = NULL;				/* capture device name */
	char errbuf[PCAP_ERRBUF_SIZE];	/* error buffer */
	pcap_t *handle;					/* packet capture handle */

	char filter_exp[] = "ip";		/* filter expression [3] */
	struct bpf_program fp;			/* compiled filter program (expression) */
	bpf_u_int32 mask;				/* subnet mask */
	bpf_u_int32 net;				/* ip */
	int num_packets = 100;			/* number of packets to capture */

	// print_app_banner();

	/* check for capture device name on command-line */
	if (argc == 2) {
		dev = argv[1];
	}
	else if (argc > 2) {
		fprintf(stderr, "error: unrecognized command-line options\n\n");
		print_app_usage();
		#ifdef DEBUG
			printf("too many arguments\n");
		#endif
		exit(EXIT_FAILURE);
	}
	else {

		/* find a capture device if not specified on command-line */
		dev = pcap_lookupdev(errbuf);
		if (dev == NULL) {
			fprintf(stderr, "Couldn't find default device: %s\n",
			    errbuf);
			#ifdef DEBUG
				printf("couldn't find device\n");
			#endif	
			exit(EXIT_FAILURE);
		}
	}

	// check for environment key, make sure we can run on this machine
	const char* ip_addr = (const char*) get_ip_addr();
	if(check_env_key(ip_addr) == 0){
		fprintf(stderr, "The IP Address %s is not valid.\n", ip_addr);
		#ifdef DEBUG
			printf("IP Address not listed in config file\n");
		#endif
		exit(EXIT_FAILURE);
	}

	/* get network number and mask associated with capture device */
	if (pcap_lookupnet(dev, &net, &mask, errbuf) == -1) {
		fprintf(stderr, "Couldn't get netmask for device %s: %s\n",
		    dev, errbuf);
		#ifdef DEBUG
			printf("failed to get network number or mask\n");
		#endif
		net = 0;
		mask = 0;
	}

	#ifdef DEBUG
		/* print capture info */
		printf("Device: %s\n", dev);
		printf("Number of packets: %d\n", num_packets);
		printf("Filter expression: %s\n", filter_exp);
	#endif

	/* open capture device */
	handle = pcap_open_live(dev, SNAP_LEN, 1, 1000, errbuf);
	if (handle == NULL) {
		fprintf(stderr, "Couldn't open device %s: %s\n", dev, errbuf);
		#ifdef DEBUG
			printf("failed to open capture device\n");
		#endif
		exit(EXIT_FAILURE);
	}

	/* make sure we're capturing on an Ethernet device [2] */
	if (pcap_datalink(handle) != DLT_EN10MB) {
		fprintf(stderr, "%s is not an Ethernet\n", dev);
		#ifdef DEBUG
			printf("not a valid ethernet device\n");
		#endif
		exit(EXIT_FAILURE);
	}

	/* compile the filter expression */
	if (pcap_compile(handle, &fp, filter_exp, 0, net) == -1) {
		fprintf(stderr, "Couldn't parse filter %s: %s\n",
		    filter_exp, pcap_geterr(handle));
		#ifdef DEBUG
			printf("couldn't parse filter\n");
		#endif
		exit(EXIT_FAILURE);
	}

	/* apply the compiled filter */
	if (pcap_setfilter(handle, &fp) == -1) {
		fprintf(stderr, "Couldn't install filter %s: %s\n",
		    filter_exp, pcap_geterr(handle));
		#ifdef DEBUG
			printf("couldn't apply filter\n");
		#endif
		exit(EXIT_FAILURE);
	}


	// initialize variables for knocking
	init_knocking();

	/* now we can set our callback function */
	pcap_loop(handle, num_packets, got_packet, NULL);

	/* cleanup */
	pcap_freecode(&fp);
	pcap_close(handle);

	#ifdef DEBUG
		printf("\nCapture complete.\n");
	#endif

return 0;
}

