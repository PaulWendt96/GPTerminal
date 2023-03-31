#!/usr/local/bin/python
import sys

if len(sys.argv) > 1:
    file = open(sys.argv[1])
else:
    file = sys.stdin

contents = file.read()
file.close()

#print("Can you give me a high level summary of what the following program does? The program is below:\n")
print("Can you give explain what the following does?\n")
print(contents)
