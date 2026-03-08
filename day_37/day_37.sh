#!/bin/bash

# Ask the user for password length
echo "Enter password length:"
read length

# Generate random password
password=$(tr -dc 'A-Za-z0-9!@#$%^&*' </dev/urandom | head -c $length)

# Print the password
echo "Generated Password: $password"