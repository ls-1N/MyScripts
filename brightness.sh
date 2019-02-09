#!/bin/bash
# Add the following to /etc/rc.local:
#       chmod 666 /sys/class/backlight/intel_backlight/brightness
# Modern systems might need tinkering to make rc.local work again.
# The file .config/khotkeysrc should contain the hotkeys CTRL+SHIFT+F4/F5 to
# adjust brightness down and up respectively.
#
# Usage:
#    ./brightness.sh up   # bump up brightness
#    ./brightness.sh down # bump down brightness
#
curr=`cat /sys/class/backlight/intel_backlight/brightness`
bump=$(( $curr / 50 ))
if [ "$1" == "up" ]; then
  curr=`echo "$curr + $bump + 1" | bc`
else
  curr=`echo "$curr - $bump - 1" | bc`
fi
# Set the brightness to the new level. 0 is the lower limit. Cant set it lower than that.
printf "Current brightness: " && echo $curr | tee /sys/class/backlight/intel_backlight/brightness
printf "Single step amount: $bump\n"
