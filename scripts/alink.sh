#!/usr/bin/bash

function help()
{
	cat <<-EOF
	Usage: $(basename "$0")
	--init:  Create config files
	EOF
}

function read_config()
{
  while read -r line; do
    if [[ $line =~ '=' ]]; then
      varname="${line%%=*}"
      value="${line#*=}"
      config[$varname]="$value"
    fi
  done < "$HOME/.config/alink/config"
}

function setup()
{
  declare -gA config=(
    [path_to_git_dir]=""
    [configs_path]=""
    [list_of_configs]=""
    [home_list_of_configs]=""
  )

  mkdir -p "$HOME/.config/alink"

  if [[ -e $HOME/.config/alink/config ]]; then
    read_config
    # for file in "${config[@]}"; do
    #   echo $file
    # done
  else
    echo "There is no $HOME/.config/alink/config file." >&2
    cat <<-EOF
		Example config file:
				path_to_git_dir      = $HOME/git/dotfiles
				configs_path         = $HOME/.config
				list_of_configs      = nvim/init.vim redshift.conf rofi i3 polybar scripts compton zathura dunst
				home_list_of_configs = .zshrc .xinitrc .gitignore .tmux.conf
		EOF
    exit 1
  fi
}

setup

function check_config_corectness()
{
  if [[ -d ${config[path_to_git_dir]} ]]; then
    echo jest ${config[path_to_git_dir]}
  else
    echo kurde ${config[path_to_git_dir]}
  fi
}
check_config_corectness

# changes_flag=0

if [[ ! -e ${config[path_to_git_dir]} ]]; then
  echo "There is no ${config[path_to_git_dir]} set" >&2
  exit 1
fi

mkdir -p "$HOME/.config/backup_alist"

# function create_links ()
# {
#   for file in $1;do
#     cp -r -L -u "$2/$file" "$HOME/.config/backupX"
#     if_new_file_add_to_git_first "$file" "$2"
#     rm -rf "${2:?}/$file"
#     ln -s "${config["path_to_git_dir"]}/$file" "$2/$file"
#   done

#   if [ $changes_flag = 0 ]; then
#     echo "nothing change in $2"
#   fi
# }

# function if_new_file_add_to_git_first()
# {
#   if  [ -z "$(ls "${config["path_to_git_dir"]}/$1" 2>/dev/null)" ]; then
#     mv "$2/$1" "${config["path_to_git_dir"]}"
#     echo "$1 was added"
#     changes_flag=1
#   fi
# }

# create_links "${config["list_of_configs"]}" "${config["configs_path"]}"
# create_links "${config["home_list_of_configs"]}" "$HOME"
