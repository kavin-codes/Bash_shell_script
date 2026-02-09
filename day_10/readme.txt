 Day 10 Task(09-02-2026)

🟢 Day 10 Task– Linux Automation & Monitoring Tasks


________________________________________
🔹 Task 1: Process Monitoring

Requirements
•	Check if a specific process is running (example: nginx or apache2)
•	If NOT running:
o	Log a warning to process_alert.log
o	Attempt to restart the service
📌 Example log:
WARNING: nginx process not running – restarted on 2026-02-09
________________________________________
🔹 Task 2: CPU Usage Monitoring

Requirements
•	Check current CPU usage
•	Trigger alert if usage > 75%
•	Log warning with timestamp
📌 Example:
WARNING: CPU usage exceeded 75% at 2026-02-09 14:10:22
________________________________________
🔹 Task 3: Memory Usage Monitoring

Requirements
•	Check memory usage percentage
•	Trigger alert if usage > 80%
•	Log warning to memory_alert.log
📌 Example:
WARNING: Memory usage exceeded 80% on 2026-02-09
________________________________________
🔹 Task 4: Zombie Process Detection

Requirements
•	Detect zombie processes
•	Log PID and command name
•	Count number of zombie processes
📌 Example:
Zombie detected: PID=2345 CMD=defunct
Total zombies: 2
________________________________________
🔹 Task 5: Automation Challenge (Mini Project)

Requirements
•	Combine Tasks 1–4 into ONE script
•	Use:
o	Functions
o	Absolute paths (cron-safe)
o	Central log file: system_health.log
•	Script must be cron ready
________________________________________



================================================================================================


#!/bin/bash
# ↑ Shebang: tells the system to run this script using the Bash shell

############################################
# SYSTEM HEALTH MONITORING SCRIPT
# This script monitors:
# 1. A service/process (nginx)
# 2. CPU usage
# 3. Memory usage
# 4. Zombie processes
# All warnings are logged to a file
############################################


############################################
# CONFIGURATION SECTION
############################################

PROCESS_NAME="nginx"
# Name of the process/service to monitor

LOG_FILE="/var/log/system_health.log"
# Log file where all alerts will be stored

DATE="$(/usr/bin/date '+%Y-%m-%d %H:%M:%S')"
# Current date and time (used in log messages)


############################################
# FUNCTION: log_message
# Purpose: Write messages into the log file
############################################
log_message() {
    # $1 is the first argument passed to this function
    # >> appends the message to the log file
    echo "$1" >> "$LOG_FILE"
}


############################################
# TASK 1: Process Monitoring
# Checks if nginx is running
# If not running → restart it
############################################
check_process() {

    # pgrep checks if the process exists
    # ! means "if NOT running"
    # Output is suppressed using /dev/null
    if ! /usr/bin/pgrep "$PROCESS_NAME" > /dev/null 2>&1; then

        # Try to restart the service
        /bin/systemctl restart "$PROCESS_NAME" 2>/dev/null

        # $? stores the exit status of the last command
        # 0 = success, non-zero = failure
        if [ $? -eq 0 ]; then
            log_message "WARNING: $PROCESS_NAME process not running – restarted on $DATE"
        else
            log_message "CRITICAL: Failed to restart $PROCESS_NAME on $DATE"
        fi
    fi
}


############################################
# TASK 2: CPU Usage Monitoring
# Logs a warning if CPU usage > 75%
############################################
check_cpu() {

    # top -bn1 → one snapshot of CPU usage
    # $8 is idle CPU percentage
    # 100 - idle = actual CPU usage
    CPU_USAGE=$(/usr/bin/top -bn1 | /usr/bin/awk '/Cpu\(s\)/ {print int(100 - $8)}')

    # Compare CPU usage with threshold
    if [ "$CPU_USAGE" -gt 75 ]; then
        log_message "WARNING: CPU usage exceeded 75% at $DATE (Usage=${CPU_USAGE}%)"
    fi
}


############################################
# TASK 3: Memory Usage Monitoring
# Logs a warning if memory usage > 80%
############################################
check_memory() {

    # free shows memory stats
    # $3 = used memory
    # $2 = total memory
    # (used / total) * 100 = memory usage percentage
    MEM_USAGE=$(/usr/bin/free | /usr/bin/awk '/Mem:/ {print int(($3/$2)*100)}')

    # Check if memory usage crosses threshold
    if [ "$MEM_USAGE" -gt 80 ]; then
        log_message "WARNING: Memory usage exceeded 80% on $DATE (Usage=${MEM_USAGE}%)"
    fi
}


############################################
# TASK 4: Zombie Process Detection
# Finds and logs zombie processes
############################################
check_zombies() {

    # ps -eo pid,stat,comm → list all processes
    # stat column contains process state
    # Z indicates a zombie process
    ZOMBIES=$(/bin/ps -eo pid,stat,comm | /usr/bin/awk '$2 ~ /Z/ {print}')

    # -n checks if variable is not empty
    if [ -n "$ZOMBIES" ]; then

        # Count number of zombie processes
        COUNT=$(echo "$ZOMBIES" | /usr/bin/wc -l)

        # Loop through each zombie process
        echo "$ZOMBIES" | while read -r line; do

            # Extract PID (1st column)
            PID=$(echo "$line" | /usr/bin/awk '{print $1}')

            # Extract command name (3rd column)
            CMD=$(echo "$line" | /usr/bin/awk '{print $3}')

            # Log details of each zombie process
            log_message "Zombie detected: PID=$PID CMD=$CMD"
        done

        # Log total zombie count
        log_message "Total zombies detected: $COUNT on $DATE"
    fi
}


############################################
# MAIN SECTION
# Executes all monitoring tasks
############################################
check_process     # Monitor and restart service if needed
check_cpu         # Check CPU usage
check_memory      # Check memory usage
check_zombies     # Detect zombie processes
