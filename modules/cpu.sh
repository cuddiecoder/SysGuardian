#!/bin/bash
# ================================================
# CPU Usage Checker
# Shows CPU usage using `mpstat` or falls back to `top`
# ================================================

echo "CPU Usage:"

# Try mpstat first (more detailed)
mpstat 1 1 2>/dev/null \
    || top -bn1 | grep "Cpu"   # Fallback if mpstat isn't installed

# Pause so user can read the output
read -p "Press enter to continue..."
