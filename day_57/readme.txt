Task day 57 (28-03-2026) 
Day 57-URL Health Checker Script

Problem
Take multiple URLs
Check if they are reachable
Print status (UP / DOWN)





#!/bin/bash

# Loop through all input URLs
for url in "$@"
do
    # Use curl to get HTTP status code
    status=$(curl -o /dev/null -s -w "%{http_code}" $url)
    # -o /dev/null → discard output
    # -s → silent mode
    # -w → print HTTP status code

    if [ $status -eq 200 ]; then
        # If status code is 200 (OK)
        echo "$url is UP"
    else
        # Any other status means not reachable
        echo "$url is DOWN"
    fi
done