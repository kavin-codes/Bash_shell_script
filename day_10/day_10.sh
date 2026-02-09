



PROCESS_NAME="nginx"
LOG_FILE="/var/log/system_health.log"
DATE="$(/usr/bin/date '+%Y-%m-%d %H:%M:%S')"


log_message() {
    echo "$1" >> "$LOG_FILE"
}

check_process() {

    if ! pgrep "$PROCESS_NAME" > /dev/null 2>&1; then
        systemctl restart "$PROCESS_NAME"

        if [ $? -eq 0 ]; then
            echo "Process was not running and has been restarted successfully"
        else
            echo "Failed to restart the process"
        fi
    fi
}

check_cpu() {

    cpu_usage=$(top -bn1 | awk '/Cpu\(s\)/ {print int(100 - $8)}')

    if [ "$cpu_usage" -gt 75 ]; then
        echo "CPU usage is more than 75% at $(date '+%Y-%m-%d %H:%M:%S')"
    fi

}


check_memory() {
    memory_usage=$(free | awk '/Mem:/ {print int(($3/$2)*100)}')

    if [ "$memory_usage" -gt 80 ]; then
        echo "Memory usage is more than 80% at $(date '+%Y-%m-%d %H:%M:%S')" >> memory_alert.log
    fi
}

check_zombies() {

    ZOMBIES=$(/bin/ps -eo pid,stat,comm | /usr/bin/awk '$2 ~ /Z/ {print}')

    if [ -n "$ZOMBIES" ]; then
        COUNT=$(echo "$ZOMBIES" | /usr/bin/wc -l)

        echo "$ZOMBIES" | while read -r line; do
            PID=$(echo "$line" | /usr/bin/awk '{print $1}')
            CMD=$(echo "$line" | /usr/bin/awk '{print $3}')
            log_message "Zombie detected: PID=$PID CMD=$CMD"
        done

        log_message "Total zombies detected: $COUNT on $DATE"
    fi
}


check_process
check_cpu
check_memory
check_zombies