Task day_18 (17-02-2026) 
📝 Task 18: Time-Based Greeting Script

Objective:
Create a Bash shell script that displays a greeting message based on the current system time.

Requirements:
•	Fetch the current hour from the system
•	Use conditional statements
•	Display:
o	“Good Morning” (morning hours)
o	“Good Afternoon” (afternoon hours)
o	“Good Evening” (evening hours)
o	“Good Night” (night hours)

Output:
A single greeting message printed to the terminal according to the time



============================================================================================


#!/bin/bash
# The above line is called a shebang.
# It tells the system to use the Bash shell to run this script.

hour=$(date +%H)
# This command gets the current system hour in 24-hour format (00–23)
# The value is stored in the variable named 'hour'

if [ $hour -ge 5 ] && [ $hour -lt 12 ]
# Check if the current hour is greater than or equal to 5
# AND less than 12 (Morning time)
then
    echo "Good Morning"
    # Prints "Good Morning" if the condition is true

elif [ $hour -ge 12 ] && [ $hour -lt 17 ]
# Check if the current hour is between 12 and 17 (Afternoon time)
then
    echo "Good Afternoon"
    # Prints "Good Afternoon"

elif [ $hour -ge 17 ] && [ $hour -lt 21 ]
# Check if the current hour is between 17 and 21 (Evening time)
then
    echo "Good Evening"
    # Prints "Good Evening"

else
    # If none of the above conditions are true
    # This means it is night time
    echo "Good Night"
    # Prints "Good Night"
fi
# Ends the if–elif–else conditional block
