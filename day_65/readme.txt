Task day 65 (05-03-2026) 
Day 65-Sum column values


#!/bin/bash

# Input file
file="data.csv"

# Column number to sum (example: column 2)
col=2

# Use awk to calculate sum
awk -F',' -v column=$col '
{
    sum += $column   # Add current row value to sum
}
END {
    print "Sum =", sum   # Print final sum
}
' "$file"


