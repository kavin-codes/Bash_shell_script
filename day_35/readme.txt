

Task day_35 (06-03-2026) 
🧪 Day 35: Count the Number of Elements in an Array using Bash Script


==========================================================================


#!/bin/bash

# Program: Count the number of elements in an array (User Input)

# Display a message asking the user to enter array elements
# The elements should be separated by spaces
echo "Enter the array elements separated by space:"

# read -a arr
# -a option tells bash to store the input values into an array
# arr is the name of the array
read -a arr

# Display all the elements of the array
# ${arr[@]} prints every element stored in the array
echo "Array elements are: ${arr[@]}"

# ${#arr[@]} returns the total number of elements in the array
# We store that value in a variable called count
count=${#arr[@]}

# Print the number of elements in the array
echo "Number of elements in the array: $count"