#!/bin/bash

## Get the "Device name" or ID number
## for touch from `xsetwacom list dev`

# Known problems:
# - Still outputs normal message when command fails

DEVICE="Wacom HID 4846 Finger touch"

TOUCH_STATE=`xsetwacom get "$DEVICE" touch`
MESSAGE_ON="Touch screen enabled"
MESSAGE_OFF="Touch screen disabled"
if [ "$TOUCH_STATE" == "on" ]
  then
    xsetwacom set "$DEVICE" touch off
    echo $MESSAGE_OFF
    qdbus org.kde.plasmashell /org/kde/osdService org.kde.osdService.showText input-touchpad-off "$MESSAGE_OFF"
  else
    xsetwacom set "$DEVICE" touch on
    echo $MESSAGE_ON
    qdbus org.kde.plasmashell /org/kde/osdService org.kde.osdService.showText input-touchpad-on "$MESSAGE_ON"
fi
