#!/bin/bash

array=(1 65 22 19 94)

sum=0

for num in "${array[@]}"; do
    sum=$((sum + num))
done

echo "The sum of elements in the array is: $sum"