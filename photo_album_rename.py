#!/usr/bin/python3

from pathlib import Path
import os
import re
import sys
import click

# TODO: Maybe convert these to tuples of before and after if this gets any more complicated
sought_patterns = [
    '\d\d\d\d:\d\d:\d\d \d\d:\d\d:\d\d\.[^\.]+', # e.g. 2022:12:06 23:03:02.jpg
    '\d\d\d\d-\d\d-\d\dT\d\d:\d\d:\d\d\.[^\.]+', # e.g. 2022-12-06T23:03:02.jpg
    '\d\d\d\d-\d\d-\d\d-\d\d-\d\d-\d\d\.[^\.]+', # e.g. 2022-12-06-23-03-02.jpg
    '\d\d\d\d-\d\d-\d\d-\d\d-\d\d-\d\d-\d\d\d\.[^\.]+' # e.g. 2022-12-06-23-03-02-144.jpg
    ]

def process_match(successful_match, matched_file):
    m = successful_match.group(0)
    new_filename = f'{m[:4]}-{m[5:7]}-{m[8:10]} {m[11:13]}:{m[14:16]}:{m[17:19]}'
    for character in list(m[20:23]):
        if character.isnumeric():
            if new_filename[19:20] != '.':
                new_filename += '.'
            new_filename += character
        else:
            break
    new_filename += os.path.splitext(matched_file)[1]
    os.rename(matched_file, f'{matched_file.parents[0]}/{new_filename}')
    click.echo(f"Renamed {matched_file} to {new_filename}")

@click.command()
@click.argument('path', type=click.Path(exists=True))
@click.option('--verbose', type=click.BOOL, default=False, help="Whether not matching files should be listed in the output")
def process_files_at_path(path, verbose):
    """
    Rename all files at PATH that match the internally defined patterns to the 
    format YYYY-MM-DD hh:mm:ss.extension (e.g. 2022-12-06 23:03:02.jpg).
    The output supports milliseconds if detected in a specific pattern.
    """
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
            if verbose and not file_matches_a_pattern:
                click.echo(f"Not matched: {file}")

if __name__ == '__main__':
    process_files_at_path()