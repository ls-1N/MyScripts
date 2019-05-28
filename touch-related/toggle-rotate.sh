#!/bin/bash 

# Known problems:
# - Needs screenrotator installed
# - Shows the unnecessary status icon

MESSAGE_ON="Rotation lock on"
MESSAGE_OFF="Rotation lock off"
if [ `pgrep screenrotator` ]
  then
    killall screenrotator && \
    echo $MESSAGE_ON && \
    qdbus org.kde.plasmashell /org/kde/osdService org.kde.osdService.showText osd-rotate-normal "$MESSAGE_ON"
  else
    screenrotator & \
    echo $MESSAGE_OFF && \
    qdbus org.kde.plasmashell /org/kde/osdService org.kde.osdService.showText osd-rotate-ccw "$MESSAGE_OFF"
fi
