Task day_39 (10-03-2026) 
Day 39: Print the multiplication table of a number (1–10).

#!/bin/bash

# This script prints the multiplication table of a number from 1 to 10

# Ask the user to enter a number
echo "Enter a number:"

# Read the input number from the user and store it in variable 'num'
read num

# Start a for loop that runs from 1 to 10
for i in {1..10}
do
    # Calculate multiplication of the entered number and loop variable
    # $(( )) is used for arithmetic operations in bash
    result=$((num * i))

    # Print the multiplication result in table format
    echo "$num x $i = $result"
done

# End of script