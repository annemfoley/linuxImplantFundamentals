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
    if not os.path.exists('log.csv'):
        fieldnamesList = ["datetime", "ipAddress", "domain", "architecture", "platform", "os", "versionNumber", "payload", "activate", "interface", "key", "size", "dateDelay", "timeDelay", "trigger", "persistence", "bang", "downloadURL", "loadShellcode", "reverseShell", "reverseIP", "reversePort", "Notes", "debug", "outputName", "strip", "static"]
        log_writer.writerow(fieldnamesList)

    log_writer.writerow([str(datetime.datetime.now()), str(args.ipAddress), str(args.domain), str(args.architecture), str(args.platform), str(args.os), str(args.versionNumber), str(args.payload), str(args.activate), str(args.interface), str(args.key), str(args.size), str(args.dateDelay), str(args.timeDelay), str(args.trigger), str(args.persistence), str(args.bang), str(args.downloadURL), str(args.loadShellcode), str(args.reverseShell), str(args.reverseIP), str(args.reversePort), str(args.notes), str(args.debug), str(args.outputName), str(args.strip), str(args.static)])


