
Task Day 14 (13-02-2026)
🛠️ Day 14 – Multi-Source Log Correlation & Incident Reporting
Goal:
Move from single-system monitoring ➜ multi-system correlation & incident reporting.
This is where you start thinking like a SOC analyst tracking threats across multiple services.
________________________________________
🔹 Task 1: Suspicious SSH Login Detection
Requirements:
• Parse /var/log/auth.log
• Detect failed or unusual SSH logins (outside normal business hours, e.g., 09:00–18:00)
• Extract:
o Username
o Source IP
o Timestamp
• Save results to:
/home/kavin/server_logs/suspicious_ssh.log
📌 Example:
2026-02-12 03:14:56 user=john ip=203.0.113.55 (outside normal hours)
________________________________________
🔹 Task 2: Web Server Log Analysis
Requirements:
• Parse web server logs (/var/log/apache2/access.log or /var/log/nginx/access.log)
• Identify:
o Top 5 IPs by number of requests
o IPs generating errors (HTTP status 401, 403, 500)
• Save findings to daily report section
📌 Example:
Top Web Requesters:
192.0.2.33 – 243 requests
198.51.100.12 – 101 requests

HTTP Anomalies:
192.0.2.33 – 13 times 403 Forbidden
198.51.100.12 – 7 times 500 Internal Server Error
________________________________________
🔹 Task 3: Cross-System Correlation
Requirements:
• Find IPs that appear in both SSH anomalies and web errors
• Highlight potential threats that span multiple services
• Save cross-referenced IPs to:
/home/kavin/server_logs/cross_referenced_ips.log
📌 Example:
203.0.113.55 – Failed SSH & 401 Accesses
198.51.100.12 – Failed SSH & 500 Errors
________________________________________
🔹 Task 4: Generate Correlated Daily Report
Requirements:
• Combine all findings into one report:
/home/kavin/server_logs/web_system_correlation_report_<DATE>.txt
• Include sections:
o Suspicious SSH logins
o Top web requesters
o HTTP anomalies
o Cross-referenced IPs
📌 Example report structure:
===== Correlated Web + System Log Report (2026-02-12) =====

1) Suspicious SSH Logins:
- 2026-02-12 03:14:56 user=john ip=203.0.113.55 (outside normal hours)

2) Top Web Requesters:
192.0.2.33 – 243 requests
198.51.100.12 – 101 requests

3) HTTP Anomalies:
192.0.2.33 – 13 times 403 Forbidden
198.51.100.12 – 7 times 500 Internal Server Error

4) Cross-Referenced IPs (SSH + Web):
203.0.113.55 – Failed SSH & 401 Accesses
198.51.100.12 – Failed SSH & 500 Errors
________________________________________
🔹 Task 5: Cron Automation
Requirements:
• Run after Day 12 script
• Schedule at:
07:00 AM daily
📌 Cron:
0 7 * * * /bin/bash /home/kavin/server_logs/day_14_.sh >> /home/kavin/server_logs/cron.log 2>&1




======================================================================================

#!/bin/bash
# Use bash shell (required for cron jobs)

# -----------------------------
# Paths & Date
# -----------------------------

DATE=$(date +%F)
# Stores today's date in YYYY-MM-DD format

AUTH_LOG="/var/log/auth.log"
# SSH authentication log file

WEB_LOG="/var/log/apache2/access.log"
# Apache web server access log

BASE_DIR="/home/kavin/server_logs"
# Base directory to store all generated reports

SSH_REPORT="$BASE_DIR/suspicious_ssh.log"
# File to store suspicious SSH login attempts

CROSS_REPORT="$BASE_DIR/cross_referenced_ips.log"
# File to store IPs found in both SSH and Web logs

FINAL_REPORT="$BASE_DIR/web_system_correlation_report_$DATE.txt"
# Final combined daily report with date in filename

mkdir -p "$BASE_DIR"
# Create report directory if it does not already exist

# -----------------------------
# Task 1: Suspicious SSH Logins
# -----------------------------

grep -a -i "Failed password" "$AUTH_LOG" | awk '
{
    # Loop through all fields in the log line
    for (i=1; i<=NF; i++) {

        # Username appears after keyword "for"
        if ($i == "for")  user = $(i+1)

        # IP address appears after keyword "from"
        if ($i == "from") ip   = $(i+1)
    }

    # Build timestamp (auth.log does not contain year)
    timestamp = $1 " " $2 " " $3

    # Extract hour from HH:MM:SS
    split($3, t, ":")
    hour = t[1]

    # Check if login attempt is outside business hours (09–18)
    if (hour < 9 || hour >= 18) {
        print timestamp " user=" user " ip=" ip " (outside normal hours)"
    }

    # Reset variables for next log entry
    user=""
    ip=""
}
' > "$SSH_REPORT"
# Save suspicious SSH attempts to file

# -----------------------------
# Task 2: Web Log Analysis
# -----------------------------

TOP_WEB=$(awk '{print $1}' "$WEB_LOG" | \
sort | uniq -c | sort -nr | head -5 | \
awk '{print $2 " – " $1 " requests"}')
# Finds top 5 IPs by number of web requests

HTTP_ANOMALIES=$(awk '$9==401 || $9==403 || $9==500 {print $1, $9}' "$WEB_LOG" | \
sort | uniq -c | sort -nr | \
awk '{
    if ($3==401) print $2 " – " $1 " times 401 Unauthorized"
    else if ($3==403) print $2 " – " $1 " times 403 Forbidden"
    else if ($3==500) print $2 " – " $1 " times 500 Internal Server Error"
}')
# Counts HTTP error responses per IP and formats output

# -----------------------------
# Task 3: Cross-System Correlation
# -----------------------------

grep "Failed password" "$AUTH_LOG" | \
awk '{print $(NF-3)}' | sort | uniq > /tmp/ssh_ips.txt
# Extract unique IPs involved in failed SSH logins

awk '$9==401 || $9==403 || $9==500 {print $1, $9}' "$WEB_LOG" | \
sort | uniq > /tmp/web_ip_errors.txt
# Extract IPs and HTTP error codes from web logs

> "$CROSS_REPORT"
# Clear old correlation results before writing new ones

while read ssh_ip; do
    # Read each SSH attacker IP

    grep "^$ssh_ip " /tmp/web_ip_errors.txt | \
    while read ip code; do
        # Match same IP in web error file and read error code

        if [ "$code" = "401" ]; then
            echo "$ip – Failed SSH & 401 Accesses" >> "$CROSS_REPORT"
        elif [ "$code" = "403" ]; then
            echo "$ip – Failed SSH & 403 Forbidden Accesses" >> "$CROSS_REPORT"
        elif [ "$code" = "500" ]; then
            echo "$ip – Failed SSH & 500 Errors" >> "$CROSS_REPORT"
        fi
    done
done < /tmp/ssh_ips.txt
# This block finds IPs attacking both SSH and Web services

# -----------------------------
# Task 4: Final Correlated Report
# -----------------------------

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
# Combine all findings into one daily report file
