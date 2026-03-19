Task day 48 (19-03-2026)

Day 48:frequency of each element in an array

Find the frequency of each element in an array

==============================================================================

#!/bin/bash

# Input array
arr=(1 2 2 3 1 4 2)

# Declare associative array (key-value pair)
declare -A freq

# Loop through array elements
for num in "${arr[@]}"
do
    ((freq[$num]++))   # Increment count
done

# Print frequencies
for key in "${!freq[@]}"
do
    echo "$key -> ${freq[$key]} times"
done