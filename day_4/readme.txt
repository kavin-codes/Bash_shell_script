Task Title ((03-02-2026))
Day 4 – Log Monitoring + Email Alert + Scheduled Automation
________________________________________
Task Description
You will modify your Day 3 Bash script to:
1.	Monitor log files for ERRORs
2.	Send an email alert if errors exceed a threshold
3.	Archive logs older than a certain date
4.	Maintain a script activity log
5.	Schedule the script to run automatically using cron
________________________________________
Tasks to Perform (in order)
1️⃣ Setup
•	Folder: server_logs (from Day 3)
•	Files inside: app.log, db.log, error.log
•	Add sample INFO, WARNING, ERROR messages
•	Ensure mailx or mailutils is installed for sending email
           sudo apt install mailutils  # For Ubuntu/Debian
________________________________________
2️⃣ Bash Script Creation
•	File: day_4_log_monitor.sh
•	Base it on Day 3 script, add email alert logic
________________________________________
3️⃣ Inside the Script
1.	Print current date & time
2.	Count ERROR lines from .log files
3.	If ERRORs > threshold, send email alert
4.	Save ERROR lines into error_report.log
5.	Create an archive folder if it doesn’t exist
6.	Move logs older than 1 day into archive/
7.	Log script execution in activity.log

 ________________________________________
4️⃣ Permissions & Test
chmod +x day_4_log_monitor.sh
./day_4_log_monitor.sh

________________________________________
5️⃣ Schedule Script Using Cron
1.	Open cron editor:
crontab -e
2.	Add a line to run script every hour:
* * * * * /full/path/to/server_logs/day_4_log_monitor.sh >> /full/path/to/server_logs/cron.log 2>&1
•	Save and exit
•	Script will now run automatically hourly


---------------------------------------------------------------------

#!/bin/bash
# Use bash shell to run this script

# Define the base directory where all logs are stored
LOG_DIR="/home/kavin/server_logs"

# File to store success and activity messages
activity="$LOG_DIR/activity.log"

# File to store collected error messages
error_report="$LOG_DIR/error_report1.log"

# Log script start time
echo "$(date '+%F %T') - script started" >> "$activity"

# Count number of lines containing the word "error" in all .log files
# 2>/dev/null hides errors if some log files do not exist
error_count=$(grep -i error $LOG_DIR/*.log 2>/dev/null | wc -l)

# Log the error count
echo "error count is : $error_count" >> "$activity"

# If error count is greater than 5, send alert email
if [ "$error_count" -gt 5 ]; then 
  # Send email using full path (cron-safe)
  /usr/bin/mail -s "log alert" pikachukavin@gmail.com <<< "Alert: threshold reached"

  # Check if mail command succeeded
  if [ $? -eq 0 ]; then
    echo "$(date '+%F %T') - email sent" >> "$activity"
  else
    echo "$(date '+%F %T') - email failed" >> "$activity"
  fi
fi

# Extract all error lines from specific log files and append to error report
# Errors are hidden if files don’t exist
grep -i "error" \
  $LOG_DIR/app.log \
  $LOG_DIR/db.log \
  $LOG_DIR/error.log >> "$error_report" 2>/dev/null

# Create archive directory if it does not exist
if [ ! -d "$LOG_DIR/archive" ]; then
  mkdir "$LOG_DIR/archive"
fi 

# Move today’s .log files to archive directory
# Exclude important log files from being moved
find "$LOG_DIR" -maxdepth 1 -type f -name "*.log" \
  ! -name "error_report1.log" \
  ! -name "activity.log" \
  ! -name "cron.log" \
  -mtime 0 -exec mv {} "$LOG_DIR/archive/" \;

# Log script end time
echo "$(date '+%F %T') - script ended" >> "$activity"

------------------------------------------------------------------------------------------------------------


👉 Cron does NOT run scripts from your script’s folder
👉 Cron usually runs from /home/kavin or /