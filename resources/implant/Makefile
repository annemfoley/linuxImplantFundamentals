CC = gcc
CFLAGS = -Wall -o

default: implant

implant: sniffex.c sniffex.h implantMain.c
	$(CC) $(CFLAGS) implant sniffex.c helper.c implantMain.c -lpcap

implant32: sniffex.c sniffex.h implantMain.c
	$(CC) $(CFLAGS) -m32 implant sniffex.c helper.c implantMain.c -lpcap

implantDebug: sniffex.c sniffex.h implantMain.c
	$(CC) -DDEBUG $(CFLAGS) implantDebug sniffex.c helper.c implantMain.c -lpcap

clean:
	$(RM) implant implantDebug *.o *~