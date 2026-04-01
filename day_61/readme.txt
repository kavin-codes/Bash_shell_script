Task day 61 (01-04-2026) 
Day 61-Remove Blank Lines from a File


Given a file, remove all empty (blank) lines.

#!/bin/bash

file=$1

# Remove blank lines
grep -v '^$' "$file"