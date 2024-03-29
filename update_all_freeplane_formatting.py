#!/usr/bin/python3
"""
A script to find and modify styling of all Freeplane documents at a given path to conform to a template document.

Key assumptions:
* names of styles in all found documents are either unique or an iteration of a previous version with the same name
"""

import glob
import os
import xml.etree.ElementTree as ET
import re

# TODO: replace with parameters and a config file
# User-facing vars:
home_directory = os.path.expanduser('~')
search_path = f'{home_directory}/Documents/mindmaps/'
template_document = f'{home_directory}/Documents/mindmaps/STYLE_TEMPLATE.mm'
update_rules = [
    ['Pros','GREEN'],
    ['Cons','RED'],
    ['FOSS','GREEN'],
    ['NFCSS','RED'],
    ['Warning','ORANGE'],
    ['Items','CYAN'],
    ['Unimportant','Background'],
    ['`terminal`','xTerm'],
]


def styling_used(file: str) -> set:
    """Return a set of all stylings used in the body of a Freeplane document."""
    tree = ET.parse(file)
    root = tree.getroot()
    set1 = {elem.get('STYLE_REF') for elem in root.findall('.//*[@STYLE_REF]')}
    set2 = {elem.get('LOCALIZED_STYLE_REF') for elem in root.findall('.//*[@LOCALIZED_STYLE_REF]')}
    return set1 | set2

def styling_defined(file: str) -> set:
    """Return a set of all stylings specified as available in a Freeplane document."""
    tree = ET.parse(file)
    root = tree.getroot()
    map_styles_xml = root.findall('.//*[@LOCALIZED_TEXT=\'styles.root_node\']/stylenode/stylenode')
    set1 = {elem.get('TEXT') for elem in map_styles_xml}
    set2 = {elem.get('LOCALIZED_TEXT') for elem in map_styles_xml}
    return set1 | set2

def get_map_styles_string(file: str) -> str:
    """Return the substring that is the map_styles subsection of a Freeplane document."""
    with open(file, 'r') as f:
        return regex_for_styling_section.search(f.read())[0]

# Technical vars:
regex_for_styling_section = re.compile('(<map_styles>(.*\n)*</map_styles>)',re.MULTILINE)
reference_map_styles_string = get_map_styles_string(template_document)
styles_safe_to_modify = styling_defined(template_document) | {old_style for old_style, _ in update_rules}

# Main
for document in glob.iglob(search_path + '**/*.mm', recursive=True):
    print(f"Found document: {os.path.join(search_path, document)}")
    in_document_but_not_in_safelist = styling_used(document) - styles_safe_to_modify
    if in_document_but_not_in_safelist:
        print(f"\tSkipping: Found unknown stylings used: {in_document_but_not_in_safelist}")
    else:
        print("\tAttempting substitution...")
        with open(document) as f:
            contents = f.read()
        contents = re.sub(regex_for_styling_section, reference_map_styles_string, contents)
        for style_old, style_new in update_rules:
            substitution = re.subn(f'STYLE_REF="{style_old}', f'STYLE_REF="{style_new}', contents)
            contents = substitution[0]
        with open(document, 'w') as f:
            f.write(contents)
        print(f"\tSuccess! Made {substitution[1]} substitutions.")
