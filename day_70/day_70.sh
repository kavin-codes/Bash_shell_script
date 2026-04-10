#!/bin/bash

isPowerOfTwo() {
    local n=$1
    if [ "$n" -le 0 ]; then
        echo "false"
        return
    fi

    if (( (n & (n - 1)) == 0 )); then
        echo "true"
    else
        echo "false"
    fi
}

isPowerOfTwo 1
isPowerOfTwo 16
isPowerOfTwo 3