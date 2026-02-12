{
echo "Top Targeted Users:"
grep -a "Failed password" /var/log/auth.log | awk '{print $9}' | sort | uniq -c | sort -nr | head -5

echo ""
echo "Top Attacking IPs:"
grep -a "Failed password" /var/log/auth.log | awk '{print $11}' | sort | uniq -c | sort -nr | head -5

echo ""
echo "Attack Peak Hours:"
grep -a "Failed password" /var/log/auth.log | awk '{print $3}' | cut -d: -f1 | sort | uniq -c | sort -nr
} > /home/kavin/server_logs/day_13_mini_soc_report.txt
