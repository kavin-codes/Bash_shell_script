
Task day 26 (25-02-2026)

Day 26: checks if a network host is reachable


Create a script that checks if a network host is reachable


#!/bin/bash

# Store the first command-line argument (hostname or IP) into the variable "host"
host="$1"

# Check if the host variable is empty (no argument provided)
if [ -z "$host" ]; then
    # If empty, print usage instructions
    echo "Usage: $0 <hostname or IP>"
    # Exit the script with status code 1 (indicates error)
    exit 1
fi

# Send 4 ICMP echo requests (ping) to the specified host
ping -c 4 "$host"

# $? stores the exit status of the last executed command (ping)
# 0 means success, any other number means failure
if [ $? -eq 0 ]; then
    # If ping was successful
    echo "$host is reachable."
else
    # If ping failed
    echo "$host is not reachable."
fi