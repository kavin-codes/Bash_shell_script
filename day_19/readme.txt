Task day 19 ( 18-02-2026)

Day 19: Advanced Security Automation & Reporting
🔹 Task 1: Automated Log Rotation & Archiving
Goal: Keep logs manageable and prevent your alert scripts from growing too large.
Steps:
1.	Set up a daily or weekly rotation for /var/log/auth.log and /var/log/apache2/access.log.
2.	Move old logs to /home/kavin/server_logs/archives/.
3.	Compress old logs using gzip to save space.
4.	Optional: Keep a 7-day history, delete older logs automatically.
________________________________________
🔹 Task 2: Scheduled Security Alerts via Cron
Goal: Automate your scripts from Day 15 to run daily without manual execution.
Steps:
1.	Edit your crontab:
2.	crontab -e
3.	Add an entry to run the daily security report at 8 AM:
4.	0 8 * * * /home/kavin/server_logs/day_19.sh
5.	Ensure day_19.sh is executable:
6.	chmod +x /home/kavin/server_logs/day_19.sh
________________________________________
🔹 Task 3: Email Alerts for Critical Threats
Goal: Receive instant notifications for correlated threats.
Steps:
1.	Install mailutils or sendmail.
2.	Modify your Day 15 script to send an email when critical threats are detected:
if [ -s "$CRITICAL_LOG" ]; then
    mail -s "Critical Security Alerts - $DATE" admin@example.com < "$CRITICAL_LOG"
fi
3.	Optional: Include report summary in the email body.
________________________________________

🔹 Task 4: Defensive Analysis & Reflection
Questions to answer in notes:
1.	Why is automation critical in security monitoring?
2.	What are the risks of ignoring log rotation?
3.	How does scheduling alerts improve response time?
4.	How can email alerts help with early threat detection?
________________________________________

================================================================================================================

#!/bin/bash
# Day 19: Automated Security Alerts & Reporting

# ==============================
# LOG FILES
# ==============================
AUTH_LOG="/var/log/auth.log"                  # SSH authentication log (records login attempts)
WEB_LOG="/var/log/apache2/access.log"        # Apache web server access log (records all HTTP requests)

# ==============================
# DIRECTORIES & FILES
# ==============================
REPORT_DIR="/home/kavin/server_logs"         # Directory to store daily security reports
ARCHIVE_DIR="$REPORT_DIR/archives"           # Task 19 Addition: Folder to archive old reports
DATE=$(date +%F)                             # Current date in YYYY-MM-DD format
REPORT_FILE="$REPORT_DIR/security_alerts_$DATE.log"  # Path for today's report
CRITICAL_LOG="$REPORT_DIR/critical_alerts_$DATE.log" # Task 19 Addition: File to store only critical threats

# ==============================
# SETUP
# ==============================
mkdir -p "$REPORT_DIR" "$ARCHIVE_DIR"        # Ensure both report and archive directories exist
> "$REPORT_FILE"                              # Clear today's report file if it exists
> "$CRITICAL_LOG"                             # Task 19 Addition: Empty critical log at start

# ==============================
# REPORT HEADER
# ==============================
echo "===== Security Alerts ($DATE) =====" >> "$REPORT_FILE"  # Add a header line with current date
echo "" >> "$REPORT_FILE"                                     # Add an empty line for readability

# ==============================
# 1) SSH Brute Force Alerts
# ==============================
echo "1) SSH Brute Force Alerts:" >> "$REPORT_FILE"           # Section header for SSH alerts

# Extract IPs with failed login attempts, count them, sort by frequency
grep -a -i "Failed password" "$AUTH_LOG" | awk '{print $13}' | sort | uniq -c | sort -nr | \
while read count ip; do
    if [ "$count" -gt 5 ]; then                                # Only consider IPs with more than 5 failed attempts
        echo "$ip - $count failed attempts" >> "$REPORT_FILE"  # Log in daily report
        echo "$ip SSH brute force ($count attempts)" >> "$CRITICAL_LOG" # Task 19 Addition: record in critical log
    fi
done

echo "" >> "$REPORT_FILE"                                     # Empty line after section

# ==============================
# 2) Web Abuse Alerts
# ==============================
echo "2) Web Abuse Alerts:" >> "$REPORT_FILE"                  # Section header for web abuse

# High request rate detection: IPs with more than 50 requests
awk '
{
    ip = $1
    total[ip]++
}
END {
    for (ip in total)
        if (total[ip] > 50)
            print ip " - " total[ip] " requests"
}' "$WEB_LOG" >> "$REPORT_FILE"                              # Log in report

# HTTP error detection: IPs with more than 10 HTTP 401, 403, or 500 errors
awk '
$9 ~ /401|403|500/ {
    ip = $1
    errors[ip]++
}
END {
    for (ip in errors)
        if (errors[ip] > 10)
            print ip " - " errors[ip] " HTTP errors"
}' "$WEB_LOG" >> "$REPORT_FILE"                              # Log in report

echo "" >> "$REPORT_FILE"                                     # Empty line after section

# ==============================
# 3) Critical Correlated Threats
# ==============================
echo "3) Critical Correlated Threats:" >> "$REPORT_FILE"       # Section header

# Extract SSH IPs from critical log and Web IPs from access log
grep "SSH brute force" "$CRITICAL_LOG" | awk '{print $1}' | sort -u > /tmp/ssh_ips.txt
awk '{print $1}' "$WEB_LOG" | sort -u > /tmp/web_ips.txt

# Compare IPs attacking both SSH and Web, log as correlated threats
comm -12 /tmp/ssh_ips.txt /tmp/web_ips.txt | while read ip; do
    echo "$ip - SSH brute force & Web abuse" >> "$REPORT_FILE"  # Record in daily report
    echo "$ip CORRELATED SSH + WEB ATTACK" >> "$CRITICAL_LOG"   # Record in critical log
done

rm -f /tmp/ssh_ips.txt /tmp/web_ips.txt                          # Cleanup temporary files

echo "" >> "$REPORT_FILE"
echo "Report generated on $DATE" >> "$REPORT_FILE"               # Add report footer

# ==============================
# 4) Email Alerts
# ==============================
if [ -s "$CRITICAL_LOG" ]; then                                  # Check if critical log is not empty
    mail -s "Critical Security Alerts - $DATE" admin@example.com < "$CRITICAL_LOG" # Send email with critical threats
fi

# ==============================
# 5) Archive & Compress Reports
# ==============================
mv "$REPORT_FILE" "$ARCHIVE_DIR/"                                # Move daily report to archive folder
gzip "$ARCHIVE_DIR/security_alerts_$DATE.log"                    # Compress report to save disk space

# ==============================
# 6) Retention Policy
# ==============================
find "$ARCHIVE_DIR" -name "*.gz" -mtime +7 -delete               # Delete archive files older than 7 days





===================================================================================

Step 1: Open the Crontab
crontab -e
Step 2: Add a Cron Entry for Daily Execution
0 8 * * * /home/kavin/server_logs/day_19.sh
=======================================================================

task 5;

1)Why is automation critical?

Security events happen all the time. Automation checks logs, detects threats, and generates reports without missing anything.

2)Risks of ignoring log rotation:

Logs can grow too big, fill disk space, slow down scripts, and make threat detection harder.

3)How scheduling alerts helps:

Scripts run automatically at set times, so admins get reports on time and can respond faster.

4)How email alerts help:

They notify admins instantly about critical threats, allowing quick action and early prevention.