Day 6 Task(05-02-2026)

🟢 Day 6 Task – Log Analysis & Critical Event Alerts



________________________________________
🛠️ Day 6 Task Requirements
Task 1: Analyze Logs
• Scan all archived log files for:
•	ERROR
•	WARNING
•	CRITICAL
• Count occurrences per log file
📌 Example:
app_2026-02-03.log:
  ERROR: 5
  WARNING: 2
  CRITICAL: 0
db_2026-02-03.log:
  ERROR: 2
  WARNING: 0
  CRITICAL: 1
________________________________________
Task 2: Generate Daily Summary Report
• Save report as:
daily_log_analysis_YYYY-MM-DD.txt
• Include:
•	Total occurrences of each event type
•	Breakdown per log file
•	Script execution timestamp
________________________________________
Task 3: Automated Alerts
• If CRITICAL events exist → send an email alert
• If ERROR count exceeds a threshold → send email summary
📌 Email subject example:
Critical Log Alert - 2026-02-03
________________________________________
Task 4: Archive Reports
• Create folder: /home/kavin/server_logs/analysis_reports
• Store all daily reports with date-stamp for history tracking
📌 Example:
analysis_reports/daily_log_analysis_2026-02-03.txt
________________________________________
Task 5: Cron Automation
• Run the script daily after Day 5 log rotation (e.g., 1 AM)
0 1 * * * /home/kavin/server_logs/day_6.sh 2>> /home/kavin/server_logs/cron.log
________________________________________



#!/bin/bash

# -------------------------------------
# LOG ANALYSIS SCRIPT WITH EMAIL ALERTS
# -------------------------------------
# This script scans server log files, counts "error", "warning", and "critical"
# occurrences, generates a daily report, sends email alerts if thresholds are exceeded,
# and archives the reports.
# -------------------------------------

# -- VARIABLES --
LOG_DIR="/home/kavin/server3_logs"   # Directory containing log files

# Absolute paths for all binaries (to avoid PATH issues)
MAIL_BIN="/usr/bin/mail"
GREP_BIN="/usr/bin/grep"
WC_BIN="/usr/bin/wc"
DATE_BIN="/usr/bin/date"
BASENAME_BIN="/usr/bin/basename"
MKDIR_BIN="/usr/bin/mkdir"
MV_BIN="/usr/bin/mv"

# ------- TODAY & REPORT FILE -------
today=$("$DATE_BIN" +%F)                  # Get current date in YYYY-MM-DD format
reports_dir="$LOG_DIR/daily_report_$today.txt"  # Daily report file path

#  REPORT HEADER 
# Append current time to the report
echo "Report generated on $("$DATE_BIN" '+%H:%M:%S')" >> "$reports_dir"

# ------ TOTAL COUNTS ----------------
# Count all occurrences of each event type across all logs
# 2>/dev/null ignores errors if some files are missing
count_error1=$("$GREP_BIN" -i error "$LOG_DIR"/*[0-9]*.log 2>/dev/null | "$WC_BIN" -l)
count_warning1=$("$GREP_BIN" -i warning "$LOG_DIR"/*[0-9]*.log 2>/dev/null | "$WC_BIN" -l)
count_critical1=$("$GREP_BIN" -i critical "$LOG_DIR"/*[0-9]*.log 2>/dev/null | "$WC_BIN" -l)

# Write total counts to the report
echo "total occurrences of each event type:" >> "$reports_dir"
echo "=============================" >> "$reports_dir"
echo "error count    : $count_error1" >> "$reports_dir"
echo "warning count  : $count_warning1" >> "$reports_dir"
echo "critical count : $count_critical1" >> "$reports_dir"
echo "==============================" >> "$reports_dir"

# ----- PER-FILE COUNTS ------
# Loop through each log file individually
for need in "$LOG_DIR"/*[0-9]*.log; do
    [ -e "$need" ] || continue     # Skip if file does not exist

    # Count events per file
    count_error=$("$GREP_BIN" -i error "$need" | "$WC_BIN" -l)
    count_warning=$("$GREP_BIN" -i warning "$need" | "$WC_BIN" -l)
    count_critical=$("$GREP_BIN" -i critical "$need" | "$WC_BIN" -l)

    # Append counts to the report
    echo "file name : $("$BASENAME_BIN" "$need")" >> "$reports_dir"
    echo "error count    : $count_error" >> "$reports_dir"
    echo "warning count  : $count_warning" >> "$reports_dir"
    echo "critical count : $count_critical" >> "$reports_dir"
done

# ------ EMAIL ALERTS -------
# Send email if critical events exceed 1
if [ "$count_critical1" -gt 1 ]; then
    echo "$count_critical1 CRITICAL events found" | \
    "$MAIL_BIN" -s "Critical Log Alert - $today" pikachukavin@gmail.com
fi

# Send email if error events exceed 10
if [ "$count_error1" -gt 10 ]; then
    echo "$count_error1 ERROR events found" | \
    "$MAIL_BIN" -s "Threshold limit exceeded - $today" pikachukavin@gmail.com
fi

# ------- ARCHIVE REPORTS -------
ARCHIVE_DIR="$LOG_DIR/analysis_log"

# Create archive directory if it does not exist
if [ ! -d "$ARCHIVE_DIR" ]; then
    "$MKDIR_BIN" -p "$ARCHIVE_DIR"
fi

# Move all daily report files into archive directory
"$MV_BIN" "$LOG_DIR"/daily_report_* "$ARCHIVE_DIR/" 2>/dev/null


 Cron Automation

0 1 * * * /home/kavin/server3_logs/day_6.sh 2>> /home/kavin/server3_logs/cron.log
