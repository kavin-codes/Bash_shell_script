 
Task day 27 (26-02-2026)

Day 27: calculates the sum of integers from 1 to N
 
Write a shell script that calculates the sum of integers from 1 to N using a loop.



#!/bin/bash
# Shebang line → tells the system to execute this script using bash shell

echo "Enter a number (N):"
# Display a message asking the user to enter a number

read N
# Read user input and store it in variable N

sum=0
# Initialize variable 'sum' to 0
# This variable will store the total sum

for (( i=1; i<=$N; i++ ))
do
    # Start a loop:
    # i=1        → initialize counter at 1
    # i<=$N      → run loop until i is less than or equal to N
    # i++        → increment i by 1 each iteration

    sum=$((sum + i))
    # Add current value of i to sum
    # $(( )) is used for arithmetic operations in bash
done

echo "Sum of integers from 1 to $N is: $sum"
# Print the final result
# $N  → user input number
# $sum → calculated total