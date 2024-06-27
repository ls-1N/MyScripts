#!/usr/bin/python3
"""
Rename all matching files at a searched path to the format YYYY-MM-DD hh:mm:ss.*
E.g. 2022-12-06 23:03:02.jpg
Support for optional milliseconds at the end.
"""

from pathlib import Path
import os
import re
import sys

# TODO: Maybe convert these to tuples of before and after if this gets any more complicated
sought_patterns = [
    '\d\d\d\d:\d\d:\d\d \d\d:\d\d:\d\d\.[^\.]+', # e.g. 2022:12:06 23:03:02.jpg
    '\d\d\d\d-\d\d-\d\dT\d\d:\d\d:\d\d\.[^\.]+', # e.g. 2022-12-06T23:03:02.jpg
    '\d\d\d\d-\d\d-\d\d-\d\d-\d\d-\d\d\.[^\.]+', # e.g. 2022-12-06-23-03-02.jpg
    '\d\d\d\d-\d\d-\d\d-\d\d-\d\d-\d\d-\d\d\d\.[^\.]+' # e.g. 2022-12-06-23-03-02-144.jpg
    ]

def process_match(successful_match, matched_file):
    m = successful_match.group(0)
    new_filename = m[:4] + '-' + m[5:7] + '-' + m[8:10] + ' ' + m[11:13] + ':' + m[14:16] + ':' + m[17:19]
    for character in list(m[20:23]):
        if character.isnumeric():
            if new_filename[19:20] != '.':
                new_filename += '.'
            new_filename += character
    new_filename += os.path.splitext(matched_file)[1]
    os.rename(matched_file, str(matched_file.parents[0]) + '/' + new_filename)
    print(f'renamed {matched_file} to {new_filename}')

def process_files_at_path(path):
    for file in Path(path).rglob('*'):
        if file.is_file():
            file_matches_a_pattern = False
            for pattern_string in sought_patterns:
                if file_matches_a_pattern:
                    break
                pattern = re.compile(pattern_string)
                successful_match = re.match(pattern, str(file.name))
                if successful_match:
                    process_match(successful_match, file)
                    file_matches_a_pattern = True
            if not file_matches_a_pattern:
                print(f'not matched {file}')

process_files_at_path(sys.argv[1])