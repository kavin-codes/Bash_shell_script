

## NOTE: 
## This code currently only detects successful logins using the "Accepted password" method.
## It will NOT detect logins using SSH key-based authentication ("Accepted publickey").
## To include publickey logins, grep should also search for "Accepted publickey".


#!/bin/bash

FILE_PATH="/var/log/auth.log"
dir="/home/kavin/server_logs"
DATE=$(date +%F)
REPORT="$dir/security_report_$DATE.txt"
BLOCKED_LOG="$dir/blocked_ips.log"
INTEGRITY_LOG="$dir/log_integrity.log"

mkdir -p "$dir"

# Task 3: 
grep -i "Failed password" "$FILE_PATH" 2>/dev/null | \
awk '{print $(NF-4)}' | sort | uniq -c | sort -nr | head -5 | \
while read count ip; do
    if [ "$count" -gt 15 ]; then
        if ! grep -qi "^BLOCKED: $ip " "$BLOCKED_LOG" 2>/dev/null; then
            echo "BLOCKED: $ip on $DATE (exceeded 15 SSH failures)" >> "$BLOCKED_LOG"
        fi
    fi
done


# Task 4: Log Integrity Check

current_checksum=$(sha256sum "$FILE_PATH" | awk '{print $1}')

if [ -f "$INTEGRITY_LOG" ]; then
    last_checksum=$(tail -1 "$INTEGRITY_LOG" | awk '{print $2}')
else
    last_checksum=""
fi

if [ -n "$last_checksum" ] && [ "$current_checksum" != "$last_checksum" ]; then
    echo "WARNING: auth.log checksum changed on $DATE" >> "$INTEGRITY_LOG"
fi

# Store today's checksum
echo "$DATE $current_checksum" >> "$INTEGRITY_LOG"


{
    echo "===== Daily Security Report ($DATE) ====="
    echo

    # --- Successful SSH logins ---
    echo "🔐 Successful SSH Logins:"
    grep -i "Accepted password" "$FILE_PATH" 2>/dev/null | awk '{
        user=$9; ip=$11; timestamp=$1" "$2" "$3;
        print timestamp, "user="user, "ip="ip
    }'
    echo

    # --- Top Failed SSH IPs ---
    echo "⚠️ Top Failed SSH IPs:"
    grep -i "Failed password" "$FILE_PATH" 2>/dev/null | \
    awk '{print $(NF-4)}' | sort | uniq -c | sort -nr | head -5 | \
    while read count ip; do
        echo "$ip - $count attempts"
    done
    echo

    # --- Blocked IPs (today only) ---
    echo "🚫 Blocked IPs:"
    grep "BLOCKED:.*$DATE" "$BLOCKED_LOG" 2>/dev/null || echo "No IPs blocked today"
    echo

    # --- Log Integrity Warnings (today only) ---
    echo "🛡️ Log Integrity Warnings:"
    grep "WARNING:.*$DATE" "$INTEGRITY_LOG" 2>/dev/null || echo "No integrity issues today"
    echo

} > "$REPORT"

echo "Daily Security Report generated: $REPORT"






#or 
# use this code for cron job



#!/bin/bash


FILE_PATH="/var/log/auth.log"
DIR="/home/kavin/server_logs"
DATE=$(date +%F)
REPORT="$DIR/security_report_$DATE.txt"
BLOCKED_LOG="$DIR/blocked_ips.log"
INTEGRITY_LOG="$DIR/log_integrity.log"

/bin/mkdir -p "$DIR"


/bin/grep -i "Failed password" "$FILE_PATH" 2>/dev/null | \
/usr/bin/awk '{print $(NF-4)}' | /usr/bin/sort | /usr/bin/uniq -c | /usr/bin/sort -nr | /usr/bin/head -5 | \
while read count ip; do
    if [ "$count" -gt 15 ]; then
        if ! /bin/grep -qi "^BLOCKED: $ip " "$BLOCKED_LOG" 2>/dev/null; then
            /bin/echo "BLOCKED: $ip on $DATE (exceeded 15 SSH failures)" >> "$BLOCKED_LOG"
        fi
    fi
done


current_checksum=$(/usr/bin/sha256sum "$FILE_PATH" | /usr/bin/awk '{print $1}')

if [ -f "$INTEGRITY_LOG" ]; then
    last_checksum=$(/usr/bin/tail -1 "$INTEGRITY_LOG" | /usr/bin/awk '{print $2}')
else
    last_checksum=""
fi

if [ -n "$last_checksum" ] && [ "$current_checksum" != "$last_checksum" ]; then
    /bin/echo "WARNING: auth.log checksum changed on $DATE" >> "$INTEGRITY_LOG"
fi


/bin/echo "$DATE $current_checksum" >> "$INTEGRITY_LOG"


{
    /bin/echo "===== Daily Security Report ($DATE) ====="
    /bin/echo

   
    /bin/echo "🔐 Successful SSH Logins:"
    /bin/grep -i "Accepted password" "$FILE_PATH" 2>/dev/null | \
    /usr/bin/awk '{user=$9; ip=$11; timestamp=$1" "$2" "$3; print timestamp, "user="user, "ip="ip}'
    /bin/echo

   
    /bin/echo "⚠️ Top Failed SSH IPs:"
    /bin/grep -i "Failed password" "$FILE_PATH" 2>/dev/null | \
    /usr/bin/awk '{print $(NF-4)}' | /usr/bin/sort | /usr/bin/uniq -c | /usr/bin/sort -nr | /usr/bin/head -5 | \
    while read count ip; do
        /bin/echo "$ip - $count attempts"
    done
    /bin/echo

   
    /bin/echo "🚫 Blocked IPs:"
    /bin/grep "BLOCKED:.*$DATE" "$BLOCKED_LOG" 2>/dev/null || /bin/echo "No IPs blocked today"
    /bin/echo

    
    /bin/echo "🛡️ Log Integrity Warnings:"
    /bin/grep "WARNING:.*$DATE" "$INTEGRITY_LOG" 2>/dev/null || /bin/echo "No integrity issues today"
    /bin/echo

} > "$REPORT"


/bin/echo "Daily Security Report generated: $REPORT"


cron_job:

40 6 * * * /bin/bash /home/kavin/server_logs/day_12.sh >> /home/kavin/server_logs/cron.log 2>&1


