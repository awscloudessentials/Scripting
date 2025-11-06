#!/bin/bash

# VM Health Check Script for Ubuntu
# Checks CPU, Memory, and Disk utilization to determine VM health
# Usage: ./vm_health_check.sh [explain]

EXPLAIN=false
if [[ "$1" == "explain" ]]; then
    EXPLAIN=true
fi

HEALTHY=true
REASONS=()

# CPU Utilization
# Take CPU idle percent from top, calculate used percent
CPU_IDLE=$(top -b -n1 | grep "Cpu(s)" | awk '{print $8}' | cut -d'.' -f1)
CPU_UTIL=$((100 - CPU_IDLE))

if [[ $CPU_UTIL -gt 60 ]]; then
    HEALTHY=false
    REASONS+=("CPU usage is ${CPU_UTIL}% (>60%)")
fi

# Memory Utilization
MEM_TOTAL=$(free -m | awk '/^Mem:/ {print $2}')
MEM_USED=$(free -m | awk '/^Mem:/ {print $3}')
MEM_UTIL=$(awk "BEGIN { printf(\"%.0f\", (${MEM_USED}/${MEM_TOTAL})*100 ) }")

if [[ $MEM_UTIL -gt 60 ]]; then
    HEALTHY=false
    REASONS+=("Memory usage is ${MEM_UTIL}% (>60%)")
fi

# Disk Utilization (for root /)
DISK_UTIL=$(df --output=pcent / | tail -n1 | tr -dc '0-9')

if [[ $DISK_UTIL -gt 60 ]]; then
    HEALTHY=false
    REASONS+=("Disk usage on / is ${DISK_UTIL}% (>60%)")
fi

# Print status
if $HEALTHY; then
    echo "VM Health: Healthy"
    if $EXPLAIN; then
        echo "All parameters (CPU, Memory, Disk) are at or below 60% utilization."
    fi
else
    echo "VM Health: Not Healthy"
    if $EXPLAIN; then
        for reason in "${REASONS[@]}"; do
            echo "Reason: $reason"
        done
    fi
fi
