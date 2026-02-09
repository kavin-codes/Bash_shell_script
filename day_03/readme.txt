Task Title (02-02-2026)
Day 3 – Automated Log Analysis with Alerts & Cleanup
Tasks to Perform (in order)

1️⃣ Setup
•	Folder: server_logs

•	Files inside: app.log, db.log, error.log

•	Add sample INFO/WARNING/ERROR messages (like Day-2)

2️⃣ Bash Script Creation

•	File: day_3_log_monitor.sh

3️⃣ Inside the Script

1.	Print current date & time

2.	Count ERROR lines from .log files

3.	If ERRORs > 5, print alert message

4.	Save ERROR lines into error_report.log

5.	Create an archive folder (if not exists)

6.	Move logs older than 1 day into archive/

7.	Log script execution in activity.log
________________________________________

4️⃣ Permissions
•	Make executable:

chmod +x day_3_log_monitor.sh

•	Run it:

./day_3_log_monitor.sh
________________________________________

first run the setup file

1. Create a file:
nano day_3_log_monitor.sh

2.Paste all commands inside

3.Save and exit ( esc, :wq)

4.Make executable:
chmod +x day_3_log_monitor.sh

5.Run script:
./day_3_log_monitor.sh





explaination code :

#!/bin/bash
# Shebang: tells Linux to run this script using Bash

log_activity="activity.log"  # Variable storing the activity log filename

# Log the start of the script into activity.log with timestamp
echo "$(date '+%F %T') - script started" >> "$log_activity"

# Print the current date and time to the terminal
echo "date and time : $(date)"

# Count number of lines containing "error" (case-insensitive) in all .log files
count_error=$(grep -i error *.log | wc -l)

# Print the error count to terminal
echo "error count is : $count_error"

# Check if error count is greater than 5
if [ "$count_error" -gt 5 ]; then
  # If true, print alert message
  echo "ERROR count exceeded 5 "
  # Optional: You could also log this alert into activity.log
  echo "$(date '+%F %T') - ERROR count exceeded 5" >> "$log_activity"
fi

# Extract all lines containing "error" from app.log, db.log, error.log
# and append them to error_report.log (creates the file if it doesn't exist)
grep -i "error" app.log db.log error.log >> error_report.log

# Check if the archive folder exists
if [ ! -d "archive" ]; then
    # If it doesn't exist, create the archive folder
    mkdir archive
fi

# Move all .log files older than 1 day to the archive folder
# Exclude error_report.log and activity.log from moving
find . -maxdepth 1 -type f -name "*.log" \
    \! -name "error_report.log" \
    \! -name "activity.log" \
    -mtime +1 -exec mv {} archive/ \;

# Log the end of the script into activity.log with timestamp
echo "$(date '+%F %T') - script ended" >> "$log_activity"
