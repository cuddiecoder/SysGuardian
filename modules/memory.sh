#!/bin/bash
# ================================================
# Memory Usage Checker
# Uses the `free` command to show memory status
# ================================================

echo "Memory Usage:"

# Show memory in human-readable format
free -h

# Pause so user can read the output
read -p "Press enter to continue..."
