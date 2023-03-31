#!/bin/bash
#
# draft a response to a message
# not symlinking this one yet, needs some work
[ $# -ge 1 -a -f "$1" ] && input="$1" || input="-"
echo "Can you draft a response to the following message?" $(cat "$input")
