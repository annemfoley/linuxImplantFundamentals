CC = gcc
CFLAGS = -lpcap

# sniffex: sniffex.c
# 	$(CC) -Wall -o sniffex sniffex.c $(CFLAGS)

# sniffexDebug: sniffex.c
# 	$(CC) -DDEBUG -Wall -o sniffexDebug sniffex.c $(CFLAGS)

# DEPS = functionality.h helpers.h

default: main

main: sniffex.c sniffex.h main.c
	$(CC) -Wall -o main sniffex.c main.c $(CFLAGS)

mainDebug: sniffex.c sniffex.h main.c
	$(CC) -DDEBUG -Wall -o mainDebug sniffex.c main.c  $(CFLAGS)

# sniffex.o: sniffex.h sniffex.c
# 	$(CC) -Wall -c sniffex.c

clean:
	$(RM) main mainDebug *.o *~