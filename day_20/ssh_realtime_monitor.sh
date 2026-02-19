#!/bin/bash

log_path="/var/log/auth.log"
threshold=5

declare -A attempts

tail -F "$log_path" | while read line; do

  if echo "$line" | grep -q "Failed password"; then

    ip=$(echo "$line" | awk '{print $(NF-3)}')

    attempts[$ip]=$(( ${attempts[$ip]:-0} + 1 ))

    echo "Failed attempt from $ip (${attempts[$ip]})"

    if [ "${attempts[$ip]}" -ge "$threshold" ]; then

      echo "Threshold crossed — blocking $ip"

      sudo ufw deny from "$ip"

      echo "SSH brute-force detected from $ip" | mail -s "SSH Alert" admin@gmail.com

      attempts[$ip]=0
    fi
  fi
done



