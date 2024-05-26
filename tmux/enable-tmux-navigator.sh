#!/bin/sh

# Restore the bindings
tmux bind-key -n C-h if-shell "$is_vim" "send-keys C-h"  "select-pane -L"
tmux bind-key -n C-j if-shell "$is_vim" "send-keys C-j"  "select-pane -D"
tmux bind-key -n C-k if-shell "$is_vim" "send-keys C-k"  "select-pane -U"
tmux bind-key -n C-l if-shell "$is_vim" "send-keys C-l"  "select-pane -R"
