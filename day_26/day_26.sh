#!/bin/bash
host="$1"
if [ -z "$host" ]; then
echo "Usage: $0 <hostname or IP>"
exit 1
fi
ping -c 4 "$host"
 

if [ $? -eq 0 ]; then
echo "$host is reachable."
else
echo "$host is not reachable."
fi