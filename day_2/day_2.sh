
# setup file 
mkdir server_logs
cd server_logs/
touch app.log
touch db.log
touch error.log

echo "Info app started" >> app.log
echo "Info app started" >> db.log
echo "Info app started" >> error.log
echo "Warning  app issue" >> app.log
echo "Warning  app issue" >> db.log
echo "Warning  app issue" >> error.log
echo "Error  app error" >> app.log
echo "Error  app error" >> db.log
echo "Error  app error" >> error.log


vi log_monitor.sh  ## after this command paste the below code 

## log_monitor.sh

#!/bin/bash

# -------------------------------
# Log Monitoring & Cleanup Script
# -------------------------------

# 1. Print current date & time
echo "Date and Time: $(date)"

# 2. Count total ERROR lines from all .log files
error_count=$(grep -i "error" *.log | wc -l)
echo "Total ERROR lines: $error_count"

# 3. Save ERROR lines into error_report.log
grep -i "error" app.log db.log error.log > error_report.log

# 4. Create archive folder
mkdir -p archive

# 5. Move all .log files into archive
mv *.log archive/

# 6. Success message
echo "Log analysis and backup completed"
