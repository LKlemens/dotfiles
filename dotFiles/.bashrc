# .bashrc
# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi
shopt -s histappend
shopt -s cmdhist
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
export HISTSIZE=90000
export HISTFILESIZE=90000
export HISTCONTROL=ignoredups:erasedups  
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"


alias cdo="cd $OLDPWD"
alias svnd="svn diff | /opt/vim/x86_64/8.0.069-2/bin/vim -"
# Load Bash It
source $BASH_IT/bash_it.sh

#AWESOME FZF !!!
export FZF_DEFAULT_OPTS="-m --bind ctrl-h:preview-up,ctrl-l:preview-down,ctrl-a:select-all,ctrl-d:deselect-all,ctrl-t:toggle-all,page-up:preview-page-up,page-down:preview-page-down --height=80 --preview 'file {}' --history='/home/lukaszcz/.local/share/fzf-history/terminal' --preview-window=wrap:hidden  --bind ?:toggle-preview"
export FZF_DEFAULT_COMMAND='ag --hidden -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
bind -x '"\C-p": /opt/vim/x86_64/8.0.069-2/bin/vim $(fzf);'
