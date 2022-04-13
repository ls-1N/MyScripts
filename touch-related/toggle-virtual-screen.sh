#!/bin/bash 

MESSAGE_ON="Virtual screen added"
MESSAGE_OFF="Virtual screen removed"

MAIN_SCREEN="eDP-1"
#SCREEN_TO_ADD=VIRTUAL1
SCREEN_TO_ADD="virtual"
if [[ `xrandr --listactivemonitors` =~ $SCREEN_TO_ADD ]]
  then
    xrandr --output $SCREEN_TO_ADD --off && \
    xrandr --delmonitor $SCREEN_TO_ADD && \
    echo $MESSAGE_OFF && \
    qdbus org.kde.plasmashell /org/kde/osdService org.kde.osdService.showText osd-shutd-screen "$MESSAGE_OFF"
  else
    xrandr --setmonitor $SCREEN_TO_ADD 1920/270x1080/150+1920+0 none
    xrandr --addmode $SCREEN_TO_ADD 1920x1080 && \
    xrandr --output $SCREEN_TO_ADD --mode 1920x1080 --right-of $MAIN_SCREEN && \
    echo $MESSAGE_ON && \
    qdbus org.kde.plasmashell /org/kde/osdService org.kde.osdService.showText osd-duplicate "$MESSAGE_ON"
fi
