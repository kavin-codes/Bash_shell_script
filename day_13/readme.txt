 Task  Day 13(12-02-2026)
🛠️ Day 13 – Mini SOC Investigation (Task Question)
🎯 Goal
Analyze SSH authentication logs to identify basic attack patterns.
________________________________________
🔹 Task Requirements
Using /var/log/auth.log, find:
1.	The top 3 most targeted usernames in failed SSH login attempts
2.	The top 3 source IP addresses generating failed SSH logins
3.	The hour of the day with the highest number of failed SSH attempts
________________________________________
🔹 Output Requirement
Save your findings to:
/home/kavin/server_logs/day_13_mini_soc_report.txt
________________________________________
📌 Example Output Format
===== Day 13 – Mini SOC Report =====

Top Targeted Usernames:
root – 20 attempts
admin – 8 attempts
ubuntu – 4 attempts

Top Attacking IPs:
203.0.113.55 – 25 attempts
198.51.100.12 – 10 attempts
192.0.2.33 – 6 attempts

Peak Attack Hour:
03:00 – 18 attempts
________________________________________
