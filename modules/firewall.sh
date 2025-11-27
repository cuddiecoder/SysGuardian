#!/bin/bash
#
# firewall.sh
#
# This module checks the status of common Linux firewalls:
# - UFW
# - firewalld
# - iptables
#
# It detects which firewall tool is installed, checks whether it is active,
# and prints a clean, structured report. This script is designed so you can
# easily expand it in the future.
#

# Function: print_header
# Prints a standardized header for consistency across modules.
print_header() {
    echo "FIREWALL STATUS REPORT"
    echo "----------------------"
}

# Function: check_ufw
# Checks if UFW is installed and prints its status.
check_ufw() {
    if command -v ufw >/dev/null 2>&1; then
        echo "Detected firewall: UFW"

        # Get UFW status output
        UFW_STATUS=$(ufw status | head -n 1)

        echo "UFW Status: $UFW_STATUS"

        # Extract default incoming/outgoing policies
        IN_POLICY=$(ufw status verbose 2>/dev/null | grep "Default:" | awk '{print $3}')
        OUT_POLICY=$(ufw status verbose 2>/dev/null | grep "Default:" | awk '{print $5}')

        if [ -n "$IN_POLICY" ] && [ -n "$OUT_POLICY" ]; then
            echo "Default incoming policy: $IN_POLICY"
            echo "Default outgoing policy: $OUT_POLICY"
        fi

        # Count user-defined rules
        RULE_COUNT=$(ufw status numbered | sed '/Status:/d' | wc -l)
        echo "Number of rules: $RULE_COUNT"

        return 0
    else
        return 1
    fi
}

# Function: check_firewalld
# Checks if firewalld is installed and prints its status.
check_firewalld() {
    if command -v firewall-cmd >/dev/null 2>&1; then
        echo "Detected firewall: firewalld"

        # Check if service is active
        FIREWALLD_ACTIVE=$(systemctl is-active firewalld 2>/dev/null)

        echo "firewalld service: $FIREWALLD_ACTIVE"

        # List active zones
        ACTIVE_ZONES=$(firewall-cmd --get-active-zones 2>/dev/null)

        if [ -n "$ACTIVE_ZONES" ]; then
            echo "Active zones:"
            echo "$ACTIVE_ZONES"
        fi

        return 0
    else
        return 1
    fi
}

# Function: check_iptables
# If no modern firewall manager exists, check iptables rules.
check_iptables() {
    if command -v iptables >/dev/null 2>&1; then
        echo "Detected firewall tool: iptables"

        # Count number of rules in filter table
        RULE_COUNT=$(iptables -L 2>/dev/null | wc -l)
        echo "iptables rule lines: $RULE_COUNT"

        echo "Note: iptables detected without UFW/firewalld."
        echo "This may indicate manual firewall management."

        return 0
    else
        return 1
    fi
}

# Main Execution
print_header

# Try UFW first
check_ufw
if [ $? -eq 0 ]; then
    exit 0
fi

# Try firewalld next
check_firewalld
if [ $? -eq 0 ]; then
    exit 0
fi

# Try iptables
check_iptables
if [ $? -eq 0 ]; then
    exit 0
fi

# If nothing detected
echo "No firewall detected on this system."
exit 1
