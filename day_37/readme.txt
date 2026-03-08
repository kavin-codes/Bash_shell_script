task day 37 (8-03-2026)

Day 20: generates a random password of a given length

Write a script that generates a random password of a given length.


==========================================================



#!/bin/bash

# -------------------------------
# Random Password Generator Script
# -------------------------------

# Print a message asking the user to enter the password length
echo "Enter password length:"

# Read user input and store it in the variable 'length'
read length

# Generate a random password
# /dev/urandom → produces random characters
# tr -dc → keeps only allowed characters (letters, numbers, symbols)
# head -c → takes only the number of characters specified by the user

password=$(tr -dc 'A-Za-z0-9!@#$%^&*' </dev/urandom | head -c $length)

# Display the generated password
echo "Generated Password: $password"