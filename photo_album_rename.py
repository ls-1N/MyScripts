#!/usr/bin/python3
"""
Rename all matching files
From: YYYY:MM:DD hh:mm:ss.*  e.g 2022:12:06 23:03:02.jpg
To: YYYY-MM-DDThh:mm:ss.* e.g. 2022-12-06T23:03:02.jpg
"""

from pathlib import Path
import os
import re
import sys

pattern_string = '\d\d\d\d:\d\d:\d\d \d\d:\d\d:\d\d\.[^\.]+'
pattern = re.compile(pattern_string)

rootdir = Path(sys.argv[1])
for file in rootdir.rglob('*'):
    if file.is_file():
        if pattern.match(str(file.name)):
            m = re.search(pattern, str(file.name)).group(0)
            new_filename = m[:4] + '-' + m[5:7] + '-' + m[8:10] + 'T' + m[11:]
            os.rename(file, str(file.parents[0]) + '/' + new_filename)
            print(f'renamed {file}')
        else:
            print(f'not matched {file}')