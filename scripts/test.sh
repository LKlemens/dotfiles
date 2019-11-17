#!/usr/bin/bash

echo "#################version with fullfill array"

declare -gA config=(
  [path_to_git_dir]="$HOME/git/dotfiles"
)


if [[ -d ${config[path_to_git_dir]} ]]; then
  echo here I am ${config[path_to_git_dir]}
else
  echo fuck ${config[path_to_git_dir]}
fi







echo "#################version with empty array"
declare -gA config2=(
  [path_to_git_dir]=""
)

function read_config()
{
  while read -r line; do
    if [[ $line =~ '=' ]]; then
      varname="${line%%=*}"
      varname="${varname// /}"
      value="${line#*=}"
      echo var $varname val ${value}
      config2[$varname]="$value"
    fi
  done < $HOME/.config/alink/config
}

read_config

if [[ -d ${config2[path_to_git_dir]} ]]; then
  echo here I am ${config2[path_to_git_dir]}
else
  echo fuck ${config2[path_to_git_dir]}
fi
