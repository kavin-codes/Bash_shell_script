mkdir server_logs
cd server_logs
touch app.log db.log error.log

echo "ERROR app issue" >> app.log
echo "WARNING  app started" >> app.log
echo "INFO  app inngood state" >> app.log

echo "ERROR app issue" >> db.log
echo "WARNING  app started" >> db.log
echo "INFO  app inngood state" >> db.log

echo "ERROR app issue" >> error.log
echo "WARNING  app started" >> error.log
echo "INFO  app inngood state" >> error.log+-
vi day_4_log_monitor.sh



below code are inside the day _4_log_monitor.sh

#!/bin/bash

LOG_DIR="/home/kavin/server_logs"
activity="$LOG_DIR/activity.log"
error_report="$LOG_DIR/error_report1.log"

echo "$(date '+%F %T') - script started" >> "$activity"

error_count=$(grep -i error $LOG_DIR/*.log 2>/dev/null | wc -l)
echo "error count is : $error_count" >> "$activity"

if [ "$error_count" -gt 5 ]; then 
  /usr/bin/mail -s "log alert" pikachukavin@gmail.com <<< "Alert: threshold reached"

  if [ $? -eq 0 ]; then
    echo "$(date '+%F %T') - email sent" >> "$activity"
  else
    echo "$(date '+%F %T') - email failed" >> "$activity"
  fi
fi

grep -i "error" $LOG_DIR/app.log $LOG_DIR/db.log $LOG_DIR/error.log >> "$error_report" 2>/dev/null

if [ ! -d "$LOG_DIR/archive" ]; then
  mkdir "$LOG_DIR/archive"
fi 

find "$LOG_DIR" -maxdepth 1 -type f -name "*.log" \
  ! -name "error_report1.log" \
  ! -name "activity.log" \
  ! -name "cron.log" \-mtime 0 -exec mv {} "$LOG_DIR/archive/" \;

echo "$(date '+%F %T') - script ended" >> "$activity"







