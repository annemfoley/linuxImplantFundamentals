import argparse
import datetime
import os
import csv

parser = argparse.ArgumentParser(prog = 'sniffex_build', 
                                usage = '%(prog)s [options]',
                                description = 'compile the sniffex program')

parser.add_argument("-d", "--debug", action="store_true",
                    help="compile with debugging")

args = parser.parse_args()

if args.debug:
    os.system("gcc -DDEBUG -Wall -o sniffexDebug sniffex.c -lpcap")
else:
    os.system("gcc -Wall -o sniffex sniffex.c -lpcap")

with open('log.csv', mode='a+') as log_file:
    
    log_writer = csv.writer(log_file, delimiter='\t', quotechar='"', quoting=csv.QUOTE_MINIMAL)
    if os.stat("log.csv").st_size == 0:
        fieldnamesList = ["datetime", "debug"]
        log_writer.writerow(fieldnamesList)

    log_writer.writerow([str(datetime.datetime.now()), str(args.debug)])


