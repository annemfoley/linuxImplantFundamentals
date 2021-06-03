CC = gcc
CFLAGS = -lpcap

ODIR = obj

sniffex: sniffex.c
	$(CC) -Wall -o sniffex sniffex.c $(CFLAGS)

sniffexDebug: sniffex.c
	$(CC) -DDEBUG -Wall -o sniffexDebug sniffex.c $(CFLAGS)
