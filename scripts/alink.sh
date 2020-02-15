#!/usr/bin/bash


declare -A config=(
  [path_to_git_dir]=""
  [configs_path]=""
  [list_of_configs]=""
  [home_list_of_configs]=""
)


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
      varname="${varname//\ /}"
      value="${line#*=}"
      value=${value#\ }
      config[$varname]="$value"
    fi
  done < "$HOME/.config/alink/config"
}

function setup()
{

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
				home_list_of_configs = .zshrc .xinitrc .gitignore .tmux.conf .agignore
		EOF
    exit 1
  fi
}



function create_links ()
{
  list_of_configs=$1
  config_path=$2
  for config in $list_of_configs;do
    if ! [[ -h  "$config_path/$config" ]] && [[ -s "$config_path/$config" ]]; then
      cp -r -L -u "$config_path/$config" "$HOME/.config/backup_alist"
      rm -rf "${config_path:?}/$config"
    fi
    if ! [[ -h  "$config_path/$config" ]];then
      if_new_file_add_to_git_first "$config" "$config_path"
      ln -s "${config[path_to_git_dir]}/$config" "$config_path/$config"
      echo "new symlink $config_path/$config -> ${config[path_to_git_dir]}/$config"
    fi
  done
}

function if_new_file_add_to_git_first()
 {
   config=$1
   config_path=$2
   if  [ -z "$(ls "${config[path_to_git_dir]}/$config" 2>/dev/null)" ]; then
     mv "$config_path/$config" "${config[path_to_git_dir]}"
     echo "$config was added"
   fi
}


setup

if ! [[  -d ${config[path_to_git_dir]} ]]; then
  echo "There is no ${config[path_to_git_dir]} set" >&2
  exit 1
fi

mkdir -p "$HOME/.config/backup_alist"

create_links "${config[list_of_configs]}" "${config[configs_path]}"
create_links "${config[home_list_of_configs]}" "$HOME"
