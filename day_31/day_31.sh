#!/bin/bash
read -p "Enter directory path: " dir_path

if [ ! -d "$dir_path" ]; then
    echo "Directory does not exist!"
    exit 1
fi

output_file="emails_found.txt"
> "$output_file"

for file in "$dir_path"/*.txt
do
    if [ -f "$file" ]; then

        grep -E -o "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" "$file" >> "$output_file"
    fi
done

sort "$output_file" | uniq > temp.txt && mv temp.txt "$output_file"
email_count=$(wc -l < "$output_file")
echo "Unique emails found: $email_count"
echo "Saved to $output_file"