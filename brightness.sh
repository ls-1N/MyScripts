#!/bin/bash

# Usage:
#    ./brightness.sh up   # bump up brightness
#    ./brightness.sh down # bump down brightness
#
# Known problems:
# - Unlike the default brightness adjustment, this one still shows the OSD after the caps have been reached.

curr=`qdbus local.org_kde_powerdevil /org/kde/Solid/PowerManagement/Actions/BrightnessControl org.kde.Solid.PowerManagement.Actions.BrightnessControl.brightness`
bump=`echo "$curr/50 + 1" | bc`
if [ "$1" == "up" ]; then
  curr=`echo "$curr + $bump" | bc`
else
  curr=`echo "$curr - $bump" | bc`
fi
# Set the brightness to the new level (OSD included). The upper and lower cap seem to be enforced elsewhere.
qdbus local.org_kde_powerdevil /org/kde/Solid/PowerManagement/Actions/BrightnessControl org.kde.Solid.PowerManagement.Actions.BrightnessControl.setBrightness $curr
# Print output:
printf "Current brightness: "
qdbus local.org_kde_powerdevil /org/kde/Solid/PowerManagement/Actions/BrightnessControl org.kde.Solid.PowerManagement.Actions.BrightnessControl.brightness
printf "Single step amount: $bump\n"
