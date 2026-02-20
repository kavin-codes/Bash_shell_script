task day 21 (20-02-2026)

Day 21:  factorial of a given number

Write a function in a shell script that calculates the factorial of a given number.



#!/bin/bash
# Define a function to calculate factorial
calculate_factorial() {
num=$1
fact=1
for ((i=1; i<=num; i++)); do
fact=$((fact * i))
done
echo $fact
}
# Prompt the user to enter a number
echo "Enter a number: "
read input_num
# Call the calculate_factorial function with the input number
factorial_result=$(calculate_factorial $input_num)
# Display the factorial result
echo "Factorial of $input_num is: $factorial_result"