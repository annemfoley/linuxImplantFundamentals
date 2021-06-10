import argparse
import datetime
import os
import csv

# compile sniffex using the sniffex_build python script
print("COMPILING SNIFFEX...")

if os.system("python3 sniffex_build.py") != 0:
    print("FAILED: compile error, check log for details")
    exit()

# execute sniffex
print("EXECUTING SNIFFEX...")

if os.system("./sniffex & (sleep 1 ; sudo lsof | grep SOCK_RAW > listener_process.txt)") != 0:
    print("FAILED: runtime error")
    exit()

# open the SOCK_RAW process information and store in a variable
listener_process_file = open("listener_process.txt", mode="r")
raw_socket_listener = listener_process_file.read()
listener_process_file.close()
os.remove("listener_process.txt")

# check if there were processes listening on SOCK_RAW
if len(raw_socket_listener)==0:
    print("FAILED: no listener on the socket")
    exit()

# kill the processes listening on SOCK_RAW
print("KILLING SNIFFEX...")
os.system("kill " + raw_socket_listener.split()[1])

# we made it! success!
print("TEST SUCCESS!")

