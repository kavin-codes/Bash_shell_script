Task day 64 (04-03-2026) 
Day 64-Convert CSV to TSV

#!/bin/bash

# Input CSV file
input="data.csv"

# Output TSV file
output="data.tsv"

# Use awk to replace comma (,) with tab (\t)
awk 'BEGIN {FS=","; OFS="\t"} {print $0}' "$input" > "$output"

# Print success message
echo "CSV converted to TSV and saved in $output"