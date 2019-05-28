#!/bin/bash

## Get the "Device name" or ID number
## for touch from `xsetwacom list dev`

# Known problems:
# Still outputs normal message when command fails

DEVICE="Wacom HID 4846 Finger touch" 
TOUCH_STATE=`xsetwacom get "$DEVICE" touch`
MESSAGE_ON="Touch screen enabled"
MESSAGE_OFF="Touch screen Disabled"
if [ "$TOUCH_STATE" == "on" ]
  then
    xsetwacom set "$DEVICE" touch off && \
    echo $MESSAGE_OFF && \
    zenity --notification --text "$MESSAGE_OFF"
  else
    xsetwacom set "$DEVICE" touch on && \
    echo $MESSAGE_ON && \
    zenity --notification --text "$MESSAGE_ON"
fi
