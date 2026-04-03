#!/bin/bash

file="input.txt"

word="error"
grep -v "$word" "$file"