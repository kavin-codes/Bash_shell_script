#!/bin/bash


# -- VARIABLES --
LOG_DIR="/home/kavin/server3_logs"

# Absolute paths for all binaries
MAIL_BIN="/usr/bin/mail"
GREP_BIN="/usr/bin/grep"
WC_BIN="/usr/bin/wc"
DATE_BIN="/usr/bin/date"
BASENAME_BIN="/usr/bin/basename"
MKDIR_BIN="/usr/bin/mkdir"
MV_BIN="/usr/bin/mv"

# ------- TODAY & REPORT FILE -
today=$("$DATE_BIN" +%F)
reports_dir="$LOG_DIR/daily_report_$today.txt"

#  REPORT HEADER 
echo "Report generated on $("$DATE_BIN" '+%H:%M:%S')" >> "$reports_dir"

# ------ TOTAL COUNTS ----------------
count_error1=$("$GREP_BIN" -i error "$LOG_DIR"/*[0-9]*.log 2>/dev/null | "$WC_BIN" -l)
count_warning1=$("$GREP_BIN" -i warning "$LOG_DIR"/*[0-9]*.log 2>/dev/null | "$WC_BIN" -l)
count_critical1=$("$GREP_BIN" -i critical "$LOG_DIR"/*[0-9]*.log 2>/dev/null | "$WC_BIN" -l)

echo "total occurrences of each event type:" >> "$reports_dir"
echo "=============================" >> "$reports_dir"
echo "error count    : $count_error1" >> "$reports_dir"
echo "warning count  : $count_warning1" >> "$reports_dir"
echo "critical count : $count_critical1" >> "$reports_dir"
echo "==============================" >> "$reports_dir"

# ----- PER-FILE COUNTS ------
for need in "$LOG_DIR"/*[0-9]*.log; do
    [ -e "$need" ] || continue

    count_error=$("$GREP_BIN" -i error "$need" | "$WC_BIN" -l)
    count_warning=$("$GREP_BIN" -i warning "$need" | "$WC_BIN" -l)
    count_critical=$("$GREP_BIN" -i critical "$need" | "$WC_BIN" -l)

    echo "file name : $("$BASENAME_BIN" "$need")" >> "$reports_dir"
    echo "error count    : $count_error" >> "$reports_dir"
    echo "warning count  : $count_warning" >> "$reports_dir"
    echo "critical count : $count_critical" >> "$reports_dir"
done

# ------ EMAIL ALERTS -------
if [ "$count_critical1" -gt 1 ]; then
    echo "$count_critical1 CRITICAL events found" | \
    "$MAIL_BIN" -s "Critical Log Alert - $today" pikachukavin@gmail.com
fi

if [ "$count_error1" -gt 10 ]; then
    echo "$count_error1 ERROR events found" | \
    "$MAIL_BIN" -s "Threshold limit exceeded - $today" pikachukavin@gmail.com
fi

# ------- ARCHIVE REPORTS --
ARCHIVE_DIR="$LOG_DIR/analysis_log"

if [ ! -d "$ARCHIVE_DIR" ]; then
    "$MKDIR_BIN" -p "$ARCHIVE_DIR"
fi

"$MV_BIN" "$LOG_DIR"/daily_report_* "$ARCHIVE_DIR/" 2>/dev/null
