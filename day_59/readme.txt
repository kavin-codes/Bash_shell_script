Task day 59 (30-03-2026) 
Day 59-Anagram Checker

Two strings are anagrams if:

They contain the same characters
With the same frequency
Order does not matter



==============================================================
#!/bin/bash

# Read two strings from user
read -p "Enter first string: " str1
read -p "Enter second string: " str2

# Convert to lowercase (optional, for case-insensitive comparison)
str1=$(echo "$str1" | tr 'A-Z' 'a-z')
str2=$(echo "$str2" | tr 'A-Z' 'a-z')

# Remove spaces (optional)
str1=$(echo "$str1" | tr -d ' ')
str2=$(echo "$str2" | tr -d ' ')

# Sort characters
sorted1=$(echo "$str1" | fold -w1 | sort | tr -d '\n')
sorted2=$(echo "$str2" | fold -w1 | sort | tr -d '\n')

# Compare sorted strings
if [ "$sorted1" = "$sorted2" ]; then
    echo "Anagram ✅"
else
    echo "Not anagram ❌"
fi