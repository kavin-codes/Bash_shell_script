#!/bin/bash


OUTPUT_FILE="merged.csv"

cat *.csv > temp_all.csv

sort temp_all.csv | uniq > temp_unique.csv

sort -t',' -k1,1 temp_unique.csv > "$OUTPUT_FILE"

rm temp_all.csv temp_unique.csv

echo "Merged and sorted CSV saved to $OUTPUT_FILE"