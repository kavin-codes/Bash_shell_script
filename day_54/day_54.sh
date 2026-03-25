#!/bin/bash

LIMIT=5
WINDOW=60
LOGFILE="requests.log"

now=$(date +%s)

if [ -f "$LOGFILE" ]; then
    awk -v now="$now" -v window="$WINDOW" '{ if (now - $1 <= window) print $1 }' "$LOGFILE" > temp.log
    mv temp.log "$LOGFILE"
fi

count=$(wc -l < "$LOGFILE" 2>/dev/null)

if [ "$count" -ge "$LIMIT" ]; then
    echo "Rate limit exceeded. Try again later."
    exit 1
fi

echo "Request allowed"

echo "$now" >> "$LOGFILE"