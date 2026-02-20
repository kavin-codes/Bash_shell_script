#!/bin/bash

calculate_factorial() {
num=$1
fact=1
for ((i=1; i<=num; i++)); do
fact=$((fact * i))
done
echo $fact
}
echo "Enter a number: "
read input_num
factorial_result=$(calculate_factorial $input_num)
echo "Factorial of $input_num is: $factorial_result"