#!/bin/bash

arr=(1 2 3 2 4 5 1 6)

declare -A freq

echo "Duplicates:"

for num in "${arr[@]}"; do
    ((freq[$num]++))
done

for key in "${!freq[@]}"; do
    if (( freq[$key] > 1 )); then
        echo "$key"
    fi
done