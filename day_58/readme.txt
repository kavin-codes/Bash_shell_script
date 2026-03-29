Task day 58 (29-03-2026) 
Day 58-Filter Names by Vowel


Store names in an array and print names starting with a vowel


#!/bin/bash

names=("Arun" "Kiran" "Elena" "Uma" "Ravi" "Ishaan" "Deepak")

for name in "${names[@]}"
do
    first_char=${name:0:1}
    first_char=$(echo "$first_char" | tr 'A-Z' 'a-z')

    if [[ "$first_char" == "a" || "$first_char" == "e" || "$first_char" == "i" || "$first_char" == "o" || "$first_char" == "u" ]]
    then
        echo "$name"
    fi
done


