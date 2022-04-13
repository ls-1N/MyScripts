#!/usr/bin/python3

from pulsectl import Pulse
import subprocess
import sys

# Prerequisite tasks on ubuntu machine:
# sudo apt install python3-pip
# pip install pulsectl

method = 'org.bluez.MediaControl1.Volume{}'.format(
  'Down' if sys.argv[1] == 'down' else 'Up')

with Pulse() as pulse:
  for sink in pulse.sink_list():
    bluez_path = sink.proplist.get('bluez.path')
    if bluez_path:
        args = [
            'dbus-send', '--system', '--print-reply',
            '--dest=org.bluez', bluez_path, method,
        ]
        subprocess.run(args, check=True)