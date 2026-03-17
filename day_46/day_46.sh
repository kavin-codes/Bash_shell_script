#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit
fi

echo "Enter username:"
read username

id "$username" &>/dev/null

if [ $? -eq 0 ]; then
  echo "User already exists!"
else
  useradd -m "$username"
  
  echo "Enter password:"
  read -s password
  
  echo "$username:$password" | chpasswd
  
  echo "User '$username' created successfully"
fi