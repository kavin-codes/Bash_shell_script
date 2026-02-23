
Task day 24 (23-02-2026)

Day 24: Find the Greatest Element in an Array

Write a Shell Script to Find the Greatest Element in an Array


#!/bin/bash

# ----------------------------------------
# This script finds the maximum number
# from a given array in Bash
# ----------------------------------------

# Declare an array with numeric values
array=(3 56 24 89 67)

# Initialize a variable 'max'
# Start by assuming the first element is the maximum
max=${array[0]}

# Loop through each element in the array
# "${array[@]}" expands to all elements in the array
for num in "${array[@]}"; do

    # Compare current element with the stored maximum
    # (( )) is used for numeric comparison in Bash
    if (( num > max )); then
        
        # If current number is greater,
        # update 'max' with this new value
        max=$num
    fi

# End of loop
done

# Print the final maximum value
echo "The maximum element in the array is: $max"