# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/klemenslukaszczyk/.oh-my-zsh"
export ERL_AFLAGS="-kernel shell_history enabled"
export LANG="pl_PL.UTF-8"
export GOPATH=/Users/$USER/go
export PATH=/Users/klemenslukaszczyk/Documents/:/usr/local/opt/openjdk@11/bin:$PATH:/usr/local/opt/rabbitmq/sbin:$GOPATH/bin:/usr/local/opt/docker-compose/bin/:/usr/local/Cellar/mongodb-community/7.0.2/bin/:$PATH

alias livebook="/Users/klemenslukaszczyk/.asdf/installs/elixir/1.15.7-otp-26/.mix/escripts/livebook"

eval "$(/opt/homebrew/bin/brew shellenv)"

alias x86="$env /usr/bin/arch -x86_64 /bin/zsh ---login"
alias arm="$env /usr/bin/arch -arm64 /bin/zsh ---login"


# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=( git zsh-syntax-highlighting auto-ls bgnotify)

source $ZSH/oh-my-zsh.sh
source ~/.zjumper.zsh
alias z="zjumper"

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export ASDF_DIR=/usr/local/Cellar/asdf/0.14.0/libexec/
. /usr/local/opt/asdf/libexec/asdf.sh
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

alias update-nvim-nightly='asdf uninstall neovim nightly && asdf install neovim nightly'
alias remap="hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x70000002A}]}'"

alias e="nvim"
alias re="source $HOME/.zshrc"
alias zrc="nvim $HOME/.zshrc"
alias vrc="nvim $HOME/.config/nvim/init.lua"
alias trc="nvim $HOME/.tmux.conf"
alias se='sudo -E nvim'
alias l='ls'
alias tep="trans en:pl"
alias tpe="trans pl:en"
alias pkra="curl wttr.in/Krakow"
alias pzak="curl wttr.in/Zakopane"
alias cd..="cd .."
alias cd...="cd ../.."
alias cd....="cd ../../.."
alias fzfb='source ~/.fzf-bookmarks'
#
#fzf#AWESOME FZF !!!
export FZF_DEFAULT_OPTS="-m --bind J:down,K:up,ctrl-a:select-all,ctrl-d:deselect-all,ctrl-t:toggle-all,page-up:preview-page-up,page-down:preview-page-down --height=80 --preview 'rougify {} ' --history='/Users/$USER/.local/share/fzf-history/terminal'   --bind ?:toggle-preview "
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .svn -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_OPTS=" --bind ctrl-h:preview-up,ctrl-l:preview-down,ctrl-a:select-all,ctrl-d:deselect-all,ctrl-t:toggle-all  --preview 'tree -C {} | head -200'"
export FZF_ALT_C_COMMAND='ag -g "" -l | sed -e "s:/[^/]*$::" | uniq '
bindkey  -s '^p' '~/.tmux/plugins/disable-tmux-navigator.sh && files=$(fzf) && [[ $files ]] && nvim $(echo $files | tr "\n" " "); ~/.tmux/plugins/enable-tmux-navigator.sh  ^M'
bindkey  -s '^o' 'files=$(z list) && [[ $files ]] && file=$(echo $files | fzf) && cd $file ^M'
FZF_MARKS_COMMAND="fzf --height 40% --reverse"

bindkey '^ ' autosuggest-accept

# fshow - git commit browser
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --preview 'f() { set -- $(echo -- "$@" | grep -o "[a-f0-9]\{7\}"); [ $# -eq 0 ] || git show --color=always $1; }; f {}' \
      --bind "ctrl-y:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 | xclip) << 'FZF-EOF'
                {}
FZF-EOF" \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"

}
function tc () {
        pathh="/Users/klemenslukaszczyk"
        eng_word="$1"
        out=$(trans en:pl "${eng_word}" -speak -download-audio-as "$pathh/${eng_word}.mp3")
        if [[ -z $2 ]]; then
          pathfile="$pathh/Documents/eng/mine.txt"
        else
          pathfile="$pathh/Documents/eng/$2.txt"
        fi

        header=($(echo "$out" | head -n 3))
        transaltion=$(echo "$out" | tail -n 1)
        echo "$eng_word"
        if ! [[ ${header[2]} =~ "/" ]];then
          header[2]='';
        fi
        echo "${header[2]}"
        transaltion=$(echo $transaltion | sed "s/\b$eng_word\b//I")
        echo "$transaltion"
        if [[ -n $3 ]]; then
          read  "?Do you want change translation ?[y/n]:?"
          if [[ $REPLY == 'y' ]];then
            transaltion=$3
            echo "translation changed"
            echo $transaltion
          fi
        fi
        if grep -w -o -q "$eng_word" $pathfile; then
          echo "That word is stored already"
          rm $pathh/${eng_word}.mp3
          return 0
        fi
        read  "?Do you want create flashcard?[y/n]:?"
        if [[ $REPLY == 'y' ]];then
          sed  -e "s#frontpage#${eng_word}<br />${header[2]}#" -e "s#backpage#$transaltion#" -e "s#sound_mp3#${eng_word}#" $pathh/Documents/eng/template.txt >> $pathfile
          sed  -e "s#backpage#${eng_word}<br />${header[2]}#" -e "s#frontpage#$transaltion#" -e "s#sound_mp3#${eng_word}#" $pathh/Documents/eng/template.txt >> $pathfile
          mv $pathh/${eng_word}.mp3  $pathh/Library/Application\ Support/Anki2/User\ 1/collection.media/
        else
          rm $pathh/${eng_word}.mp3
        fi;


}
alias tep="trans en:pl"
alias tpe="trans pl:en"

function tcw() {
  tc "$1" "504" $2
}

function tcp() {
  tc "$1" "podcast" $2
}

function tcd() {
  tc "$1" "daily" $2
}

function tcb() {
  tc "$1" "books" $2
}

function tcb2() {
  tc "$1" "books2" $2
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


eval "$(direnv hook zsh)"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export PATH=/Users/klemenslukaszczyk/.meteor:$PATH
