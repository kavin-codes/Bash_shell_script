#!/bin/bash

FILE="employees.txt"

touch $FILE

while true
do
    echo "------ Employee Menu ------"
    echo "1. Add Employee"
    echo "2. View Employees"
    echo "3. Search Employee"
    echo "4. Delete Employee"
    echo "5. Exit"
    echo "---------------------------"

    read -p "Enter choice: " choice

    case $choice in
        1)
            read -p "Enter ID: " id
            read -p "Enter Name: " name
            read -p "Enter Dept: " dept
            read -p "Enter Salary: " salary
            echo "$id:$name:$dept:$salary" >> $FILE
            echo "Employee Added!"
            ;;
        2)
            echo "Employee List:"
            cat $FILE
            ;;
        3)
            read -p "Enter ID to search: " id
            grep "^$id:" $FILE
            ;;
        4)
            read -p "Enter ID to delete: " id
            grep -v "^$id:" $FILE > temp.txt
            mv temp.txt $FILE
            echo "Employee Deleted!"
            ;;
        5)
            echo "Bye!"
            exit
            ;;
        *)
            echo "Invalid choice!"
            ;;
    esac

done