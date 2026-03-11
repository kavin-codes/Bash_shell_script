#!/bin/bash

arr=(34 12 5 67 23)

n=${#arr[@]}

for ((i=0;i<n;i++))
do
    for ((j=i+1;j<n;j++))
    do
        if [ ${arr[i]} -gt ${arr[j]} ]
        then
            temp=${arr[i]}
            arr[i]=${arr[j]}
            arr[j]=$temp
        fi
    done
done

echo "Sorted numbers:"
echo "${arr[@]}"