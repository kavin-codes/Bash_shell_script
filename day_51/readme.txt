Task day 51 (22-03-2026) 
Day 51-Divide Two Numbers


#!/bin/bash

# Function to handle errors
# Takes one argument (error message)
# Prints the message and exits the script
handle_error() {
    echo "Error: $1"   # Display error message
    exit 1             # Exit script with status 1 (indicates failure)
}

# Read two inputs from user
# 'a' → first number
# 'b' → second number
read a b

# Check if second number (b) is equal to 0
# If true, call handle_error function
# '&&' means: execute next command only if condition is true
[ $b -eq 0 ] && handle_error "Division by zero"

# Perform integer division using arithmetic expansion
# $((a / b)) divides a by b
echo $((a / b))   # Print result