Task day 55 (26-03-2026)

Day 50:Find second largest number


================================================================================


#!/bin/bash

# Step 1: Declare an array
arr=(10 20 4 45 99)

# Step 2: Assume first element as largest and second largest
largest=${arr[0]}
second=${arr[0]}

# Step 3: Loop through each element in array
for num in "${arr[@]}"
do
  # If current number is greater than largest
  if [ $num -gt $largest ]; then
    # Update second largest to previous largest
    second=$largest
    # Update largest
    largest=$num

  # If number is between largest and second largest
  elif [ $num -gt $second ] && [ $num -ne $largest ]; then
    # Update second largest
    second=$num
  fi
done

# Step 4: Print second largest number
echo "Second Largest: $second"
