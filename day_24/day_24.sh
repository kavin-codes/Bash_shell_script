#!/bin/bash
array=(3 56 24 89 67)
max=${array[0]}

for num in "${array[@]}"; do
    if ((num > max)); then
        max=$num
    fi
done

echo "The maximum element in the array is: $max" explain the code using comment in single file