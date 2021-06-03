CC = gcc
CFLAGS = -lpcap

ODIR = obj

sniffexMake: sniffex.c
	$(CC) -Wall -o sniffex sniffex.c $(CFLAGS)

sniffexDebug: sniffex.c
	$(CC) -DDEBUG -Wall -o sniffex sniffex.c $(CFLAGS)
