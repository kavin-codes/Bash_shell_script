#!/bin/bash

echo "=============================="
echo "   Linux Process Snapshot"
echo "=============================="
echo

echo "Logged-in user:"
whoami
echo

echo "Current date & time:"
date
echo

echo "Total running processes:"
ps aux | wc -l
echo

echo "Top 5 CPU-consuming processes:"
ps aux --sort=-%cpu | head -6
echo

echo "Top 5 Memory-consuming processes:"
ps aux --sort=-%mem | head -6
echo

echo "Processes owned by current user:"
ps -u $USER
echo

echo "Processes owned by root:"
ps -u root
echo

echo "===== End of Snapshot ====="
