#!/bin/bash
CONFIGS_PATH="/home/klemens/.config/"
DOTFILES_PATH="/home/klemens/git/dotfiles/"
CONFIG_LIST="nvim/init.vim redshift.conf rofi i3 polybar scripts compton zathura"
HOME_LIST=".zshrc .xinitrc"

if find $DOTFILES_PATH 2>&1 | grep "No such file or directory";then
  exit 0
fi

mkdir -p "$HOME/.config/backupX"

for file in $CONFIG_LIST;do
  cp -r -L "$file" "$HOME/.config/backupX"
  rm -rf "$file"
  ln -s "$DOTFILES_PATH$file" "$CONFIGS_PATH$file"
done

for file in $HOME_LIST;do
  cp -r -L "$HOME/$file" "$HOME/.config/backupX"
  rm -rf "${HOME:?}/$file"
  ln -s "$DOTFILES_PATH$file" "$HOME/$file"
done
