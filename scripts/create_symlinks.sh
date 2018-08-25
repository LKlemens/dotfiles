#!/bin/bash
CONFIGS_PATH="/home/klemens/.config/"
DOTFILES_PATH="/home/klemens/git/dotfiles/"
LIST="nvim/init.vim redshift.conf rofi i3 polybar scripts compton zathura"
if find $DOTFILES_PATH 2>&1 | grep "No such file or directory";then
  exit 0
fi

for file in $LIST;do
  mv "$CONFIGS_PATH$file" "$DOTFILES_PATH"
  ln -s "$DOTFILES_PATH$file" "$CONFIGS_PATH$file"
done
