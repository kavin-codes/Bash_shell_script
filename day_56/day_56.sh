#!/bin/bash

for file in *.txt
do 
    new_name="${file%.txt}.bak"
  
    mv "$file" "$new_name"
done