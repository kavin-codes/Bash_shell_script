
Task day 22 (21-02-2026)

Day 22:  all filenames in a directory to lowercase

Write a shell script that converts all filenames in a directory to lowercase.




#!/bin/bash
This line specifies that the script should be executed using the Bash shell.

directory="$1"
The variable directory stores the first command-line argument passed to the script, which should be the directory name.

if [ -z "$directory" ]; then
This condition checks whether the directory argument is empty or not provided.

echo "Usage: $0 <directory>"
If no argument is given, this line prints the correct usage of the script.

exit 1
The script exits with status code 1 to indicate an error.

fi
Ends the first if condition.

if [ ! -d "$directory" ]; then
This condition checks whether the provided argument is NOT a valid directory.

echo "Error: '$directory' is not a valid directory."
If the directory does not exist or is invalid, an error message is displayed.

exit 1
The script exits again with an error status.

fi
Ends the directory validation block.

cd "$directory" || exit 1
Changes the current working directory to the specified directory.
If changing the directory fails, the script exits immediately.

for file in *; do
Starts a loop that iterates over every item in the directory.

if [ -f "$file" ]; then
Checks whether the current item is a regular file (not a directory or special file).

newname=$(echo "$file" | tr 'A-Z' 'a-z')
Converts the filename from uppercase letters to lowercase using the tr command and stores it in newname.

[ "$file" != "$newname" ] && mv "$file" "$newname"
If the original filename is different from the lowercase version, the file is renamed.

fi
Ends the regular file check.

done
Ends the loop.

Final result:
All regular files in the given directory are renamed to lowercase, while directories and already lowercase files remain unchanged.