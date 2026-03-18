#!/bin/bash

FILE="/home/user/file.txt"
USER="username"
HOST="192.168.1.10"
REMOTE_PATH="/home/username/"

scp "$FILE" "$USER@$HOST:$REMOTE_PATH"

if [ $? -eq 0 ]; then
    echo "File uploaded successfully"
else
    echo "Upload failed"
fi