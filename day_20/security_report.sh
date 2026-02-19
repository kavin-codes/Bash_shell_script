#!/bin/bash

log_path="/var/log/auth.log"
OUTPUT="security_report_$(date +%F).csv"

echo "IP,Attempts,First_Seen,Last_Seen" > "$OUTPUT"

grep "Failed password" "$log_path" | awk '
{
    ip=$(NF-3)
    count[ip]++

    if (!first[ip])
        first[ip]=$1" "$2" "$3

    last[ip]=$1" "$2" "$3
}
END {
    for (ip in count)
        print ip "," count[ip] "," first[ip] "," last[ip]
}
' >> "$OUTPUT"

echo "Report generated: $OUTPUT"
