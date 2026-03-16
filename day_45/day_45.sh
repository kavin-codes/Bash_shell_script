#!/bin/bash

queue=()

enqueue() {
    queue+=("$1")
    echo "Inserted: $1"
}

dequeue() {
    if [ ${#queue[@]} -eq 0 ]; then
        echo "Queue is empty"
    else
        echo "Removed: ${queue[0]}"
        queue=("${queue[@]:1}")
    fi
}

display() {
    echo "Queue elements: ${queue[@]}"
}

enqueue 10
enqueue 20
enqueue 30

display
dequeue
display