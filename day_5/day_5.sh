# follow day 4 setup script 

#!/bin/bash

log_directory="/home/kavin/server1_logs"
backup_dir="$log_directory/backup"
today=$(date +%Y-%m-%d)
yesterday=$(date -d "yesterday" +%Y-%m-%d)
report="$log_directory/daily_report_$today.txt"

mkdir -p "$backup_dir"

disk_usage=$(/bin/df / | /usr/bin/awk 'NR==2 {gsub("%",""); print $5 }')

echo "===================================" >> "$report"
echo " DAILY LOG REPORT - $today" >> "$report"
echo "===================================" >> "$report"
echo "" >> "$report"
echo "Script started at: $(date '+%H:%M:%S')" >> "$report"
echo "" >> "$report"

echo "Renaming yesterday's logs..." >> "$report"
if [ -f "$log_directory/app.log" ]; then
    mv "$log_directory/app.log" "$log_directory/app_$yesterday.log"
    echo "app.log renamed to app_$yesterday.log" >> "$report"
else
    echo "app.log not found" >> "$report"
fi

if [ -f "$log_directory/db.log" ]; then
    mv "$log_directory/db.log" "$log_directory/db_$yesterday.log"
    echo "db.log renamed to db_$yesterday.log" >> "$report"
else
    echo "db.log not found" >> "$report"
fi

touch "$log_directory/app.log"
touch "$log_directory/db.log"
echo "Fresh log files created for today." >> "$report"
echo "" >> "$report"

echo "Compressing old logs..." >> "$report"
/usr/bin/find "$log_directory" -type f -name "*.log" -mtime +1 -exec /usr/bin/gzip {} \;
echo "Old logs compressed." >> "$report"
echo "" >> "$report"

echo "Creating backup..." >> "$report"
/usr/bin/tar -czf "$backup_dir/backup_$today.tar.gz" "$log_directory"/*.log.gz "$log_directory"/*[0-9]*.log >> "$report" 2>&1
if [ $? -eq 0 ]; then
    echo "Backup completed successfully: backup_$today.tar.gz" >> "$report"
else
    echo "Backup failed!" >> "$report"
fi
echo "" >> "$report"

echo "Checking disk usage..." >> "$report"
if [ "$disk_usage" -gt 80 ]; then
    echo "WARNING: Disk usage is high: $disk_usage%" >> "$report"
    echo "Disk usage is $disk_usage%" | /usr/bin/mail -s "Disk Usage Alert - $today" pikachukavin@gmail.com
else
    echo "Disk usage is normal: $disk_usage%" >> "$report"
fi
echo "" >> "$report"

echo "Counting errors in logs..." >> "$report"
/usr/bin/grep -i "error" "$log_directory"/*[0-9]*.log | /usr/bin/wc -l >> "$report"
echo "Error count added to report." >> "$report"
echo "" >> "$report"

echo "Disk usage summary:" >> "$report"
echo "Root partition usage: $disk_usage%" >> "$report"
echo "" >> "$report"

echo "Script finished at: $(date '+%H:%M:%S')" >> "$report"
echo "===================================" >> "$report"
echo " DAILY REPORT COMPLETE" >> "$report"
echo "===================================" >> "$report"
