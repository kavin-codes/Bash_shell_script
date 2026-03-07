
 Task Day 36 (07-03-2026)
 Day 36: Write a Bash shell script to check whether a given number is an Armstrong number.



============================================================================================
#!/bin/bash

# Ask the user to enter a number
echo "Enter a number:"
read num   # Store the user input in variable 'num'

temp=$num  # Copy the original number to 'temp' so we can modify it later
digits=${#num}  # Count how many digits are in the number

sum=0  # Variable to store the sum of powered digits

# Loop until all digits of the number are processed
while [ $temp -gt 0 ]
do
    digit=$((temp % 10))  # Get the last digit of the number using modulus
    power=$((digit ** digits))  # Raise the digit to the power of total digits
    sum=$((sum + power))  # Add the result to 'sum'
    temp=$((temp / 10))  # Remove the last digit from temp
done

# Check if the calculated sum equals the original number
if [ $sum -eq $num ]; then
    # If equal, it is an Armstrong number
    echo "$num is an Armstrong number"
else
    # Otherwise, it is not an Armstrong number
    echo "$num is not an Armstrong number"
fi