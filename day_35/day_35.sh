#!/bin/bash


echo "Enter the array elements separated by space:"
read -a arr

echo "Array elements are: ${arr[@]}"

count=${#arr[@]}

echo "Number of elements in the array: $count"