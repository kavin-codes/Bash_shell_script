#!/bin/bash


FILE_PATH="/var/log/auth.log"
BASE_DIR="/home/kavin/server_logs"
REPORT_DIR="/home/kavin/server_logs/security_reports"

SUDO_LOG="$BASE_DIR/sudo_audit.log"
SUSPICIOUS_LOG="$BASE_DIR/suspicious_ips.log"
ALERT_LOG="$BASE_DIR/security_alerts.log"

DATE=$(date +"%Y-%m-%d")
REPORT_FILE="$REPORT_DIR/security_report_$DATE.txt"

ssh_failed_count=$(grep -i "Failed password" "$FILE_PATH" | wc -l)

echo "$ssh_failed_count"
echo "Failed SSH Attempts:"

grep -i "Failed password" "$FILE_PATH" | \
awk '{print $(NF-5)}' | sort | uniq -c | sort -nr


grep "sudo:" "$FILE_PATH" | awk '
{
  user=$4
  gsub(":", "", user)
  split($0, cmd, "COMMAND=")
  print $1, "user=" user, "command=" cmd[2]
}' >> "$SUDO_LOG"


grep "Failed password" "$FILE_PATH" | \
awk '{print $(NF-3)}' | \
sort | uniq -c | \
while read count ip; do
    if [ "$count" -gt 5 ]; then
        echo "ALERT: $ip exceeded failed login threshold" >> "$SUSPICIOUS_LOG"
    fi
done


{
    echo "===== Daily Security Report ($DATE) ====="
    echo

    echo "🔐 Failed SSH Login Summary:"
    grep "Failed password" "$FILE_PATH" | \
    awk '{print $(NF-3)}' | \
    sort | uniq -c | sort -nr
    echo

    echo "🛡️ Sudo Activity Count:"
    grep "sudo:" "$FILE_PATH" | wc -l
    echo

    echo "🚨 Suspicious IPs:"
    grep "Failed password" "$FILE_PATH" | \
    awk '{print $(NF-3)}' | \
    sort | uniq -c | \
    awk '$1 > 5 {print "ALERT:", $2, "failed", $1, "times"}'

} > "$REPORT_FILE"


grep "Failed password" "$FILE_PATH" | \
awk '{print $(NF-3)}' | \
sort | uniq -c | \
while read count ip; do
    if [ "$count" -gt 10 ]; then
        echo "CRITICAL: Possible brute-force attack from $ip on $DATE" \
        >> "$ALERT_LOG"
    fi
done  





#Cron Job Scheduler Code

#!/bin/bash


PATH=/usr/sbin:/usr/bin:/sbin:/bin


FILE_PATH="/var/log/auth.log"
BASE_DIR="/home/kavin/server_logs"
REPORT_DIR="/home/kavin/server_logs/security_reports"

SUDO_LOG="$BASE_DIR/sudo_audit.log"
SUSPICIOUS_LOG="$BASE_DIR/suspicious_ips.log"
ALERT_LOG="$BASE_DIR/security_alerts.log"

DATE=$(/bin/date +"%Y-%m-%d")
REPORT_FILE="$REPORT_DIR/security_report_$DATE.txt"


/bin/mkdir -p "$BASE_DIR" "$REPORT_DIR"


/bin/grep -i "Failed password" "$FILE_PATH" | \
/usr/bin/awk '{print $(NF-5)}' | \
/bin/sort | /usr/bin/uniq -c | /bin/sort -nr \
> "$BASE_DIR/failed_ssh_summary.log"


/bin/grep "sudo:" "$FILE_PATH" | /usr/bin/awk '
{
  user=$4
  gsub(":", "", user)
  split($0, cmd, "COMMAND=")
  print $1, "user=" user, "command=" cmd[2]
}' >> "$SUDO_LOG"


/bin/grep "Failed password" "$FILE_PATH" | \
/usr/bin/awk '{print $(NF-3)}' | \
/bin/sort | /usr/bin/uniq -c | \
while read count ip; do
    if [ "$count" -gt 5 ]; then
        echo "ALERT: $ip exceeded failed login threshold" >> "$SUSPICIOUS_LOG"
    fi
done


{
    echo "===== Daily Security Report ($DATE) ====="
    echo

    echo "Failed SSH Login Summary:"
    /bin/grep "Failed password" "$FILE_PATH" | \
    /usr/bin/awk '{print $(NF-3)}' | \
    /bin/sort | /usr/bin/uniq -c | /bin/sort -nr
    echo

    echo "Sudo Activity Count:"
    /bin/grep "sudo:" "$FILE_PATH" | /usr/bin/wc -l
    echo

    echo "Suspicious IPs:"
    /bin/grep "Failed password" "$FILE_PATH" | \
    /usr/bin/awk '{print $(NF-3)}' | \
    /bin/sort | /usr/bin/uniq -c | \
    /usr/bin/awk '$1 > 5 {print "ALERT:", $2, "failed", $1, "times"}'

} > "$REPORT_FILE"


/bin/grep "Failed password" "$FILE_PATH" | \
/usr/bin/awk '{print $(NF-3)}' | \
/bin/sort | /usr/bin/uniq -c | \
while read count ip; do
    if [ "$count" -gt 10 ]; then
        echo "CRITICAL: Possible brute-force attack from $ip on $DATE" \
        >> "$ALERT_LOG"
    fi
done
