#!/bin/bash
# ===========================================================
# System Update Availability Checker
# -----------------------------------
# This module checks whether your system has updates available.
# It supports:
#   - APT-based systems (Ubuntu, Debian, Kali, Linux Mint)
#   - Pacman-based systems (Arch, Manjaro)
#
# It automatically detects the package manager and runs the
# appropriate update check for that system.
# ===========================================================

# Title for clean formatting
echo "===== System Update Checker ====="

# -----------------------------------------------------------
# STEP 1: Detect which package manager the system uses
# -----------------------------------------------------------
# We check for the existence of "apt"
# command -v returns 0 if the command exists on the system
# >/dev/null hides the output
if command -v apt >/dev/null 2>&1; then

    echo "[+] Detected APT-based system."
    echo

    # -------------------------------------------------------
    # STEP 2: Update the repository package list
    # -------------------------------------------------------
    # Instead of showing the update process on screen,
    # we redirect it into a temporary file.
    echo "Checking for available updates..."
    echo
    sudo apt update -y > /tmp/sysguardian_updates.txt 2>/dev/null

    # -------------------------------------------------------
    # STEP 3: Show upgradeable packages
    # -------------------------------------------------------
    # apt list --upgradeable displays all packages with updates.
    echo "Available Upgrades:"
    apt list --upgradeable 2>/dev/null

# -----------------------------------------------------------
# Check if the system uses pacman instead (Arch-based distros)
# -----------------------------------------------------------
elif command -v pacman >/dev/null 2>&1; then

    echo "[+] Detected Pacman-based system."
    echo

    # Sync package database quietly into a tmp file
    echo "Checking for available updates..."
    echo
    sudo pacman -Sy > /tmp/sysguardian_updates.txt 2>/dev/null

    # Show all packages that have upgrades available
    echo "Available Upgrades:"
    pacman -Qu 2>/dev/null

# -----------------------------------------------------------
# If neither apt nor pacman is found, system is unsupported
# -----------------------------------------------------------
else
    echo "[!] Unsupported package manager."
    echo "This module works with apt or pacman."
fi

# Pause so that results remain visible before returning to menu
echo
read -p "Press enter to return to menu..."

