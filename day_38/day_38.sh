#!/bin/bash

echo "Enter file name:"
read file

if [ -e "$file" ]; then
    echo "File exists"

    if [ -r "$file" ]; then
        echo "File is readable"
    else
        echo "File is not readable"
    fi

    if [ -w "$file" ]; then
        echo "File is writable"
    else
        echo "File is not writable"
    fi

    if [ -x "$file" ]; then
        echo "File is executable"
    else
        echo "File is not executable"
    fi

else
    echo "File does not exist"
fi