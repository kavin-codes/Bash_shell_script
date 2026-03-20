Task day 49 (20-03-2026)

Day 49:temperature from Celsius to Fahrenheit


Write a Bash script to convert temperature from Celsius to Fahrenheit.



requirement:
   sudo apt install bc


=============================================================================


#!/bin/bash

# Pattern: Mathematical Formula + User Input

# Step 1: Take input from user
read -p "Enter temperature in Celsius: " celsius

# Step 2: Apply formula using bc (for decimal calculation)
fahrenheit=$(echo "($celsius * 9/5) + 32" | bc)

# Step 3: Print result
echo "Temperature in Fahrenheit: $fahrenheit"