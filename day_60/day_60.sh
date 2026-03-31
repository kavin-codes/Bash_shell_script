#!/bin/bash


findFirst() {
    local nums=("$@")
    local target=${nums[-1]}
    unset 'nums[-1]'
    
    local left=0
    local right=$((${#nums[@]} - 1))
    local result=-1

    while [ $left -le $right ]; do
        local mid=$(( (left + right) / 2 ))

        if [ ${nums[$mid]} -eq $target ]; then
            result=$mid
            right=$((mid - 1))
        elif [ ${nums[$mid]} -lt $target ]; then
            left=$((mid + 1))
        else
            right=$((mid - 1))
        fi
    done

    echo $result
}


findLast() {
    local nums=("$@")
    local target=${nums[-1]}
    unset 'nums[-1]'
    
    local left=0
    local right=$((${#nums[@]} - 1))
    local result=-1

    while [ $left -le $right ]; do
        local mid=$(( (left + right) / 2 ))

        if [ ${nums[$mid]} -eq $target ]; then
            result=$mid
            left=$((mid + 1))
        elif [ ${nums[$mid]} -lt $target ]; then
            left=$((mid + 1))
        else
            right=$((mid - 1))
        fi
    done

    echo $result
}


nums=(5 7 7 8 8 10)
target=8

first=$(findFirst "${nums[@]}" "$target")
last=$(findLast "${nums[@]}" "$target")

echo "[$first, $last]"