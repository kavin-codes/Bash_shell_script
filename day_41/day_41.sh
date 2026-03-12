#!/bin/bash

while true
do
echo "1. Show current date and time"
echo "2. Show logged-in users"
echo "3. Show system uptime"
echo "4. Show disk usage"
echo "5. Exit"

read -p "Enter your choice: " choice

case $choice in
1) date ;;
2) who ;;
3) uptime ;;
4) df -h ;;
5) exit ;;
*) echo "Invalid choice" ;;
esac

done