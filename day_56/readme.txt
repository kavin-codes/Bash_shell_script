Task day 56 (27-03-2026) 
Day 56-Change File Extensions

Rename all files with .txt extension to .bak in a directory

==================================================================

#!/bin/bash

# Loop through all .txt files
for file in *.txt
do
    # Remove .txt and add .bak
    new_name="${file%.txt}.bak"
    
    # Rename file
    mv "$file" "$new_name"
done