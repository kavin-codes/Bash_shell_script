Task Day 5 (04-02-2026)


🟢 Day 5 Task – Log Rotation, Backup & Monitoring Report

🎯 Objective
Enhance your log-monitoring script by adding:
•	Log rotation
•	Backup with date
•	Disk usage monitoring
•	Daily summary report
This is a very practical DevOps/Linux admin task.
________________________________________
🛠️ Day 5 Task Requirements

Task 1: Log Rotation (Daily)
•	Rotate log files daily
•	Rename logs with today’s date
📌 Example:
app.log        → app_2026-02-03.log
db.log         → db_2026-02-03.log

________________________________________
Task 2: Compress Old Logs

•	Compress archived logs using gzip
•	Only compress logs older than 1 day
📌 Example:
app_2026-02-01.log.gz
________________________________________
Task 3: Backup Logs

•	Create a backup directory:
/home/kavin/server_logs/backup
•	Create a tar.gz backup of archived logs
•	Backup name must contain date
📌 Example:
logs_backup_2026-02-03.tar.gz
_______________________________
_________
Task 4: Disk Usage Monitoring

•	Check disk usage using df
•	If disk usage > 80%, send an email alert
📌 Email subject:
Disk Usage Alert
________________________________________
Task 5: Daily Summary Report
Generate a report file:
daily_report_YYYY-MM-DD.txt
Include:
•	Total log files processed
•	Error count
•	Backup status
•	Disk usage percentage
•	Script execution status

________________________________________
Task 6: Cron Automation
Run the script once per day at midnight
* * * * * /home/kavin/server1_logs/day_5_log_automation.sh >> /home/kavin/server1_logs/cron.log 2>&1





#!/bin/bash

# =============================================
# DAILY LOG & BACKUP SCRIPT
# =============================================
# WARNING:
# 1. Before running this script, make sure the 'server1_logs' directory exists.
# 2. Run the setup (creating initial logs) at least one day before to avoid "file not found" errors.
# 3. Ensure mail utility is configured if you want disk alerts to work.
# 4. Always make this script executable: chmod +x day_5.sh
# 5. This script is cron-safe but always test manually first.

# -----------------------------
# Setup Variables
# -----------------------------
log_directory="/home/kavin/server1_logs"          # Path to your log files
backup_dir="$log_directory/backup"               # Path to store backups
today=$(date +%Y-%m-%d)                          # Today's date
yesterday=$(date -d "yesterday" +%Y-%m-%d)      # Yesterday's date
report="$log_directory/daily_report_$today.txt"  # Daily report file

# Create backup directory if it doesn't exist
mkdir -p "$backup_dir"

# Get disk usage percentage of root partition
# Using full paths to make script cron-safe
disk_usage=$(/bin/df / | /usr/bin/awk 'NR==2 {gsub("%",""); print $5 }')

# -----------------------------
# Start Report
# -----------------------------
echo "===================================" >> "$report"
echo " DAILY LOG REPORT - $today" >> "$report"
echo "===================================" >> "$report"
echo "" >> "$report"
echo "Script started at: $(date '+%H:%M:%S')" >> "$report"
echo "" >> "$report"

# -----------------------------
# Rename yesterday's logs
# -----------------------------
echo "Renaming yesterday's logs..." >> "$report"

# Check if app.log exists, then rename it
if [ -f "$log_directory/app.log" ]; then
    mv "$log_directory/app.log" "$log_directory/app_$yesterday.log"
    echo "app.log renamed to app_$yesterday.log" >> "$report"
else
    echo "app.log not found" >> "$report"
fi

# Check if db.log exists, then rename it
if [ -f "$log_directory/db.log" ]; then
    mv "$log_directory/db.log" "$log_directory/db_$yesterday.log"
    echo "db.log renamed to db_$yesterday.log" >> "$report"
else
    echo "db.log not found" >> "$report"
fi

# Create fresh log files for today
touch "$log_directory/app.log"
touch "$log_directory/db.log"
echo "Fresh log files created for today." >> "$report"
echo "" >> "$report"

# -----------------------------
# Compress old logs (>1 day)
# -----------------------------
echo "Compressing old logs..." >> "$report"

# Find all .log files older than 1 day and compress them using gzip
/usr/bin/find "$log_directory" -type f -name "*.log" -mtime +1 -exec /usr/bin/gzip {} \;

echo "Old logs compressed." >> "$report"
echo "" >> "$report"

# -----------------------------
# Backup all logs
# -----------------------------
echo "Creating backup..." >> "$report"

# Create a tar.gz archive of all .log.gz files and yesterday's logs
/usr/bin/tar -czf "$backup_dir/backup_$today.tar.gz" "$log_directory"/*.log.gz "$log_directory"/*[0-9]*.log >> "$report" 2>&1

# Check if backup succeeded
if [ $? -eq 0 ]; then
    echo "Backup completed successfully: backup_$today.tar.gz" >> "$report"
else
    echo "Backup failed!" >> "$report"
fi
echo "" >> "$report"

# -----------------------------
# Disk usage alert
# -----------------------------
echo "Checking disk usage..." >> "$report"

# Send email alert if disk usage > 80%
if [ "$disk_usage" -gt 80 ]; then
    echo "WARNING: Disk usage is high: $disk_usage%" >> "$report"
    echo "Disk usage is $disk_usage%" | /usr/bin/mail -s "Disk Usage Alert - $today" pikachukavin@gmail.com
else
    echo "Disk usage is normal: $disk_usage%" >> "$report"
fi
echo "" >> "$report"

# -----------------------------
# Error count
# -----------------------------
echo "Counting errors in logs..." >> "$report"

# Count lines containing "error" (case-insensitive) in yesterday's logs
/usr/bin/grep -i "error" "$log_directory"/*[0-9]*.log | /usr/bin/wc -l >> "$report"

echo "Error count added to report." >> "$report"
echo "" >> "$report"

# -----------------------------
# Disk usage in report
# -----------------------------
echo "Disk usage summary:" >> "$report"
echo "Root partition usage: $disk_usage%" >> "$report"
echo "" >> "$report"

# -----------------------------
# End Report
# -----------------------------
echo "Script finished at: $(date '+%H:%M:%S')" >> "$report"
echo "===================================" >> "$report"
echo " DAILY REPORT COMPLETE" >> "$report"
echo "===================================" >> "$report"

# -----------------------------
# WARNING BEFORE RUNNING SCRIPT
# -----------------------------
# 1. Run a setup at least one day before:
#    mkdir -p /home/kavin/server1_logs
#    touch /home/kavin/server1_logs/app.log
#    touch /home/kavin/server1_logs/db.log
# 2. Make sure the mail command works to receive alerts
# 3. Make the script executable: chmod +x day_5.sh
# 4. Test manually before scheduling with cron
