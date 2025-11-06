# Scripting
How it works:

The script checks CPU, memory, and disk space utilization.
If any is greater than 60%, VM is declared "Not Healthy", else "Healthy".
Use ./vm_health_check.sh for basic check, or ./vm_health_check.sh explain to see reasons.
Target operating system: Ubuntu, using standard utilities (top, free, df).
Make executable:
chmod +x vm_health_check.sh
