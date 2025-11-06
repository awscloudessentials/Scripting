# Scripting Task
Create a shell script where the script should analyze the health of the virtual machine based on cpu, memory and disk space. If any of these are less than 60% utilized , the script declares the state of vm as healthy whereas if any of these parameters are more than 60% , script declares the health as not healthy.
Also, the script should support a command line argument named "explain", when passed, the script should explain the reason for health status along with printing the health status. Target vm's are always ubuntu.


How it works:

The script checks CPU, memory, and disk space utilization.
If any is greater than 60%, VM is declared "Not Healthy", else "Healthy".
Use ./vm_health_check.sh for basic check, or ./vm_health_check.sh explain to see reasons.
Target operating system: Ubuntu, using standard utilities (top, free, df).
Make executable:
chmod +x vm_health_check.sh
