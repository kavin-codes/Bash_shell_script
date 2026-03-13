Task day 42 (13-03-2026)
Day 42:find the GCD of two numbers.

Write a script to find the GCD (Greatest Common Divisor) of two numbers.
 

===============================================================================================

#!/bin/bash

# Read two numbers from the user
read -p "Enter first number: " a
read -p "Enter second number: " b

# Apply Euclidean Algorithm
while [ $b -ne 0 ]
do
    temp=$b          # Store value of b
    b=$((a % b))     # Find remainder
    a=$temp          # Update a
done

# Final value of a is the GCD
echo "GCD is: $a"