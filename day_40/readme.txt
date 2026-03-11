
Task day 40 (11-03-2026)

Day 40:sort numbers without using sort command


=======================================================


#!/bin/bash

# Declare an array of numbers
arr=(34 12 5 67 23)

# Find the number of elements in the array
n=${#arr[@]}

# Outer loop to iterate through each element
for ((i=0;i<n;i++))
do
    # Inner loop to compare elements
    for ((j=i+1;j<n;j++))
    do
        # Compare two numbers
        if [ ${arr[i]} -gt ${arr[j]} ]
        then
            # Swap the numbers if the first is greater
            temp=${arr[i]}
            arr[i]=${arr[j]}
            arr[j]=$temp
        fi
    done
done

# Print the sorted array
echo "Sorted numbers:"
echo "${arr[@]}"