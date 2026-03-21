Task day 50 (21-03-2026)

Day 50:Find Duplicates in Array


================================================================================

#!/bin/bash

# Declare an array with some duplicate values
arr=(1 2 3 2 4 5 1 6)

# Declare an associative array (like a hashmap/dictionary)
# This will store frequency of each number
declare -A freq

# Print heading
echo "Duplicates:"

# Loop through each element in the array
for num in "${arr[@]}"; do
    # Increase the count of the current number in freq array
    # If not present, it initializes to 0 and then increments
    ((freq[$num]++))
done

# Loop through all keys (unique elements) in the freq array
for key in "${!freq[@]}"; do
    # Check if frequency is greater than 1 (means duplicate)
    if (( freq[$key] > 1 )); then
        # Print the duplicate number
        echo "$key"
    fi
done