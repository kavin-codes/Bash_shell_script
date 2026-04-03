Task day 62 (02-04-2026) 
Day 62-Invert Match (Exclude Word)


#!/bin/bash

# Input file
file="input.txt"

# Word to exclude
word="error"

# grep -v → prints lines that DO NOT match the pattern
# "$word" → word to exclude
# "$file" → input file

grep -v "$word" "$file"