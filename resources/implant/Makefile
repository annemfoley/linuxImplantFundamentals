CC = gcc
CFLAGS = -Wall -o

default: main

main: sniffex.c sniffex.h main.c
	$(CC) $(CFLAGS) main sniffex.c main.c -lpcap

mainDebug: sniffex.c sniffex.h main.c
	$(CC) -DDEBUG $(CFLAGS) mainDebug sniffex.c main.c -lpcap

clean:
	$(RM) main mainDebug *.o *~