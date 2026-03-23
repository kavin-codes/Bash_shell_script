Task Day 52 (23-03-2026)
Day 52: Sorting an Array using Bubble Sort in Bash

====================================================

#!/bin/bash

# Step 1: Initialize the array with unsorted elements
arr=(5 2 9 1 5 6)

# Step 2: Get the length of the array
n=${#arr[@]}

# Step 3: Outer loop runs for all elements
for ((i=0; i<n; i++))
do
    # Step 4: Inner loop compares adjacent elements
    # After each iteration, largest element moves to the end
    for ((j=0; j<n-i-1; j++))
    do
        # Step 5: Compare current element with next element
        if (( arr[j] > arr[j+1] ))
        then
            # Step 6: Swap if elements are in wrong order
            temp=${arr[j]}
            arr[j]=${arr[j+1]}
            arr[j+1]=$temp
        fi
    done
done

# Step 7: Print the sorted array
echo "${arr[@]}"