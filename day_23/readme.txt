Task day 23 (22-02-2026)

Day 23:  sum of Elements in an Array


Write a scripte to calculate the sum of Elements in an Array.



#!/bin/bash
# Shebang line
# It tells the system to use the Bash shell to execute this script.

# Declare an array
array=(1 65 22 19 94)
# This creates a Bash array named 'array'
# The elements are: 1, 65, 22, 19, 94

# Initialize a variable to store the sum
sum=0
# Variable 'sum' is initialized to 0
# We will use it to accumulate total value

# Iterate through the array and add each element to the sum
for num in "${array[@]}"; do
    # "${array[@]}" means:
    # Take all elements of the array one by one
    
    sum=$((sum + num))
    # $(( )) is arithmetic expansion in Bash
    # It adds current number (num) to sum
done

# Print the sum
echo "The sum of elements in the array is: $sum"
# echo prints the result to the terminal
# $sum accesses the value stored in variable sum