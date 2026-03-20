#!/bin/bash

read -p "Enter temperature in Celsius: " celsius
fahrenheit=$(echo "($celsius * 9/5) + 32" | bc)
echo "Temperature in Fahrenheit: $fahrenheit"