#!/bin/bash

file="data.txt"


awk '{print $1 "-" $2}' "$file"