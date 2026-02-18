#!/bin/bash


AUTH_LOG="/var/log/auth.log"
WEB_LOG="/var/log/apache2/access.log"


REPORT_DIR="/home/kavin/server_logs"
ARCHIVE_DIR="$REPORT_DIR/archives"                 #  Task 19 Addition: Archive directory
DATE=$(date +%F)
REPORT_FILE="$REPORT_DIR/security_alerts_$DATE.log"
CRITICAL_LOG="$REPORT_DIR/critical_alerts_$DATE.log" # Task 19 Addition: Separate critical log


mkdir -p "$REPORT_DIR" "$ARCHIVE_DIR"              # Task 19 Addition: Ensure archive directory exists
> "$REPORT_FILE"
> "$CRITICAL_LOG"                                  #  Task 19 Addition: Empty critical log at start


echo "===== Security Alerts ($DATE) =====" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"


echo "1) SSH Brute Force Alerts:" >> "$REPORT_FILE"

grep -a -i "Failed password" "$AUTH_LOG" | awk '{print $13}' | sort | uniq -c | sort -nr | \
while read count ip; do
    if [ "$count" -gt 5 ]; then
        echo "$ip - $count failed attempts" >> "$REPORT_FILE"
        echo "$ip SSH brute force ($count attempts)" >> "$CRITICAL_LOG"   # Task 19 Addition: Record critical threats
    fi
done

echo "" >> "$REPORT_FILE"

echo "2) Web Abuse Alerts:" >> "$REPORT_FILE"

# High request rate detection
awk '
{
    ip = $1
    total[ip]++
}
END {
    for (ip in total)
        if (total[ip] > 50)
            print ip " - " total[ip] " requests"
}' "$WEB_LOG" >> "$REPORT_FILE"

# HTTP error detection
awk '
$9 ~ /401|403|500/ {
    ip = $1
    errors[ip]++
}
END {
    for (ip in errors)
        if (errors[ip] > 10)
            print ip " - " errors[ip] " HTTP errors"
}' "$WEB_LOG" >> "$REPORT_FILE"

echo "" >> "$REPORT_FILE"


echo "3) Critical Correlated Threats:" >> "$REPORT_FILE"

grep "SSH brute force" "$CRITICAL_LOG" | awk '{print $1}' | sort -u > /tmp/ssh_ips.txt      #  Use critical log
awk '{print $1}' "$WEB_LOG" | sort -u > /tmp/web_ips.txt                                   #  Extract Web IPs

comm -12 /tmp/ssh_ips.txt /tmp/web_ips.txt | while read ip; do
    echo "$ip - SSH brute force & Web abuse" >> "$REPORT_FILE"
    echo "$ip CORRELATED SSH + WEB ATTACK" >> "$CRITICAL_LOG"                               #  Mark correlated critical IPs
done

rm -f /tmp/ssh_ips.txt /tmp/web_ips.txt

echo "" >> "$REPORT_FILE"
echo "Report generated on $DATE" >> "$REPORT_FILE"

if [ -s "$CRITICAL_LOG" ]; then
    mail -s "Critical Security Alerts - $DATE" admin@example.com < "$CRITICAL_LOG"        #  Task 19 Addition: Email critical threats
fi

# ==============================
# 5) ARCHIVE & COMPRESS REPORT
# ==============================
mv "$REPORT_FILE" "$ARCHIVE_DIR/"                                                            # Move report to archive
gzip "$ARCHIVE_DIR/security_alerts_$DATE.log"                                                #  Compress report

# ==============================
# 6) RETENTION POLICY
# ==============================
find "$ARCHIVE_DIR" -name "*.gz" -mtime +7 -delete                                           #  Delete reports older than 7 days
