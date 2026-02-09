🗂️ Task Title (01-02-2026)
Day 2 – Bash Script for Log Monitoring & Cleanup

📝 Task Description
You will create ONE bash script file that does all the below tasks.


✅ Tasks to Perform (in order)

1️⃣ Setup
•	Create a folder named server_logs
•	Inside it, create:
o	app.log
o	db.log
o	error.log
Add sample content using echo (INFO, WARNING, ERROR).

________________________________________
2️⃣ Bash Script Creation
•	Create a script file:
•	log_monitor.sh
________________________________________

3️⃣ Inside the Script (IMPORTANT)
The script should:
1.	Print current date & time
2.	Count total ERROR lines from all .log files
3.	Save ERROR lines into a file called error_report.log
4.	Create a folder called archive
5.	Move all .log files into archive
6.	Print a success message:
7.	Log analysis and backup completed
________________________________________
4️⃣ Permissions
•	Make the script executable using chmod
•	Run it using:
•	./log_monitor.sh
________________________________________

--------------------------------------------------------------------------------------------------------


 1. Create a file:
nano day_2.sh

2.Paste all commands inside

3.Save and exit ( esc, :wq)

4.Make executable:
chmod +x day_2.sh

5.Run script:
./day_2.sh
