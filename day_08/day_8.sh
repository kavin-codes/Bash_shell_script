#!/bin/bash

LOG_DIR="/home/kavin/server3_logs"
archive_dir="$LOG_DIR/archive"
ALERT_LOG="$LOG_DIR/disk_alert.log"

# Create archive directory if missing
mkdir -p "$archive_dir"

# -------- Task 1: Daily report archiving --------
yesterday=$(date -d "yesterday" +%Y-%m-%d)
report="daily_report_${yesterday}.txt"

if [ -f "$LOG_DIR/$report" ]; then
    if [ ! -f "$archive_dir/$report" ]; then
        mv "$LOG_DIR/$report" "$archive_dir/"
        echo "Daily report archived: $report"
    else
        echo "Daily report already exists in archive"
    fi
else
    echo "No daily report found for $yesterday"
fi

# -------- Task 2: Log rotation (10MB) --------
for filename in "$LOG_DIR"/*.log; do
    [ -e "$filename" ] || continue

    size=$(stat -c %s "$filename")

    if [ "$size" -gt 10485760 ]; then   # 10MB
        timestamp=$(date +%Y-%m-%d_%H-%M-%S)
        mv "$filename" "$filename.$timestamp"
        touch "$filename"
        echo "Rotated $(basename "$filename")"
    fi
done

# -------- Task 3: Retention Policy (14 days) --------
find "$archive_dir" -type f -mtime +14 -print -delete

# -------- Task 4: Compression of archived logs (older than 3 days) --------
find "$archive_dir" -type f -mtime +3 ! -name "*.gz" -exec /usr/bin/gzip {} \;

# -------- Task 5: Disk Usage Monitoring --------
today=$(date +%Y-%m-%d)

disk_usage=$(df "$LOG_DIR" | awk 'NR==2 {gsub("%",""); print $5}')

if [ "$disk_usage" -gt 80 ]; then
    echo "Warning: Disk usage exceeded 80% on $today" | tee -a "$ALERT_LOG"
else
    echo "Disk usage is normal: $disk_usage%"
fi




#use this script with cron schedulin


#!/bin/bash

# ====== Absolute paths for cron ======
DATE_BIN="/usr/bin/date"
MV_BIN="/usr/bin/mv"
STAT_BIN="/usr/bin/stat"
TOUCH_BIN="/usr/bin/touch"
FIND_BIN="/usr/bin/find"
GZIP_BIN="/usr/bin/gzip"
DF_BIN="/bin/df"
AWK_BIN="/usr/bin/awk"
TEE_BIN="/usr/bin/tee"
BASENAME_BIN="/usr/bin/basename"
MKDIR_BIN="/usr/bin/mkdir"
ECHO_BIN="/usr/bin/echo"

LOG_DIR="/home/kavin/server3_logs"
archive_dir="$LOG_DIR/archive"
ALERT_LOG="$LOG_DIR/disk_alert.log"

# Create archive directory if missing
$MKDIR_BIN -p "$archive_dir"

# -------- Task 1: Daily report archiving --------
yesterday=$($DATE_BIN -d "yesterday" +%Y-%m-%d)
report="daily_report_${yesterday}.txt"

if [ -f "$LOG_DIR/$report" ]; then
    if [ ! -f "$archive_dir/$report" ]; then
        $MV_BIN "$LOG_DIR/$report" "$archive_dir/"
        $ECHO_BIN "Daily report archived: $report"
    else
        $ECHO_BIN "Daily report already exists in archive"
    fi
else
    $ECHO_BIN "No daily report found for $yesterday"
fi

# -------- Task 2: Log rotation (10MB) --------
for filename in "$LOG_DIR"/*.log; do
    [ -e "$filename" ] || continue

    size=$($STAT_BIN -c %s "$filename")

    if [ "$size" -gt 10485760 ]; then   # 10MB
        timestamp=$($DATE_BIN +%Y-%m-%d_%H-%M-%S)
        $MV_BIN "$filename" "$filename.$timestamp"
        $TOUCH_BIN "$filename"
        $ECHO_BIN "Rotated $($BASENAME_BIN "$filename")"
    fi
done

# -------- Task 3: Retention Policy (14 days) --------
$FIND_BIN "$archive_dir" -type f -mtime +14 -print -delete

# -------- Task 4: Compression of archived logs (older than 3 days) --------
$FIND_BIN "$archive_dir" -type f -mtime +3 ! -name "*.gz" -exec $GZIP_BIN {} \;

# -------- Task 5: Disk Usage Monitoring --------
today=$($DATE_BIN +%Y-%m-%d)

disk_usage=$($DF_BIN "$LOG_DIR" | $AWK_BIN 'NR==2 {gsub("%",""); print $5}')

if [ "$disk_usage" -gt 80 ]; then
    $ECHO_BIN "Warning: Disk usage exceeded 80% on $today" | $TEE_BIN -a "$ALERT_LOG"
else
    $ECHO_BIN "Disk usage is normal: $disk_usage%"
fi


