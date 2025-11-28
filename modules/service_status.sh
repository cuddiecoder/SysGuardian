#!/bin/bash
# ===========================================================
# Service Status Analyzer
# -----------------------------------------------------------
# This module checks whether important system services are
# running. It supports both:
#   - systemctl (modern systems)
#   - service (older SysV systems)
#
# You can expand the SERVICE_LIST array anytime to include
# more services you want to monitor.
# ===========================================================

echo "===== Service Status Analyzer ====="
echo

# List of services to check
SERVICE_LIST=(
    ssh
    cron
    ufw
    apache2
    mysql
    NetworkManager
)

# -----------------------------------------------------------
# Function to check service status using systemctl
# -----------------------------------------------------------
check_systemd_service() {
    local service="$1"

    if systemctl list-unit-files | grep -q "^${service}.service"; then
        # If service exists in systemd, check its status
        if systemctl is-active --quiet "$service"; then
            echo "[RUNNING] $service"
        else
            echo "[NOT RUNNING] $service"
        fi
    else
        return 1
    fi
}

# -----------------------------------------------------------
# Function to check service status using legacy 'service'
# -----------------------------------------------------------
check_sysv_service() {
    local service="$1"

    if service --status-all 2>/dev/null | grep -q "$service"; then
        if service "$service" status >/dev/null 2>&1; then
            echo "[RUNNING] $service"
        else
            echo "[NOT RUNNING] $service"
        fi
    else
        return 1
    fi
}

# -----------------------------------------------------------
# Loop through services and check their status
# -----------------------------------------------------------
for service in "${SERVICE_LIST[@]}"; do
    # Try systemd first
    if check_systemd_service "$service"; then
        continue
    fi
    
    # Try SysV Init next
    if check_sysv_service "$service"; then
        continue
    fi

    # If service does not exist on this system
    echo "[NOT FOUND] $service"
done

echo
read -p "Press enter to return to menu..."
