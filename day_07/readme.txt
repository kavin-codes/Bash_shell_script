Day 7 Task (06-02-2026)

🟢 Day 7 Task – Centralized Log Dashboard & Trend Alerts

🎯 Objective

Enhance your log-monitoring system by adding:
• Centralized log summary across multiple days
• Trend detection for errors and critical events
• Summary report with historical data
• Email alerts for rising trends or repeated critical events
This task simulates building a real-time log dashboard in Bash.
________________________________________
🛠️ Day 7 Task Requirements

Task 1: Aggregate Historical Logs
• Read archived daily reports from /home/kavin/server_logs/archive/
• Extract total counts of error, warning, critical for each day
📌 Example table in log_dashboard.txt:
Date       | Errors | Warnings | Critical
----------------------------------------
2026-02-01 |   5    |   2      | 0
2026-02-02 |  10    |   3      | 1
2026-02-03 |   7    |   1      | 2
________________________________________
Task 2: Trend Detection

• Compare today’s log counts with the previous 3 days
• Flag alerts if:
•	Errors increase by >50% compared to the 3-day average
•	Critical events occur 2+ days in a row
📌 Example:
Alert: Errors increased by 60% compared to 3-day average
Alert: Critical events detected 2 consecutive days
________________________________________
Task 3: Summary Report

• Generate log_dashboard.txt in /home/kavin/server_logs/
• Include:
•	Date-wise log counts
•	Trend alerts (if any)
•	Total logs processed today
•	Script execution status
________________________________________
Task 4: Email Alerts

• Send an email if trends exceed thresholds
📌 Email example:
Subject: Log Trend Alert – 2026-02-05
Body: 
Errors increased by 60% compared to last 3 days
Critical events detected 2 consecutive days
________________________________________
Task 5: Automation with Cron

• Schedule the script to run daily at 6 AM:
0 6 * * * /home/kavin/server3_logs/day_7.sh 2>> /home/kavin/server3_logs/cron.log
________________________________________

#!/bin/bash                                  # Use Bash shell to run this script

LOG_DIR="/home/kavin/server_logs"             # Directory containing all .log files
DASHBOARD="/home/kavin/server_logs/log_dashboard.txt"   # Summary dashboard output file
TREND_FILE="/home/kavin/server_logs/daily_logs.txt"     # Stores daily counts for trend analysis

DATE_CMD="/bin/date"                          # Absolute path for date command
GREP_CMD="/bin/grep"                          # Absolute path for grep command
WC_CMD="/usr/bin/wc"                          # Absolute path for wc command
TAIL_CMD="/usr/bin/tail"                      # Absolute path for tail command
AWK_CMD="/usr/bin/awk"                        # Absolute path for awk command
MAIL_CMD="/usr/bin/mail"                      # Absolute path for mail command

TODAY=$($DATE_CMD +%F)                        # Get today's date (YYYY-MM-DD)
TIME_NOW=$($DATE_CMD '+%H:%M:%S')             # Get current time (HH:MM:SS)
STATUS="SUCCESS"                              # Track script execution status

EMAIL_TO="admin@example.com"                  # Email recipient for alerts
EMAIL_SUBJECT="Log Trend Alert – $TODAY"      # Email subject with today's date

total_error=0                                 # Initialize total error counter
total_warning=0                               # Initialize total warning counter
total_critical=0                              # Initialize total critical counter
files_processed=0                             # Count how many log files are processed
alerts=""                                     # Store alert messages if thresholds exceed

for logfile in "$LOG_DIR"/*.log; do            # Loop through each .log file in log directory
    [[ -f "$logfile" ]] || continue            # Skip if no log files exist

    error=$($GREP_CMD -i error "$logfile" | $WC_CMD -l)       # Count 'error' lines
    warning=$($GREP_CMD -i warning "$logfile" | $WC_CMD -l)   # Count 'warning' lines
    critical=$($GREP_CMD -i critical "$logfile" | $WC_CMD -l) # Count 'critical' lines

    total_error=$((total_error + error))       # Add file errors to total
    total_warning=$((total_warning + warning)) # Add file warnings to total
    total_critical=$((total_critical + critical)) # Add file criticals to total
    files_processed=$((files_processed + 1))   # Increment processed file count
done

echo "$TODAY $total_error $total_critical" >> "$TREND_FILE"  # Append daily data for trends

mapfile -t last_days < <($TAIL_CMD -n 4 "$TREND_FILE")       # Read last 4 days into array

if [[ ${#last_days[@]} -eq 4 ]]; then        # Proceed only if 4 days of data exist

    today_errors=$($AWK_CMD '{print $2}' <<< "${last_days[3]}") # Extract today's error count

    sum=0                                    # Initialize sum for 3-day average
    for i in 0 1 2; do
        sum=$((sum + $($AWK_CMD '{print $2}' <<< "${last_days[$i]}"))) # Sum last 3 days errors
    done

    avg_3day=$((sum / 3))                    # Calculate 3-day average error count

    if [[ $avg_3day -gt 0 ]]; then            # Avoid division by zero
        increase=$(( (today_errors - avg_3day) * 100 / avg_3day )) # Calculate % increase
        if [[ $increase -gt 50 ]]; then
            alerts+="Errors increased by ${increase}% compared to last 3 days\n" # Alert text
        fi
    fi

    critical_days=0                           # Track consecutive critical days
    for i in 2 3; do                          # Check yesterday and today
        crit=$($AWK_CMD '{print $3}' <<< "${last_days[$i]}") # Extract critical count
        [[ $crit -gt 0 ]] && ((critical_days++)) # Count if critical exists
    done

    if [[ $critical_days -eq 2 ]]; then
        alerts+="Critical events detected 2 consecutive days\n" # Add alert message
    fi
fi

{
echo "Log Dashboard Summary"                  # Dashboard title
echo "=============================="
echo "Date: $TODAY"                           # Display current date
echo "Time: $TIME_NOW"                       # Display current time
echo
echo "Date-wise Log Counts (Today)"
echo "------------------------------"
echo "Errors   : $total_error"                # Total errors today
echo "Warnings : $total_warning"              # Total warnings today
echo "Critical : $total_critical"             # Total critical today
echo
echo "Total log files processed today: $files_processed" # Files processed count
echo
echo "Trend Alerts"
echo "------------------------------"
if [[ -n "$alerts" ]]; then
    echo -e "$alerts"                         # Print alerts if present
else
    echo "No trend alerts detected"            # Otherwise show no alerts
fi
echo
echo "Script Execution Status: $STATUS"       # Show script status
} > "$DASHBOARD"                              # Write everything to dashboard file

if [[ -n "$alerts" ]]; then
    echo -e "$alerts" | $MAIL_CMD -s "$EMAIL_SUBJECT" "$EMAIL_TO" # Send alert email
fi
