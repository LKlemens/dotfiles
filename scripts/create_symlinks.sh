#!/bin/bash
CONFIGS_PATH="$HOME/.config"
DOTFILES_PATH="$HOME/git/dotfiles"
CONFIG_LIST="nvim/init.vim redshift.conf rofi i3 polybar scripts compton zathura dunst"
HOME_LIST=".zshrc .xinitrc .gitignore .tmux.conf"
CHANGES_FLAG=0

if find "$DOTFILES_PATH" | grep "No such file or directory";then
  exit 0
fi

mkdir -p "$HOME/.config/backupX"

create_links () {
  for file in $1;do
    cp -r -L -u "$2/$file" "$HOME/.config/backupX"
    if_new_file_add_to_git_first "$file" "$2"
    rm -rf "${2:?}/$file"
    ln -s "$DOTFILES_PATH/$file" "$2/$file"
  done

  if [ $CHANGES_FLAG = 0 ]; then
    echo "nothing change in $2"
  fi
}

if_new_file_add_to_git_first() {
  if  [ -z "$(ls "$DOTFILES_PATH/$1" 2>/dev/null)" ]; then
    mv "$2/$1" "$DOTFILES_PATH"
    echo "$1 was added"
    CHANGES_FLAG=1
  fi
}

create_links "$CONFIG_LIST" "$CONFIGS_PATH"
create_links "$HOME_LIST" "$HOME"
