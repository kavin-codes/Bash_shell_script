#!/bin/bash


AUTH_LOG="/var/log/auth.log"
WEB_LOG="/var/log/apache2/access.log"
REPORT_DIR="/home/kavin/server_logs"
DATE=$(date +%F)   
REPORT_FILE="$REPORT_DIR/security_alerts_$DATE.log"


mkdir -p "$REPORT_DIR"

> "$REPORT_FILE"


echo "===== Security Alerts ($DATE) =====" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
echo "1) SSH Brute Force Alerts:" >> "$REPORT_FILE"

grep -a -i "Failed password" "$AUTH_LOG" | awk '{print $13}' | sort | uniq -c | sort -nr | \
while read count ip; do
    if [ "$count" -gt 5 ]; then
        echo "$ip - $count failed attempts" >> "$REPORT_FILE"
    fi
done

echo "" >> "$REPORT_FILE"


echo "2) Web Abuse Alerts:" >> "$REPORT_FILE"


awk '
{
    ip = $1
    total[ip]++
}
END {
    for (ip in total) {
        if (total[ip] > 50)
            print ip " - " total[ip] " requests"
    }
}' "$WEB_LOG" >> "$REPORT_FILE"


awk '
$9 ~ /401|403|500/ {
    ip = $1
    errors[ip]++
}
END {
    for (ip in errors) {
        if (errors[ip] > 10)
            print ip " - " errors[ip] " HTTP errors"
    }
}' "$WEB_LOG" >> "$REPORT_FILE"

echo "" >> "$REPORT_FILE"


echo "3) Critical Correlated Threats:" >> "$REPORT_FILE"

# Extract IPs from SSH alerts (already in report file, but could also use previous ssh_alerts.log)
awk '{print $1}' "$REPORT_DIR/ssh_alerts.log" 2>/dev/null > /tmp/ssh_ips.txt
awk '{print $1}' "$REPORT_DIR/suspicious.log" 2>/dev/null > /tmp/web_ips.txt

sort /tmp/ssh_ips.txt > /tmp/ssh_ips_sorted.txt
sort /tmp/web_ips.txt > /tmp/web_ips_sorted.txt

comm -12 /tmp/ssh_ips_sorted.txt /tmp/web_ips_sorted.txt | while read ip; do
    echo "$ip - SSH brute force & Web abuse" >> "$REPORT_FILE"
done

# Cleanup temporary files
rm -f /tmp/ssh_ips.txt /tmp/web_ips.txt /tmp/ssh_ips_sorted.txt /tmp/web_ips_sorted.txt

echo "" >> "$REPORT_FILE"
echo "Report generated: $REPORT_FILE"
