Task day 69 (09-04-2026) 
Day 69-Remove Special Characters



#!/bin/bash

# Input file name
file="input.txt"

# tr command:
# -d → delete characters
# '[:punct:]' → matches all special characters (punctuation)
# This removes characters like !@#$%^&*() etc.

tr -d '[:punct:]' < "$file"