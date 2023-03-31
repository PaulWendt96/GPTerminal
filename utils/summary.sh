#!/bin/bash
#
# DAN-like prompt for trying to extract "real" reponses from chatGPT
[ $# -ge 1 -a -f "$1" ] && input="$1" || input="-"
echo "Can you summarize the following text for me?" $(cat "$input")

