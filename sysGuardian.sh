#!/bin/bash
# ===========================================================
# SysGuardian - A simple modular system auditing toolkit
# This is the main menu script that calls separate modules.
# ===========================================================

# Set log file location
LOGFILE="logs/sysguardian.log"

# Make sure logs folder exists
mkdir -p logs

# Log function (not used yet, but useful for future expansion)
log() {
    echo "$(date) - $1" >> "$LOGFILE"
}

# Infinite loop for the menu
while true; do
    clear
    echo "===== SysGuardian ====="
    echo "1) Check CPU usage"
    echo "2) Check Memory usage"
    echo "3) Check Disk space"
    echo "4) Show Network info"
    echo "5) Exit"
    echo
    read -p "Choose an option: " choice

    # Choose what script to run
    case $choice in
        1) bash modules/cpu.sh ;;      # Run CPU module
        2) bash modules/memory.sh ;;   # Run memory module
        3) bash modules/disk.sh ;;     # Run disk module
        4) bash modules/network.sh ;;  # Run network module
        5) exit 0 ;;                   # Quit
        *) 
            echo "Invalid option" 
            sleep 1 
            ;;
    esac
done

