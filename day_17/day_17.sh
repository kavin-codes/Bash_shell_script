#!/bin/bash

while true
do
    echo "Enter your password:"
    read -s password
    echo

    score=0

    # Minimum length >= 12
    if [ ${#password} -ge 12 ]; then
        ((score++))
    fi

    # Uppercase letter check
    if [[ $password =~ [A-Z] ]]; then
        ((score++))
    fi

    # Lowercase letter check
    if [[ $password =~ [a-z] ]]; then
        ((score++))
    fi

    # Number check
    if [[ $password =~ [0-9] ]]; then
        ((score++))
    fi

    # Special character check
    if [[ $password =~ [^a-zA-Z0-9] ]]; then
        ((score++))
    fi

    # Final decision
    if [ $score -eq 5 ]; then
        echo "Password Strength: STRONG ✅"
        break
    else
        echo "Password Strength: WEAK ❌"
        echo "Your password must contain:"
        echo "- At least 12 characters"
        echo "- Uppercase letter"
        echo "- Lowercase letter"
        echo "- Number"
        echo "- Special character"
        echo "Please try again."
        echo
    fi
done
