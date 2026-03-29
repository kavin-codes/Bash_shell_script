#!/bin/bash

names=("Arun" "Kiran" "Elena" "Uma" "Ravi" "Ishaan" "Deepak")

for n in "${names[@]}"; do
    [[ "${n,,}" =~ ^[aeiou] ]] && echo "$n"
done