#!/bin/bash

read -p "Enter first string: " str1
read -p "Enter second string: " str2

str1=$(echo "$str1" | tr 'A-Z' 'a-z')
str2=$(echo "$str2" | tr 'A-Z' 'a-z')

str1=$(echo "$str1" | tr -d ' ')
str2=$(echo "$str2" | tr -d ' ')

sorted1=$(echo "$str1" | fold -w1 | sort | tr -d '\n')
sorted2=$(echo "$str2" | fold -w1 | sort | tr -d '\n')

if [ "$sorted1" = "$sorted2" ]; then
    echo "Anagram ✅"
else
    echo "Not anagram ❌"
fi