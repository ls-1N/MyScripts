#!/bin/bash

file_location="/sys/bus/serio/devices/serio1/drvctl"

echo -n "none" | sudo tee $file_location && echo -n "reconnect" | sudo tee $file_location
