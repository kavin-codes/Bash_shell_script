#!/bin/bash

echo "Enter a number:"
read num

for i in {1..10}
do
    result=$((num * i))
    echo "$num x $i = $result"
done