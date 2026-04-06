#!/bin/bash

file="data.csv"
col=2

awk -F',' -v column=$col '
{
    sum += $column   # Add current row value to sum
}
END {
    print "Sum =", sum   # Print final sum
}
' "$file"