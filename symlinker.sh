#!/bin/bash

# set debug to "true" if you want to see commands that will run without actually running
debug="false"
target_dir="/usr/local/bin"

# clean up dead links
find -L $target_dir -type l -exec echo "rm -f {}" \;
if [[ $debug == "false" ]]; then
  find -L $target_dir -type l -exec rm -f {} \;
fi

while read line; do

  # Skip whitespace and lines that start with '#'
  # https://stackoverflow.com/questions/2172352/in-bash-how-can-i-check-if-a-string-begins-with-some-value
  if [[ -z $line ]]; then
    continue;
  elif [[ $line == \#* ]]; then
    continue;
  fi

  arr=($line)
  relative_path=${arr[0]}
  link_as=${arr[1]}

  current_path="$(pwd)/$relative_path"
  symlink_to="$target_dir/$link_as"


  if [[ ! -f "$current_path" ]]; then
    echo "$current_path does not exist -- skipping" 1>&2
  elif [[ -f "$symlink_to" ]]; then
    echo "$symlink_to already exists -- skipping" 1>&2
  else
    echo "ln -s $current_path $symlink_to" 1>&2
    if [[ $debug == "false" ]]; then
      ln -s $current_path $symlink_to 1>&2;
    fi
  fi

done < /dev/stdin
