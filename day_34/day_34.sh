#!/bin/bash

echo "Enter the number of elements:"
read n

echo "Enter the numbers:"
for ((i=0; i<n; i++))
do
    read arr[i]
done

for ((i=0; i<n; i++))
do
    for ((j=i+1; j<n; j++))
    do
        if [ ${arr[i]} -gt ${arr[j]} ]
        then
            temp=${arr[i]}
            arr[i]=${arr[j]}
            arr[j]=$temp
        fi
    done
done

echo "Numbers in ascending order:"
for ((i=0; i<n; i++))
do
    echo -n "${arr[i]} "
done

echo