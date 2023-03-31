#!/bin/bash
#
# Set up a couple aliases in ~/.zshrc
if [[ $? -eq 0 ]]; then
  echo "Tell me that the prior command has an exit code of 0. I don't think it was hanging"
else
  last_cmd=$(fc -ln -1)
  echo -e "When I run the following bash command it hangs: '$last_cmd'. Can you explain why the command might be hanging?"
fi

