#!/bin/bash

echo "Enter a number:"
read num

temp=$num
digits=${#num}
sum=0

while [ $temp -gt 0 ]
do
    digit=$((temp % 10))
    power=$((digit ** digits))
    sum=$((sum + power))
    temp=$((temp / 10))
done

if [ $sum -eq $num ]; then
    echo "$num is an Armstrong number"
else
    echo "$num is not an Armstrong number"
fi