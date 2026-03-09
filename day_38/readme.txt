
Task day 38 (09-03-2026)

Day 38: check whether a file is readable, writable, or executable

Write a script to check whether a file is readable, writable, or executable


#!/bin/bash

# Ask the user to enter a file name
echo "Enter file name:"

# Read the file name from user input and store it in variable 'file'
read file

# Check if the file exists using -e
if [ -e "$file" ]; then
    echo "File exists"

    # Check if the file has read permission using -r
    if [ -r "$file" ]; then
        echo "File is readable"
    else
        echo "File is not readable"
    fi

    # Check if the file has write permission using -w
    if [ -w "$file" ]; then
        echo "File is writable"
    else
        echo "File is not writable"
    fi

    # Check if the file has execute permission using -x
    if [ -x "$file" ]; then
        echo "File is executable"
    else
        echo "File is not executable"
    fi

# If the file does not exist, print message
else
    echo "File does not exist"
fi