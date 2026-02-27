Task day 28 (27-02-2026)

Day 28: Check Prime Number
 
Write a shell script that Check Prime Number.


#!/bin/bash

# Pattern: Loop + Conditional (Trial Division)
# Idea:
# 1. A prime number is greater than 1.
# 2. It has no divisors other than 1 and itself.
# 3. We check divisibility from 2 to n-1.
# 4. If divisible by any number -> Not Prime.
# 5. Otherwise -> Prime.

# Read number from user
echo "Enter a number:"
read num

# Check if number is less than or equal to 1
if [ $num -le 1 ]; then
    echo "$num is NOT a Prime number"
    exit
fi

# Assume number is prime
isPrime=1

# Loop from 2 to num-1
for (( i=2; i<=num/2; i++ ))
do
    if [ $((num % i)) -eq 0 ]; then
        isPrime=0
        break
    fi
done

# Check result
if [ $isPrime -eq 1 ]; then
    echo "$num is a Prime number"
else
    echo "$num is NOT a Prime number"
fi