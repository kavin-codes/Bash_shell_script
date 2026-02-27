#!/bin/bash

echo "Enter a number:"
read num

if [ $num -le 1 ]; then
    echo "$num is NOT a Prime number"
    exit
fi

isPrime=1

for (( i=2; i<=num/2; i++ ))
do
    if [ $((num % i)) -eq 0 ]; then
        isPrime=0
        break
    fi
done

if [ $isPrime -eq 1 ]; then
    echo "$num is a Prime number"
else
    echo "$num is NOT a Prime number"
fi