
 Day 8 Task(07-02-2026)

🟢 Day 8 Task – Log Rotation, Archiving & Retention Policy
🎯 Objective
Improve the reliability and scalability of your log-monitoring system by:
•	Rotating large log files
•	Archiving old reports
•	Applying retention rules
•	Ensuring disk usage is controlled
•	Preparing logs for long-term analysis
This is a very real production task.
________________________________________


 Day 8 Task Requirements
________________________________________
🔹 Task 1: Daily Report Archiving
Requirements
•	Move yesterday’s daily report to archive
•	Rename files consistently
•	Ensure no overwrite occurs
📂 Example:
/home/kavin/server3_logs/daily_reports/
  └── daily_report_2026-02-07.txt

→ Move to

/home/kavin/server3_logs/archive/
  └── daily_report_2026-02-07.txt
________________________________________
🔹 Task 2: Log Rotation for Application Logs
Requirements
•	Rotate .log files if size > 10MB
•	Rename old logs with timestamp
•	Create a fresh empty log file
📌 Example:
server.log → server.log.2026-02-08
________________________________________
🔹 Task 3: Retention Policy
Requirements
•	Keep only last 14 days of:
o	Archived daily reports
o	Rotated logs
•	Automatically delete older files
📌 Command hint:
find <path> -type f -mtime +14 -delete
________________________________________
🔹 Task 4: Compression of Archived Logs
Requirements
•	Compress archived files older than 3 days
•	Use .gz format
•	Skip already compressed files
📌 Example:
daily_report_2026-02-01.txt.gz
________________________________________
🔹 Task 5: Disk Usage Monitoring
Requirements
•	Check disk usage of /home/kavin/server_logs
•	Trigger warning if usage > 80%
•	Log warning to disk_alert.log
📌 Example:
Warning: Disk usage exceeded 80% on 2026-02-08
________________________________________
🔹 Task 6: Automation with Cron
Schedule
•	Run after Day 7 script
•	Daily at 6:15 AM
15 6 * * * /home/kavin/server3_logs/day_8.sh \
>> /home/kavin/server3_logs/cron.log 2>&1



#!/bin/bash
# Uses bash shell to execute this script (required for cron & execution)

# ===== Absolute command paths (cron-safe) =====
DATE_BIN="/usr/bin/date"        # date command to get current/yesterday date
MV_BIN="/usr/bin/mv"            # move/rename files
STAT_BIN="/usr/bin/stat"        # get file size
TOUCH_BIN="/usr/bin/touch"      # create empty files
FIND_BIN="/usr/bin/find"        # search files based on condition
GZIP_BIN="/usr/bin/gzip"        # compress files
DF_BIN="/bin/df"                # check disk usage
AWK_BIN="/usr/bin/awk"          # text processing
TEE_BIN="/usr/bin/tee"          # output to screen + file
BASENAME_BIN="/usr/bin/basename"# extract filename only
MKDIR_BIN="/usr/bin/mkdir"      # create directory
ECHO_BIN="/usr/bin/echo"        # print messages

# ===== Directory variables =====
LOG_DIR="/home/kavin/server3_logs"          # Main logs directory
archive_dir="$LOG_DIR/archive"              # Archive directory
ALERT_LOG="$LOG_DIR/disk_alert.log"          # Disk alert log file

# Create archive directory if it does not exist
$MKDIR_BIN -p "$archive_dir"

# =================================================
# Task 1: Daily Report Archiving
# =================================================

# Get yesterday's date in YYYY-MM-DD format
yesterday=$($DATE_BIN -d "yesterday" +%Y-%m-%d)

# Build yesterday's report filename
report="daily_report_${yesterday}.txt"

# Check if yesterday's report exists
if [ -f "$LOG_DIR/$report" ]; then

    # Check if the report is NOT already in archive
    if [ ! -f "$archive_dir/$report" ]; then

        # Move the report to archive directory
        $MV_BIN "$LOG_DIR/$report" "$archive_dir/"

        # Print confirmation message
        $ECHO_BIN "Daily report archived: $report"
    else
        # File already exists in archive
        $ECHO_BIN "Daily report already exists in archive"
    fi
else
    # Yesterday's report not found
    $ECHO_BIN "No daily report found for $yesterday"
fi

# =================================================
# Task 2: Log Rotation (Rotate if > 10MB)
# =================================================

# Loop through all .log files in LOG_DIR
for filename in "$LOG_DIR"/*.log; do

    # Skip loop if no .log files exist
    [ -e "$filename" ] || continue

    # Get file size in bytes
    size=$($STAT_BIN -c %s "$filename")

    # Check if file size is greater than 10MB
    if [ "$size" -gt 10485760 ]; then

        # Generate timestamp for rotated log
        timestamp=$($DATE_BIN +%Y-%m-%d_%H-%M-%S)

        # Rename the current log file with timestamp
        $MV_BIN "$filename" "$filename.$timestamp"

        # Create a fresh empty log file
        $TOUCH_BIN "$filename"

        # Print rotation message
        $ECHO_BIN "Rotated $($BASENAME_BIN "$filename")"
    fi
done

# =================================================
# Task 3: Retention Policy (Keep only last 14 days)
# =================================================

# Find and delete archived files older than 14 days
$FIND_BIN "$archive_dir" -type f -mtime +14 -print -delete

# =================================================
# Task 4: Compression of Archived Logs (>3 days)
# =================================================

# Compress archived files older than 3 days
# Skip files that are already compressed (.gz)
$FIND_BIN "$archive_dir" -type f -mtime +3 ! -name "*.gz" -exec $GZIP_BIN {} \;

# =================================================
# Task 5: Disk Usage Monitoring
# =================================================

# Get today's date
today=$($DATE_BIN +%Y-%m-%d)

# Get disk usage percentage of LOG_DIR
disk_usage=$($DF_BIN "$LOG_DIR" | $AWK_BIN 'NR==2 {gsub("%",""); print $5}')

# Check if disk usage exceeds 80%
if [ "$disk_usage" -gt 80 ]; then

    # Log warning to disk_alert.log and display it
    $ECHO_BIN "Warning: Disk usage exceeded 80% on $today" | $TEE_BIN -a "$ALERT_LOG"
else
    # Disk usage is under control
    $ECHO_BIN "Disk usage is normal: $disk_usage%"
fi



cron setup :


Open crontab:

crontab -e

Add cron entry:

0 1 * * * /home/kavin/server3_logs/day_8.sh >> /home/kavin/server3_logs/cron.log 2>&1

