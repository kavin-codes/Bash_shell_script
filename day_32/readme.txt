Task day 32 (01-03-2026)

Day 32: palindrome number pattern.

Write a Bash script that:

Print palindrome number pattern.

Example (n = 4)
   1
  121
 12321
1234321



==============================================================================


#!/bin/bash

# Ask user to enter a number
# This number represents how many rows to print
read -p "Enter number: " n

# Outer loop controls number of rows
# i represents the current row number
for ((i=1; i<=n; i++))
do
    # Print leading spaces
    # Number of spaces decreases as row increases
    # Example: if n=4
    # Row 1 → 3 spaces
    # Row 2 → 2 spaces
    for ((space=n-i; space>0; space--))
    do
        printf " "
    done

    # Print increasing numbers from 1 to i
    # Example:
    # Row 3 → 123
    for ((num=1; num<=i; num++))
    do
        printf "%d" "$num"
    done

    # Print decreasing numbers from (i-1) down to 1
    # Example:
    # Row 3 → 21
    # So full row becomes 12321
    for ((num=i-1; num>=1; num--))
    do
        printf "%d" "$num"
    done

    # Move to the next line after completing one row
    printf "\n"
done