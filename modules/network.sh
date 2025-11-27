#!/bin/bash
# ================================================
# Network Information Viewer
# Uses `ip a` to show network interfaces & addresses
# ================================================

echo "Network Info:"

# Display all IP addresses and interfaces
ip a

# Wait before returning to main menu
read -p "Press enter to continue..."
