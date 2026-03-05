
Task Day 34  (05-03-2026)

Day 34 – sort numbers in ascending order

Write a Bash program to sort numbers in ascending order.


==================================================================


#!/bin/bash

# Ask the user to enter how many numbers they want to sort
echo "Enter the number of elements:"
read n

# Ask the user to enter the numbers
echo "Enter the numbers:"

# Loop to read numbers and store them in an array
for ((i=0; i<n; i++))
do
    read arr[i]      # Store each number in array arr at position i
done

# Sorting logic using nested loops (similar to Bubble/Selection sort)

# Outer loop selects each element one by one
for ((i=0; i<n; i++))
do
    # Inner loop compares the selected element with the remaining elements
    for ((j=i+1; j<n; j++))
    do
        # Check if current element is greater than the next element
        if [ ${arr[i]} -gt ${arr[j]} ]
        then
            # Swap the numbers if they are in the wrong order
            
            temp=${arr[i]}      # Store arr[i] in temporary variable
            arr[i]=${arr[j]}    # Move smaller value to position i
            arr[j]=$temp        # Put stored value in position j
        fi
    done
done

# Print the sorted array
echo "Numbers in ascending order:"

# Loop through the array and print each element
for ((i=0; i<n; i++))
do
    echo -n "${arr[i]} "    # -n prints on the same line
done

# Print a new line at the end
echo