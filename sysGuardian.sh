#!/bin/bash
# ===========================================================
# SysGuardian - A simple modular system auditing toolkit
# This main menu script calls separate modules and ensures
# the output is visible before returning to the menu.
# ===========================================================

# Set log file location
LOGFILE="logs/sysguardian.log"

# Ensure the logs folder exists
mkdir -p logs

# Log function (optional, for future expansion)
log() {
    echo "$(date) - $1" >> "$LOGFILE"
}

# Infinite loop to display the menu
while true; do
    clear
    echo "===== SysGuardian ====="
    echo "1) Check CPU usage"
    echo "2) Check Memory usage"
    echo "3) Check Disk space"
    echo "4) Show Network info"
    echo "5) Check Firewall status"
    echo "6) Check System Updates"
    echo "7) Check Service Status"

    echo "8) Exit"
    echo

    read -p "Choose an option: " choice

    # Execute the module corresponding to the choice
    case $choice in
        1)
            bash modules/cpu.sh
            read -p "Press enter to return to menu..."
            ;;
        2)
            bash modules/memory.sh
            read -p "Press enter to return to menu..."
            ;;
        3)
            bash modules/disk.sh
            read -p "Press enter to return to menu..."
            ;;
        4)
            bash modules/network.sh
            read -p "Press enter to return to menu..."
            ;;
        5)
            bash modules/firewall.sh
            read -p "Press enter to return to menu..."
            ;;
        6)
            bash modules/update_check.sh
            read -p "Press enter to return to menu..."
            ;;
        7)
            bash modules/service_status.sh
            read -p "Press enter to return to menu..."
            ;;

        8)
            echo "Exiting SysGuardian..."
            exit 0
            ;;
        *)
            echo "Invalid option"
            sleep 1
            ;;
    esac
done
