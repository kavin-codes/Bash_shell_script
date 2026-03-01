
Task day 30 (01-03-2026)

Day 30: Merge, Deduplicate, and Sort CSV Files in Bash
 

🎯 Requirement

You have multiple .csv files in a directory with the same structure. 
Write a Bash script to merge all CSV files into one file, remove duplicates, and sort them based on the first column.



#!/bin/bash
# merge_csv.sh - Merge, deduplicate, and sort CSV files
# Pattern Used: File concatenation + Sorting + Deduplication using Bash utilities

# -----------------------------
# Step 0: Define output file
# -----------------------------
OUTPUT_FILE="merged.csv"   # This is the final CSV file after merging

# -----------------------------
# Step 1: Merge all CSV files in the current directory
# -----------------------------
# 'cat *.csv' concatenates all CSV files into one temporary file
# temp_all.csv contains all rows from all CSVs
cat *.csv > temp_all.csv

# -----------------------------
# Step 2: Remove duplicate lines
# -----------------------------
# 'sort' sorts the lines so that duplicates are consecutive
# 'uniq' removes consecutive duplicate lines
# The result is stored in another temporary file temp_unique.csv
sort temp_all.csv | uniq > temp_unique.csv

# -----------------------------
# Step 3: Sort by the first column
# -----------------------------
# 'sort -t',' -k1,1' sorts CSV rows based on the first column
# '-t',' sets comma as the column delimiter
# '-k1,1' specifies sorting by the first column only
# The sorted and deduplicated data is saved to the final output file
sort -t',' -k1,1 temp_unique.csv > "$OUTPUT_FILE"

# -----------------------------
# Step 4: Cleanup temporary files
# -----------------------------
# Remove intermediate files to keep the directory clean
rm temp_all.csv temp_unique.csv

# -----------------------------
# Step 5: Print confirmation
# -----------------------------
echo "Merged and sorted CSV saved to $OUTPUT_FILE"