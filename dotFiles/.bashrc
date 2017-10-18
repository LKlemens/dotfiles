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
export FZF_DEFAULT_OPTS="-m --bind J:down,K:up,ctrl-a:select-all,ctrl-d:deselect-all,ctrl-t:toggle-all,page-up:preview-page-up,page-down:preview-page-down --height=80 --preview '/opt/python-pygments/noarch/2.2.0.p360-1/bin/pygmentize {}' --history='/home/$USER/.local/share/fzf-history/terminal' --preview-window=wrap:hidden  --bind ?:toggle-preview "
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .svn -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_OPTS=" --bind ctrl-h:preview-up,ctrl-l:preview-down,ctrl-a:select-all,ctrl-d:deselect-all,ctrl-t:toggle-all  --preview 'tree -C {} | head -200'"
export FZF_ALT_C_COMMAND='ag -g "" -l | sed -e "s:/[^/]*$::" | uniq '
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
bind -x '"\C-p": /opt/vim/x86_64/8.0.069-2/bin/vim -p $(fzf);'

