#!/bin/bash
# ================================================
# Disk Space Checker
# Uses df to show used/free disk space
# ================================================

echo "Disk Usage:"

# The -h flag gives human-readable output (GB/MB)
df -h

# Wait before clearing the screen
read -p "Press enter to continue..."
