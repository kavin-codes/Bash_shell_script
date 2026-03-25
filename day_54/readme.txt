
Task day 54 (25-03-2026)

Day 54:Implement rate limiting in a script





#!/bin/bash

# Maximum number of allowed requests
LIMIT=5

# Time window in seconds (e.g., 60 seconds = 1 minute)
WINDOW=60

# File to store timestamps of requests
LOGFILE="requests.log"

# Get current timestamp (seconds since epoch)
now=$(date +%s)

# Remove timestamps older than the time window
# This keeps only recent requests within the last 60 seconds
if [ -f "$LOGFILE" ]; then
    awk -v now="$now" -v window="$WINDOW" '{ if (now - $1 <= window) print $1 }' "$LOGFILE" > temp.log
    mv temp.log "$LOGFILE"
fi

# Count number of requests in current window
count=$(wc -l < "$LOGFILE" 2>/dev/null)

# Check if limit exceeded
if [ "$count" -ge "$LIMIT" ]; then
    echo "Rate limit exceeded. Try again later."
    exit 1
fi

# If under limit → allow request
echo "Request allowed"

# Store current timestamp in logfile
echo "$now" >> "$LOGFILE"