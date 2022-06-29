#!/usr/bin/python3

import pyautogui
import datetime
import time

# The purpose of this script is to type out the current date according to the ISO-8601 standard.

# Preceding tasks on an Ubuntu machine:
#sudo apt-get install idle3
#sudo apt-get install python3-pip
#sudo apt-get install scrot
#sudo apt-get install python-tk

# This is the amount of time the user has for releasing the keys they pressed to trigger this script - otherwise those keys will interfere with this script's function.
time.sleep (0.3)

pyautogui.write (str(datetime.date.today().isoformat()), interval=0.01)
