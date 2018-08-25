#!/bin/bash
CONFIGS_PATH="$HOME/.config/"
DOTFILES_PATH="$HOME/git/dotfiles/"
CONFIG_LIST="nvim/init.vim redshift.conf rofi i3 polybar scripts compton zathura"
HOME_LIST=".zshrc .xinitrc"

if find "$DOTFILES_PATH" | grep "No such file or directory";then
  exit 0
fi

mkdir -p "$HOME/.config/backupX"

for file in $CONFIG_LIST;do
  cp -r -L "$CONFIGS_PATH$file" "$HOME/.config/backupX"
  rm -rf "$CONFIGS_PATH$file"
  ln -s "$DOTFILES_PATH$file" "$CONFIGS_PATH$file"
done

for file in $HOME_LIST;do
  cp -r -L "$HOME/$file" "$HOME/.config/backupX"
  rm -rf "${HOME:?}/$file"
  ln -s "$DOTFILES_PATH$file" "$HOME/$file"
done
