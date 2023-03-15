#!/usr/bin/python3
'''
A script to find and modify styling of all Freeplane documents at a given path to conform to a template document.

Key assumptions:
* names of styles in all found documents are either unique or an iteration of a previous version with the same name
'''

import glob
import os
import xml.etree.ElementTree as ET
import re

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


def styling_used(document):
    '''Return a set of all stylings used in the body of a Freeplane document.'''
    tree = ET.parse(document)
    root = tree.getroot()
    set1 = set(map(lambda elem : elem.get('STYLE_REF'), root.findall('.//*[@STYLE_REF]')))
    set2 = set(map(lambda elem : elem.get('LOCALIZED_STYLE_REF'), root.findall('.//*[@LOCALIZED_STYLE_REF]')))
    return(set1 | set2)

def styling_defined(document):
    '''Return a set of all stylings specified as available in a Freeplane document.'''
    tree = ET.parse(document)
    root = tree.getroot()
    map_styles_xml = root.findall('.//*[@LOCALIZED_TEXT=\'styles.root_node\']/stylenode/stylenode')
    set1 = set(map(lambda elem : elem.get('TEXT') , map_styles_xml))
    set2 = set(map(lambda elem : elem.get('LOCALIZED_TEXT') , map_styles_xml))
    return(set1 | set2)

def get_map_styles_string(document):
    '''Return the substring that is the map_styles subsection of a Freeplane document.'''
    with open(document, 'r') as f:
        return(regex_for_styling_section.search(f.read())[0])

# Technical vars:
regex_for_styling_section = re.compile('(<map_styles>(.*\n)*</map_styles>)',re.MULTILINE)
reference_map_styles_string = get_map_styles_string(template_document)
reference_map_styles_set = styling_defined(template_document)
styles_safe_to_modify = reference_map_styles_set
for rule in update_rules:
    styles_safe_to_modify = styles_safe_to_modify | {rule[0]}

# Main
for document in glob.iglob(search_path + '**/*.mm', recursive=True):
    print(f"Found document: {os.path.join(search_path, document)}")
    in_document_but_not_in_safelist = styling_used(document) - styles_safe_to_modify
    if in_document_but_not_in_safelist != set():
        print(f"\tSkipping: Found unknown stylings used: {in_document_but_not_in_safelist}")
    else:
        print("\tAttempting substitution...")
        contents = ''
        with open(document) as f:
            contents = f.read()
        contents = re.sub(regex_for_styling_section, reference_map_styles_string, contents)
        for rule in update_rules:
            substitution = re.subn(f'STYLE_REF="{rule[0]}', f'STYLE_REF="{rule[1]}', contents)
            contents = substitution[0]
        with open(document, 'w') as f:
            f.write(contents)
        print(f"\tSuccess! Made {substitution[1]} substitutions.")
