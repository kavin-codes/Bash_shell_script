
Task day 25 (24-02-2026)

Day 25: generates a secure random password


Write a script that generates a secure random password.


#!/bin/bash

# Define a function to generate a random password
generate_password() {

  # tr -dc 'A-Za-z0-9!@#$%^&*()_+{}[]'
  # -d  : delete characters NOT in the given set
  # -c  : complement the set (invert match)
  # This keeps only:
  #   - Uppercase letters (A-Z)
  #   - Lowercase letters (a-z)
  #   - Numbers (0-9)
  #   - Special characters listed
  #
  # < /dev/urandom
  # /dev/urandom provides a stream of random bytes from the OS
  #
  # fold -w 12
  # Splits the continuous random stream into lines of width 12
  #
  # head -n 1
  # Takes only the first 12-character line as the password

  tr -dc 'A-Za-z0-9!@#$%^&*()_+{}[]' < /dev/urandom | fold -w 12 | head -n 1
}

# Call the function and store the generated password in a variable
password=$(generate_password)

# Print the generated password
echo "Generated password: $password"

