Task day 45 (16-03-2026)

Day 45:Implement Queue Using Array

Description:
Write a Bash script to implement a Queue data structure using an array. The program should support the following operations:

Enqueue – Insert an element into the queue.

Dequeue – Remove an element from the queue (FIFO order).

Display – Show all elements currently in the queue.

The queue should follow the FIFO (First In First Out) rule.

================================================================================


#!/bin/bash

# Initialize empty array for queue
queue=()

# Enqueue function (add element at end)
enqueue() {
    # $1 represents the value passed to the function
    queue+=("$1")     # add element to array
    echo "Inserted: $1"
}

# Dequeue function (remove element from front)
dequeue() {
    # Check if queue is empty
    if [ ${#queue[@]} -eq 0 ]; then
        echo "Queue is empty"
    else
        # Print element being removed
        echo "Removed: ${queue[0]}"
        
        # Remove first element
        queue=("${queue[@]:1}")
    fi
}

# Display queue elements
display() {
    echo "Queue elements: ${queue[@]}"
}

# ---- Function Calls ----

enqueue 10
enqueue 20
enqueue 30

display

dequeue

display