#!/bin/bash

log_path="/var/log/security/critical_alerts_$(date +%F).log"

if [ ! -f "$log_path" ]; then
  echo "File not found: $log_path"
  exit 1
fi

ips=$(grep -eo '([0-9]{1,3}\.){3}[0-9]{1,3}' "$log_path" | sort -u)

for ip in $ips; do
  echo "Blocking IP: $ip"
  sudo ufw deny from "$ip"
done


chmod +x block_ips.sh
sudo ./block_ips.sh

