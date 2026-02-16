Task day_17 (16-02-2026) 
🧪 Day 17: Password Strength Checker Using Bash
🎯 Objective
Create a Bash shell script that validates the strength of a user’s password based on predefined security rules.
________________________________________
📌 Task Requirements
1.	Prompt the user to enter a password.
2.	Ensure the password input is hidden while typing.
3.	Validate the password using the following rules:
o	Minimum length of 12 characters
o	Must contain at least one uppercase letter
o	Must contain at least one lowercase letter
o	Must contain at least one numeric digit
o	Must contain at least one special character
4.	If the password does not meet all requirements:
o	Display a clear message explaining the missing criteria
o	Prompt the user to re-enter the password
5.	Repeat the process until a strong password is entered.
6.	Once all conditions are satisfied, display a success message and terminate the script.


===========================================================================

#!/bin/bash
# Use Bash shell to execute the script

while true
do
    # Prompt user to enter a password
    echo "Enter your password:"
    
    # Read password silently (input not shown on screen)
    read -s password
    echo   # Print a blank line for clean output

    score=0   # Initialize score to measure password strength

    # Check if password length is at least 12 characters
    if [ ${#password} -ge 12 ]; then
        ((score++))   # Increase score if condition is satisfied
    fi

    # Check for at least one uppercase letter (A-Z)
    if [[ $password =~ [A-Z] ]]; then
        ((score++))   # Increase score if uppercase letter exists
    fi

    # Check for at least one lowercase letter (a-z)
    if [[ $password =~ [a-z] ]]; then
        ((score++))   # Increase score if lowercase letter exists
    fi

    # Check for at least one numeric digit (0-9)
    if [[ $password =~ [0-9] ]]; then
        ((score++))   # Increase score if number exists
    fi

    # Check for at least one special character
    if [[ $password =~ [^a-zA-Z0-9] ]]; then
        ((score++))   # Increase score if special character exists
    fi

    # Final decision based on total score
    if [ $score -eq 5 ]; then
        # All security conditions satisfied
        echo "Password Strength: STRONG ✅"
        break   # Exit the loop when password is strong
    else
        # One or more security conditions failed
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
