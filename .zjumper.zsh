# MIT License
#
# Copyright (c) 2023 romainchapou
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.


# Super simple solution to bookmark your frequently used directories and cd
# into them quickly by using fzf

fzf-zjumper() {
  setopt localoptions pipefail no_aliases 2> /dev/null
  local dir="$(test -s $HOME/.config/zjumper/list && fzf --height ${FZF_TMUX_HEIGHT:-40%} --reverse --bind=ctrl-z:ignore < $HOME/.config/zjumper/list)"
  if [[ -z "$dir" ]]; then
    zle redisplay
    return 0
  fi
  zle push-line # Clear buffer. Auto-restored on next prompt.
  BUFFER="builtin cd -- ${(q)dir}"
  zle accept-line
  local ret=$?
  unset dir # ensure this doesn't end up appearing in prompt expansion
  zle reset-prompt
  return $ret
}

# Main functionality: ctrl-space or alt-z to cd to select a bookmarked directory to cd into
zle     -N             fzf-zjumper
bindkey -M emacs '^ '  fzf-zjumper
bindkey -M vicmd '^ '  fzf-zjumper
bindkey -M viins '^ '  fzf-zjumper
bindkey -M emacs '\ez' fzf-zjumper
bindkey -M vicmd '\ez' fzf-zjumper
bindkey -M viins '\ez' fzf-zjumper

function zjumper {
    local config_dir="$HOME/.config/zjumper"
    local config_file="$config_dir/list"

    if [ "$1" = "add" ]; then
        mkdir -p "$config_dir"
        touch "$config_file"
        if ! grep -qE "^$(pwd)\$" < "$config_file"; then
            pwd >> "$config_file"
        fi
        return 0
    fi

    if [ "$1" = "list" ] || [ "$1" = "ls" ]; then
        if ! [ -s "$config_file" ]; then
            echo "no recorded shortcuts"
        else
            cat "$config_file"
        fi

        return 0
    fi

    if [ "$1" = "edit" ] || [ "$1" = "ed" ]; then
        cd

        $EDITOR "$config_file"
        return 0
    fi

    echo "usage: "
    echo "    $0 add   -> add current path to bookmarked paths"
    echo "    $0 ls    -> list bookmarked paths"
    echo "    $0 edit  -> open list of bookmarked paths in \$EDITOR"
    return 1
}
