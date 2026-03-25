Task day 53 (24-03-2026)

Day 53:frequency of each element in an array



#!/bin/bash

# Store the MD5 hash of the first file in variable sum1
# md5sum outputs: <hash> <filename>
# cut extracts only the hash (first field separated by space)
sum1=$(md5sum "$file1" | cut -d ' ' -f1)

# Store the MD5 hash of the second file in variable sum2
sum2=$(md5sum "$file2" | cut -d ' ' -f1)

# Compare both hash values
# If hashes are equal → files are identical
if [ "$sum1" = "$sum2" ]; then
    echo "Files are identical"
else
    # If hashes differ → files are different
    echo "Files are different"
fi