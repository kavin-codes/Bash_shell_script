Task day 29 (28-02-2026)

Day 29: Directory Analyzer Script
 
Write a Bash script that:

Asks the user to enter a directory path

Checks whether the directory exists

If it exists, print:

Number of files

Number of sub-directories

Number of hidden files

If it does not exist, show an error message



=================================================================================================


#!/bin/bash

# Ask the user to enter a directory path
echo "Enter directory path:"
read dir   # Store user input in variable 'dir'

# Check if the given path is a directory
if [ -d "$dir" ]; then
    echo "Directory exists."

    # Count regular files in the directory (only current level, not recursive)
    # -maxdepth 1 → stay in the given directory only
    # -type f → select only regular files
    # wc -l → count the number of lines (number of files found)
    file_count=$(find "$dir" -maxdepth 1 -type f | wc -l)

    # Count sub-directories (exclude the main directory itself)
    # -type d → select directories
    # ! -path "$dir" → exclude the parent directory from count
    dir_count=$(find "$dir" -maxdepth 1 -type d ! -path "$dir" | wc -l)

    # Count hidden files
    # -name ".*" → files starting with '.' are hidden files
    # -type f → only regular files
    hidden_count=$(find "$dir" -maxdepth 1 -type f -name ".*" | wc -l)

    # Print results
    echo "Number of files: $file_count"
    echo "Number of directories: $dir_count"
    echo "Number of hidden files: $hidden_count"

else
    # If directory does not exist, show error message
    echo "Error: Directory does not exist."
fi