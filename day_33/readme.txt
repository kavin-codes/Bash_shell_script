
Day 33 Task (04-03-2026)
Day 33 – Linux Bash Task – Employee Management System

Objective

Create a menu-driven Bash script to manage employee records using a text file for storage.

==============================================================================================================


#!/bin/bash
# Simple Employee Management System (Bash Script)
# Stores employee records in a text file and allows basic operations

# File to store employee records
FILE="employees.txt"

# Create the file if it does not exist
touch $FILE

# Infinite loop to keep the menu running until user exits
while true
do
    # Display the menu
    echo "------ Employee Menu ------"
    echo "1. Add Employee"
    echo "2. View Employees"
    echo "3. Search Employee"
    echo "4. Delete Employee"
    echo "5. Exit"
    echo "---------------------------"

    # Read the user's choice
    read -p "Enter choice: " choice

    # Use case statement to handle different menu options
    case $choice in
        1)
            # Option 1: Add Employee
            # Prompt the user to enter employee details
            read -p "Enter ID: " id
            read -p "Enter Name: " name
            read -p "Enter Dept: " dept
            read -p "Enter Salary: " salary

            # Append the employee record to the file in format ID:Name:Dept:Salary
            echo "$id:$name:$dept:$salary" >> $FILE
            echo "Employee Added!"
            ;;
        2)
            # Option 2: View Employees
            echo "Employee List:"
            
            # Display the contents of the file
            cat $FILE
            ;;
        3)
            # Option 3: Search Employee
            # Prompt user for the employee ID to search
            read -p "Enter ID to search: " id

            # Use grep to find the line starting with the entered ID
            grep "^$id:" $FILE
            ;;
        4)
            # Option 4: Delete Employee
            # Prompt user for the employee ID to delete
            read -p "Enter ID to delete: " id

            # Use grep -v to exclude the line with this ID and save to temp file
            grep -v "^$id:" $FILE > temp.txt

            # Replace original file with updated temp file
            mv temp.txt $FILE
            echo "Employee Deleted!"
            ;;
        5)
            # Option 5: Exit
            echo "Bye!"
            exit
            ;;
        *)
            # Default case if user enters an invalid option
            echo "Invalid choice!"
            ;;
    esac
done