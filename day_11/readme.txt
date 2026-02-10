Day 11 Task(10-02-2026)
🟢 Day 11 – Linux Security, Audit & Intrusion Monitoring
🎯 Objective
Extend your monitoring system to detect security-related events by:
•	Tracking failed login attempts
•	Monitoring sudo usage
•	Detecting suspicious IP activity
•	Generating a daily security report
•	Triggering alerts for critical behavior
This is exactly what SOC, SRE, and DevOps engineers are expected to understand.
________________________________________
🛠️ Day 11 Task Requirements
________________________________________
🔹 Task 1: Failed Login Monitoring
Requirements
•	Parse authentication logs:
o	/var/log/auth.log (Ubuntu/Debian)
o	/var/log/secure (RHEL/CentOS)
•	Count failed SSH login attempts
•	Extract:
o	Username
o	Source IP
•	Save results to a report
📌 Example Output:
Failed SSH Attempts:
root from 192.168.1.50 (5 times)
admin from 10.0.0.12 (3 times)
________________________________________
🔹 Task 2: Sudo Usage Audit
Requirements
•	Track sudo command usage
•	Capture:
o	User
o	Command executed
o	Timestamp
•	Store in sudo_audit.log
📌 Example:
2026-02-09 08:14:22 user=kavin command=/usr/bin/systemctl restart nginx
________________________________________
🔹 Task 3: Suspicious IP Detection
Requirements
•	Identify IPs with:
o	More than 5 failed login attempts
•	Flag them as suspicious
•	Log them separately
📂 File:
suspicious_ips.log
📌 Example:
ALERT: 192.168.1.50 exceeded failed login threshold
________________________________________
🔹 Task 4: Daily Security Report
Requirements
•	Generate a consolidated report:
o	Failed login summary
o	Sudo activity count
o	Suspicious IPs
•	Save as:
security_report_YYYY-MM-DD.txt
📂 Location:
/home/kavin/server_logs/security_reports/
________________________________________
🔹 Task 5: Critical Alert Trigger
Requirements
•	Trigger alert if:
o	Any IP has >10 failed attempts
•	Log alert to:
security_alerts.log
📌 Example:
CRITICAL: Possible brute-force attack from 192.168.1.50 on 2026-02-09
________________________________________
🔹 Task 6: Cron Automation
Schedule
•	Run daily at 6:30 AM
•	After Day 10 automation
30 6 * * * /home/kavin/server_logs/day_11_security_monitor.sh \
>> /home/kavin/server_logs/cron.log 2>&1


=================================================================================

#!/bin/bash
# -----------------------------------------
# Day 11: Security Monitoring Script
# Monitors SSH failures, sudo usage,
# detects suspicious & critical IPs,
# and generates a daily security report
# -----------------------------------------

# ----------- Log file paths ---------------

FILE_PATH="/var/log/auth.log"                 # Authentication log file
BASE_DIR="/home/kavin/server_logs"            # Base directory for all logs
REPORT_DIR="/home/kavin/server_logs/security_reports"  # Reports directory

SUDO_LOG="$BASE_DIR/sudo_audit.log"            # Sudo usage audit log
SUSPICIOUS_LOG="$BASE_DIR/suspicious_ips.log"  # Suspicious IP log (>5 fails)
ALERT_LOG="$BASE_DIR/security_alerts.log"      # Critical alert log (>10 fails)

# ----------- Date & report file ------------

DATE=$(date +"%Y-%m-%d")                       # Current date
REPORT_FILE="$REPORT_DIR/security_report_$DATE.txt"  # Daily report file

# ==========================================
# Task 1: Count Failed SSH Login Attempts
# ==========================================

# Count total failed SSH login attempts
ssh_failed_count=$(grep -i "Failed password" "$FILE_PATH" | wc -l)

echo "$ssh_failed_count"                       # Print total failed attempts
echo "Failed SSH Attempts:"

# Show failed SSH attempts grouped by username
grep -i "Failed password" "$FILE_PATH" | \
awk '{print $(NF-5)}' | sort | uniq -c | sort -nr

# ==========================================
# Task 2: Sudo Usage Audit
# ==========================================

# Extract sudo usage:
# - User who ran sudo
# - Command executed
# Append results to sudo audit log
grep "sudo:" "$FILE_PATH" | awk '
{
  user=$4                      # Extract username field
  gsub(":", "", user)          # Remove trailing colon
  split($0, cmd, "COMMAND=")   # Extract executed command
  print $1, "user=" user, "command=" cmd[2]
}' >> "$SUDO_LOG"

# ==========================================
# Task 3: Suspicious IP Detection (>5 fails)
# ==========================================

# Extract IP addresses from failed SSH attempts
# Count failures per IP
# Log IPs with more than 5 failures
grep "Failed password" "$FILE_PATH" | \
awk '{print $(NF-3)}' | \
sort | uniq -c | \
while read count ip; do
    if [ "$count" -gt 5 ]; then
        echo "ALERT: $ip exceeded failed login threshold" \
        >> "$SUSPICIOUS_LOG"
    fi
done

# ==========================================
# Task 4: Daily Security Report
# ==========================================

# Generate consolidated daily report
{
    echo "===== Daily Security Report ($DATE) ====="
    echo

    # Failed SSH login summary
    echo "🔐 Failed SSH Login Summary:"
    grep "Failed password" "$FILE_PATH" | \
    awk '{print $(NF-3)}' | \
    sort | uniq -c | sort -nr
    echo

    # Total sudo command count
    echo "🛡️ Sudo Activity Count:"
    grep "sudo:" "$FILE_PATH" | wc -l
    echo

    # List suspicious IPs (>5 failures)
    echo "🚨 Suspicious IPs:"
    grep "Failed password" "$FILE_PATH" | \
    awk '{print $(NF-3)}' | \
    sort | uniq -c | \
    awk '$1 > 5 {print "ALERT:", $2, "failed", $1, "times"}'

} > "$REPORT_FILE"

# ==========================================
# Task 5: Critical Alert Trigger (>10 fails)
# ==========================================

# Detect IPs with more than 10 failed SSH attempts
# Log them as critical security alerts
grep "Failed password" "$FILE_PATH" | \
awk '{print $(NF-3)}' | \
sort | uniq -c | \
while read count ip; do
    if [ "$count" -gt 10 ]; then
        echo "CRITICAL: Possible brute-force attack from $ip on $DATE" \
        >> "$ALERT_LOG"
    fi
done





30 6 * * * /home/kavin/server_logs/day_11.sh \
>> /home/kavin/server_logs/cron.log 2>&1