Day 12 Task (11-02-2026)

🛠️ Day 12 – Advanced Log Analysis & Automated Response
Goal:
Move from monitoring ➜ response & hardening
This is where you start thinking like a security engineer / SOC analyst.
________________________________________
🔹 Task 1: SSH Login Success Monitoring
Requirements
•	Parse /var/log/auth.log
•	Detect successful SSH logins
•	Extract:
o	Username
o	Source IP
o	Timestamp
•	Save to:
/home/kavin/server_logs/ssh_success.log
📌 Example:
2026-02-11 09:22:10 user=kavin ip=192.168.1.20
________________________________________
🔹 Task 2: Top Attacking IPs Report
Requirements
•	Identify top 5 IPs with failed SSH attempts
•	Count attempts per IP
•	Sort descending
•	Save to daily report section
📌 Example:
Top Failed SSH IPs:
192.168.1.50 - 14 attempts
10.0.0.12    - 9 attempts
________________________________________
🔹 Task 3: Auto-IP Blocking Simulation (Safe)
⚠️ Simulation only — no real blocking yet
Requirements
•	If an IP exceeds 15 failed attempts:
o	Add it to:
/home/kavin/server_logs/blocked_ips.log
•	Log:
o	IP
o	Date
o	Reason
📌 Example:
BLOCKED: 192.168.1.50 on 2026-02-11 (exceeded 15 SSH failures)
________________________________________
🔹 Task 4: Log Integrity Check
Requirements
•	Calculate checksum of:
/var/log/auth.log
•	Store checksum daily
•	Detect if the file was modified unexpectedly
•	Log warning if checksum changes
📂 File:
/home/kavin/server_logs/log_integrity.log
📌 Example:
WARNING: auth.log checksum changed on 2026-02-11
________________________________________
🔹 Task 5: Extended Daily Security Report
Requirements
Add these new sections to your report:
•	Successful SSH logins
•	Top attacking IPs
•	Blocked IPs
•	Log integrity status
📂 File:
security_report_YYYY-MM-DD.txt
________________________________________
🔹 Task 6: Cron Automation (Extended)
Requirements
•	Run after Day 11 script
•	Schedule at:
06:40 AM
📌 Cron:
40 6 * * * /bin/bash /home/kavin/server_logs/day_12_security_hardening.sh \
>> /home/kavin/server_logs/cron.log 2>&1
________________________________________

explaination of code:


#!/bin/bash

# ------------------------------
# Variables
# ------------------------------
FILE_PATH="/var/log/auth.log"        # Path to the SSH authentication log
DIR="/home/kavin/server_logs"        # Directory to store reports and logs
DATE=$(date +%F)                     # Current date in YYYY-MM-DD format
REPORT="$DIR/security_report_$DATE.txt"   # Daily report file path
BLOCKED_LOG="$DIR/blocked_ips.log"        # File to store blocked IPs
INTEGRITY_LOG="$DIR/log_integrity.log"    # File to store checksum and warnings

# Ensure the directory exists
/bin/mkdir -p "$DIR"                  # Create the directory if it doesn't exist

# ------------------------------
# Task 3: Update blocked_ips.log
# ------------------------------
/bin/grep -i "Failed password" "$FILE_PATH" 2>/dev/null | \    # Find all failed password attempts
/usr/bin/awk '{print $(NF-4)}' | \                             # Extract IP address (4th field from end)
/usr/bin/sort | /usr/bin/uniq -c | /usr/bin/sort -nr | /usr/bin/head -5 | \   # Count, sort, get top 5 IPs
while read count ip; do
    if [ "$count" -gt 15 ]; then                                # Check if failed attempts exceed threshold
        if ! /bin/grep -qi "^BLOCKED: $ip " "$BLOCKED_LOG" 2>/dev/null; then  # Skip if already blocked
            /bin/echo "BLOCKED: $ip on $DATE (exceeded 15 SSH failures)" >> "$BLOCKED_LOG"  # Add to blocked log
        fi
    fi
done

# ------------------------------
# Task 4: Log Integrity Check
# ------------------------------
current_checksum=$(/usr/bin/sha256sum "$FILE_PATH" | /usr/bin/awk '{print $1}')  # Calculate current SHA256 checksum

if [ -f "$INTEGRITY_LOG" ]; then
    last_checksum=$(/usr/bin/tail -1 "$INTEGRITY_LOG" | /usr/bin/awk '{print $2}')   # Get last stored checksum
else
    last_checksum=""
fi

if [ -n "$last_checksum" ] && [ "$current_checksum" != "$last_checksum" ]; then   # If checksum changed
    /bin/echo "WARNING: auth.log checksum changed on $DATE" >> "$INTEGRITY_LOG"   # Log a warning
fi

# Store today's checksum for future comparisons
/bin/echo "$DATE $current_checksum" >> "$INTEGRITY_LOG"

# ------------------------------
# Task 5: Generate Daily Security Report
# ------------------------------
{
    /bin/echo "===== Daily Security Report ($DATE) ====="   # Header
    /bin/echo

    # --- Successful SSH logins ---
    /bin/echo "🔐 Successful SSH Logins:"                  # Section title
    /bin/grep -i "Accepted password" "$FILE_PATH" 2>/dev/null | \   # Only password logins
    /usr/bin/awk '{user=$9; ip=$11; timestamp=$1" "$2" "$3; print timestamp, "user="user, "ip="ip}'   # Extract info
    /bin/echo

    # --- Top Failed SSH IPs ---
    /bin/echo "⚠️ Top Failed SSH IPs:"                     # Section title
    /bin/grep -i "Failed password" "$FILE_PATH" 2>/dev/null | \
    /usr/bin/awk '{print $(NF-4)}' | /usr/bin/sort | /usr/bin/uniq -c | /usr/bin/sort -nr | /usr/bin/head -5 | \
    while read count ip; do
        /bin/echo "$ip - $count attempts"                # Print top failed IPs
    done
    /bin/echo

    # --- Blocked IPs (today only) ---
    /bin/echo "🚫 Blocked IPs:"                          # Section title
    /bin/grep "BLOCKED:.*$DATE" "$BLOCKED_LOG" 2>/dev/null || /bin/echo "No IPs blocked today"  # Only today's blocked IPs
    /bin/echo

    # --- Log Integrity Warnings (today only) ---
    /bin/echo "🛡️ Log Integrity Warnings:"               # Section title
    /bin/grep "WARNING:.*$DATE" "$INTEGRITY_LOG" 2>/dev/null || /bin/echo "No integrity issues today"  # Today's warnings
    /bin/echo

} > "$REPORT"                                            # Save the entire report to a file

# Final message to console
/bin/echo "Daily Security Report generated: $REPORT"

# ------------------------------
# Cron Job Example
# ------------------------------
# To automate this script daily at 06:40 AM, add the following line to your crontab:
# 40 6 * * * /bin/bash /home/kavin/server_logs/day_12.sh >> /home/kavin/server_logs/cron.log 2>&1
# Explanation:
# - 40 6 * * * : run at 06:40 every day
# - /bin/bash /home/kavin/server_logs/day_12.sh : execute this script
# - >> /home/kavin/server_logs/cron.log 2>&1 : append all output and errors to cron.log
