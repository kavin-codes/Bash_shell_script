Task Day 47 (18-03-2026)

Day 47–Upload File to Remote Server using scp

Write a Bash script to upload a file from your local system to a remote server using the scp command.


==============================================================================

#!/bin/bash

# Local file to upload
FILE="/home/user/file.txt"

# Remote server details
USER="username"
HOST="192.168.1.10"
REMOTE_PATH="/home/username/"

# Upload file using scp
scp "$FILE" "$USER@$HOST:$REMOTE_PATH"

# Check if upload was successful
if [ $? -eq 0 ]; then
    echo "File uploaded successfully ✅"
else
    echo "Upload failed ❌"
fi