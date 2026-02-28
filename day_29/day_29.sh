#!/bin/bash

echo "Enter directory path:"
read dir

if [ -d "$dir" ]; then
    echo "Directory exists."


    file_count=$(find "$dir" -maxdepth 1 -type f | wc -l)

    
    dir_count=$(find "$dir" -maxdepth 1 -type d ! -path "$dir" | wc -l)

  
    hidden_count=$(find "$dir" -maxdepth 1 -type f -name ".*" | wc -l)

    echo "Number of files: $file_count"
    echo "Number of directories: $dir_count"
    echo "Number of hidden files: $hidden_count"

else
    echo "Error: Directory does not exist."
fi