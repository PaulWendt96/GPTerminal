#!/usr/local/bin/python
import argparse
import json
import os
import pathlib

parser = argparse.ArgumentParser()
parser.add_argument('script', help='Script to check')
parser.add_argument('--context', help='Additional context message')
args = parser.parse_args()

script = args.script
context = args.context

def get_extension(file_name: str, extension_mapping: dict = {}) -> str:
    """Given a file name, try to get the corresponding file type via the extension"""
    extension = pathlib.Path(file_name).suffix
    return extension_mapping.get(extension, "")

# Open the provided script
# Try to load in the extension mapping as well
with open(script, "r") as file:
    script_contents = file.read()

extension_path = "/usr/local/share/extensions.json"
try:
    with open(extension_path, "r") as file:
        extension_map = json.load(file)
except FileNotFoundError:
    extension_map = {}

script_extension = get_extension(script, extension_map)


print(f"Can you help me find bugs in the following {script_extension} file?")
if context:
    print(f"For some additional context: the goal of the script is to {context}")
print(f"The contents of the script are below: \n\n{script_contents}\n\n")
