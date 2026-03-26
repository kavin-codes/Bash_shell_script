#!/bin/bash
arr=(10 20 4 45 99)

largest=${arr[0]}
second=${arr[0]}

for num in "${arr[@]}"
do
  if [ $num -gt $largest ]; then
    second=$largest
    largest=$num
  elif [ $num -gt $second ] && [ $num -ne $largest ]; then
    second=$num
  fi
done

echo $second