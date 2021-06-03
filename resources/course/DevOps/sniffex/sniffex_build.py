import argparse
import datetime
import os
import csv

# initialize the parser
parser = argparse.ArgumentParser(prog = 'sniffex_build', 
                                usage = '%(prog)s [options]',
                                description = 'compile the sniffex program')

# define all arguments
parser.add_argument("-d", "--debug", action="store_true",
                    help="compile with debugging")

args = parser.parse_args()

# compile with or without debugging based on the -d argument
if args.debug:
    exit_code = os.system("gcc -DDEBUG -Wall -o sniffexDebug sniffex.c -lpcap 2> compile_error.txt")
else:
    exit_code = os.system("gcc -Wall -o sniffex sniffex.c -lpcap 2> compile_error.txt")

# if there are errors with compiling, they will be stored in error.txt
error_file = open('compile_error.txt',mode='r')
error = error_file.read()
error_file.close()

# we are done with this temporary file
os.remove('compile_error.txt')

# log the time, any errors with compilation, and the arguments used to compile
with open('log.csv', mode='a+') as log_file:
    
    log_writer = csv.writer(log_file, delimiter='\t', quotechar='"', quoting=csv.QUOTE_MINIMAL)
    if os.stat("log.csv").st_size == 0:
        fieldnamesList = ["datetime", "compile status", "error msg", "debug"]
        log_writer.writerow(fieldnamesList)
    
    if exit_code != 0:
        error_msg = error
    else:
        error_msg = "none"

    log_writer.writerow([str(datetime.datetime.now()), exit_code, error_msg, str(args.debug),])
