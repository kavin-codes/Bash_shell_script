#!/bin/bash

handle_error() {
    echo "Error: $1"
    exit 1
}

read a b

[ $b -eq 0 ] && handle_error "Division by zero"

echo $((a / b))