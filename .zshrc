# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH=/home/klemens/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13
export TERM=xterm-256color

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=( git zsh-syntax-highlighting auto-ls bgnotify)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"
export LC_CTYPE=en_US.UTF-8

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# xmodmap -e "clear Lock"
# setxkbmap -option "shift:both_capslock"
# setxkbmap -option "caps:backspace"
# xmodmap -e "clear Lock"


alias e="nvim"
alias re="source $HOME/.zshrc"
alias zrc="nvim $HOME/.zshrc"
alias vrc="nvim $HOME/.config/nvim/init.vim"
alias trc="nvim $HOME/.tmux.conf"
alias i3r="nvim $HOME/.config/i3/config"
alias get="sudo pikaur -S"
alias wifi="sudo wifi-menu"
alias c="clear"
alias pcount="sudo pacman -Q | wc -l"
alias pfind="sudo pacman -Ss"
alias up="sudo pikaur -Syyu"
alias se='sudo -E nvim'
alias prm='sudo pacman -Rsc'
#ls aliases
alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias ll='ls -lh --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias la='ls -lha --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias l='ls'
alias wat="mpv $HOME/db/*"
alias yt="youtube-viewer -W -C"
alias rd="rtv --enable-media"

alias tmuxn="tmux new -s"
alias tmuxa="tmux attach -t"
alias scro="scrot -e 'mv $f ~/screens'"
alias jk="history 10 | tac | gitjk_cmd"
alias cal="cal -3"
alias el='e --servername VIM'
alias gascii="curl -F c=@term.json https://ptpb.pw/"
alias tep="trans en:pl"
alias tpe="trans pl:en"



export PATH=$PATH:$HOME/.bin:/usr/lib/ruby/gems/2.4.0:$HOME/.config/scripts:$HOME/git/rtags/bin:$HOME/bachelor/gcc-linaro-7.2.1-2017.11-x86_64_arm-linux-gnueabihf/bin:.
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:.
export GOPATH=$HOME/git

# junit
export CLASSPATH=$CLASSPATH:/usr/share/java/junit-4.12.jar:/usr/share/java/hamcrest-core.jar:/usr/share/java/hamcrest-integration.jar:/usr/lib/jvm/java-9-openjdk:$HOME/git/JFoenix/jfoenix/build/libs/jfoenix-0.0.0-SNAPSHOT.jar:.

#fzf#AWESOME FZF !!!
#--preview "(~/termpix.sh 50 {} || cat {}) 2> /dev/null | head -'.&lines.'"'
# export FZF_DEFAULT_OPTS="-m --bind J:down,K:up,ctrl-a:select-all,ctrl-d:deselect-all,ctrl-t:toggle-all,page-up:preview-page-up,page-down:preview-page-down --height=80 --preview 'rougify {} ' --history='/home/$USER/.local/share/fzf-history/terminal'   --bind ?:toggle-preview "
export FZF_DEFAULT_OPTS="-m --bind J:down,K:up,ctrl-a:select-all,ctrl-d:deselect-all,ctrl-t:toggle-all,page-up:preview-page-up,page-down:preview-page-down --height=80 --preview 'rougify {} ' --history='/home/$USER/.local/share/fzf-history/terminal'   --bind ?:toggle-preview "
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .svn -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_OPTS=" --bind ctrl-h:preview-up,ctrl-l:preview-down,ctrl-a:select-all,ctrl-d:deselect-all,ctrl-t:toggle-all  --preview 'tree -C {} | head -200'"
export FZF_ALT_C_COMMAND='ag -g "" -l | sed -e "s:/[^/]*$::" | uniq '
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# bindkey '^P': /opt/vim/x86_64/8.0.069-2/bin/vim -p $(fzf);
bindkey  -s '^p' 'nvim -p $(fzf)^M'




source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/auto-ls.zsh
# source ~/.zsh/auto-fu.zsh
# source /home/klemens/.zsh/roupa/z.sh
# source ~/.zsh/fz/fz.sh
source $HOME/.config/scripts/fzfMarks.fzf
# source $HOME/.config/scripts/zsh-vimto.zsh
source $HOME/.config/aliasTip/alias-tips.plugin.zsh
# source $HOME/.config/scripts/enhancd/init.sh
bindkey '^ ' autosuggest-accept

# fshow - git commit browser
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --preview 'f() { set -- $(echo -- "$@" | grep -o "[a-f0-9]\{7\}"); [ $# -eq 0 ] || git show --color=always $1; }; f {}' \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

pbin() {
"$@" | curl -F c=@- https://ptpb.pw/
}

FZF_MARKS_COMMAND="fzf --height 40% --reverse"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

PATH="/home/klemens/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/klemens/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/klemens/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/klemens/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/klemens/perl5"; export PERL_MM_OPT;