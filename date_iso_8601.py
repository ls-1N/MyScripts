#!/usr/bin/python3

import pyautogui
import datetime
import time

#The function of this script is to type out current date according to iso-8601 standard

#previous tasks on ubuntu machine:
#sudo apt-get install idle3
#sudo apt-get install python3-pip
#sudo apt-get install scrot
#sudo apt-get install python-tk

#so this is the amount of time i have to release the keys i pressed to trigger this script otherwise those keys will interfere with this typing
time.sleep (0.3)
#today formatted to ISO 8601 standard
pyautogui.typewrite (str(datetime.date.today().isoformat()))
