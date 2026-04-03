Task day 63 (03-04-2026) 
Day 63-Concatenate columns

#!/bin/bash

# Input file
file="data.txt"

# awk processes columns
# $1 → first column (name)
# $2 → second column (age)

# Concatenate both columns with a dash
awk '{print $1 "-" $2}' "$file"

