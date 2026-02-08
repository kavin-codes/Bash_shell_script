
 Day 9 Task(08-02-2026)

🟢 Day 9 Task– Linux Process & Resource Monitoring (Medium Level)
🎯 Objective
Understand how Linux tracks processes, CPU usage, memory usage, and zombie states and apply this knowledge using simple bash logic (no full automation yet).
________________________________________
🔹 Task 1: Process Status Check
📌 Problem Statement
Write a bash script to check whether a given process is running on the system.
✅ Requirements
•	Accept a process name as input (argument or variable)
•	Check if the process is running
•	Display a single, clear status message
•	Do not restart the service
•	Do not log to a file
📤 Expected Output
nginx is running (PID: 1234)
OR
nginx is NOT running
________________________________________
🔹 Task 2: CPU Usage Threshold Check
📌 Problem Statement
Determine the current CPU usage and print a warning if it exceeds a defined threshold.
✅ Requirements
•	Calculate CPU usage percentage
•	Threshold: 75%
•	Display output only if threshold is exceeded
•	No logging
•	No cron
📤 Expected Output
WARNING: CPU usage exceeded 75% (78%)
________________________________________
🔹 Task 3: Memory Usage Calculation
📌 Problem Statement
Calculate the system memory usage percentage.
✅ Requirements
•	Use total and available memory values
•	Print memory usage percentage
•	No condition check
•	No logging
📤 Expected Output
Memory usage: 64%
________________________________________
🔹 Task 4: Zombie Process Detection
📌 Problem Statement
Identify zombie processes and report their count.
✅ Requirements
•	Detect processes in Z (zombie) state
•	Count total zombie processes
•	Print only the final count
📤 Expected Output
Zombie processes found: 2



-----------------------------------------------------------------------------------


#!/bin/bash
# This script performs basic system health checks:
# 1. Checks if a specific process is running
# 2. Checks CPU usage and warns if it is high
# 3. Calculates memory usage percentage
# 4. Counts zombie processes

# -------------------------------
# Task 1: Process Check
# -------------------------------

# Name of the process to look for
process_name="python"

# pgrep searches for a process by name and returns its PID if found
process=$(pgrep -x "$process_name")

# -n checks if the variable is not empty
if [ -n "$process" ]; then
    # If PID exists, the process is running
    echo "Process '$process_name' is running (PID: $process)"
else
    # If no PID is found, the process is not running
    echo "Process '$process_name' is not running"
fi


# -------------------------------
# Task 2: CPU Usage Check
# -------------------------------

# top -bn1 runs top in batch mode for one iteration
# awk extracts the idle CPU percentage and subtracts it from 100
cpu_usage=$(top -bn1 | awk '/Cpu\(s\)/ {print int(100 - $8)}')

# Check if CPU usage exceeds the threshold (75%)
if [ "$cpu_usage" -gt 75 ]; then
    echo "WARNING: CPU usage exceeded 75% ($cpu_usage%)"
fi


# -------------------------------
# Task 3: Memory Usage Calculation
# -------------------------------

# free shows memory statistics
# awk calculates memory usage using total and available memory
# Formula: (total - available) / total * 100
usage_memory=$(free | awk '/Mem:/ {print int((($2-$7)/$2)*100)}')

# Print memory usage percentage
echo "Memory usage: $usage_memory%"


# -------------------------------
# Task 4: Zombie Process Detection
# -------------------------------

# ps lists all process states
# grep filters zombie processes (state Z)
# -c counts how many zombie processes exist
zombies=$(ps -eo stat | grep -c '^Z')

# Print the total zombie process count
echo "Zombie processes found: $zombies"
