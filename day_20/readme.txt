task day 20 (19-02-2026)

Day 20: Automated Threat Response & Intrusion Detection
Goal: Extend your security automation to not just detect threats but respond automatically to high-risk events.
________________________________________
🔹 Task 1: Integrate Fail2Ban for SSH Protection
Goal: Automatically block IPs performing repeated SSH login failures.
Steps:
1.	Install Fail2Ban:
2.	sudo apt install fail2ban
3.	Configure jail for SSH:
o	Edit /etc/fail2ban/jail.local
o	Enable [sshd] section and set maxretry = 5, bantime = 3600
4.	Start and enable Fail2Ban service:
5.	sudo systemctl enable fail2ban
6.	sudo systemctl start fail2ban
7.	Test by attempting failed logins from a test IP.
________________________________________
🔹 Task 2: Automated Blocking of Web Abusers
Goal: Use Day 19 reports to automatically block IPs abusing the web server.
Steps:
1.	Parse critical_alerts_<date>.log for web abuse IPs.
2.	Add offending IPs to iptables or ufw block list:
3.	sudo ufw deny from <IP>
4.	Schedule this script with cron to run daily after the report generation.
________________________________________
🔹 Task 3: Log Monitoring with Alerts
Goal: Monitor logs in real-time and trigger immediate actions.
Steps:
1.	Use tail -F /var/log/auth.log and /var/log/apache2/access.log for real-time monitoring.
2.	Use a script to detect threshold breaches (e.g., SSH >5 failed attempts in 5 minutes).
3.	When threshold is exceeded:
o	Send email alert to admin.
o	Optionally, auto-block IP with Fail2Ban or firewall rule.
________________________________________
🔹 Task 4: Enhanced Reporting & Trend Analysis (Optional)
Goal: Improve report readability and identify patterns over time.
Steps:
1.	Include weekly or monthly trends in your report.
2.	Highlight new IPs vs repeat offenders.
3.	Output in CSV or HTML for management review.
________________________________________
🔹 Task 5: Defensive Analysis & Reflection
Answer these in your notes:
1.	Why is automated response important in addition to detection?
2.	What risks exist if high-risk IPs are not blocked quickly?
3.	How does combining real-time monitoring with cron-based reporting improve security?
4.	How would you improve the current automated system to handle zero-day attacks?



file setup for fail2ban:

first install fail2ban  using command prompt - sudo apt-get install fail2ban

next step:

sudo nano /etc/fail2ban/jail.local

then copy below code or text 

[sshd]
enabled  = true
port     = ssh
logpath  = /var/log/auth.log

# Number of failed attempts allowed
maxretry = 5

# Time window to count failures (seconds)
findtime = 300

# Ban time (seconds) → 1 hour
bantime  = 3600



 1. Why is automated response important in addition to detection?

Automated response is important because it immediately blocks attacks, reducing damage and eliminating delays caused by manual intervention.
 2. What risks exist if high-risk IPs are not blocked quickly?

If high-risk IPs are not blocked quickly, attackers can repeatedly attempt access, leading to system compromise, data theft, or service disruption.

 3. How does combining real-time monitoring with cron-based reporting improve security?

Combining real-time monitoring with cron-based reporting provides instant protection against attacks while also enabling long-term analysis of security trends.

 4. How would you improve the current automated system to handle zero-day attacks?

The system can be improved by adding behavior-based detection, adaptive thresholds, and integrated alerting to identify and respond to unknown attack patterns.



