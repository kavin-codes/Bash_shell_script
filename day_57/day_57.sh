#!/bin/bash

for url in "$@"
do
    status=$(curl -o /dev/null -s -w "%{http_code}" $url)
    
    if [ $status -eq 200 ]; then
        echo "$url is UP"
    else
        echo "$url is DOWN"
    fi
done