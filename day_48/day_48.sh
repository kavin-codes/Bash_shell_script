#!/bin/bash

arr=(1 2 2 3 1 4 2)
declare -A freq

for num in "${arr[@]}"
do
    ((freq[$num]++))
done

for key in "${!freq[@]}"
do
    echo "$key -> ${freq[$key]} times"
done