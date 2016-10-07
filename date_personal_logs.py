#!/usr/bin/python3

import pyautogui
import datetime
import time

#The function of this script is to type out current date according to a personal standard

#previous tasks on ubuntu machine:
#sudo apt-get install idle3
#sudo apt-get install python3-pip
#sudo apt-get install scrot
#sudo apt-get install python-tk


#variables
t = datetime.date.today()
weekday = (datetime.date.weekday(t))

#translate weekday to Estonian weekday initials
if weekday == 0:
    day = "E"
elif weekday == 1:
    day = "T"
elif weekday == 2:
    day = "K"
elif weekday == 3:
    day = "N"
elif weekday == 4:
    day = "R"
elif weekday == 5:
    day = "L"
elif weekday == 6:
    day = "P"
else:
    day = "DAY ERROR"

#sleep because autotype would interact with the hotkey pressed to launch this script
time.sleep (0.3)
#the format that ive been using for my log titles
pyautogui.typewrite (t.strftime("%d.%m.%y") + " " + day)