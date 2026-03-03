#!/bin/bash

read -p "Enter number: " n

for ((i=1; i<=n; i++))
do
    # Print spaces
    for ((space=n-i; space>0; space--))
    do
        printf " "
    done

    # Print increasing numbers
    for ((num=1; num<=i; num++))
    do
        printf "%d" "$num"
    done

    # Print decreasing numbers
    for ((num=i-1; num>=1; num--))
    do
        printf "%d" "$num"
    done

    # New line
    printf "\n"
done