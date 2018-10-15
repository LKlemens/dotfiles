#!/bin/bash
declare -A config=(
  [path_to_git_dir]=""
  [configs_path]=""
  [list_of_configs]=""
  [home_list_of_configs]=""
)

mkdir -p "$HOME/.config/auto_link"

if [[ -e $HOME/.config/scripts/create_conf ]]; then
  while read -r line; do
    if [[ $line =~ '=' ]]; then
      varname="${line%%=*}"
      config[$varname]="${line#*=}"
    fi
  done < "$HOME/.config/scripts/create_conf"
else
  echo "There is no $HOME/.config/scripts/create_conf file." >&2
  cat <<EOF
  Example config file:
    path_to_git_dir=$HOME/git/dotfiles
    configs_path=$HOME/.config
    list_of_configs=nvim/init.vim redshift.conf rofi i3 polybar scripts compton zathura dunst
    home_list_of_configs=.zshrc .xinitrc .gitignore .tmux.conf
EOF
  exit 1
fi

# for file in "${config[@]}"; do
#   echo $file
# done

changes_flag=0

if [[ $( find "${config["path_to_git_dir"]}" ) ]]; then
  echo "There is no path_to_git_dir set" >&2
  exit 1
fi

mkdir -p "$HOME/.config/backupX"

create_links () {
  for file in $1;do
    cp -r -L -u "$2/$file" "$HOME/.config/backupX"
    if_new_file_add_to_git_first "$file" "$2"
    rm -rf "${2:?}/$file"
    ln -s "${config["path_to_git_dir"]}/$file" "$2/$file"
  done

  if [ $changes_flag = 0 ]; then
    echo "nothing change in $2"
  fi
}

if_new_file_add_to_git_first() {
  if  [ -z "$(ls "${config["path_to_git_dir"]}/$1" 2>/dev/null)" ]; then
    mv "$2/$1" "${config["path_to_git_dir"]}"
    echo "$1 was added"
    changes_flag=1
  fi
}

create_links "${config["list_of_configs"]}" "${config["configs_path"]}"
create_links "${config["home_list_of_configs"]}" "$HOME"
