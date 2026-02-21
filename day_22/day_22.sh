#!/bin/bash
directory="$1"
if [ -z "$directory" ]; then
echo "Usage: $0 <directory>"
exit 1
fi

if [ ! -d "$directory" ]; then

echo "Error: '$directory' is not a valid directory."
exit 1
fi

cd "$directory" || exit 1

for file in *; do
if [ -f "$file" ]; then
newname=$(echo "$file" | tr 'A-Z' 'a-z')
[ "$file" != "$newname" ] && mv "$file" "$newname"
fi
done