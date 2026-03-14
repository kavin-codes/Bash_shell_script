#!/bin/bash

read -p "Enter first number: " a
read -p "Enter second number: " b
read -p "Enter third number: " c

small=$a

if [ $b -lt $small ]; then
    small=$b
fi

if [ $c -lt $small ]; then
    small=$c
fi

echo "Smallest number is: $small"