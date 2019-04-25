#!/bin/bash 

help_message="Usage: ./switch_cpu_governor.sh args

Valid args:
        --performance - Puts cpu scaling_governor to peformance mode. Uses more power.
        --powersave   - Puts cpu scaling_governor to powersave mode. Uses less power. 

"

# Display help if arg amount isn't suitable.
if [ $# -ne 1 ]; then
    echo "$help_message"
    exit 1
elif [ $1 == "--powersave" ]; then
    echo powersave | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
elif [ $1 == "--performance" ]; then
    echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
else
    echo "$help_message"
    exit 2
fi
