Task day 70 (10-04-2026) 
Day 70-number is a power of two

Function to check if a number is a power of two

#!/bin/bash


isPowerOfTwo() {
    local n=$1

    # Check if n is greater than 0
    if [ "$n" -le 0 ]; then
        echo "false"
        return
    fi

    # Use bitwise AND: n & (n - 1)
    # If result is 0 → power of two
    if (( (n & (n - 1)) == 0 )); then
        echo "true"
    else
        echo "false"
    fi
}

# Example usage
isPowerOfTwo 1    # true
isPowerOfTwo 16   # true
isPowerOfTwo 3    # false