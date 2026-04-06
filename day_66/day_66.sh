#!/bin/bash
file="data.csv"
col=2

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