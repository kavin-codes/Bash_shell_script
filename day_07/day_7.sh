#!/bin/bash

LOG_DIR="/home/kavin/server3_logs"
DASHBOARD="/home/kavin/server3_logs/log_dashboard.txt"
TREND_FILE="/home/kavin/server3_logs/daily_logs.txt"

DATE_CMD="/bin/date"
GREP_CMD="/bin/grep"
WC_CMD="/usr/bin/wc"
TAIL_CMD="/usr/bin/tail"
AWK_CMD="/usr/bin/awk"
MAIL_CMD="/usr/bin/mail"

TODAY=$($DATE_CMD +%F)
TIME_NOW=$($DATE_CMD '+%H:%M:%S')
STATUS="SUCCESS"

EMAIL_TO="admin@example.com"
EMAIL_SUBJECT="Log Trend Alert – $TODAY"

total_error=0
total_warning=0
total_critical=0
files_processed=0
alerts=""

for logfile in "$LOG_DIR"/*.log; do
    [[ -f "$logfile" ]] || continue

    error=$($GREP_CMD -i error "$logfile" | $WC_CMD -l)
    warning=$($GREP_CMD -i warning "$logfile" | $WC_CMD -l)
    critical=$($GREP_CMD -i critical "$logfile" | $WC_CMD -l)

    total_error=$((total_error + error))
    total_warning=$((total_warning + warning))
    total_critical=$((total_critical + critical))
    files_processed=$((files_processed + 1))
done

echo "$TODAY $total_error $total_critical" >> "$TREND_FILE"

mapfile -t last_days < <($TAIL_CMD -n 4 "$TREND_FILE")

if [[ ${#last_days[@]} -eq 4 ]]; then
    today_errors=$($AWK_CMD '{print $2}' <<< "${last_days[3]}")

    sum=0
    for i in 0 1 2; do
        sum=$((sum + $($AWK_CMD '{print $2}' <<< "${last_days[$i]}")))
    done

    avg_3day=$((sum / 3))

    if [[ $avg_3day -gt 0 ]]; then
        increase=$(( (today_errors - avg_3day) * 100 / avg_3day ))
        if [[ $increase -gt 50 ]]; then
            alerts+="Errors increased by ${increase}% compared to last 3 days\n"
        fi
    fi

    critical_days=0
    for i in 2 3; do
        crit=$($AWK_CMD '{print $3}' <<< "${last_days[$i]}")
        [[ $crit -gt 0 ]] && ((critical_days++))
    done

    if [[ $critical_days -eq 2 ]]; then
        alerts+="Critical events detected 2 consecutive days\n"
    fi
fi

{
echo "Log Dashboard Summary"
echo "=============================="
echo "Date: $TODAY"
echo "Time: $TIME_NOW"
echo
echo "Date-wise Log Counts (Today)"
echo "------------------------------"
echo "Errors   : $total_error"
echo "Warnings : $total_warning"
echo "Critical : $total_critical"
echo
echo "Total log files processed today: $files_processed"
echo
echo "Trend Alerts"
echo "------------------------------"
if [[ -n "$alerts" ]]; then
    echo -e "$alerts"
else
    echo "No trend alerts detected"
fi
echo
echo "Script Execution Status: $STATUS"
} > "$DASHBOARD"

if [[ -n "$alerts" ]]; then
    echo -e "$alerts" | $MAIL_CMD -s "$EMAIL_SUBJECT" "$EMAIL_TO"
fi
