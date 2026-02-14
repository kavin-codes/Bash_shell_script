
 Task Day 15 (14-02-2026)
🔹 Day 15: Security Automation & Alerting
🔹 Task 1: SSH Brute Force Detection
Requirements:
• Parse SSH authentication logs (/var/log/auth.log)
• Identify IPs with more than 5 failed SSH login attempts
• Save findings to daily alert section
📌 Example:
SSH Brute Force Alerts:
203.0.113.55 - 12 failed attempts
198.51.100.77 - 8 failed attempts
________________________________________
🔹 Task 2: Web Abuse Detection
Requirements:
• Parse web server logs (/var/log/apache2/access.log or /var/log/nginx/access.log)
• Identify:
•	IPs with more than 50 total requests
•	IPs generating more than 10 HTTP errors (401, 403, 500)
• Save suspicious IPs to daily alert section
📌 Example:
Suspicious Web Activity:
203.0.113.10 - 87 requests
198.51.100.25 - 14 HTTP errors
________________________________________
🔹 Task 3: Cross-System Threat Correlation
Requirements:
• Compare results from:
•	SSH brute-force detection
•	Web abuse detection
• Identify IPs appearing in both SSH and web alerts
• Mark these IPs as critical threats
📌 Example:
Critical Correlated Threats:
203.0.113.55 - SSH brute force & Web abuse
________________________________________
🔹 Task 4: Generate Security Alert Report
Requirements:
• Combine all findings into one daily alert report:
/home/kavin/server_logs/security_alerts_<DATE>.log
• Include sections:
1.	SSH Brute Force Alerts
2.	Web Abuse Alerts
3.	Critical Correlated Threats
📌 Example Report Structure:
===== Security Alerts (2026-02-15) =====

1) SSH Brute Force Alerts:
203.0.113.55 - 12 failed attempts

2) Web Abuse Alerts:
198.51.100.25 - Excessive HTTP errors

3) Critical Correlated Threats:
203.0.113.55 - SSH + Web abuse detected
________________________________________
🔹 Task 5: Defensive Analysis (No Coding)
Requirements:
• Answer the following questions in your own notes:
•	Why are threshold-based alerts needed?
•	What are possible false positives in SSH failures?
•	Why should alerts be reviewed before blocking?
•	Difference between monitoring and response

=================================================================================================================

#!/bin/bash

# -----------------------------
# 1️⃣ Define log files and report paths
# -----------------------------
AUTH_LOG="/var/log/auth.log"                       # SSH authentication log
WEB_LOG="/var/log/apache2/access.log"             # Web server access log
REPORT_DIR="/home/kavin/server_logs"              # Directory to store daily reports
DATE=$(date +%F)                                  # Current date in YYYY-MM-DD format
REPORT_FILE="$REPORT_DIR/security_alerts_$DATE.log"  # Daily report filename

# Ensure the report directory exists
mkdir -p "$REPORT_DIR"

# Clear previous report file if exists
> "$REPORT_FILE"

# -----------------------------
# 2️⃣ Report header
# -----------------------------
echo "===== Security Alerts ($DATE) =====" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
echo "1) SSH Brute Force Alerts:" >> "$REPORT_FILE"

# -----------------------------
# 3️⃣ SSH Brute Force Detection
# -----------------------------
# Search auth.log for failed SSH login attempts, count per IP
grep -a -i "Failed password" "$AUTH_LOG" | awk '{print $13}' | sort | uniq -c | sort -nr | \
while read count ip; do
    # Only include IPs with more than 5 failed attempts
    if [ "$count" -gt 5 ]; then
        echo "$ip - $count failed attempts" >> "$REPORT_FILE"
    fi
done

# Add a blank line for readability
echo "" >> "$REPORT_FILE"

# -----------------------------
# 4️⃣ Web Abuse Alerts
# -----------------------------
echo "2) Web Abuse Alerts:" >> "$REPORT_FILE"

# Count total requests per IP (>50)
awk '
{
    ip = $1              # First field is the IP address
    total[ip]++          # Increment count for each IP
}
END {
    for (ip in total) {
        if (total[ip] > 50)
            print ip " - " total[ip] " requests"  # Only IPs exceeding threshold
    }
}' "$WEB_LOG" >> "$REPORT_FILE"

# Count HTTP errors per IP (>10) (status codes 401, 403, 500)
awk '
$9 ~ /401|403|500/ {   # Only consider lines with 401, 403, or 500 errors
    ip = $1             # Extract IP address
    errors[ip]++        # Increment error count per IP
}
END {
    for (ip in errors) {
        if (errors[ip] > 10)
            print ip " - " errors[ip] " HTTP errors"  # Only IPs exceeding threshold
    }
}' "$WEB_LOG" >> "$REPORT_FILE"

# Add a blank line for readability
echo "" >> "$REPORT_FILE"

# -----------------------------
# 5️⃣ Critical Correlated Threats
# -----------------------------
echo "3) Critical Correlated Threats:" >> "$REPORT_FILE"

# Extract IPs from SSH alerts and Web abuse alerts
# Using previously saved files if available (otherwise suppress errors)
awk '{print $1}' "$REPORT_DIR/ssh_alerts.log" 2>/dev/null > /tmp/ssh_ips.txt
awk '{print $1}' "$REPORT_DIR/suspicious.log" 2>/dev/null > /tmp/web_ips.txt

# Sort IP lists (required by 'comm' to find common IPs)
sort /tmp/ssh_ips.txt > /tmp/ssh_ips_sorted.txt
sort /tmp/web_ips.txt > /tmp/web_ips_sorted.txt

# Find IPs appearing in both SSH and Web alerts
comm -12 /tmp/ssh_ips_sorted.txt /tmp/web_ips_sorted.txt | while read ip; do
    echo "$ip - SSH brute force & Web abuse" >> "$REPORT_FILE"
done

# Cleanup temporary files used for comparison
rm -f /tmp/ssh_ips.txt /tmp/web_ips.txt /tmp/ssh_ips_sorted.txt /tmp/web_ips_sorted.txt

# Add a blank line and report generation message
echo "" >> "$REPORT_FILE"
echo "Report generated: $REPORT_FILE"


task 5

1️ Why are threshold-based alerts needed?

Thresholds help us focus on the really important stuff. For example, one failed login is normal, but 10 or 12 failed logins in a short time might be an attack. Without thresholds, we’d get flooded with alerts for normal mistakes. Thresholds help filter the noise so we only respond to likely threats.

2️ Possible false positives in SSH failures

Not every failed login is a hacker. Some common “false alarms” are:

Someone simply typed the wrong password a few times.

Automated tasks or scripts trying to log in.

Network hiccups causing retries.

Security scanners or tests from IT itself.

Basically, sometimes the system thinks it’s an attack, but it’s just normal activity.

3️ Why should alerts be reviewed before blocking?

You don’t want to block real users by accident. If an alert goes off, it might be a legitimate user or an internal script. Reviewing first makes sure we don’t disrupt business and only take action against real threats. Think of it as checking before you hit the “delete” button — better safe than sorry.

4️ Difference between monitoring and response

Monitoring is like watching the security cameras — you’re keeping an eye on things and noting anything unusual.

Response is what you do after spotting something suspicious — like calling security, locking doors, or blocking an attacker.

Monitoring tells you there’s a problem; response is taking action to fix it. Both are important, but one is observing, the other is acting.