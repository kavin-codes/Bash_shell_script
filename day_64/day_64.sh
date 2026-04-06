#!/bin/bash
input="data.csv"
output="data.tsv"
awk 'BEGIN {FS=","; OFS="\t"} {print $0}' "$input" > "$output"
echo "CSV converted to TSV and saved in $output"