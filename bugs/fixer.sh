#!/bin/bash
#
# Set up a couple aliases in ~/.zshrc
#
#   alias fix='source /Users/paulwendt/utils/bash/chatgpt/bugs/fixer.sh | ask_gpt | tee /tmp/fix'
#   alias run='cat /tmp/fix | /bin/sh -s'
#
# If a command fails, use `fix` to get GPT's suggested fix (note that this reruns the command; GPT
# seems to work much better when it knows the error). If GPT's suggested fix looks good to you,
# run it with `run`
#
#
# Example 1:
#   (.venv) [paulwendt@Paul-Wendt dagster](zuora_exportzoql)(prod)(prod-dagster)$ /bin/sh -c "ls -la | grep m | (awk '{print $1}'"
#   /bin/sh: -c: line 1: syntax error: unexpected end of file
#   (.venv) [paulwendt@Paul-Wendt dagster](zuora_exportzoql)(prod)(prod-dagster)$ fix
#   /bin/sh -c "ls -la | grep m | awk '{print $1}'"
#   (.venv) [paulwendt@Paul-Wendt dagster](zuora_exportzoql)(prod)(prod-dagster)$ run
#   drwxr-xr-x   11 paulwendt  staff   352 Mar 27 14:14 commerce_tools
#   drwxr-xr-x   58 paulwendt  staff  1856 Mar 30 13:07 customer_experience
#   -rw-r--r--    1 paulwendt  staff   173 Mar 16 13:31 dagster.yaml
#
#
# Example 2:
# (.venv) [paulwendt@Paul-Wendt bugs](master)(prod)(prod-dagster)$ ls -la | awk '{print $-1}'
# awk: trying to access out of range field -1
#  input record number 1, file
#  source line number 1
# (.venv) [paulwendt@Paul-Wendt bugs](master)(prod)(prod-dagster)$ fix
# ls -la | awk '{print $NF}'
# (.venv) [paulwendt@Paul-Wendt bugs](master)(prod)(prod-dagster)$ run
# 40
# .
# ..
# bugs.py
# fixer.sh
if [[ $? -eq 0 ]]; then
  echo "Tell me that the prior command was good and nothing needs to be done"
else
  last_cmd=$(fc -ln -1)
  error=$(/bin/sh -c $last_cmd 2>&1)
  echo -e "The following bash command, '$last_cmd', is failing with the following error:\n\n" \
          "$error\n\n" \
          "Fix the command by correcting syntax and removing invalid arguments." \
          "Try your best to preserve the original intent of the command." \
          "Do not give any explanation or explain your work in any way"
fi

