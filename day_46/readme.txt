Task day 46 (17-03-2026)

Day 46:create a new user with a password

Write a Bash script to create a new user with a password.

The script should ask for username and password

It should create the user and set the password


============================================================================


#!/bin/bash

# Check if the script is run as root user
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit
fi

# Ask user to enter a username
echo "Enter username:"
read username

# Check if the user already exists (id command)
id "$username" &>/dev/null

# $? stores exit status (0 = exists, non-zero = not exists)
if [ $? -eq 0 ]; then
  echo "User already exists!"
else
  # Create user with home directory (-m)
  useradd -m "$username"
  
  # Ask for password (hidden input)
  echo "Enter password:"
  read -s password
  
  # Set password using chpasswd
  echo "$username:$password" | chpasswd
  
  echo "User '$username' created successfully"
fi

