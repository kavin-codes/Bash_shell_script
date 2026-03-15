
Task day_44 (15-03-2026) 
Day 44-Given an array of integers, find all unique triplets whose sum is 0.


 #!/bin/bash

# Store all command-line arguments into an array called arr
# Example input when running script:
# bash threesum.sh -1 0 1 2 -1 -4
arr=("$@")

# Get the number of elements in the array
n=${#arr[@]}

# First loop selects the first element of the triplet
for ((i=0;i<n-2;i++))
do
    # Second loop selects the second element
    # Starts from i+1 so we don't reuse the same element
    for ((j=i+1;j<n-1;j++))
    do
        # Third loop selects the third element
        # Starts from j+1 to ensure all indices are different
        for ((k=j+1;k<n;k++))
        do
            # Calculate the sum of the three selected numbers
            sum=$((arr[i] + arr[j] + arr[k]))

            # Check if the sum equals zero
            if [ $sum -eq 0 ]
            then
                # If condition is true, print the triplet
                echo "${arr[i]} ${arr[j]} ${arr[k]}"
            fi
        done
    done
done