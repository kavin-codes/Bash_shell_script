# setup file

mkdir server_logs
cd server_logs
touch app.log db.log error.log
echo "ERROR app issue" >> app.log
echo "ERROR app issue" >> db.log
echo "ERROR app issue" >> error.log

echo "INFO app started" >> app.log
echo "INFO app started" >> db.log
echo "INFO app started" >> error.log

echo "WARNING check immediately" >> app.log
echo "WARNING check immediately" >> db.log
echo "WARNING check immediately" >> error.log


vi day_3_log_monitor.sh

# paste the below code inside the day_3_log_monitor.sh

#!/bin/bash

log_activity="activity.log"

echo "$(date '+%F %T') -script started " >> "$log_activity"


echo "date and time :$(date)"

count_error=$(grep -i error *.log | wc -l)

echo "error count is : $count_error"

if [ "$count_error" -gt 5 ];
 then
  echo "ERROR count exceeded 5 "

fi

grep -i "error" app.log db.log error.log >> error_report.log


if [ ! -d  "archive"  ];
 then

   mkdir archive

fi



find . -maxdepth 1 -type f  -name "*.log" \! -name "error_report.log" \! -name "activity.log" -mtime +1 -exec mv {} archive/ \;

echo "$(date '+%F %T') -script ended " >> "$log_activity"




