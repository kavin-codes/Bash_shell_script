Task day 66 (06-03-2026) 
Day 66-Average Column Values


#!/bin/bash

# Input file
file="data.csv"

# Column number
col=2

# Use awk to calculate average
awk -F',' -v column=$col '
{
    sum += $column   # Add value to sum
    count++          # Count number of rows
}
END {
    if (count > 0)
        print "Average =", sum / count   # Calculate average
    else
        print "No data"
}
' "$file"
