#!/usr/bin/python3

import pyautogui
import datetime
import subprocess
import time
import tkinter
from dateutil import tz

# The purpose of this script is to type out current date and time according to the ISO-8601 standard.

# Preceding steps on an Ubuntu machine:
#sudo apt-get install idle3
#sudo apt-get install python3-pip
#sudo apt-get install scrot
#sudo apt-get install python-tk
#sudo apt-get install xsel xvkbd



# Couldn't get the platform-independent copy-paste handling to work. So calling Linux specific commands instead.
# Using primary clipboard, didn't manage to paste'it though.
def copy_to_clipboard(text):
    subprocess.run('echo -n "{}" | xsel --input'.format(text), shell=True)

# Actual typing is slower and more error-prone. So copy-paste instead.
def copy_type(text):
    copy_to_clipboard(text)
    time.sleep(0.3)
    pyautogui.write(str(subprocess.run('xsel --output', shell=True, stdout=subprocess.PIPE).stdout.decode('utf-8')), interval=0.01)



time.sleep (0.3)
copy_type(str(datetime.datetime.now(tz=tz.tzlocal()).replace(microsecond=0).isoformat()))
