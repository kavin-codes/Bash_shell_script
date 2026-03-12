Task Day 41 (12-03-2026)


 Day 41 – Interactive Menu-Driven Bash Script


Write a Bash script that displays a menu and allows the user to choose different system operations.

 Requirements

The script should display a menu like:

1. Show current date and time
2. Show logged-in users
3. Show system uptime
4. Show disk usage
5. Exit

===============================================



#!/bin/bash

# Infinite loop to keep showing menu
while true
do

echo "------ System Menu ------"
echo "1. Show current date and time"
echo "2. Show logged-in users"
echo "3. Show system uptime"
echo "4. Show disk usage"
echo "5. Exit"

# Read user choice
read -p "Enter your choice: " choice

# Use case statement to execute commands
case $choice in

1)
# Display current date and time
date
;;

2)
# Show logged-in users
who
;;

3)
# Show system uptime
uptime
;;

4)
# Show disk usage
df -h
;;

5)
# Exit the script
echo "Exiting..."
exit
;;

*)
# Handle invalid input
echo "Invalid choice. Try again."
;;

esac

done