Task day 68 (08-04-2026) 
Day 68-Search element in array


#!/bin/bash

# Read number of elements
echo "Enter number of elements:"
read n

# Read array elements
echo "Enter the elements:"
for (( i=0; i<n; i++ ))
do
    read arr[$i]
done

# Read element to search
echo "Enter element to search:"
read key

# Flag variable (0 = not found, 1 = found)
found=0

# Search element
for (( i=0; i<n; i++ ))
do
    if [ "${arr[$i]}" == "$key" ]
    then
        echo "Element found at index $i"
        found=1
        break
    fi
done

# If not found
if [ $found -eq 0 ]
then
    echo "Element not found"
fi