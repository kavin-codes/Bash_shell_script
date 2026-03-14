Task day 43 (14-08-2026)

Day 43: Find the smallest of three numbers.

======================================================


#!/bin/bash

# Read three numbers from user
read -p "Enter first number: " a
read -p "Enter second number: " b
read -p "Enter third number: " c

# Assume first number is smallest
small=$a

# Compare with second number
if [ $b -lt $small ]; then
    small=$b
fi

# Compare with third number
if [ $c -lt $small ]; then
    small=$c
fi

# Print result
echo "Smallest number is: $small"