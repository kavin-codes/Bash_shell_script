#!/bin/bash

process_name="python"

process=$(pgrep -x "$process_name")

if [ -n "$process" ]; then
    echo "Process '$process_name' is running (PID: $process)"
else
    echo "Process '$process_name' is not running"
fi


cpu_usage=$(top -bn1 | awk '/Cpu\(s\)/ {print int(100 - $8)}')

if [ "$cpu_usage" -gt 75 ]; then
    echo "WARNING: CPU usage exceeded 10% ($cpu_usage%)"
fi

usage_memory=$(free | awk '/Mem:/ {print int((($2-$7)/$2)*100)}')
echo "Memory usage: $usage_memory%"

zombies=$(ps -eo stat | grep -c '^Z')
echo "Zombie processes found: $zombies"
