#!/bin/bash
# Dell N4010 brightness control workaround
# Note: add the following to /etc/rc.local
#       chmod 777 /sys/class/backlight/intel_backlight/brightness
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
echo $curr | tee /sys/class/backlight/intel_backlight/brightness
echo $bump
