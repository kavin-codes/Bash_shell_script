Task day 31 (01-03-2026)

Day 31: Email Extractor from Multiple Files

Write a Bash script that:

Accepts a directory path from the user.

Loops through all text files (*.txt) in that directory.

Finds and extracts all email addresses in the files.

Stores the unique email addresses in a file called emails_found.txt.

Prints the total number of unique emails found.



#!/bin/bash


# Ask the user to enter the directory path containing the text files
read -p "Enter directory path: " dir_path

# Check if the entered directory exists
if [ ! -d "$dir_path" ]; then
    echo "Directory does not exist!"  # Print error message if directory not found
    exit 1                           # Exit the script with error status
fi

# Define the file to store all extracted emails
output_file="emails_found.txt"

# Clear the file if it already exists (start fresh)
> "$output_file"

# Loop through all .txt files in the given directory
for file in "$dir_path"/*.txt
do
    # Check if the file actually exists (in case no .txt files are present)
    if [ -f "$file" ]; then
        # Use grep with regular expression to extract email patterns
        # -E  → use extended regex
        # -o  → print only the matched part of each line
        # The regex matches common email formats (letters, numbers, dots, @, domain)
        grep -E -o "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" "$file" >> "$output_file"
        # Append the results to the output file
    fi
done

# Remove duplicate emails to get unique email addresses
# sort  → sorts the file (required for uniq)
# uniq  → removes duplicate lines
# temp.txt → temporary file to store intermediate result
# mv temp.txt "$output_file" → overwrite the original output file with unique emails
sort "$output_file" | uniq > temp.txt && mv temp.txt "$output_file"

# Count the number of unique emails
# wc -l → counts the number of lines (each line = one email)
email_count=$(wc -l < "$output_file")

# Print the results to the user
echo "Unique emails found: $email_count"
echo "Saved to $output_file"