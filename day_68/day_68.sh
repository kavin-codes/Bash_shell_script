#!/bin/bash

echo "Enter number of elements:"
read n

echo "Enter the elements:"
for (( i=0; i<n; i++ ))
do
    read arr[$i]
done

echo "Enter element to search:"
read key

found=0

for (( i=0; i<n; i++ ))
do
    if [ "${arr[$i]}" == "$key" ]
    then
        echo "Element found at index $i"
        found=1
        break
    fi
done

if [ $found -eq 0 ]
then
    echo "Element not found"
fi