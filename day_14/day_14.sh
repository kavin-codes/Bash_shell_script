#!/bin/bash


DATE=$(date +%F)
AUTH_LOG="/var/log/auth.log"
WEB_LOG="/var/log/apache2/access.log"
BASE_DIR="/home/kavin/server_logs"

SSH_REPORT="$BASE_DIR/suspicious_ssh.log"
CROSS_REPORT="$BASE_DIR/cross_referenced_ips.log"
FINAL_REPORT="$BASE_DIR/web_system_correlation_report_$DATE.txt"

mkdir -p "$BASE_DIR"


grep -a -i "Failed password" "$AUTH_LOG" | awk '
{
    for (i=1; i<=NF; i++) {
        if ($i == "for")  user = $(i+1)
        if ($i == "from") ip   = $(i+1)
    }

    timestamp = $1 " " $2 " " $3
    split($3, t, ":")
    hour = t[1]

    if (hour < 9 || hour >= 18) {
        print timestamp " user=" user " ip=" ip " (outside normal hours)"
    }

    user=""
    ip=""
}
' > "$SSH_REPORT"


TOP_WEB=$(awk '{print $1}' "$WEB_LOG" | sort | uniq -c | sort -nr | head -5 | \
awk '{print $2 " – " $1 " requests"}')

HTTP_ANOMALIES=$(awk '$9==401 || $9==403 || $9==500 {print $1, $9}' "$WEB_LOG" | \
sort | uniq -c | sort -nr | \
awk '{
    if ($3==401) print $2 " – " $1 " times 401 Unauthorized"
    else if ($3==403) print $2 " – " $1 " times 403 Forbidden"
    else if ($3==500) print $2 " – " $1 " times 500 Internal Server Error"
}')

grep "Failed password" "$AUTH_LOG" | awk '{print $(NF-3)}' | sort | uniq > /tmp/ssh_ips.txt

awk '$9==401 || $9==403 || $9==500 {print $1, $9}' "$WEB_LOG" | \
sort | uniq > /tmp/web_ip_errors.txt

> "$CROSS_REPORT"

while read ssh_ip; do
    grep "^$ssh_ip " /tmp/web_ip_errors.txt | \
    while read ip code; do
        if [ "$code" = "401" ]; then
            echo "$ip – Failed SSH & 401 Accesses" >> "$CROSS_REPORT"
        elif [ "$code" = "403" ]; then
            echo "$ip – Failed SSH & 403 Forbidden Accesses" >> "$CROSS_REPORT"
        elif [ "$code" = "500" ]; then
            echo "$ip – Failed SSH & 500 Errors" >> "$CROSS_REPORT"
        fi
    done
done < /tmp/ssh_ips.txt


{
echo "===== Correlated Web + System Log Report ($DATE) ====="
echo

echo "1) Suspicious SSH Logins:"
cat "$SSH_REPORT"
echo

echo "2) Top Web Requesters:"
echo "$TOP_WEB"
echo

echo "3) HTTP Anomalies:"
echo "$HTTP_ANOMALIES"
echo

echo "4) Cross-Referenced IPs (SSH + Web):"
cat "$CROSS_REPORT"
} > "$FINAL_REPORT"
