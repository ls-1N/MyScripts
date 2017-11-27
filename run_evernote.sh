#!/bin/bash

#Start Evernote from PlayOnLinux without tray (looks unpleasant in KDE Plasma 5) or clipper.

exec /usr/share/playonlinux/playonlinux --run "Evernote" &
sleep 1
killall EvernoteClipper.exe
killall EvernoteTray.exe
sleep 5
killall EvernoteClipper.exe
killall EvernoteTray.exe
sleep 10
killall EvernoteClipper.exe
killall EvernoteTray.exe
