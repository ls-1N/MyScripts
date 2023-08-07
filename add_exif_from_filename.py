#!/usr/bin/python3
"""
Add exif data using the exiftool CLI tool based on datetime in the filename
Expected format: YYYYMMDD_hhmmss e.g. 20230521_222735
"""

from pathlib import Path
import os
import re
import subprocess
import sys

pattern = re.compile('\d\d\d\d\d\d\d\d_\d\d\d\d\d\d')

rootdir = Path(sys.argv[1])
for file in rootdir.iterdir():
    if file.is_file():
        date_match = re.search(pattern, str(file))
        dt = date_match.group(0)
        dt = dt[:4] + ':' + dt[4:6] + ':' + dt[6:8] + ' ' + dt[9:11] + ':' + dt[11:13] + ':' + dt[13:15]
        command = f'exiftool -modifydate="{dt}" -createdate="{dt}" {file}'
        print(command)
        subprocess.run(command, shell=True, stdout=subprocess.PIPE)