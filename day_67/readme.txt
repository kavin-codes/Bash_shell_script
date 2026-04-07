Task day 67 (07-03-2026) 
Day 67-Remove Blank Lines in Bash



sed        # stream editor used for text processing

'/^$/d'    # pattern + action:
           # ^  -> start of line
           # $  -> end of line
           # ^$ -> matches an empty line
           # d  -> delete the matched line

input.txt  # input file to read from

> output.txt  # redirects the result into output.txt (saves cleaned file)